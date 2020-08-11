Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB9CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF38720774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHKXkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:40:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:17649 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgHKXkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:40:20 -0400
IronPort-SDR: P0tVTh9Qc5ltIPsouDQTeiI0j7aOv12X8OqG7TJ3KdE+Ln3ZnOhkhmUzEujr0MazjzeucQ/2Y+
 epu1knSbKoSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="141467701"
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="gz'50?scan'50,208,50";a="141467701"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 16:40:18 -0700
IronPort-SDR: Mw74LTYYUkdSNbbS6QcKBki4yy4M9/3PQE0LmhKXCPEOmSVTr6k03jHsvKJo1dTb/K3a/PsRZD
 PHp3fT0zKehA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="gz'50?scan'50,208,50";a="324906527"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2020 16:40:17 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5dsO-0000ql-IK; Tue, 11 Aug 2020 23:40:16 +0000
Date:   Wed, 12 Aug 2020 07:40:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.08.10a 105/111] riscv64-linux-ld: main.c:undefined
 reference to `rcu_read_unlock_strict'
Message-ID: <202008120701.iIY4BdGm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.08.10a
head:   9dd4d242c535c30266a08806314ea6b016f94617
commit: 9e20110f8ef2745df8f4fe2d679114dccfaaa1af [105/111] rcu: Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs
config: riscv-allnoconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9e20110f8ef2745df8f4fe2d679114dccfaaa1af
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: init/main.o: in function `.L0 ':
   main.c:(.ref.text+0x34): undefined reference to `rcu_read_unlock_strict'
>> riscv64-linux-ld: main.c:(.ref.text+0x64): undefined reference to `rcu_read_unlock_strict'
   riscv64-linux-ld: kernel/fork.o: in function `.L26':
   fork.c:(.text+0x144): undefined reference to `rcu_read_unlock_strict'
   riscv64-linux-ld: kernel/fork.o: in function `.L27':
   fork.c:(.text+0x164): undefined reference to `rcu_read_unlock_strict'
   riscv64-linux-ld: kernel/fork.o: in function `.L183':
   fork.c:(.text+0xbb4): undefined reference to `rcu_read_unlock_strict'
   riscv64-linux-ld: kernel/fork.o:fork.c:(.text+0xbd4): more undefined references to `rcu_read_unlock_strict' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
FI+zQAKQhTPsO7vsQVbIxHr/C6jOOqV8SgAA

--ZGiS0Q5IWpPtfppv--
