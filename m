Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB8C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB272074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 18:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgIES4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:56:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:44448 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgIES4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 14:56:32 -0400
IronPort-SDR: fygREe8meD6FR1do08yXxsZj8/sPJEGgEuw8lQRQACIurGl9mrnMj0wMPdnxGAjL+A6LofEsQe
 RuFN7ZVlqJoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9735"; a="222084685"
X-IronPort-AV: E=Sophos;i="5.76,395,1592895600"; 
   d="scan'208";a="222084685"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 11:56:30 -0700
IronPort-SDR: lE9MdW1RFiORsaxSsS4ATRvsgBRB5BIylK6YFTDPB4I5Mn5hOXLrG9DbCE93dz2fiCevrenjnC
 1Zq926HzRFTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,395,1592895600"; 
   d="scan'208";a="478990137"
Received: from lkp-server01.sh.intel.com (HELO 4b5d6de90563) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Sep 2020 11:56:29 -0700
Received: from kbuild by 4b5d6de90563 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kEdMS-00002a-Oh; Sat, 05 Sep 2020 18:56:28 +0000
Date:   Sun, 06 Sep 2020 02:56:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.09.03a] BUILD REGRESSION
 e710c928fb52d8e56bc6173515805301da6aa22b
Message-ID: <5f53df43.ehwUl8tNA8+dUcuY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.09.03a
branch HEAD: e710c928fb52d8e56bc6173515805301da6aa22b  rcu: Panic after fixed number of stalls

Error/Warning in current branch:

ERROR: modpost: "resched_cpu" [kernel/scftorture.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- m68k-allmodconfig
    `-- ERROR:resched_cpu-kernel-scftorture.ko-undefined

elapsed time: 1266m

configs tested: 140
configs skipped: 8

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
m68k                            q40_defconfig
m68k                       m5208evb_defconfig
m68k                       m5249evb_defconfig
arm                         mv78xx0_defconfig
sh                        edosk7705_defconfig
arm                         axm55xx_defconfig
xtensa                    xip_kc705_defconfig
powerpc                          allmodconfig
s390                                defconfig
m68k                                defconfig
nios2                               defconfig
sh                           se7751_defconfig
m68k                         apollo_defconfig
sh                        edosk7760_defconfig
openrisc                         alldefconfig
mips                        vocore2_defconfig
arm                          simpad_defconfig
arm                          collie_defconfig
arm                        multi_v7_defconfig
arm                       imx_v6_v7_defconfig
parisc                           allyesconfig
sh                         ecovec24_defconfig
arm                        mvebu_v5_defconfig
mips                          malta_defconfig
openrisc                 simple_smp_defconfig
arm                         nhk8815_defconfig
arm                      tct_hammer_defconfig
sh                             sh03_defconfig
mips                      loongson3_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
sh                     sh7710voipgw_defconfig
arm                        trizeps4_defconfig
arm                          imote2_defconfig
arm                            mmp2_defconfig
sparc                       sparc64_defconfig
sh                           se7780_defconfig
nios2                            alldefconfig
sh                          landisk_defconfig
arc                         haps_hs_defconfig
mips                            ar7_defconfig
sh                           se7619_defconfig
sh                   sh7724_generic_defconfig
ia64                         bigsur_defconfig
arc                     nsimosci_hs_defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
powerpc                     skiroot_defconfig
sh                           se7750_defconfig
mips                      fuloong2e_defconfig
powerpc                       ppc64_defconfig
arm                         palmz72_defconfig
s390                             alldefconfig
arm                  colibri_pxa270_defconfig
mips                           xway_defconfig
m68k                       m5275evb_defconfig
powerpc                      ep88xc_defconfig
m68k                          atari_defconfig
mips                          ath25_defconfig
xtensa                       common_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200905
x86_64               randconfig-a004-20200905
x86_64               randconfig-a003-20200905
x86_64               randconfig-a005-20200905
x86_64               randconfig-a001-20200905
x86_64               randconfig-a002-20200905
i386                 randconfig-a004-20200904
i386                 randconfig-a005-20200904
i386                 randconfig-a006-20200904
i386                 randconfig-a002-20200904
i386                 randconfig-a003-20200904
i386                 randconfig-a001-20200904
x86_64               randconfig-a013-20200906
x86_64               randconfig-a011-20200906
x86_64               randconfig-a016-20200906
x86_64               randconfig-a012-20200906
x86_64               randconfig-a015-20200906
x86_64               randconfig-a014-20200906
x86_64               randconfig-a013-20200904
x86_64               randconfig-a011-20200904
x86_64               randconfig-a016-20200904
x86_64               randconfig-a012-20200904
x86_64               randconfig-a015-20200904
x86_64               randconfig-a014-20200904
i386                 randconfig-a016-20200904
i386                 randconfig-a015-20200904
i386                 randconfig-a011-20200904
i386                 randconfig-a013-20200904
i386                 randconfig-a014-20200904
i386                 randconfig-a012-20200904
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3

clang tested configs:
x86_64               randconfig-a006-20200904
x86_64               randconfig-a004-20200904
x86_64               randconfig-a003-20200904
x86_64               randconfig-a005-20200904
x86_64               randconfig-a001-20200904
x86_64               randconfig-a002-20200904

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
