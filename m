Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837BFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B4E206F9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgEPXNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 19:13:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:21336 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgEPXNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 19:13:22 -0400
IronPort-SDR: H70TAAeNG0+eTTEc7sO3uwJsC3OSXNLfKPBOKVjkPutJ8g/On3Eb6J3Veb9LFK4CRobwKpdC9t
 Z7DPqR/2ud2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 16:13:21 -0700
IronPort-SDR: zUN/i6sVbdJ00Rjezck/JbRh0IFpVwDAQ+JM4UsNO3i9Qm8dEaeX8igRlspE8ySVSLMItu2VhG
 KkcTim0pt2DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,400,1583222400"; 
   d="scan'208";a="288174039"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2020 16:13:20 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ja5zb-0004C0-Sj; Sun, 17 May 2020 07:13:19 +0800
Date:   Sun, 17 May 2020 07:12:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 55e00fb66fd5048f4a3ee357018fd26fc527abca
Message-ID: <5ec0736d.vN7JX1uQTwG6c1GD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/fpu
branch HEAD: 55e00fb66fd5048f4a3ee357018fd26fc527abca  x86/fpu/xstate: Restore supervisor states for signal return

elapsed time: 481m

configs tested: 95
configs skipped: 91

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
m68k                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                malta_kvm_guest_defconfig
arc                            hsdk_defconfig
arc                           tb10x_defconfig
h8300                            alldefconfig
powerpc                           allnoconfig
xtensa                    xip_kc705_defconfig
mips                 pnx8335_stb225_defconfig
xtensa                              defconfig
ia64                             allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
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
mips                              allnoconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20200517
x86_64               randconfig-a003-20200517
x86_64               randconfig-a006-20200517
x86_64               randconfig-a004-20200517
x86_64               randconfig-a001-20200517
x86_64               randconfig-a002-20200517
i386                 randconfig-a006-20200517
i386                 randconfig-a005-20200517
i386                 randconfig-a003-20200517
i386                 randconfig-a001-20200517
i386                 randconfig-a004-20200517
i386                 randconfig-a002-20200517
i386                 randconfig-a012-20200517
i386                 randconfig-a016-20200517
i386                 randconfig-a014-20200517
i386                 randconfig-a011-20200517
i386                 randconfig-a013-20200517
i386                 randconfig-a015-20200517
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
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
