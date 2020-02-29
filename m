Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC39AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 04:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B61C246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 04:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgB2EYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 23:24:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:2917 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB2EYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 23:24:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 20:24:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,498,1574150400"; 
   d="gz'50?scan'50,208,50";a="242581529"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2020 20:24:15 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j7tfi-000FQe-NR; Sat, 29 Feb 2020 12:24:14 +0800
Date:   Sat, 29 Feb 2020 12:23:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] proc: Remove the now unnecessary internal mount of
 proc
Message-ID: <202002291254.mYsR31pv%lkp@intel.com>
References: <87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Eric,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on uml/linux-next]
[also build test ERROR on linux/master kees/for-next/pstore linus/master v5.6-rc3 next-20200228]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Eric-W-Biederman/proc-Actually-honor-the-mount-options/20200229-100926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/proc/base.c: In function 'proc_flush_task':
>> fs/proc/base.c:3217:31: error: 'struct pid_namespace' has no member named 'proc_mnt'
    3217 |   proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
         |                               ^~

vim +3217 fs/proc/base.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  3180  
0895e91d60ef9b Randy Dunlap      2007-10-21  3181  /**
0895e91d60ef9b Randy Dunlap      2007-10-21  3182   * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
0895e91d60ef9b Randy Dunlap      2007-10-21  3183   * @task: task that should be flushed.
0895e91d60ef9b Randy Dunlap      2007-10-21  3184   *
0895e91d60ef9b Randy Dunlap      2007-10-21  3185   * When flushing dentries from proc, one needs to flush them from global
60347f6716aa49 Pavel Emelyanov   2007-10-18  3186   * proc (proc_mnt) and from all the namespaces' procs this task was seen
0895e91d60ef9b Randy Dunlap      2007-10-21  3187   * in. This call is supposed to do all of this job.
0895e91d60ef9b Randy Dunlap      2007-10-21  3188   *
0895e91d60ef9b Randy Dunlap      2007-10-21  3189   * Looks in the dcache for
0895e91d60ef9b Randy Dunlap      2007-10-21  3190   * /proc/@pid
0895e91d60ef9b Randy Dunlap      2007-10-21  3191   * /proc/@tgid/task/@pid
0895e91d60ef9b Randy Dunlap      2007-10-21  3192   * if either directory is present flushes it and all of it'ts children
0895e91d60ef9b Randy Dunlap      2007-10-21  3193   * from the dcache.
0895e91d60ef9b Randy Dunlap      2007-10-21  3194   *
0895e91d60ef9b Randy Dunlap      2007-10-21  3195   * It is safe and reasonable to cache /proc entries for a task until
0895e91d60ef9b Randy Dunlap      2007-10-21  3196   * that task exits.  After that they just clog up the dcache with
0895e91d60ef9b Randy Dunlap      2007-10-21  3197   * useless entries, possibly causing useful dcache entries to be
0895e91d60ef9b Randy Dunlap      2007-10-21  3198   * flushed instead.  This routine is proved to flush those useless
0895e91d60ef9b Randy Dunlap      2007-10-21  3199   * dcache entries at process exit time.
0895e91d60ef9b Randy Dunlap      2007-10-21  3200   *
0895e91d60ef9b Randy Dunlap      2007-10-21  3201   * NOTE: This routine is just an optimization so it does not guarantee
0895e91d60ef9b Randy Dunlap      2007-10-21  3202   *       that no dcache entries will exist at process exit time it
0895e91d60ef9b Randy Dunlap      2007-10-21  3203   *       just makes it very unlikely that any will persist.
60347f6716aa49 Pavel Emelyanov   2007-10-18  3204   */
60347f6716aa49 Pavel Emelyanov   2007-10-18  3205  
60347f6716aa49 Pavel Emelyanov   2007-10-18  3206  void proc_flush_task(struct task_struct *task)
60347f6716aa49 Pavel Emelyanov   2007-10-18  3207  {
9fcc2d15b14894 Eric W. Biederman 2007-11-14  3208  	int i;
9b4d1cbef8f41a Oleg Nesterov     2009-09-22  3209  	struct pid *pid, *tgid;
130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3210  	struct upid *upid;
130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3211  
130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3212  	pid = task_pid(task);
130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3213  	tgid = task_tgid(task);
9fcc2d15b14894 Eric W. Biederman 2007-11-14  3214  
9fcc2d15b14894 Eric W. Biederman 2007-11-14  3215  	for (i = 0; i <= pid->level; i++) {
130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3216  		upid = &pid->numbers[i];
130f77ecb2e7d5 Pavel Emelyanov   2007-10-18 @3217  		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
9b4d1cbef8f41a Oleg Nesterov     2009-09-22  3218  					tgid->numbers[i].nr);
130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3219  	}
60347f6716aa49 Pavel Emelyanov   2007-10-18  3220  }
60347f6716aa49 Pavel Emelyanov   2007-10-18  3221  

:::::: The code at line 3217 was first introduced by commit
:::::: 130f77ecb2e7d5ac3e53e620f55e374f4a406b20 pid namespaces: make proc_flush_task() actually from entries from multiple namespaces

:::::: TO: Pavel Emelyanov <xemul@openvz.org>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--EeQfGwPcQSOJBaQU--
