Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A77C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9FD2084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgGDK6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:58:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:63250 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgGDK6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:58:24 -0400
IronPort-SDR: fkr9eAnjw3yb6xiEzgn7p7KYD1SlluseTQ9N5xRUNFieOYaQ1LHkdw8oC9h3fLCNkTfGSWx4hL
 y9qKUILqYRew==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="208762188"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; 
   d="scan'208";a="208762188"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2020 03:58:06 -0700
IronPort-SDR: OV4tj9FO+LFgQy5lnf3iNbkUcHCCD8NbdCkr68VXihEUVcgptvHlf2JU1wz9J9yK9Qt6UR2nd0
 hAjDRP3kzfeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; 
   d="scan'208";a="356983447"
Received: from lkp-server01.sh.intel.com (HELO 6dc8ab148a5d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2020 03:58:05 -0700
Received: from kbuild by 6dc8ab148a5d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jrfrw-0000e8-Se; Sat, 04 Jul 2020 10:58:04 +0000
Date:   Sat, 04 Jul 2020 18:57:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.06.29b] BUILD SUCCESS
 1cd0309d69031e82ed876acbc696a5a71be65c7e
Message-ID: <5f006087.r4pVAivo0N9DRxLW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.06.29b
branch HEAD: 1cd0309d69031e82ed876acbc696a5a71be65c7e  fixup! torture: Add scftorture to the rcutorture scripting

i386-tinyconfig vmlinux size:

========================================================================================
 TOTAL  TEXT                                                                            
========================================================================================
    +1     0  6b05dfacd761 docs: RCU: Convert checklist.txt to ReST                     
     0     0  a3b0a79f8903 docs: RCU: Convert lockdep-splat.txt to ReST                 
     0     0  058cc23bcad0 docs: RCU: Convert lockdep.txt to ReST                       
     0     0  2cdb54c93a7e docs: RCU: Convert rculist_nulls.txt to ReST                 
     0     0  43cb5451dffe docs: RCU: Convert torture.txt to ReST                       
     0     0  90c73cb2c65f docs: RCU: Convert rcuref.txt to ReST                        
     0     0  f2286ab99549 docs: RCU: Convert stallwarn.txt to ReST                     
     0     0  2d9c318bfd15 docs: RCU: Don't duplicate chapter names in rculist_nulls.rs 
     0     0  b81898e3d213 doc: Timer problems can cause RCU CPU stall warnings         
     0     0  d93d97cbe0d4 doc: Tasks RCU must protect instructions before trampoline   
   +61   +61  13625c0a4074 Merge branches 'doc.2020.06.29a', 'fixes.2020.06.29a', 'kfre 
   +59   +59  71e05e558a5f Merge branch 'kcsan.2020.06.29a' into HEAD                   
     0     0  ae6e37643c37 Merge branch 'lkmm-dev.2020.06.29a' into HEAD                
     0     0  47c6b57496e9 rcu: Remove KCSAN stubs                                      
     0     0  7bfb022fdcf7 rcu: Remove KCSAN stubs from update.c                        
     0     0  766e7e371ec8 srcu: Remove KCSAN stubs                                     
     0     0  9cd52394debe rcu/segcblist: Prevent useless GP start if no CBs to acceler 
     0     0  f338ebbff010 rcutorture: Output number of elapsed grace periods           
     0     0  63b268925cf4 rcu/trace: Print negative GP numbers correctly               
     0     0  a3d7b6af8ca6 rcu/trace: Use gp_seq_req in acceleration's rcu_grace_period 
     0     0  67d72a7bc0da nocb: Clarify RCU nocb CPU error message                     
     0     0  771247eed13a rcu/tree: Force quiescent state on callback overload         
     0     0  d1ff121810bb rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp()   
     0     0  d2b8c546d4e7 nocb: Remove show_rcu_nocb_state() false positive printout   
     0     0  8cfb8423d873 rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor 
     0     0  3061e68f1195 rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_resched 
     0     0  3cb6a7ea523f rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_kick_kt 
     0     0  1ef32f5fc430 rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_cpu_sta 
     0     0  8033840e8e88 rcu: Remove unused __rcu_is_watching() function              
     0     0  3a1cc5cdafcc scftorture: Add smp_call_function() torture test             
     0     0  7ff7c366f80f torture: Add scftorture to the rcutorture scripting          
     0     0  b5a199cf5756 scftorture: Implement weighted primitive selection           
     0     0  07a4b46c7e42 tick-sched: Clarify "NOHZ: local_softirq_pending" warning    
    -1     0  b89f3d4d5d09 smp: Add source and destination CPUs to __call_single_data   
     0     0  09dbc033be2b kernel/smp: Provide CSD lock timeout diagnostics             
     0     0  0c5e33e2bdb4 torture: Declare parse-console.sh independence from rcutortu 
     0     0  09a79731d738 scftorture: Add CPU-hotplug statistics to the stats output   
     0     0  46152d56b65a fixup! scftorture: Add smp_call_function() torture test      
     0     0  1cd0309d6903 fixup! torture: Add scftorture to the rcutorture scripting   
  +120  +120  9ebcfadb0610..1cd0309d6903 (ALL COMMITS)                                  
========================================================================================

elapsed time: 5089m

configs tested: 85
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
i386                              allnoconfig
i386                                defconfig
i386                             allyesconfig
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
i386                 randconfig-a011-20200701
i386                 randconfig-a015-20200701
i386                 randconfig-a016-20200701
i386                 randconfig-a012-20200701
i386                 randconfig-a013-20200701
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
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
