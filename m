Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C78C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E69B2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgESCw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:52:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:27747 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgESCw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:52:28 -0400
IronPort-SDR: D741joAqXMutdo8PMZq67YhFwWg3Iy4490sokfh6Beqe7v3cjKAQhuOHOV/owJUPNOZNT98l53
 LeEQ5c8qtxMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 19:52:28 -0700
IronPort-SDR: RkfVDaiP3kXtYzJifao7PW6GkrN0+4/TiVqcCzqdzefs/DF0QWCSm7ShSKxIwv0Ct9ELVO1wPd
 cZDDDMkbyYhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="282182093"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2020 19:52:26 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jasMj-0000W6-Gu; Tue, 19 May 2020 10:52:25 +0800
Date:   Tue, 19 May 2020 10:51:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 68cd9f4e7238839c590c1eb02302c5741f62700b
Message-ID: <5ec349cf.AW85dBit06tEBg9G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 68cd9f4e7238839c590c1eb02302c5741f62700b  tick/nohz: Narrow down noise while setting current task's tick dependency

i386-tinyconfig vmlinux size:

============================================================================================================================
 TOTAL  TEXT  arch/x86/events/zhaoxin/built-in.*                                                                            
============================================================================================================================
  -225  -224                                -136  f21d375f5014 Merge branch 'kcsan-dev.2020.04.13c' into HEAD               
     0     0                                +136  a2dbbcab9f92 Merge branch 'lkmm-dev.2020.05.16a' into HEAD                
     0     0                                -136  0ccf50efbcde torture:  Remove qemu dependency on EFI firmware             
     0     0                                      68ba178084b7 torture: Add script to smoke-test commits in a branch        
   +38   +38                                      1ed85645da6f fork: Annotate a data race in vm_area_dup()                  
     0     0                                      9706e500af92 x86/mm/pat: Mark an intentional data race                    
    +1     0                                      73143a2756f2 rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init 
     0     0                                      df9e0d326c58 locktorture: Use true and false to assign to bool variables  
     0     0                                      31836e7f3957 srcu: Fix a typo in comment "amoritized"->"amortized"        
     0     0                                      8dc81894e15e rcu: Simplify the calculation of rcu_state.ncpus             
     0     0                                      866d35bc4268 docs: RCU: Convert checklist.txt to ReST                     
     0     0                                      a5a641694e90 docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0                                      075d262d495a docs: RCU: Convert lockdep.txt to ReST                       
     0     0                                      030f202e9320 docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0                                      719a5977c19e docs: RCU: Convert torture.txt to ReST                       
     0     0                                      07fda9360cb8 docs: RCU: Convert rcuref.txt to ReST                        
     0     0                                      43a6aa111c1b docs: RCU: Convert stallwarn.txt to ReST                     
     0     0                                      fb821a0f1ae9 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0                                      f684413ca0fe rcutorture: Add races with task-exit processing              
     0     0                                      642c60ddf812 torture: Set configfile variable to current scenario         
     0     0                                      358b76258c2b rcutorture: Handle non-statistic bang-string error messages  
     0     0                                      6b38c8a9e78b rcutorture: NULL rcu_torture_current earlier in cleanup code 
     0     0                                      6d9c6773218b kcsan: Add test suite                                        
     0     0                                      58a00281305d doc: Timer problems can cause RCU CPU stall warnings         
     0     0                                      7286dcd8100f rcu: Add callbacks-invoked counters                          
     0     0                                      eee5c02a9c54 rcu: Add comment documenting rcu_callback_map's purpose      
     0     0                                      196d069523d7 Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom o 
     0     0                                      517213014c07 rcu/tree: Add better tracing for dyntick-idle                
     0     0                                      e18e6adf3fb1 rcu/tree: Clean up dynticks counter usage                    
     0     0                                      035be4f36ec9 rcu/tree: Remove dynticks_nmi_nesting counter                
     0     0                                      cd3a9f7eb268 trace: events: rcu: Change description of rcu_dyntick trace  
     0     0                                      15e6274bd8e0 torture: Remove whitespace from identify_qemu_vcpus output   
     0     0                                      8e2bb86cf48f torture: Add --allcpus argument to the kvm.sh script         
     0     0                                      0e47cb02a13f rcu: Grace-period-kthread related sleeps to idle priority    
     0     0                                      de75483d02eb rcu: Priority-boost-related sleeps to idle priority          
     0     0                                      0d6fb0eb3c27 rcu: No-CBs-related sleeps to idle priority                  
     0     0                                      04172e98fa9a rcu: Expedited grace-period sleeps to idle priority          
     0     0                                      4f41f854eff3 rcu-tasks: Convert sleeps to idle priority                   
     0     0                                      dae667494ffa fs/btrfs: Add cond_resched() for try_release_extent_mapping( 
     0     0                                      b1b2ccd81f39 locking/osq_lock: Annotate a data race in osq_lock           
     0     0                                      531c3224d19f doc: Tasks RCU must protect instructions before trampoline   
     0     0                                      0fcfee4481c1 ubsan, kcsan: Don't combine sanitizer with kcov on clang     
     0     0                                      c2c970dec439 doc: Update comment from rsp->rcu_gp_seq to rsp->gp_seq      
     0     0                                      68cd9f4e7238 tick/nohz: Narrow down noise while setting current task's ti 
  -177  -177                                -136  0adeeee7dd32..68cd9f4e7238 (ALL COMMITS)                                  
============================================================================================================================

elapsed time: 497m

configs tested: 106
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
s390                          debug_defconfig
c6x                        evmc6457_defconfig
arm                       mainstone_defconfig
arm                           sama5_defconfig
c6x                              allyesconfig
arm                       imx_v6_v7_defconfig
mips                        maltaup_defconfig
m68k                            mac_defconfig
um                               alldefconfig
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
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
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
powerpc                           allnoconfig
i386                 randconfig-a006-20200518
i386                 randconfig-a005-20200518
i386                 randconfig-a001-20200518
i386                 randconfig-a003-20200518
i386                 randconfig-a004-20200518
i386                 randconfig-a002-20200518
x86_64               randconfig-a016-20200518
x86_64               randconfig-a012-20200518
x86_64               randconfig-a015-20200518
x86_64               randconfig-a013-20200518
x86_64               randconfig-a011-20200518
x86_64               randconfig-a014-20200518
i386                 randconfig-a012-20200518
i386                 randconfig-a014-20200518
i386                 randconfig-a016-20200518
i386                 randconfig-a011-20200518
i386                 randconfig-a015-20200518
i386                 randconfig-a013-20200518
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
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
