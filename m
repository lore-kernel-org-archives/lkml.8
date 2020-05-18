Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5F5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E9D20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgERBBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:01:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:15784 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgERBBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:01:47 -0400
IronPort-SDR: l14H6Uj1eMXhwPz+bjCuveFDFBU1tmVvosQ893jiwNMcB5MEbZF/aUknerfsKb6ifWvP7phQKb
 Eu7WPLgSjN6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 18:01:45 -0700
IronPort-SDR: g4r+Vpzx6y6zgrPq+KnTwHY7k5FF7Hmrbsp6uIUrcbnw2Jb+1IAb/XXgKE5PB8g9/no8wx2dTa
 YV+BTNgNrS3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,405,1583222400"; 
   d="scan'208";a="465592442"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2020 18:01:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaUA3-000DzV-3n; Mon, 18 May 2020 09:01:43 +0800
Date:   Mon, 18 May 2020 09:00:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.05.16b] BUILD SUCCESS
 a136026322ab53d8e6c16d5394d8858ff58734ec
Message-ID: <5ec1de3d.SCfGkmG1H/TWe5nn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.05.16b
branch HEAD: a136026322ab53d8e6c16d5394d8858ff58734ec  tick/nohz: Narrow down noise while setting current task's tick dependency

i386-tinyconfig vmlinux size:

============================================================================================================================
 TOTAL  TEXT  arch/x86/events/zhaoxin/built-in.*                                                                            
============================================================================================================================
  -225  -224                                -136  f21d375f5014 Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0                                +136  a2dbbcab9f92 Merge branch 'lkmm-dev.2020.05.16a' into HEAD                
   +38   +38                                   0  2b1504d6d829 fork: Annotate a data race in vm_area_dup()                  
     0     0                                   0  0f70c0f4492e x86/mm/pat: Mark an intentional data race                    
     0     0                                   0  de41f941b567 rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                   0  1abab1ad92eb locktorture: Use true and false to assign to bool variables  
     0     0                                   0  9cbf290947d6 srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                   0  6c1e0ae41c11 rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                   0  b1685eebf4e7 docs: RCU: Convert checklist.txt to ReST                     
     0     0                                   0  16e20563df88 docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                   0  e4c987790ff4 docs: RCU: Convert lockdep.txt to ReST                       
     0     0                                   0  edc1a6b38d58 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                   0  a6b7ad30b208 docs: RCU: Convert torture.txt to ReST                       
     0     0                                   0  91eb3f11b9e1 docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                   0  1ebcbb15d737 docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                   0  598b9f862211 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                   0  8aaeb5125243 rcutorture: Add races with task-exit processing              
     0     0                                   0  5c8e537402d9 torture: Set configfile variable to current scenario         
     0     0                                   0  db29a71d6cce rcutorture: Handle non-statistic bang-string error messages  
     0     0                                   0  ead35f54f211 rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                   0  faf865144299 kcsan: Add test suite                                        
     0     0                                   0  2f48f720b7bc torture:  Remove qemu dependency on EFI firmware             
     0     0                                   0  8ae4131601ef doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                   0  c25a812e9ecc rcu: Add callbacks-invoked counters                          
     0     0                                   0  6c4efe2625f9 rcu: Add comment documenting rcu_callback_map's purpose      
    +1     0                                   0  1b2530e7d0c3 Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
     0     0                                   0  03f31532d0ce rcu/tree: Add better tracing for dyntick-idle                
     0     0                                   0  a309d5ce2335 rcu/tree: Clean up dynticks counter usage                    
     0     0                                   0  5c6e734fbaeb rcu/tree: Remove dynticks_nmi_nesting counter                
     0     0                                   0  bc666ef50700 trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                   0  9055994e10c9 torture: Add script to smoke-test commits in a branch        
     0     0                                   0  ff29aecf039b torture: Remove whitespace from identify_qemu_vcpus output   
     0     0                                   0  fcf95b789b06 torture: Add --allcpus argument to the kvm.sh script         
     0     0                                   0  9346f5c9537e rcu: Grace-period-kthread related sleeps to idle priority    
     0     0                                   0  f4f61f144291 rcu: Priority-boost-related sleeps to idle priority          
     0     0                                   0  5835f972e185 rcu: No-CBs-related sleeps to idle priority                  
     0     0                                   0  c397985b487e rcu: Expedited grace-period sleeps to idle priority          
     0     0                                   0  69e95e6e69ef rcu-tasks: Convert sleeps to idle priority                   
     0     0                                   0  211ef52376c7 fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
     0     0                                   0  d4f27f5f67dc locking/osq_lock: Annotate a data race in osq_lock           
     0     0                                   0  01d362c93e79 doc: Tasks RCU must protect instructions before trampoline   
     0     0                                   0  22db64813afb ubsan, kcsan: Don't combine sanitizer with kcov on clang     
     0     0                                   0  63141f73adb1 doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq      
     0     0                                   0  a136026322ab tick/nohz: Narrow down noise while setting current task's ti 
  -177  -177                                   0  0adeeee7dd32..a136026322ab (ALL COMMITS)                                  
============================================================================================================================

elapsed time: 482m

configs tested: 123
configs skipped: 6

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
mips                  cavium_octeon_defconfig
microblaze                          defconfig
powerpc64                        alldefconfig
arm                      integrator_defconfig
arc                     nsimosci_hs_defconfig
s390                                defconfig
arm                  colibri_pxa300_defconfig
arm                        clps711x_defconfig
mips                  maltasmvp_eva_defconfig
arm                        magician_defconfig
sh                                allnoconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                          exynos_defconfig
m68k                                defconfig
sparc64                             defconfig
arm                       multi_v4t_defconfig
sh                        dreamcast_defconfig
powerpc                     skiroot_defconfig
powerpc                    amigaone_defconfig
mips                           mtx1_defconfig
parisc                generic-64bit_defconfig
c6x                         dsk6455_defconfig
sh                           sh2007_defconfig
arm                         s3c6400_defconfig
arm                              zx_defconfig
arm                        mvebu_v5_defconfig
arc                        nsim_700_defconfig
sh                        sh7757lcr_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
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
x86_64               randconfig-a005-20200517
x86_64               randconfig-a003-20200517
x86_64               randconfig-a006-20200517
x86_64               randconfig-a004-20200517
x86_64               randconfig-a001-20200517
x86_64               randconfig-a002-20200517
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
x86_64                              defconfig
sparc                               defconfig
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
