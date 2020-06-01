Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABD3206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgFAFxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:53:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:37647 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgFAFxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:53:00 -0400
IronPort-SDR: khE98j4mxASZaK/A0hrHsrFEM22TLv8iWyTL9CJ+ig7m2+6CHd9n+tmbsaCI5bv2BttiP573kY
 pZhU8y1GaOYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:52:59 -0700
IronPort-SDR: xg8gy2hZ/QGdZUARoaHwdiA5MMyVUbaZTz2uYF51yNsJ+mN96aeErDj4k/8wl7O7OJOXtrskBx
 N6C9d4PeC9FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="286169892"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 May 2020 22:52:58 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfdNZ-0000XX-Mb; Mon, 01 Jun 2020 05:52:57 +0000
Date:   Mon, 01 Jun 2020 13:51:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.sched/core] BUILD REGRESSION
 1f8db4150536431b031585ecc2a6793f69245de2
Message-ID: <5ed4977e.0ESin4hABcdaKBlv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  WIP.sched/core
branch HEAD: 1f8db4150536431b031585ecc2a6793f69245de2  sched/headers: Split out open-coded prototypes into kernel/sched/smp.h

Error/Warning in current branch:

smp.c:(.text+0x10c): undefined reference to `irq_work_single'
smp.c:(.text+0x110): undefined reference to `irq_work_single'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-allnoconfig
|   `-- smp.c:(.text):undefined-reference-to-irq_work_single
`-- s390-allnoconfig
    `-- smp.c:(.text):undefined-reference-to-irq_work_single


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
  +141  +173                               +76                                   0  d505b8af5891..1f8db4150536 (ALL COMMITS)                                  
==============================================================================================================================================================

elapsed time: 5488m

configs tested: 152
configs skipped: 9

arm                                 defconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                              allyesconfig
arm                              allmodconfig
um                           x86_64_defconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
arm                         vf610m4_defconfig
arm                        trizeps4_defconfig
sparc                       sparc64_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
powerpc                      pasemi_defconfig
h8300                            allyesconfig
sh                             sh03_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
mips                         db1xxx_defconfig
mips                        nlm_xlr_defconfig
mips                        nlm_xlp_defconfig
sh                          rsk7269_defconfig
ia64                        generic_defconfig
mips                             allyesconfig
m68k                            q40_defconfig
sh                           se7724_defconfig
mips                malta_qemu_32r6_defconfig
mips                            e55_defconfig
mips                       lemote2f_defconfig
arm                            pleb_defconfig
sh                             espt_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
sparc64                          allyesconfig
microblaze                    nommu_defconfig
arc                          axs101_defconfig
powerpc                       maple_defconfig
nds32                             allnoconfig
sh                               allmodconfig
arm                        mvebu_v5_defconfig
arc                        nsim_700_defconfig
arm                        mvebu_v7_defconfig
mips                      maltaaprp_defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
arm                       cns3420vb_defconfig
arm                        spear3xx_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200529
i386                 randconfig-a001-20200529
i386                 randconfig-a002-20200529
i386                 randconfig-a006-20200529
i386                 randconfig-a003-20200529
i386                 randconfig-a005-20200529
i386                 randconfig-a004-20200531
i386                 randconfig-a003-20200531
i386                 randconfig-a006-20200531
i386                 randconfig-a002-20200531
i386                 randconfig-a005-20200531
i386                 randconfig-a001-20200531
x86_64               randconfig-a011-20200531
x86_64               randconfig-a016-20200531
x86_64               randconfig-a012-20200531
x86_64               randconfig-a014-20200531
x86_64               randconfig-a013-20200531
x86_64               randconfig-a015-20200531
x86_64               randconfig-a002-20200529
x86_64               randconfig-a006-20200529
x86_64               randconfig-a005-20200529
x86_64               randconfig-a001-20200529
x86_64               randconfig-a004-20200529
x86_64               randconfig-a003-20200529
i386                 randconfig-a013-20200529
i386                 randconfig-a011-20200529
i386                 randconfig-a012-20200529
i386                 randconfig-a015-20200529
i386                 randconfig-a016-20200529
i386                 randconfig-a014-20200529
i386                 randconfig-a013-20200531
i386                 randconfig-a012-20200531
i386                 randconfig-a015-20200531
i386                 randconfig-a011-20200531
i386                 randconfig-a016-20200531
i386                 randconfig-a014-20200531
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                                defconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                                allnoconfig
um                               allyesconfig
um                               allmodconfig
um                                  defconfig
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
