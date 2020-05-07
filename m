Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED1C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00650208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEGUCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:02:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:23442 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:02:35 -0400
IronPort-SDR: LdM7NwY8xLcg/FSQeZg5WHzNi5PJ5bWQWBRs2AGcfMjM+ZScwnm+xdSELDuEhUYMzmNpMubnxR
 alZHaNYqEIew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 13:02:35 -0700
IronPort-SDR: aufg7iT73fW8nX1Y3R3RlKiZnwFoYj2jqSk+P2IE6p97zX/gqizdVs0m8Ynwcbja9haZro2LA6
 0Z3mvj5IEzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,365,1583222400"; 
   d="scan'208";a="339461114"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 May 2020 13:02:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWmj3-000CXI-Cn; Fri, 08 May 2020 04:02:33 +0800
Date:   Fri, 08 May 2020 04:02:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/cpu] BUILD SUCCESS
 3436157f57eabe5569357243e6f94d6a53890207
Message-ID: <5eb4693d.8gv4dR1W4d4lVrj4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  WIP.x86/cpu
branch HEAD: 3436157f57eabe5569357243e6f94d6a53890207  x86/cpu/amd: Make erratum #1054 a legacy erratum

i386-tinyconfig vmlinux size:

=========================================================================================================================
 TOTAL  TEXT  init.data  cpu_vuln_whitelist()                                                                            
=========================================================================================================================
  +203  +172       +160                  +124  e9d7144597b1 x86/cpu: Add a steppings field to struct x86_cpu_id          
    -2    -2          0                     0  51485635ebc2 Merge 'x86/urgent' into x86/cpu                              
     0     0          0                     0  d8422f6bb052 x86/cpu: Add a X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS() macro  
     0     0          0                     0  66abf2388331 x86/apic: Convert the TSC deadline timer matching to steppin 
     0     0          0                     0  3436157f57ea x86/cpu/amd: Make erratum #1054 a legacy erratum             
  +201  +170       +160                  +124  ae83d0b416db..3436157f57ea (ALL COMMITS)                                  
=========================================================================================================================

elapsed time: 483m

configs tested: 101
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
sparc                            allyesconfig
m68k                             allyesconfig
csky                                defconfig
alpha                               defconfig
um                                allnoconfig
csky                             allyesconfig
openrisc                            defconfig
mips                             allmodconfig
riscv                            allmodconfig
sh                               allmodconfig
um                                  defconfig
i386                              allnoconfig
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
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20200507
i386                 randconfig-a004-20200507
i386                 randconfig-a001-20200507
i386                 randconfig-a002-20200507
i386                 randconfig-a003-20200507
i386                 randconfig-a006-20200507
x86_64               randconfig-a015-20200507
x86_64               randconfig-a014-20200507
x86_64               randconfig-a012-20200507
x86_64               randconfig-a013-20200507
x86_64               randconfig-a011-20200507
x86_64               randconfig-a016-20200507
x86_64               randconfig-a004-20200507
x86_64               randconfig-a006-20200507
x86_64               randconfig-a002-20200507
i386                 randconfig-a012-20200507
i386                 randconfig-a016-20200507
i386                 randconfig-a014-20200507
i386                 randconfig-a011-20200507
i386                 randconfig-a015-20200507
i386                 randconfig-a013-20200507
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
sparc                               defconfig
um                               allmodconfig
um                               allyesconfig
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
