Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10986C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C976624685
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgCDBdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:33:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:40490 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgCDBdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:33:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 17:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="gz'50?scan'50,208,50";a="274458533"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2020 17:33:21 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j9IuX-00062w-17; Wed, 04 Mar 2020 09:33:21 +0800
Date:   Wed, 4 Mar 2020 09:33:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.03.03b 43/45] kernel/rcu/update.c:583:2: error:
 implicit declaration of function 'rcu_tasks_bootup_oddness'
Message-ID: <202003040915.QC7nV6ZR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.03b
head:   647c0bb2da5c14b25d27661fa93de7fca9042daf
commit: d060bd985c4d160df31659a80cf5fabe1cd508b4 [43/45] rcu-tasks: Refactor RCU-tasks to allow variants to be added
config: openrisc-simple_smp_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d060bd985c4d160df31659a80cf5fabe1cd508b4
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/rcu/update.c: In function 'rcupdate_announce_bootup_oddness':
>> kernel/rcu/update.c:583:2: error: implicit declaration of function 'rcu_tasks_bootup_oddness' [-Werror=implicit-function-declaration]
     583 |  rcu_tasks_bootup_oddness();
         |  ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/rcu_tasks_bootup_oddness +583 kernel/rcu/update.c

59d80fd8351b7b Paul E. McKenney 2017-04-28  567  
59d80fd8351b7b Paul E. McKenney 2017-04-28  568  /*
59d80fd8351b7b Paul E. McKenney 2017-04-28  569   * Print any significant non-default boot-time settings.
59d80fd8351b7b Paul E. McKenney 2017-04-28  570   */
59d80fd8351b7b Paul E. McKenney 2017-04-28  571  void __init rcupdate_announce_bootup_oddness(void)
59d80fd8351b7b Paul E. McKenney 2017-04-28  572  {
59d80fd8351b7b Paul E. McKenney 2017-04-28  573  	if (rcu_normal)
59d80fd8351b7b Paul E. McKenney 2017-04-28  574  		pr_info("\tNo expedited grace period (rcu_normal).\n");
59d80fd8351b7b Paul E. McKenney 2017-04-28  575  	else if (rcu_normal_after_boot)
59d80fd8351b7b Paul E. McKenney 2017-04-28  576  		pr_info("\tNo expedited grace period (rcu_normal_after_boot).\n");
59d80fd8351b7b Paul E. McKenney 2017-04-28  577  	else if (rcu_expedited)
59d80fd8351b7b Paul E. McKenney 2017-04-28  578  		pr_info("\tAll grace periods are expedited (rcu_expedited).\n");
59d80fd8351b7b Paul E. McKenney 2017-04-28  579  	if (rcu_cpu_stall_suppress)
59d80fd8351b7b Paul E. McKenney 2017-04-28  580  		pr_info("\tRCU CPU stall warnings suppressed (rcu_cpu_stall_suppress).\n");
59d80fd8351b7b Paul E. McKenney 2017-04-28  581  	if (rcu_cpu_stall_timeout != CONFIG_RCU_CPU_STALL_TIMEOUT)
59d80fd8351b7b Paul E. McKenney 2017-04-28  582  		pr_info("\tRCU CPU stall warnings timeout set to %d (rcu_cpu_stall_timeout).\n", rcu_cpu_stall_timeout);
59d80fd8351b7b Paul E. McKenney 2017-04-28 @583  	rcu_tasks_bootup_oddness();
59d80fd8351b7b Paul E. McKenney 2017-04-28  584  }
59d80fd8351b7b Paul E. McKenney 2017-04-28  585  

:::::: The code at line 583 was first introduced by commit
:::::: 59d80fd8351b7b9a5dc7bbfa8bc4ca19f6ff3dad rcu: Print out rcupdate.c non-default boot-time settings

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--opJtzjQTFsWo+cga--
