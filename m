Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76809C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2DE20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgIJWq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:46:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:61062 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgIJWq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:46:26 -0400
IronPort-SDR: PTKBpsD9BPn1hIgdQ0Y4w9m/B87ak37HguSY6bNVSLkJkO39dh8NCeLeWA88esPWXioszSgUND
 JlUwi+jijwgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="146345963"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="146345963"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 15:46:23 -0700
IronPort-SDR: OaS8r4xNxpE2vVHWQWQSqgNf0GP1XW11kmP0dHkGPltfwSIkvM/kMHQ2eVizSCg0VITDrYuAF2
 rxrFv81DWSYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="505299804"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2020 15:46:22 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGVKf-00014v-Kd; Thu, 10 Sep 2020 22:46:21 +0000
Date:   Fri, 11 Sep 2020 06:46:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 1909760f5fc3f123e47b4e24e0ccdc0fc8f3f106
Message-ID: <5f5aacaf.EtBVBX7LRakABGKP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  locking/core
branch HEAD: 1909760f5fc3f123e47b4e24e0ccdc0fc8f3f106  seqlock: PREEMPT_RT: Do not starve seqlock_t writers

elapsed time: 721m

configs tested: 173
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
powerpc                       maple_defconfig
openrisc                         alldefconfig
sh                            titan_defconfig
ia64                        generic_defconfig
arm                     davinci_all_defconfig
sh                         apsh4a3a_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       cns3420vb_defconfig
sparc64                             defconfig
arm                             pxa_defconfig
mips                           ip28_defconfig
arc                     haps_hs_smp_defconfig
arm                          prima2_defconfig
mips                      pistachio_defconfig
sh                           se7705_defconfig
sh                             sh03_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       versatile_defconfig
arm                        magician_defconfig
riscv                    nommu_k210_defconfig
m68k                           sun3_defconfig
arm                            u300_defconfig
mips                      pic32mzda_defconfig
riscv                            alldefconfig
arm                           h5000_defconfig
arm                         axm55xx_defconfig
sh                        edosk7760_defconfig
arc                         haps_hs_defconfig
arm                          simpad_defconfig
mips                malta_kvm_guest_defconfig
powerpc                      ppc64e_defconfig
h8300                            alldefconfig
mips                     cu1830-neo_defconfig
arm                         lubbock_defconfig
s390                             alldefconfig
mips                          ath25_defconfig
arm                         ebsa110_defconfig
c6x                        evmc6457_defconfig
m68k                            q40_defconfig
arm                           u8500_defconfig
sh                ecovec24-romimage_defconfig
c6x                                 defconfig
m68k                         amcore_defconfig
arm                             ezx_defconfig
arm                         lpc32xx_defconfig
sh                          polaris_defconfig
m68k                        mvme16x_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc8272_ads_defconfig
sh                               allmodconfig
powerpc                mpc7448_hpc2_defconfig
m68k                                defconfig
sparc                               defconfig
arm                           efm32_defconfig
mips                 pnx8335_stb225_defconfig
arm                           omap1_defconfig
c6x                        evmc6472_defconfig
arm                          lpd270_defconfig
sh                           se7750_defconfig
arm                         hackkit_defconfig
arm                          gemini_defconfig
sh                         microdev_defconfig
arm                          ixp4xx_defconfig
m68k                        mvme147_defconfig
um                            kunit_defconfig
arm                         orion5x_defconfig
mips                  maltasmvp_eva_defconfig
sh                              ul2_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arm                         nhk8815_defconfig
mips                        workpad_defconfig
parisc                           alldefconfig
arm                          tango4_defconfig
mips                      loongson3_defconfig
s390                       zfcpdump_defconfig
powerpc                  storcenter_defconfig
powerpc64                        alldefconfig
mips                         cobalt_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200910
x86_64               randconfig-a006-20200910
x86_64               randconfig-a003-20200910
x86_64               randconfig-a002-20200910
x86_64               randconfig-a005-20200910
x86_64               randconfig-a001-20200910
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
i386                 randconfig-a004-20200910
i386                 randconfig-a006-20200910
i386                 randconfig-a001-20200910
i386                 randconfig-a003-20200910
i386                 randconfig-a002-20200910
i386                 randconfig-a005-20200910
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
i386                 randconfig-a015-20200911
i386                 randconfig-a014-20200911
i386                 randconfig-a011-20200911
i386                 randconfig-a013-20200911
i386                 randconfig-a016-20200911
i386                 randconfig-a012-20200911
i386                 randconfig-a015-20200910
i386                 randconfig-a014-20200910
i386                 randconfig-a011-20200910
i386                 randconfig-a013-20200910
i386                 randconfig-a016-20200910
i386                 randconfig-a012-20200910
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200911
x86_64               randconfig-a006-20200911
x86_64               randconfig-a003-20200911
x86_64               randconfig-a002-20200911
x86_64               randconfig-a005-20200911
x86_64               randconfig-a001-20200911
x86_64               randconfig-a013-20200909
x86_64               randconfig-a016-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
