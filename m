Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A3B20801
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbgFIAPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:15:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:59232 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730869AbgFIAPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:15:24 -0400
IronPort-SDR: EFGL2dMu+w2Xa8BeBMDYvznIi3BkIkbJwt1aOxma3z4UaQiJ/R850OOkVd7l3IpdB5WJQ/1ZXA
 by3W7Cva22/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 17:15:24 -0700
IronPort-SDR: 2jE1yL44YRx5wXGa2gZyeDfvB8Cw93TF2/l3h4SFNKYpAgGofMs2duM0dYNRR1gRaZ3pATlI2N
 CO9mkYJuP0Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,489,1583222400"; 
   d="scan'208";a="314045736"
Received: from lkp-server01.sh.intel.com (HELO 12d5c0ac8e64) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2020 17:15:21 -0700
Received: from kbuild by 12d5c0ac8e64 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jiRvF-00004J-9W; Tue, 09 Jun 2020 00:15:21 +0000
Date:   Tue, 09 Jun 2020 08:05:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.06.05a] BUILD REGRESSION
 c5432e18c8bfe9283bf5e0bc5e2460ae8f39a7ee
Message-ID: <5eded238.ZnKhOmS6OYYobxUH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.06.05a
branch HEAD: c5432e18c8bfe9283bf5e0bc5e2460ae8f39a7ee  rcuperf: Further fix printk format warning

Error/Warning in current branch:

