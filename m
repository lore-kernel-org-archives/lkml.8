Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F6920789
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgHBAhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:37:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:7524 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBAht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 20:37:49 -0400
IronPort-SDR: DzSY7yvolDh2vuZl3OLbrYj+ukLQBgo6mt4iyFprUuk5igYh1X6jufH0/9hxJdj5fmoM4U1EWG
 1ddASxhaiFTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="216396806"
X-IronPort-AV: E=Sophos;i="5.75,424,1589266800"; 
   d="scan'208";a="216396806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 17:37:49 -0700
IronPort-SDR: Exk5olildQl2lmpAE4hwcWYK9tXJQLzuWCanFngIRKS01Gvye/lsSkVnTcQbC47I8qkGBMcLe6
 yH8TgPrxfp2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,424,1589266800"; 
   d="scan'208";a="305430576"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2020 17:37:47 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k220Z-0001S9-5u; Sun, 02 Aug 2020 00:37:47 +0000
Date:   Sun, 02 Aug 2020 08:37:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 adb334d17858d8b679a41f7f2cd230e5c6accc0a
Message-ID: <5f260ab9.GI8AxwoNwT41m8cD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: adb334d17858d8b679a41f7f2cd230e5c6accc0a  Merge branch 'WIP.x86/entry' into x86/entry, to merge the latest generic code and resolve conflicts

elapsed time: 2148m

configs tested: 85
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                    xip_kc705_defconfig
arm                       versatile_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
arm                            pleb_defconfig
arm                            mmp2_defconfig
arm                          lpd270_defconfig
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
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
i386                 randconfig-a004-20200802
i386                 randconfig-a005-20200802
i386                 randconfig-a001-20200802
i386                 randconfig-a002-20200802
i386                 randconfig-a003-20200802
i386                 randconfig-a006-20200802
i386                 randconfig-a004-20200801
i386                 randconfig-a005-20200801
i386                 randconfig-a001-20200801
i386                 randconfig-a003-20200801
i386                 randconfig-a002-20200801
i386                 randconfig-a006-20200801
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a013-20200731
i386                 randconfig-a011-20200731
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
