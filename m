Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C436C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FE8207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390809AbgEZUEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:04:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:15698 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgEZUEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:04:04 -0400
IronPort-SDR: MiTOwbw7ouWO+BpP0LNzlaShPvhGR410SbQVf2j+OEz4ShKwj3rmBDs+2eSRe0yzZKrKJRFx0T
 jDvTKXIKEVLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 13:04:03 -0700
IronPort-SDR: mdtb4Xu5R1BhrDr1elWB+chnOvdo/F5DDNDq6NWcnDYWyLuDo/BN88KMPePqErtd4O3WMsvb+J
 sCCqlTgyij7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="255257249"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 May 2020 13:04:02 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdfnt-000Bn9-G6; Wed, 27 May 2020 04:04:01 +0800
Date:   Wed, 27 May 2020 04:03:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.05.25a] BUILD SUCCESS
 1e9451642683146552713c5ce6d269ae378eacd5
Message-ID: <5ecd761c.RHxS0wigFYlU2ROG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.05.25a
branch HEAD: 1e9451642683146552713c5ce6d269ae378eacd5  fixup! torture: Add refperf to the rcutorture scripting

i386-tinyconfig vmlinux size:

========================================================================================
 TOTAL  TEXT                                                                            
========================================================================================
  -224  -224  8747b07d1944 Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0  03e8e094dad9 Merge branch 'lkmm-dev.2020.05.16a' into HEAD                
     0     0  17e0ee2a3ec9 torture:  Remove qemu dependency on EFI firmware             
     0     0  c58148777978 torture: Add script to smoke-test commits in a branch        
   +38   +38  396a79cc6818 fork: Annotate a data race in vm_area_dup()                  
     0     0  8035e0fc710a x86/mm/pat: Mark an intentional data race                    
     0     0  d7a51c24ee4b rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0  e5efa2f1b7b6 locktorture: Use true and false to assign to bool variables  
     0     0  7514d7f181ab srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0  9dbd776542e3 rcu: Simplify the calculation of rcu_state.ncpus             
     0     0  df12d657bcc0 docs: RCU: Convert checklist.txt to ReST                     
     0     0  fdfeb779e1bd docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0  68b5951f7eb2 docs: RCU: Convert lockdep.txt to ReST                       
     0     0  ce9edc0c8a82 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0  1bee818b03c7 docs: RCU: Convert torture.txt to ReST                       
     0     0  9100131711bc docs: RCU: Convert rcuref.txt to ReST                        
     0     0  080f194cfa87 docs: RCU: Convert stallwarn.txt to ReST                     
     0     0  6999f47d8456 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0  55ce2e8178f2 rcutorture: Add races with task-exit processing              
     0     0  1c60a5e52538 torture: Set configfile variable to current scenario         
     0     0  9969401f1706 rcutorture: Handle non-statistic bang-string error messages  
     0     0  6f099e1b362b rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0  6816417616c4 kcsan: Add test suite                                        
     0     0  848d16e04f52 doc: Timer problems can cause RCU CPU stall warnings         
     0     0  2364a9f967ec rcu: Add callbacks-invoked counters                          
     0     0  2775724beeef rcu: Add comment documenting rcu_callback_map's purpose      
     0     0  bfd78bca7bdf Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
     0     0  8903088434e7 rcu/tree: Add better tracing for dyntick-idle                
     0     0  c0601bb42994 rcu/tree: Clean up dynticks counter usage                    
     0     0  3f3baaf3ac07 rcu/tree: Remove dynticks_nmi_nesting counter                
     0     0  725e4ad9e020 trace: events: rcu: Change description of rcu_dyntick trace  
    +1     0  a9b73fda34ec torture: Remove whitespace from identify_qemu_vcpus output   
     0     0  6267bacdff81 torture: Add --allcpus argument to the kvm.sh script         
    -1     0  5c6aa32472cb rcu: Grace-period-kthread related sleeps to idle priority    
    +1     0  f334f4fee6e2 rcu: Priority-boost-related sleeps to idle priority          
    -1     0  d49cb59f19b6 rcu: No-CBs-related sleeps to idle priority                  
    +1     0  4cc4ce9b67ec rcu: Expedited grace-period sleeps to idle priority          
     0     0  cef0575caddb rcu-tasks: Convert sleeps to idle priority                   
     0     0  988aef3524e2 fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
     0     0  70ca490c7ab3 locking/osq_lock: Annotate a data race in osq_lock           
     0     0  80fa4f7b355d doc: Tasks RCU must protect instructions before trampoline   
     0     0  1b397c884f7a doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq      
     0     0  dedad0a2118a tick/nohz: Narrow down noise while setting current task's ti 
     0     0  3055759634b2 rcu: fix some kernel-doc warnings                            
     0     0  cf10e7d90417 rcu: Remove initialized but unused rnp from check_slow_task( 
     0     0  af17eef88571 rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() n 
     0     0  55f712e9bd7b rcuperf: Remove useless while loops around wait_event        
     0     0  786a25497743 refperf: Add a test to measure performance of read-side sync 
     0     0  dc58d3c31f1f rcuperf: Add comments explaining the high reader overhead    
     0     0  a694aa3fc22c torture: Add refperf to the rcutorture scripting             
     0     0  d63e4a8d14d5 refperf: Add holdoff parameter to allow CPUs to come online  
     0     0  543387f1e59c refperf: Hoist function-pointer calls out of the loop        
     0     0  cb0ec0168301 fixup! torture: Add refperf to the rcutorture scripting      
     0     0  a24ecaed52b8 rcuperf: Allow decimal nanoseconds                           
     0     0  bb1200344bee fixup! torture: Add refperf to the rcutorture scripting      
     0     0  4446795bbe35 refperf: Convert nreaders to a module parameter              
     0     0  e05c9b634e0a refperf: Provide module parameter to specify number of exper 
     0     0  7b58622407bf refperf: Dynamically allocate experiment-summary output buff 
     0     0  4612778894d8 refperf: Dynamically allocate thread-summary output buffer   
     0     0  1e9451642683 fixup! torture: Add refperf to the rcutorture scripting      
  -176  -177  b1fcf9b83c41..1e9451642683 (ALL COMMITS)                                  
========================================================================================

elapsed time: 1148m

configs tested: 103
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
sh                           se7722_defconfig
arc                        vdk_hs38_defconfig
arm                          gemini_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
h8300                               defconfig
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
m68k                                defconfig
m68k                             allyesconfig
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
i386                 randconfig-a001-20200526
i386                 randconfig-a004-20200526
i386                 randconfig-a003-20200526
i386                 randconfig-a006-20200526
i386                 randconfig-a002-20200526
i386                 randconfig-a005-20200526
x86_64               randconfig-a015-20200526
x86_64               randconfig-a013-20200526
x86_64               randconfig-a016-20200526
x86_64               randconfig-a012-20200526
x86_64               randconfig-a014-20200526
x86_64               randconfig-a011-20200526
i386                 randconfig-a013-20200526
i386                 randconfig-a015-20200526
i386                 randconfig-a012-20200526
i386                 randconfig-a011-20200526
i386                 randconfig-a016-20200526
i386                 randconfig-a014-20200526
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
