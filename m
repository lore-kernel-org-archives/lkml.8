Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C948C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442A620734
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgEOCG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:06:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:49145 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgEOCGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:06:54 -0400
IronPort-SDR: 9siKRf6LkJK15HmK6xJeVJ0B2IetFRHqmRyU/3C0jC/ECqqR62lLw796nKWi8R4N/DoX3pcnl3
 QufK+ko0Z1RQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 19:06:52 -0700
IronPort-SDR: 1PBX2I1k3asjrnOMAQhmjQZa0DB8MQwIuvyxeNZgL9K9Yr4I0IcJIZTdrpIgc5rEmkXlh/zoGG
 mt5/JBGLWmig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="253660627"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 May 2020 19:06:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZPkQ-0006uy-Mw; Fri, 15 May 2020 10:06:50 +0800
Date:   Fri, 15 May 2020 10:06:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.05.14b] BUILD SUCCESS
 c1628f71b9ac81a2349f02cdebaaefe35a3fe4ba
Message-ID: <5ebdf91a.BjddnnXZSngq8I+z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.05.14b
branch HEAD: c1628f71b9ac81a2349f02cdebaaefe35a3fe4ba  ubsan, kcsan: Don't combine sanitizer with kcov on clang

i386-tinyconfig vmlinux size:

==========================================================================================================================
 TOTAL  TEXT  try_invoke_on_locked_down_task()                                                                            