powerpc-linux-ld: kernel/smp.c:128: undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc64-randconfig-c024-20200607
    `-- powerpc-linux-ld:kernel-smp.c:undefined-reference-to-__udivdi3


i386-tinyconfig vmlinux size:

============================================================================================================================
 TOTAL  TEXT  arch/x86/events/zhaoxin/built-in.*                                                                            
============================================================================================================================
    -1     0                                      b3e2d20973db rcuperf: Fix printk format warning                           
  -233  -233                                +136  6f1a383dd3b1 Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0                                   0  191a685f4f2f Merge branch 'lkmm-dev.2020.05.16a' into HEAD                
     0     0                                   0  78df41a9c13a torture:  Remove qemu dependency on EFI firmware             
     0     0                                   0  571b05c483d2 torture: Add script to smoke-test commits in a branch        
   +38   +38                                   0  e88deb89ed6a fork: Annotate a data race in vm_area_dup()                  
     0     0                                   0  e534895edc55 x86/mm/pat: Mark an intentional data race                    
     0     0                                   0  bce3f442b911 rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                   0  afa06b508109 locktorture: Use true and false to assign to bool variables  
     0     0                                   0  1318fb21873e srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                   0  c4c78437db28 rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                   0  97e3dab5cebc docs: RCU: Convert checklist.txt to ReST                     
     0     0                                   0  890bb7fe302c docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                   0  8c8b194c3a41 docs: RCU: Convert lockdep.txt to ReST                       
     0     0                                   0  c999e5cd7aa7 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                   0  09f2ded72f2e docs: RCU: Convert torture.txt to ReST                       
     0     0                                   0  e68e913d34a2 docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                   0  91080f1874d1 docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                   0  c89ecb29b2d8 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                   0  ddca16397b69 rcutorture: Add races with task-exit processing              
     0     0                                   0  59c16d050ff8 torture: Set configfile variable to current scenario         
     0     0                                   0  54351dd51082 rcutorture: Handle non-statistic bang-string error messages  
     0     0                                   0  5a510624b945 rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                   0  eaf2dde8be47 kcsan: Add test suite                                        
     0     0                                   0  f21fb721039d doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                   0  834d28c7b403 rcu: Add callbacks-invoked counters                          
    +1     0                                   0  7ec7b6a96122 rcu: Add comment documenting rcu_callback_map's purpose      
     0     0                                   0  2027c0175333 Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
     0     0                                   0  fce79449d4f5 rcu/tree: Add better tracing for dyntick-idle                
     0     0                                   0  6d0026bcc373 rcu/tree: Clean up dynticks counter usage                    
     0     0                                   0  8a00baf57f8d rcu/tree: Remove dynticks_nmi_nesting counter                
     0     0                                   0  86c5a37ba1c4 trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                   0  ac45e88c3171 torture: Remove whitespace from identify_qemu_vcpus output   
     0     0                                   0  eb3413bab732 torture: Add --allcpus argument to the kvm.sh script         
     0     0                                   0  8a33a0254a7d rcu: Grace-period-kthread related sleeps to idle priority    
     0     0                                   0  dafabfab26e7 rcu: Priority-boost-related sleeps to idle priority          
     0     0                                   0  5e482bc4e619 rcu: No-CBs-related sleeps to idle priority                  
     0     0                                   0  f411a8d5a59a rcu: Expedited grace-period sleeps to idle priority          
     0     0                                   0  41d887097fab rcu-tasks: Convert sleeps to idle priority                   
     0     0                                   0  3ecbfe4fa2f2 fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
     0     0                                   0  cf3fa62d84e1 locking/osq_lock: Annotate a data race in osq_lock           
     0     0                                   0  c152b7d96ee2 doc: Tasks RCU must protect instructions before trampoline   
     0     0                                   0  c53a43c252b8 doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq      
     0     0                                   0  c9a03aedb8fe tick/nohz: Narrow down noise while setting current task's ti 
     0     0                                   0  0b1b4e3ad8e9 rcu: fix some kernel-doc warnings                            
     0     0                                   0  8390964aaf03 rcu: Remove initialized but unused rnp from check_slow_task( 
     0     0                                   0  fd97166981e6 rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() n 
     0     0                                   0  9df19861701f rcuperf: Remove useless while loops around wait_event        
     0     0                                   0  2783ca3ea28a refperf: Add a test to measure performance of read-side sync 
     0     0                                   0  007b4ddd5c43 rcuperf: Add comments explaining the high reader overhead    
     0     0                                   0  7aeb9796b71e torture: Add refperf to the rcutorture scripting             
     0     0                                   0  06593893a534 refperf: Add holdoff parameter to allow CPUs to come online  
     0     0                                   0  b8549dc713c9 refperf: Hoist function-pointer calls out of the loop        
     0     0                                   0  67c9317844d0 refperf: Allow decimal nanoseconds                           
    -1     0                                   0  eb6d364fafb8 refperf: Convert nreaders to a module parameter              
     0     0                                   0  ebc37da04456 refperf: Provide module parameter to specify number of exper 
     0     0                                   0  ba83d49e4bb3 refperf: Dynamically allocate experiment-summary output buff 
     0     0                                   0  04012ace1809 refperf: Dynamically allocate thread-summary output buffer   
     0     0                                   0  6e8dfef46b0c srcu: Avoid local_irq_save() before acquiring spinlock_t     
     0     0                                   0  cf34abbfb304 refperf: Make functions static                               
     0     0                                   0  5626a109cb6b refperf: Tune reader measurement interval                    
     0     0                                   0  e2993b36b5b9 refperf: Convert reader_task structure's "start" field to in 
     0     0                                   0  e1f1359a3f69 refperf: More closely synchronize reader start times         
     0     0                                   0  5b6654be9916 rcuperf: Fix kfree_mult to match printk() format             
     0     0                                   0  f912f548913a refperf: Add warmup and cooldown processing phases           
     0     0                                   0  44b2e02c5006 refperf: Label experiment-number column "Runs"               
     0     0                                   0  1bc6f2ea0d93 refperf: Output per-experiment data points                   
     0     0                                   0  e5e994467e8c refperf: Simplify initialization-time wakeup protocol        
     0     0                                   0  baaf43fb4306 lockdep: Complain only once about RCU in extended quiescent  
     0     0                                   0  12f5442d718f refperf: Add read-side delay module parameter                
     0     0                                   0  0c0fb47c6018 rcu-tasks: Make rcu_tasks_postscan() be static               
     0     0                                   0  d281a747d782 rcu-tasks: Add #include of rcupdate_trace.h to update.c      
     0     0                                   0  e029f0d77e62 rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads( 
     0     0                                   0  21260cd9332d refperf: Adjust refperf.loop default value                   
     0     0                                   0  19328ca515a8 doc: Document rcuperf's module parameters                    
     0     0                                   0  83dfc8e86fcf refperf: Work around 64-bit division                         
     0     0                                   0  2b7d4e8ded4a refperf: Change readdelay module parameter to nanoseconds    
     0     0                                   0  28f37a2dec3e refperf: Add test for RCU Tasks Trace readers.               
     0     0                                   0  4778d228811d rcu/rcutorture: Replace 0 with false                         
     0     0                                   0  64c1fc2e0c10 rcu: Replace 1 with true                                     
     0     0                                   0  7e3ac6970d13 kcsan: Prefer '__no_kcsan inline' in test                    
     0     0                                   0  3f8c62d29ead EXP kernel/smp: Provide CSD lock timeout diagnostics         
     0     0                                   0  1f48f77be8c0 refperf: Add test for RCU Tasks readers                      
     0     0                                   0  694f2440eebc tools/memory-model/README: Expand dependency of klitmus7     
     0     0                                   0  3992f2e15c9a rcu: Stop shrinker loop                                      
     0     0                                   0  56a88ed755e5 torture: Create qemu-cmd in --buildonly runs                 
     0     0                                   0  57a56f435086 fixup! EXP kernel/smp: Provide CSD lock timeout diagnostics  
     0     0                                   0  c2e2e4194231 EXP sched: Experimental patch                                
     0     0                                   0  c5432e18c8bf rcuperf: Further fix printk format warning                   
  -190  -189                                +136  b1fcf9b83c41..c5432e18c8bf (ALL COMMITS)                                  
============================================================================================================================

elapsed time: 483m

configs tested: 96
configs skipped: 5

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
powerpc                      ep88xc_defconfig
sh                ecovec24-romimage_defconfig
c6x                        evmc6457_defconfig
m68k                        mvme16x_defconfig
ia64                      gensparse_defconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
i386                 randconfig-a001-20200607
i386                 randconfig-a006-20200607
i386                 randconfig-a002-20200607
i386                 randconfig-a005-20200607
i386                 randconfig-a004-20200607
i386                 randconfig-a003-20200607
i386                 randconfig-a014-20200608
i386                 randconfig-a011-20200608
i386                 randconfig-a015-20200608
i386                 randconfig-a016-20200608
i386                 randconfig-a012-20200608
i386                 randconfig-a013-20200608
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
