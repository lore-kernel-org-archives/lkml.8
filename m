Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8CBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D49F206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCMDtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:49:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:9201 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgCMDtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:49:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 20:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; 
   d="scan'208";a="235218792"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Mar 2020 20:49:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jCbKH-0000zY-To; Fri, 13 Mar 2020 11:49:33 +0800
Date:   Fri, 13 Mar 2020 11:49:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 f967140dfb7442e2db0868b03b961f9c59418a1b
Message-ID: <5e6b02b7.JUUUyo5fGcjJSIHZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: f967140dfb7442e2db0868b03b961f9c59418a1b  perf/amd/uncore: Replace manual sampling check with CAP_NO_INTERRUPT flag

elapsed time: 874m

configs tested: 138
configs skipped: 106

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
mips                      fuloong2e_defconfig
sparc64                           allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64               randconfig-a001-20200311
x86_64               randconfig-a002-20200311
x86_64               randconfig-a003-20200311
i386                 randconfig-a001-20200311
i386                 randconfig-a002-20200311
i386                 randconfig-a003-20200311
x86_64               randconfig-a001-20200312
x86_64               randconfig-a002-20200312
x86_64               randconfig-a003-20200312
i386                 randconfig-a001-20200312
i386                 randconfig-a002-20200312
i386                 randconfig-a003-20200312
alpha                randconfig-a001-20200312
m68k                 randconfig-a001-20200312
mips                 randconfig-a001-20200312
nds32                randconfig-a001-20200312
parisc               randconfig-a001-20200312
csky                 randconfig-a001-20200312
openrisc             randconfig-a001-20200312
s390                 randconfig-a001-20200312
sh                   randconfig-a001-20200312
xtensa               randconfig-a001-20200312
x86_64               randconfig-b001-20200311
x86_64               randconfig-b002-20200311
x86_64               randconfig-b003-20200311
i386                 randconfig-b001-20200311
i386                 randconfig-b002-20200311
i386                 randconfig-b003-20200311
x86_64               randconfig-c001-20200312
x86_64               randconfig-c002-20200312
x86_64               randconfig-c003-20200312
i386                 randconfig-c001-20200312
i386                 randconfig-c002-20200312
i386                 randconfig-c003-20200312
x86_64               randconfig-c001-20200311
x86_64               randconfig-c002-20200311
x86_64               randconfig-c003-20200311
i386                 randconfig-c001-20200311
i386                 randconfig-c002-20200311
i386                 randconfig-c003-20200311
x86_64               randconfig-e001-20200312
x86_64               randconfig-e002-20200312
x86_64               randconfig-e003-20200312
i386                 randconfig-e001-20200312
i386                 randconfig-e002-20200312
i386                 randconfig-e003-20200312
x86_64               randconfig-f001-20200312
x86_64               randconfig-f002-20200312
x86_64               randconfig-f003-20200312
i386                 randconfig-f001-20200312
i386                 randconfig-f002-20200312
i386                 randconfig-f003-20200312
x86_64               randconfig-h001-20200312
x86_64               randconfig-h002-20200312
x86_64               randconfig-h003-20200312
i386                 randconfig-h001-20200312
i386                 randconfig-h002-20200312
i386                 randconfig-h003-20200312
arm                  randconfig-a001-20200312
arm64                randconfig-a001-20200312
ia64                 randconfig-a001-20200312
powerpc              randconfig-a001-20200312
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
