#ifndef COMMANDPARSER_H_INCLUDED
#define COMMANDPARSER_H_INCLUDED
#include <getopt.h>
#include <string>
#include <map>
#include <vector>
#include <iostream>
using namespace std;
/**

    CommandlineParser cp;
    cp.addOpt('l', "list-file", 1, "photo list file");
    cp.addOpt('d', "data-file", 1, "save path for data file");
    cp.addOpt('r', "result-file", 1, "save path for result file");
    cp.addOpt('s', "show-img", 0, "show images for group");
    cp.addOpt('m', "cascade-model", 1, "cascade model");
    if(cp.parse(argc, argv)==-1) return -1;

    string list_file, data_file, result_file, cascade_file;
    bool show_img = false;
    cp.getOptArg('l', list_file);
    cp.getOptArg('d', data_file);
    cp.getOptArg('r', result_file);
    cp.getOptArg('m', cascade_file);
    show_img = cp.hasOpt('s');
///*/
class CommandlineParser
{
	public:
		CommandlineParser(){
            m_longOpts.clear();
            m_optString.clear();
            m_optString.append("?h");

		}
		~CommandlineParser(){

		}

    public:
        int parse(int argc, char* argv[]){
            Optdef* longOpts = new Optdef[m_longOpts.size()];
            for(unsigned i=0; i<m_longOpts.size();i++)
                longOpts[i] = m_longOpts[i];

            int opt;
            int longIndex;
            while((opt = getopt_long( argc, argv, m_optString.c_str(), longOpts, &longIndex ))!=-1){
                if(optarg == 0) m_optmap[opt]="";
                else m_optmap[opt]=optarg;
                switch(opt){
                    case 'h':
                    case '?':
                        displayUsage();
                        return -1;
                        break;
                    default:
                        break;
                }

            }
            return 0;
        }

//        void addLongOpt(char* name, int has_arg, int* flag, int val){
//            Optdef def = {name, has_arg, flag, val};
//            m_longOpts.push_back(def);
//
//        }
        void addOpt( int short_name, char* long_name, int has_arg, string desc){

            string usage;
            string optstr;
            optstr.append((char*)(&(short_name)));
            usage.append("-").append(optstr);

            if(has_arg == 1) optstr.append(":");
            //else if(has_arg == 2) optstr.append("::");

            m_optString.append(optstr);
            if(string(long_name).length()>0){
                Optdef def = {long_name, has_arg, NULL, short_name};
                m_longOpts.push_back(def);
                usage.append("\t--").append(long_name);
            }
            usage.append("\t").append(desc);
            usage.append("\n");
            m_usages.push_back(usage);


        }

        bool hasOpt(int name){
            return m_optmap.count(Optopt(name)) >0;
        }
//        void setOptString(const char* optString){
//            m_optString = optString;
//
//        }

        bool getOptArg(int name, string& arg){
             if(hasOpt(name)){
                 arg = m_optmap[name];
                 return true;
             }
             else return false;
        }
        void displayUsage(){
            for(int i=0; i<m_usages.size();i++)
                cout<<m_usages[i];

        }

        void test(){
            for(map<Optopt,Optarg>::iterator it=m_optmap.begin(); it!=m_optmap.end();it++){

                cout<<char((*it).first)<<" "<<(*it).second<<endl;
            }
        }
	protected:

	private:
        typedef int Optopt;
        typedef string Optarg;
        map<Optopt,Optarg> m_optmap;
        vector<string> m_usages;

        typedef struct option Optdef;
        vector<Optdef> m_longOpts;
        string m_optString;

};

#endif // COMMANDPARSER_H_INCLUDED
