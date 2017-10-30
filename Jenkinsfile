def fail(reason) {
  def pr_branch = ''
  if (env.CHANGE_BRANCH != null) {
    pr_branch = " (${env.CHANGE_BRANCH})"
  }
  /*(
  slackSend color: 'danger', message: "Build #${env.BUILD_NUMBER} of <${env.BUILD_URL}|${env.JOB_NAME}>${pr_branch} failed (<${env.BUILD_URL}/console|console>, <${env.BUILD_URL}/changes|changes>)\nCause: ${reason}", channel: '#lisk-explorer-jenkins'
  */
  currentBuild.result = 'FAILURE'
  error("${reason}")
}

node('lisk-explorer-01'){
  try {
    stage ('Prepare Workspace') {
      deleteDir()
      checkout scm
    }

    stage ('Shellcheck') {
      try {
        sh '''#!/bin/bash
        # shellcheck
        shopt -s globstar; shellcheck **/*.sh 
        '''
      } catch (err) {
        echo "Error: ${err}"
        fail('Stopping build, installation failed')
      }
    }
  } catch(err) {
    echo "Error: ${err}"
  } finally {
    def pr_branch = ''
    if (env.CHANGE_BRANCH != null) {
      pr_branch = " (${env.CHANGE_BRANCH})"
    }
    if (currentBuild.result == 'SUCCESS') {
      /* delete all files on success */
      deleteDir()
      /* notify of success if previous build failed */
      previous_build = currentBuild.getPreviousBuild()
      /*
      if (previous_build != null && previous_build.result == 'FAILURE') {
        slackSend color: 'good',
                  message: "Recovery: build #${env.BUILD_NUMBER} of <${env.BUILD_URL}|${env.JOB_NAME}>${pr_branch} was successful.",
                  channel: '#lisk-explorer-jenkins'
      }
      */
    }
  }
}
