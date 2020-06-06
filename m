Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902D5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 02:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622C4206F0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 02:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgFFCI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 22:08:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:3450 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgFFCIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 22:08:55 -0400
IronPort-SDR: ibzYNCLoQuDnZGJsWjE16zfhdgit4Z7PJ8BuzdHrmXL2FiB2reB+lFsPM/GrvLyqhHvyDA+2Us
 U9rBSIL2+jhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 19:08:23 -0700
IronPort-SDR: NkBp2oIOygSs3Sw4/3FWIpoeeRMQ+YQjVJ2hr+hgPdofrDV3m82K+UN1pTTgYSU9yA5e0Ggzkt
 eaNPjDLGySyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; 
   d="scan'208";a="417465063"
Received: from lkp-server02.sh.intel.com (HELO 85fa322b0eb2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2020 19:08:21 -0700
Received: from kbuild by 85fa322b0eb2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jhOFx-0000TO-3e; Sat, 06 Jun 2020 02:08:21 +0000
Date:   Sat, 06 Jun 2020 10:07:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.06.02a] BUILD REGRESSION
 5216948905dd07a84cef8a7dc72c2ec076802efd
Message-ID: <5edafa72.UrKzo8rnXmRJi3kh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.06.02a
branch HEAD: 5216948905dd07a84cef8a7dc72c2ec076802efd  torture: Create qemu-cmd in --buildonly runs

Error/Warning in current branch:

(.text+0x80c): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: (.text+0x860): undefined reference to `__aeabi_uldivmod'
kernel/smp.c:122: undefined reference to `__udivdi3'
ld: kernel/smp.c:128: undefined reference to `__udivdi3'
ld: kernel/smp.c:136: undefined reference to `__umoddi3'
ld: smp.c:(.text+0x5a3): undefined reference to `__udivdi3'
ld: smp.c:(.text+0x648): undefined reference to `__umoddi3'
smp.c:(.text+0x55a): undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-allyesconfig
|   |-- (.text):undefined-reference-to-__aeabi_uldivmod
|   `-- arm-linux-gnueabi-ld:(.text):undefined-reference-to-__aeabi_uldivmod
|-- i386-allmodconfig
|   |-- ld:smp.c:(.text):undefined-reference-to-__udivdi3
|   |-- ld:smp.c:(.text):undefined-reference-to-__umoddi3
|   `-- smp.c:(.text):undefined-reference-to-__udivdi3
|-- i386-allyesconfig
|   |-- ld:smp.c:(.text):undefined-reference-to-__udivdi3
|   |-- ld:smp.c:(.text):undefined-reference-to-__umoddi3
|   `-- smp.c:(.text):undefined-reference-to-__udivdi3
`-- i386-randconfig-c001-20200605
    |-- kernel-smp.c:undefined-reference-to-__udivdi3
    |-- ld:kernel-smp.c:undefined-reference-to-__udivdi3
    `-- ld:kernel-smp.c:undefined-reference-to-__umoddi3


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
     0     0                                   0  63452ac13382 refperf: Convert nreaders to a module parameter              
     0     0                                   0  7251a934ea19 refperf: Provide module parameter to specify number of exper 
     0     0                                   0  093461eeaff4 refperf: Dynamically allocate experiment-summary output buff 
     0     0                                   0  716ef41b54a6 refperf: Dynamically allocate thread-summary output buffer   
     0     0                                   0  5772330da07b srcu: Avoid local_irq_save() before acquiring spinlock_t     
     0     0                                   0  1c62f6690562 refperf: Make functions static                               
     0     0                                   0  484792950aed refperf: Tune reader measurement interval                    
     0     0                                   0  6ec003a89728 refperf: Convert reader_task structure's "start" field to in 
     0     0                                   0  a01f0d0a3dc9 refperf: More closely synchronize reader start times         
     0     0                                   0  7d16add62717 rcuperf: Fix kfree_mult to match printk() format             
     0     0                                   0  bc374477cc71 refperf: Add warmup and cooldown processing phases           
     0     0                                   0  a9868255e8c5 refperf: Label experiment-number column "Runs"               
     0     0                                   0  357da0e90935 refperf: Output per-experiment data points                   
     0     0                                   0  d16ff49e03b1 refperf: Simplify initialization-time wakeup protocol        
     0     0                                   0  a32fdd9b4047 lockdep: Complain only once about RCU in extended quiescent  
     0     0                                   0  f0601adfe91d refperf: Add read-side delay module parameter                
     0     0                                   0  aec9d8219e92 rcu-tasks: Make rcu_tasks_postscan() be static               
     0     0                                   0  32b5befa6acc rcu-tasks: Add #include of rcupdate_trace.h to update.c      
     0     0                                   0  54b7fd524386 rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads( 
     0     0                                   0  70374403a086 refperf: Adjust refperf.loop default value                   
     0     0                                   0  7903da67e12d doc: Document rcuperf's module parameters                    
     0     0                                   0  b8ddb7812bf0 refperf: Work around 64-bit division                         
     0     0                                   0  7c4283671969 refperf: Change readdelay module parameter to nanoseconds    
     0     0                                   0  230f38bba350 refperf: Add test for RCU Tasks Trace readers.               
     0     0                                   0  272ff09a4bc9 rcu/rcutorture: Replace 0 with false                         
     0     0                                   0  c88ad6e8ec38 rcu: Replace 1 with true                                     
    -1     0                                -136  a0fd2081c605 kcsan: Prefer '__no_kcsan inline' in test                    
    +1     0                                +136  92ebbb71443d EXP kernel/smp: Provide CSD lock timeout diagnostics         
     0     0                                   0  2cd332ee56be refperf: Add test for RCU Tasks readers                      
     0     0                                   0  eb56974d6b84 fixup! refperf: Convert nreaders to a module parameter       
     0     0                                   0  87e824f08358 tools/memory-model/README: Expand dependency of klitmus7     
     0     0                                   0  6087659edf45 rcu: Stop shrinker loop                                      
     0     0                                   0  5216948905dd torture: Create qemu-cmd in --buildonly runs                 
  -189  -189                                +136  b1fcf9b83c41..5216948905dd (ALL COMMITS)                                  
============================================================================================================================

elapsed time: 486m

configs tested: 90
configs skipped: 2

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
mips                         tb0287_defconfig
ia64                        generic_defconfig
arc                             nps_defconfig
s390                             alldefconfig
h8300                               defconfig
i386                              allnoconfig
arm                       imx_v4_v5_defconfig
alpha                               defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         lpc32xx_defconfig
riscv                             allnoconfig
mips                          ath79_defconfig
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
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                            allyesconfig
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
um                               allyesconfig
um                                allnoconfig
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