==========================================================================================================================
    +1     0                                    353159365e72 rcu: Add KCSAN stubs                                         
     0     0                                    4f58820fd710 srcu: Add KCSAN stubs                                        
     0     0                                    2f0846956355 rcu: Mark rcu_state.ncpus to detect concurrent writes        
     0     0                                    314eeb43e5f2 rcu: Add *_ONCE() and data_race() to rcu_node ->exp_tasks pl 
     0     0                                    065a6db12a80 rcu: Add READ_ONCE and data_race() to rcu_node ->boost_tasks 
     0     0                                    b68c6146512d srcu: Add data_race() to ->srcu_lock_count and ->srcu_unlock 
     0     0                                    5822b8126ff0 rcu: Add WRITE_ONCE() to rcu_node ->boost_tasks              
     0     0                                    47fbb074536e rcu: Use data_race() for RCU CPU stall-warning prints        
     0     0                                    53965dbe5396 drm: Make drm_dp_mst_dsc_aux_for_port() safe for old compile 
     0     0                                    1fca4d12f463 rcu: Expedite first two FQS scans under callback-overload co 
     0     0                                    fcbcc0e70050 rcu: Fix the (t=0 jiffies) false positive                    
     0     0                                    ddc465936643 Revert "rculist: Describe variadic macro argument in a Sphin 
     0     0                                    c28d5c09d09f rcu: Get rid of some doc warnings in update.c                
     0     0                                    62ae19511f1e rcu: Mark rcu_state.gp_seq to detect more concurrent writes  
     0     0                                    a66dbda7893f rcu: Replace assigned pointer ret value by corresponding boo 
     0     0                                    da44cd6c8e88 rcu: Replace 1 by true                                       
     0     0                                    29ffebc5fcc0 rcu: Convert ULONG_CMP_GE() to time_after() for jiffy compar 
     0     0                                    7b2413111a63 rcu: Convert rcu_initiate_boost() ULONG_CMP_GE() to time_aft 
     0     0                                    e2f3ccfa6200 rcu: Convert rcu_nohz_full_cpu() ULONG_CMP_LT() to time_befo 
   +38   +38                                 0  0f63274855bd fork: Annotate a data race in vm_area_dup()                  
     0     0                                 0  44c5704098db x86/mm/pat: Mark an intentional data race                    
     0     0                                 0  79580081c819 rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                 0  c6509b6ebd35 locktorture: Use true and false to assign to bool variables  
     0     0                                 0  9ff7fb3ae801 srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                 0  a26e676ed124 rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                 0  e69d7d3457e1 docs: RCU: Convert checklist.txt to ReST                     
     0     0                                 0  5a0420ab6838 docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                 0  b511fe2f9ca3 docs: RCU: Convert lockdep.txt to ReST                       
     0     0                                 0  de5eeb13c7d3 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                 0  413d28ccf9a6 docs: RCU: Convert torture.txt to ReST                       
     0     0                                 0  bf964e388306 docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                 0  47e08ad9b727 docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                 0  714e2785e889 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                 0  fbadb7b741f5 rcutorture: Add races with task-exit processing              
     0     0                                 0  5f6efafb13cf torture: Set configfile variable to current scenario         
     0     0                                 0  8b9222ed9674 rcutorture: Handle non-statistic bang-string error messages  
     0     0                                 0  2f63f5f0262e rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                 0  af959932fe46 kcsan: Add test suite                                        
     0     0                                 0  b8a1cab5634a torture:  Remove qemu dependency on EFI firmware             
     0     0                                 0  3e9d89174418 doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                 0  1dd7f2639314 rcu: Add callbacks-invoked counters                          
     0     0                                 0  170f96c6fc1b rcu: Add comment documenting rcu_callback_map's purpose      
     0     0                                 0  ecc8bd43403e Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
     0     0                                 0  730b4bd431b9 rcu/tree: Add better tracing for dyntick-idle                
     0     0                                 0  583fd832d151 rcu/tree: Clean up dynticks counter usage                    
     0     0                                 0  0e94d87bed08 rcu/tree: Remove dynticks_nmi_nesting counter                
     0     0                                 0  1c039ba261f3 trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                 0  5ce7e23dcb27 torture: Add script to smoke-test commits in a branch        
     0     0                                 0  84de7b509b3f torture: Remove whitespace from identify_qemu_vcpus output   
     0     0                                 0  df2e4807c87c torture: Add --allcpus argument to the kvm.sh script         
     0     0                                 0  f410328e9383 Default enable RCU list lockdep debugging with PROVE_RCU     
     0     0                                 0  9ddfee9e6268 rcu: Grace-period-kthread related sleeps to idle priority    
     0     0                                 0  91ffb34451f9 rcu: Priority-boost-related sleeps to idle priority          
     0     0                                 0  4fcf987fe01b rcu: No-CBs-related sleeps to idle priority                  
     0     0                                 0  e317828f7d96 rcu: Expedited grace-period sleeps to idle priority          
     0     0                                 0  f023a0c8b110 rcu-tasks: Convert sleeps to idle priority                   
     0     0                                 0  059dce471ca3 fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
     0     0                                 0  ea1a170b65b2 locking/osq_lock: Annotate a data race in osq_lock           
     0     0                                 0  047c99c57e08 doc: Tasks RCU must protect instructions before trampoline   
     0     0                                 0  c1628f71b9ac ubsan, kcsan: Don't combine sanitizer with kcov on clang     
   -92   -93                               +83  ae83d0b416db..c1628f71b9ac (ALL COMMITS)                                  
==========================================================================================================================

elapsed time: 485m

configs tested: 119
configs skipped: 5

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
m68k                             allyesconfig
nios2                               defconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
arm                          exynos_defconfig
powerpc                      pmac32_defconfig
mips                         rt305x_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
powerpc                       holly_defconfig
arm                        oxnas_v6_defconfig
powerpc                           allnoconfig
s390                       zfcpdump_defconfig
powerpc                       maple_defconfig
sh                           se7722_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
arm                           efm32_defconfig
nios2                         3c120_defconfig
um                             i386_defconfig
arm                         lubbock_defconfig
arm                       multi_v4t_defconfig
arc                          axs103_defconfig
s390                                defconfig
arc                      axs103_smp_defconfig
arm                         cm_x2xx_defconfig
arm                         palmz72_defconfig
ia64                             allmodconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6678_defconfig
sh                            shmin_defconfig
arm                        neponset_defconfig
mips                      fuloong2e_defconfig
m68k                          atari_defconfig
m68k                          sun3x_defconfig
mips                        jmr3927_defconfig
arm                        cerfcube_defconfig
ia64                         bigsur_defconfig
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
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20200514
i386                 randconfig-a005-20200514
i386                 randconfig-a003-20200514
i386                 randconfig-a001-20200514
i386                 randconfig-a004-20200514
i386                 randconfig-a002-20200514
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
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
