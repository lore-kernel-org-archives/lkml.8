Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F30C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 04:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255B8207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 04:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgEGE5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 00:57:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:60351 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgEGE5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 00:57:53 -0400
IronPort-SDR: COK7HTCWCE8GEmK0Qf8569sM5grSOC1UoaroU2TiFaahB+LVFnIMkeDyL0W0Iwqj0UYkFnBbf/
 2RaYQAJ5P46Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 21:57:49 -0700
IronPort-SDR: nRBUo+tO6VCoabnuvkTwwNmUszYYFckwifX277eWP5gDZknDfrIfE7lmrFvw6iun1/6mG+e48f
 3fLYPxUbIvqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="435154206"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2020 21:57:48 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWYbT-00083O-DP; Thu, 07 May 2020 12:57:47 +0800
Date:   Thu, 07 May 2020 12:57:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.05.06a] BUILD SUCCESS
 b93fdeb9aaec0c7769bac9c9333e50789a5d2e50
Message-ID: <5eb39545.zT7wjmuIbn4/9uDG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.05.06a
branch HEAD: b93fdeb9aaec0c7769bac9c9333e50789a5d2e50  torture: Add --allcpus argument to the kvm.sh script

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
   +84   +84                               +83  b6c10df0dbfe Merge branches 'fixes.2020.04.27a', 'kfree_rcu.2020.04.27a', 
  -226  -224                                 0  7ebf70dbd2e9 Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0                                 0  2fdef63182c5 Merge branch 'lkmm-dev.2020.04.15b' into HEAD                
   +38   +38                                 0  556d27a9e7c0 fork: Annotate a data race in vm_area_dup()                  
     0     0                                 0  10e01f0b5659 x86/mm/pat: Mark an intentional data race                    
     0     0                                 0  929ff10a375e rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                 0  1395d383355b locktorture: Use true and false to assign to bool variables  
     0     0                                 0  4a959fa04eb3 srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                 0  19208b635e74 rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                 0  d504de269f4e docs: RCU: Convert checklist.txt to ReST                     
     0     0                                 0  72399472281d docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                 0  c60525fba896 docs: RCU: Convert lockdep.txt to ReST                       
     0     0                                 0  76fd8200df48 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                 0  2084826b5151 docs: RCU: Convert torture.txt to ReST                       
     0     0                                 0  f3eb4ab6f0a2 docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                 0  1625788a000e docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                 0  4f044ee7882a docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                 0  89eb4ebbcc9c rcutorture: Add races with task-exit processing              
     0     0                                 0  0c7d55bd4642 objtool, kcsan: Add kcsan_disable_current() and kcsan_enable 
     0     0                                 0  fb5bfdc2aad6 torture: Set configfile variable to current scenario         
     0     0                                 0  546299d1178d rcutorture: Handle non-statistic bang-string error messages  
     0     0                                 0  2cdf04f6de72 rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                 0  0ff2e9efc5c3 kcsan: Add test suite                                        
     0     0                                 0  88e25d0f5d1b torture:  Remove qemu dependency on EFI firmware             
     0     0                                 0  5967f46b437d doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                 0  b2ea25dfae4f rcu: Add callbacks-invoked counters                          
     0     0                                 0  fbe957023b07 rcu: Add comment documenting rcu_callback_map's purpose      
    +1     0                                 0  d333f4a243ef Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
     0     0                                 0  c67538c81ce2 rcu/tree: Add better tracing for dyntick-idle                
     0     0                                 0  d9115cabb275 rcu/tree: Clean up dynticks counter usage                    
     0     0                                 0  3d8d6c0a3ef8 rcu/tree: Remove dynticks_nmi_nesting counter                
     0     0                                 0  7f63d013a119 trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                 0  ce5026da8907 torture: Add script to smoke-test commits in a branch        
     0     0                                 0  a1dc56b0ccb6 torture: Remove whitespace from identify_qemu_vcpus output   
     0     0                                 0  b93fdeb9aaec torture: Add --allcpus argument to the kvm.sh script         
   -93   -93                               +83  ae83d0b416db..b93fdeb9aaec (ALL COMMITS)                                  
==========================================================================================================================

elapsed time: 482m

configs tested: 138
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
ia64                             allyesconfig
i386                              allnoconfig
s390                             allmodconfig
riscv                               defconfig
powerpc                             defconfig
ia64                             alldefconfig
um                               allmodconfig
nds32                               defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
microblaze                       allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          alldefconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
m68k                 randconfig-a001-20200506
mips                 randconfig-a001-20200506
nds32                randconfig-a001-20200506
parisc               randconfig-a001-20200506
alpha                randconfig-a001-20200506
riscv                randconfig-a001-20200506
m68k                 randconfig-a001-20200507
mips                 randconfig-a001-20200507
nds32                randconfig-a001-20200507
parisc               randconfig-a001-20200507
alpha                randconfig-a001-20200507
riscv                randconfig-a001-20200507
h8300                randconfig-a001-20200506
nios2                randconfig-a001-20200506
microblaze           randconfig-a001-20200506
c6x                  randconfig-a001-20200506
sparc64              randconfig-a001-20200506
s390                 randconfig-a001-20200506
xtensa               randconfig-a001-20200506
sh                   randconfig-a001-20200506
openrisc             randconfig-a001-20200506
csky                 randconfig-a001-20200506
x86_64               randconfig-c002-20200506
i386                 randconfig-c002-20200506
i386                 randconfig-c003-20200506
i386                 randconfig-c001-20200506
i386                 randconfig-e003-20200506
x86_64               randconfig-e003-20200506
x86_64               randconfig-e001-20200506
i386                 randconfig-e002-20200506
i386                 randconfig-e001-20200506
x86_64               randconfig-a003-20200506
x86_64               randconfig-a001-20200506
x86_64               randconfig-a002-20200506
i386                 randconfig-a001-20200506
i386                 randconfig-a002-20200506
i386                 randconfig-a003-20200506
x86_64               randconfig-g003-20200506
i386                 randconfig-g003-20200506
i386                 randconfig-g002-20200506
x86_64               randconfig-g001-20200506
i386                 randconfig-g001-20200506
x86_64               randconfig-g002-20200506
i386                 randconfig-h002-20200506
i386                 randconfig-h001-20200506
i386                 randconfig-h003-20200506
x86_64               randconfig-h002-20200506
x86_64               randconfig-h003-20200506
x86_64               randconfig-h001-20200506
ia64                 randconfig-a001-20200507
arm64                randconfig-a001-20200507
arc                  randconfig-a001-20200507
arm                  randconfig-a001-20200507
sparc                randconfig-a001-20200507
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             alldefconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
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
