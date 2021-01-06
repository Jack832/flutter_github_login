
class RepoVO{
  final String repoName;
  final int forks;
  final int openIssues;
  final String branch;
  final String date;
  RepoVO(this.repoName,this.forks,this.openIssues,this.branch,this.date);

  Map toJson() =>{
    'name' :repoName,
    'forks' :forks,
    'open_issues' :openIssues,
    'branch':branch,
    'created_at' :date
  };

  RepoVO.fromJson(Map map):
          repoName = map['name'],
          forks = map['forks'],
          openIssues = map['open_issue'],
          branch= map['branch'],
          date= map['created_at'];
}