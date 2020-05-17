Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C08C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 01:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE1E207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 01:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgEQBwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 21:52:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:27683 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgEQBwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 21:52:38 -0400
IronPort-SDR: 4IDLIdyl6EywMCuduPsGRKkBVlBcQyvx9gj0qVsoVtFX9KGN6B1qi0kJhGeQ7KmQgSTBggnP3Q
 phapayZEIW2A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 18:52:36 -0700
IronPort-SDR: ArHX6SdxDj7ZtlH4uuB1QJNXx2fUdU9fSONJJsuz+46fYguZ8Qr9Ay+iStgCvsXpr7HL8xedXT
 gS8xF+pPkesQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,401,1583222400"; 
   d="scan'208";a="288193365"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2020 18:52:35 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ja8Ti-0009Pc-W9; Sun, 17 May 2020 09:52:34 +0800
Date:   Sun, 17 May 2020 09:51:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.05.16a] BUILD SUCCESS
 0f214eff73a9c86bf1e5a0c566c190716782b6a9
Message-ID: <5ec098a6.TTvV3AatIfjO+4if%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.05.16a
branch HEAD: 0f214eff73a9c86bf1e5a0c566c190716782b6a9  tick/nohz: Narrow down noise while setting current task's tick dependency

i386-tinyconfig vmlinux size:

============================================================================================================================
 TOTAL  TEXT  arch/x86/events/zhaoxin/built-in.*                                                                            
============================================================================================================================
  -225  -224                                -136  f21d375f5014 Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0                                      0d3abc57e048 Merge branch 'lkmm-dev.2020.05.14b' into HEAD                
   +38   +38                                      4e07267a1891 fork: Annotate a data race in vm_area_dup()                  
     0     0                                      82ee1245c8ce x86/mm/pat: Mark an intentional data race                    
     0     0                                      3e745f06e547 rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                      3064b68481a8 locktorture: Use true and false to assign to bool variables  
     0     0                                      a77eaf80c023 srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                      7876218db8cb rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                      11b741bd89c5 docs: RCU: Convert checklist.txt to ReST                     
     0     0                                      dd051b8b94b5 docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                      0ac5a288bd8e docs: RCU: Convert lockdep.txt to ReST                       
     0     0                                      92943993fb41 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                      e8dd4b58c6fc docs: RCU: Convert torture.txt to ReST                       
     0     0                                      73ee3d5eec05 docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                      425c2ecca450 docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                      b8b9ee19d328 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                      7c76eb5e4209 rcutorture: Add races with task-exit processing              
     0     0                                      be8258baccc0 torture: Set configfile variable to current scenario         
     0     0                                      46de31180c5b rcutorture: Handle non-statistic bang-string error messages  
     0     0                                      f5d2e43344f1 rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                      046b23f81154 kcsan: Add test suite                                        
     0     0                                      f742885f1fbf torture:  Remove qemu dependency on EFI firmware             
     0     0                                      a34638af2455 doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                      8609e646d509 rcu: Add callbacks-invoked counters                          
     0     0                                      e1ea77a91005 rcu: Add comment documenting rcu_callback_map's purpose      
     0     0                                      037b0281beb8 Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
     0     0                                      adfc62c9416b rcu/tree: Add better tracing for dyntick-idle                
    +1     0                                      791756fd750d rcu/tree: Clean up dynticks counter usage                    
     0     0                                      4993b760a88f rcu/tree: Remove dynticks_nmi_nesting counter                
     0     0                                      e1b441a18227 trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                      9623376f6294 torture: Add script to smoke-test commits in a branch        
     0     0                                      b6d56227b204 torture: Remove whitespace from identify_qemu_vcpus output   
     0     0                                      b518c273d0d9 torture: Add --allcpus argument to the kvm.sh script         
     0     0                                      afd3653541c7 rcu: Grace-period-kthread related sleeps to idle priority    
     0     0                                      a969886c710d rcu: Priority-boost-related sleeps to idle priority          
     0     0                                      1fddc94e62d4 rcu: No-CBs-related sleeps to idle priority                  
     0     0                                      c4feb48f7230 rcu: Expedited grace-period sleeps to idle priority          
     0     0                                      af610e9dbd74 rcu-tasks: Convert sleeps to idle priority                   
     0     0                                      569a382d1e5f fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
     0     0                                      4ac696b08ad5 locking/osq_lock: Annotate a data race in osq_lock           
     0     0                                      a3f2dc389f08 doc: Tasks RCU must protect instructions before trampoline   
     0     0                                      5c1a94c798a7 ubsan, kcsan: Don't combine sanitizer with kcov on clang     
     0     0                                      074e56be3218 doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq      
     0     0                                      0f214eff73a9 tick/nohz: Narrow down noise while setting current task's ti 
  -177  -177                                -136  0adeeee7dd32..0f214eff73a9 (ALL COMMITS)                                  
============================================================================================================================

elapsed time: 529m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
arm                         bcm2835_defconfig
sparc                       sparc32_defconfig
ia64                             alldefconfig
sh                         ecovec24_defconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nios2                               defconfig
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
i386                 randconfig-a006-20200517
i386                 randconfig-a005-20200517
i386                 randconfig-a003-20200517
i386                 randconfig-a001-20200517
i386                 randconfig-a004-20200517
i386                 randconfig-a002-20200517
i386                 randconfig-a012-20200517
i386                 randconfig-a016-20200517
i386                 randconfig-a014-20200517
i386                 randconfig-a011-20200517
i386                 randconfig-a013-20200517
i386                 randconfig-a015-20200517
x86_64               randconfig-a005-20200517
x86_64               randconfig-a003-20200517
x86_64               randconfig-a006-20200517
x86_64               randconfig-a004-20200517
x86_64               randconfig-a001-20200517
x86_64               randconfig-a002-20200517
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
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
