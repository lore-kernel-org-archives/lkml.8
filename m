Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E15C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1944A20659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgENCJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:09:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:7777 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgENCJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:09:47 -0400
IronPort-SDR: iYSxrszNNb2InA4ZHUKwuaqf0QcMFNQObzD6sSI0FHUIsI+HEyjo7ATsMN80Lvrgz41JvGe/d/
 NWL6wGMmBoJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 19:09:46 -0700
IronPort-SDR: ZxfsolDVixpty+MjFPwQNL8WnPgnIDAqa41NviXNq24lofJOGf4bOMa+mqw07W36MPhh7wn0mm
 pSLLjUrjGTBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="297863138"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2020 19:09:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZ3Jg-0009oy-SS; Thu, 14 May 2020 10:09:44 +0800
Date:   Thu, 14 May 2020 10:09:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e2938f0f997b5bb37e32b2679afc2ad101065df4
Message-ID: <5ebca853.7LwrvnthwMycIeH3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: e2938f0f997b5bb37e32b2679afc2ad101065df4  Merge branch 'core/kprobes'

elapsed time: 923m

configs tested: 114
configs skipped: 5

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
mips                          rm200_defconfig
riscv                    nommu_virt_defconfig
mips                      pistachio_defconfig
xtensa                           alldefconfig
sh                           se7722_defconfig
openrisc                         alldefconfig
arm                        cerfcube_defconfig
arm                         assabet_defconfig
sh                ecovec24-romimage_defconfig
arc                            hsdk_defconfig
arm                          iop32x_defconfig
riscv                             allnoconfig
c6x                                 defconfig
sh                            titan_defconfig
mips                       capcella_defconfig
arm                       spear13xx_defconfig
arc                        nsimosci_defconfig
m68k                       m5475evb_defconfig
arm                         s3c2410_defconfig
sh                   rts7751r2dplus_defconfig
arm                         shannon_defconfig
nios2                            alldefconfig
arm                           corgi_defconfig
arm                         lpc32xx_defconfig
mips                      loongson3_defconfig
arm                        clps711x_defconfig
powerpc                    adder875_defconfig
parisc                generic-64bit_defconfig
arm                        vexpress_defconfig
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
x86_64               randconfig-a005-20200513
x86_64               randconfig-a003-20200513
x86_64               randconfig-a006-20200513
x86_64               randconfig-a004-20200513
x86_64               randconfig-a001-20200513
x86_64               randconfig-a002-20200513
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
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
