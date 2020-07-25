Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7122C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8947820719
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGYDcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 23:32:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:38726 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgGYDcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:32:19 -0400
IronPort-SDR: smorE3aO4jO4AWxw6mrglkTfuDh3b+GtyCkTI6wjmSMdu21biESniAksU3f9SHxfdWmRhoy6HD
 gUofcj5DET5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="150802009"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="150802009"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 20:32:18 -0700
IronPort-SDR: e9chISZr+ZcitYoPBpcB6dAnHwvm1Ym3Aj//Xq1w8uMQSafLwBm9ydcy6ueTqmT6qP3Hnwkw5K
 hx7dYha9NsIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="393493459"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2020 20:32:17 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzAv2-0000jH-NO; Sat, 25 Jul 2020 03:32:16 +0000
Date:   Sat, 25 Jul 2020 11:32:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 587af649bcc04eb016822f209a975005c0092151
Message-ID: <5f1ba7bb.9QWvgISfcydgVVkE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/build
branch HEAD: 587af649bcc04eb016822f209a975005c0092151  x86/build: Move max-page-size option to LDFLAGS_vmlinux

elapsed time: 722m

configs tested: 92
configs skipped: 70

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
i386                 randconfig-a003-20200725
i386                 randconfig-a005-20200725
i386                 randconfig-a004-20200725
i386                 randconfig-a006-20200725
i386                 randconfig-a002-20200725
i386                 randconfig-a001-20200725
x86_64               randconfig-a014-20200724
x86_64               randconfig-a016-20200724
x86_64               randconfig-a015-20200724
x86_64               randconfig-a012-20200724
x86_64               randconfig-a013-20200724
x86_64               randconfig-a011-20200724
i386                 randconfig-a016-20200725
i386                 randconfig-a013-20200725
i386                 randconfig-a012-20200725
i386                 randconfig-a015-20200725
i386                 randconfig-a014-20200725
i386                 randconfig-a011-20200725
i386                 randconfig-a016-20200724
i386                 randconfig-a013-20200724
i386                 randconfig-a012-20200724
i386                 randconfig-a015-20200724
i386                 randconfig-a014-20200724
i386                 randconfig-a011-20200724
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
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
