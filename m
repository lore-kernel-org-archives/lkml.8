Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0738C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE69620772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFAFws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:52:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:37614 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgFAFwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:52:47 -0400
IronPort-SDR: t2kdZaal3AcbUIdEDmPcTaQ9PogkT1r7T96hk1fxs5JQdukocLmdZiVtcPeihHkkB0/c0xTxh5
 hInd+JDnzSeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:52:46 -0700
IronPort-SDR: Tml+sV7POtmLGOD8to24EppaEVV/Vm1Z4ifjv0HvW8Z3/jaKMaZmiVGBSs3DU8fWBl3zKyJuv8
 lKnL4m8BidhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="257149888"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2020 22:52:44 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfdNM-0000W9-6C; Mon, 01 Jun 2020 05:52:44 +0000
Date:   Mon, 01 Jun 2020 13:51:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.05.25b] BUILD SUCCESS
 39d28156618fd7787f3363cf66d77918c94abc54
Message-ID: <5ed49758.Hnaf9OnRHpr/eIjC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.05.25b
branch HEAD: 39d28156618fd7787f3363cf66d77918c94abc54  refperf: Output per-experiment data points

i386-tinyconfig vmlinux size:

========================================================================================================================================
 TOTAL  TEXT  built-in.*  arch/x86/events/zhaoxin/built-in.*                                                                            
========================================================================================================================================
  -233  -233                                                  8747b07d1944 Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0                                                  03e8e094dad9 Merge branch 'lkmm-dev.2020.05.16a' into HEAD                
     0     0                                                  17e0ee2a3ec9 torture:  Remove qemu dependency on EFI firmware             
     0     0                                                  c58148777978 torture: Add script to smoke-test commits in a branch        
   +38   +38                                                  396a79cc6818 fork: Annotate a data race in vm_area_dup()                  
     0     0                                                  8035e0fc710a x86/mm/pat: Mark an intentional data race                    
     0     0                                                  d7a51c24ee4b rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                                  e5efa2f1b7b6 locktorture: Use true and false to assign to bool variables  
     0     0                                                  7514d7f181ab srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                                  9dbd776542e3 rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                                  df12d657bcc0 docs: RCU: Convert checklist.txt to ReST                     
     0     0                                                  fdfeb779e1bd docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                                  68b5951f7eb2 docs: RCU: Convert lockdep.txt to ReST                       
     0     0                                                  ce9edc0c8a82 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                                  1bee818b03c7 docs: RCU: Convert torture.txt to ReST                       
     0     0                                                  9100131711bc docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                                  080f194cfa87 docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                                  6999f47d8456 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                                  55ce2e8178f2 rcutorture: Add races with task-exit processing              
     0     0                                                  1c60a5e52538 torture: Set configfile variable to current scenario         
     0     0                                                  9969401f1706 rcutorture: Handle non-statistic bang-string error messages  
     0     0                                                  6f099e1b362b rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                                  6816417616c4 kcsan: Add test suite                                        
     0     0                                                  848d16e04f52 doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                                  2364a9f967ec rcu: Add callbacks-invoked counters                          
     0     0                                                  2775724beeef rcu: Add comment documenting rcu_callback_map's purpose      
     0     0     +138684                                      bfd78bca7bdf Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
    +1     0     -138684                                      8903088434e7 rcu/tree: Add better tracing for dyntick-idle                
    -1     0                                                  c0601bb42994 rcu/tree: Clean up dynticks counter usage                    
     0     0                                                  3f3baaf3ac07 rcu/tree: Remove dynticks_nmi_nesting counter                
    +1     0                                                  725e4ad9e020 trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                                  a9b73fda34ec torture: Remove whitespace from identify_qemu_vcpus output   
    -1     0     +138684                                      6267bacdff81 torture: Add --allcpus argument to the kvm.sh script         
    +1     0     -138684                                      5c6aa32472cb rcu: Grace-period-kthread related sleeps to idle priority    
    -1     0     +138684                                      f334f4fee6e2 rcu: Priority-boost-related sleeps to idle priority          
     0     0           0                                      d49cb59f19b6 rcu: No-CBs-related sleeps to idle priority                  
    +1     0     -138684                                      4cc4ce9b67ec rcu: Expedited grace-period sleeps to idle priority          
    -1     0     +138684                                      cef0575caddb rcu-tasks: Convert sleeps to idle priority                   
     0     0           0                                      988aef3524e2 fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
     0     0     -138684                                      70ca490c7ab3 locking/osq_lock: Annotate a data race in osq_lock           
    +1     0                                                  80fa4f7b355d doc: Tasks RCU must protect instructions before trampoline   
    -1     0     +138684                                      1b397c884f7a doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq      
     0     0     -138684                                      dedad0a2118a tick/nohz: Narrow down noise while setting current task's ti 
     0     0     +138684                                      3055759634b2 rcu: fix some kernel-doc warnings                            
    +1     0     -138684                                      cf10e7d90417 rcu: Remove initialized but unused rnp from check_slow_task( 
    -1     0     +138684                                      af17eef88571 rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() n 
     0     0     -138684                                      55f712e9bd7b rcuperf: Remove useless while loops around wait_event        
     0     0     +138684                                      786a25497743 refperf: Add a test to measure performance of read-side sync 
     0     0           0                                      dc58d3c31f1f rcuperf: Add comments explaining the high reader overhead    
     0     0     -138684                                      b2ff7128cdf1 torture: Add refperf to the rcutorture scripting             
     0     0                                                  7dde0e35f67b refperf: Add holdoff parameter to allow CPUs to come online  
     0     0     +138684                                      2ba85f14b266 refperf: Hoist function-pointer calls out of the loop        
     0     0     -138684                                      bd5b16d6c88d refperf: Allow decimal nanoseconds                           
     0     0     +138684                                      4cce30d135de refperf: Convert nreaders to a module parameter              
     0     0     -138684                                      9088b449814f refperf: Provide module parameter to specify number of exper 
     0     0     +138684                                      54c0ed208976 refperf: Dynamically allocate experiment-summary output buff 
     0     0           0                                      4fa9948454ae refperf: Dynamically allocate thread-summary output buffer   
     0     0     -138684                                      928da8256e03 srcu: Avoid local_irq_save() before acquiring spinlock_t     
    +1     0                                            +136  d87e0fb190cf refperf: Make functions static                               
    -1     0                                            -136  3ae51b9de96a refperf: Tune reader measurement interval                    
     0     0                                                  9858eb4802da refperf: Convert reader_task structure's "start" field to in 
     0     0                                                  d17c25920e29 refperf: More closely synchronize reader start times         
     0     0                                                  2fbc7d67a2ed rcuperf: Fix kfree_mult to match printk() format             
     0     0                                                  3c6bfc74bf08 refperf: Add warmup and cooldown processing phases           
     0     0                                                  86d8d02d2f1a fixup! refperf: Provide module parameter to specify number o 
     0     0                                                  f05d5fc91b06 refperf: Label experiment-number column "Runs"               
     0     0                                                  39d28156618f refperf: Output per-experiment data points                   
  -189  -189                                                  b1fcf9b83c41..39d28156618f (ALL COMMITS)                                  
========================================================================================================================================

elapsed time: 7626m

configs tested: 84
configs skipped: 1

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
mips                malta_kvm_guest_defconfig
arm                         socfpga_defconfig
nds32                             allnoconfig
mips                          malta_defconfig
arc                              alldefconfig
arm                         orion5x_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                              allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                                defconfig
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
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
arc                              allyesconfig
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
powerpc                           allnoconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
um                                allnoconfig
um                               allmodconfig
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
