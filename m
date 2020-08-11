Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E539BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63A520678
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgHKIUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:20:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:22691 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgHKIUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:20:37 -0400
IronPort-SDR: XMoyCnICBVOtJphMRoVZaXRpkwY8HKk6Ik5QtEMTBGLIsaDt6H8T9rGuKbjIAmnJxLE0PVefrf
 GO396nzlHQuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171732269"
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="scan'208";a="171732269"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 01:20:36 -0700
IronPort-SDR: IxRFUwd4q0CIVZRKA+Dh7baC1yZoIpOkWXd7A967CQ9DIgveMh+c9XdkKsQZsA+hk/sRnw6sfJ
 nD9M5QxrWejA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="scan'208";a="438972777"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2020 01:20:35 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5PWM-0000S5-MA; Tue, 11 Aug 2020 08:20:34 +0000
Date:   Tue, 11 Aug 2020 16:19:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 b0294f30256bb6023b2044fd607855123863d98f
Message-ID: <5f325493.4W6sTvJsAurfj/vV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/urgent
branch HEAD: b0294f30256bb6023b2044fd607855123863d98f  time: Delete repeated words in comments

elapsed time: 723m

configs tested: 84
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7780mp_defconfig
arm                           stm32_defconfig
arm                             ezx_defconfig
arm                        multi_v7_defconfig
openrisc                         alldefconfig
arm                   milbeaut_m10v_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200811
x86_64               randconfig-a001-20200811
x86_64               randconfig-a003-20200811
x86_64               randconfig-a005-20200811
x86_64               randconfig-a004-20200811
x86_64               randconfig-a002-20200811
i386                 randconfig-a005-20200810
i386                 randconfig-a001-20200810
i386                 randconfig-a002-20200810
i386                 randconfig-a003-20200810
i386                 randconfig-a006-20200810
i386                 randconfig-a004-20200810
i386                 randconfig-a005-20200811
i386                 randconfig-a001-20200811
i386                 randconfig-a002-20200811
i386                 randconfig-a003-20200811
i386                 randconfig-a006-20200811
i386                 randconfig-a004-20200811
x86_64               randconfig-a013-20200810
x86_64               randconfig-a012-20200810
x86_64               randconfig-a016-20200810
x86_64               randconfig-a011-20200810
x86_64               randconfig-a014-20200810
x86_64               randconfig-a015-20200810
i386                 randconfig-a016-20200810
i386                 randconfig-a011-20200810
i386                 randconfig-a015-20200810
i386                 randconfig-a013-20200810
i386                 randconfig-a012-20200810
i386                 randconfig-a014-20200810
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
