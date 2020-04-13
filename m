Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80377C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61196206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgDMQkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:40:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:49126 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbgDMQkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:40:05 -0400
IronPort-SDR: NhB6EfIKI84naL2x5NaiEN29u2w03uI8mNH2L1d3WeFHplCHRldPPZJpiBaGc4OI2ZmYNGDMfP
 /1qfQRfBAP+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 09:40:04 -0700
IronPort-SDR: m8Ssf1Dmu8TfKlxFf6pAui845/UzmNRpBBuU8aVJNe256Sjasi1EkPZnKWr5Jw5IR5bxTnd/DC
 gO/0rX34zrgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="256228897"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2020 09:40:03 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jO27u-00038L-Fa; Tue, 14 Apr 2020 00:40:02 +0800
Date:   Tue, 14 Apr 2020 00:39:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 2fa9a3cf3055db07a4835eb7bd48c648cb17ac26
Message-ID: <5e9495db.jOQHmU5FIQjN1zAg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 2fa9a3cf3055db07a4835eb7bd48c648cb17ac26  x86/smpboot: Remove the last ICPU() macro

elapsed time: 481m

configs tested: 127
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
sparc                            allyesconfig
arm                           sunxi_defconfig
parisc                generic-32bit_defconfig
openrisc                 simple_smp_defconfig
ia64                                defconfig
powerpc                             defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200413
x86_64               randconfig-a002-20200413
x86_64               randconfig-a003-20200413
i386                 randconfig-a001-20200413
i386                 randconfig-a002-20200413
i386                 randconfig-a003-20200413
c6x                  randconfig-a001-20200413
h8300                randconfig-a001-20200413
microblaze           randconfig-a001-20200413
nios2                randconfig-a001-20200413
sparc64              randconfig-a001-20200413
csky                 randconfig-a001-20200413
openrisc             randconfig-a001-20200413
s390                 randconfig-a001-20200413
sh                   randconfig-a001-20200413
xtensa               randconfig-a001-20200413
x86_64               randconfig-b001-20200413
x86_64               randconfig-b002-20200413
x86_64               randconfig-b003-20200413
i386                 randconfig-b001-20200413
i386                 randconfig-b002-20200413
i386                 randconfig-b003-20200413
x86_64               randconfig-c001-20200413
x86_64               randconfig-c002-20200413
x86_64               randconfig-c003-20200413
i386                 randconfig-c001-20200413
i386                 randconfig-c002-20200413
i386                 randconfig-c003-20200413
x86_64               randconfig-d001-20200413
x86_64               randconfig-d002-20200413
x86_64               randconfig-d003-20200413
i386                 randconfig-d001-20200413
i386                 randconfig-d002-20200413
i386                 randconfig-d003-20200413
x86_64               randconfig-e001-20200413
x86_64               randconfig-e002-20200413
x86_64               randconfig-e003-20200413
i386                 randconfig-e001-20200413
i386                 randconfig-e002-20200413
i386                 randconfig-e003-20200413
x86_64               randconfig-f001-20200413
x86_64               randconfig-f002-20200413
x86_64               randconfig-f003-20200413
i386                 randconfig-f001-20200413
i386                 randconfig-f002-20200413
i386                 randconfig-f003-20200413
x86_64               randconfig-g001-20200413
x86_64               randconfig-g002-20200413
x86_64               randconfig-g003-20200413
i386                 randconfig-g001-20200413
i386                 randconfig-g002-20200413
i386                 randconfig-g003-20200413
x86_64               randconfig-h001-20200413
x86_64               randconfig-h002-20200413
x86_64               randconfig-h003-20200413
i386                 randconfig-h001-20200413
i386                 randconfig-h002-20200413
i386                 randconfig-h003-20200413
arc                  randconfig-a001-20200413
arm                  randconfig-a001-20200413
arm64                randconfig-a001-20200413
ia64                 randconfig-a001-20200413
powerpc              randconfig-a001-20200413
sparc                randconfig-a001-20200413
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
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
