Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A1CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015622074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFBTo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:44:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:42183 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBTo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:44:59 -0400
IronPort-SDR: UhP3lZKCBwkY9ujZZYJYRfl2o/5D12z9128TipV7AfOflo6oQeEtObC4lGaRBFaxBvZ+BQVu/c
 pbpaniHa4dDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 12:44:58 -0700
IronPort-SDR: pdINC7VjCKeru4Mi5GPAm8QJDcypPjUR8XkyYL4wSp1jyIFGiAFSnHee1M/bQ0ZIVZKT9jVNzD
 cs2vZOb+Pxfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; 
   d="scan'208";a="416293574"
Received: from lkp-server01.sh.intel.com (HELO e5a7ad696f24) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2020 12:44:57 -0700
Received: from kbuild by e5a7ad696f24 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgCqG-00009e-BH; Tue, 02 Jun 2020 19:44:56 +0000
Date:   Wed, 03 Jun 2020 03:43:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 25de110d148666752dc0e0da7a0b69de31cd7098
Message-ID: <5ed6abfe.BSTtJb/dEuvZ7sfb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  sched/core
branch HEAD: 25de110d148666752dc0e0da7a0b69de31cd7098  irq_work: Define irq_work_single() on !CONFIG_IRQ_WORK too

i386-tinyconfig vmlinux size:

==============================================================================================================================================================
 TOTAL  TEXT  try_invoke_on_locked_down_task()  arch/x86/events/zhaoxin/built-in.*                                                                            
==============================================================================================================================================================
    -1     0                                                                  -136  c6e7bd7afaeb sched/core: Optimize ttwu() spinning on p->on_cpu            
     0     0                                                                  +136  2ebb17717550 sched/core: Offload wakee task activation if it the wakee is 
     0     0                                                                  -136  498bdcdb949e Merge branch 'sched/urgent' into sched/core, to pick up fix  
  +172  +172                               +76                                      58ef57b16d9e Merge branch 'core/rcu' into sched/core, to pick up dependen 
     0     0                                 0                                      19a1f5ec6999 sched: Fix smp_call_function_single_async() usage for ILB    
     0     0                                 0                                      52103be07d8b smp: Optimize flush_smp_call_function_queue()                
     0     0                                 0                                      afaa653c564d smp: Move irq_work_run() out of flush_smp_call_function_queu 
     0     0                                 0                                      b2a02fc43a1f smp: Optimize send_call_function_single_ipi()                
    +1    +1                                 0                                      4b44a21dd640 irq_work, smp: Allow irq_work on call_single_queue           
   -31     0                                 0                                      126c2092e5c8 sched: Add rq::ttwu_pending                                  
     0     0                                 0                                      a148866489fb sched: Replace rq::wake_list                                 
     0     0                                 0                                +136  1f8db4150536 sched/headers: Split out open-coded prototypes into kernel/s 
    -1     0                                 0                                   0  25de110d1486 irq_work: Define irq_work_single() on !CONFIG_IRQ_WORK too   
  +140  +173                               +76                                   0  d505b8af5891..25de110d1486 (ALL COMMITS)                                  
==============================================================================================================================================================

elapsed time: 485m

configs tested: 111
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arc                         haps_hs_defconfig
sparc64                             defconfig
arm                      pxa255-idp_defconfig
sh                             shx3_defconfig
arm                              alldefconfig
mips                           ip28_defconfig
xtensa                generic_kc705_defconfig
arc                             nps_defconfig
arm                        keystone_defconfig
arm                        multi_v5_defconfig
nios2                               defconfig
arm                        shmobile_defconfig
mips                           xway_defconfig
arm                          ixp4xx_defconfig
sh                           se7780_defconfig
arm                          moxart_defconfig
sh                               j2_defconfig
sparc64                          allyesconfig
arm                            mps2_defconfig
powerpc                     pseries_defconfig
arm                       netwinder_defconfig
xtensa                       common_defconfig
mips                          ath79_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         hackkit_defconfig
mips                     cu1000-neo_defconfig
x86_64                              defconfig
ia64                             allmodconfig
powerpc                  storcenter_defconfig
mips                  decstation_64_defconfig
sh                   rts7751r2dplus_defconfig
sh                     magicpanelr2_defconfig
parisc                            allnoconfig
mips                           ci20_defconfig
mips                           ip22_defconfig
s390                             alldefconfig
c6x                        evmc6472_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
