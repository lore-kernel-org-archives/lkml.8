Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799C2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D56C2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHYE1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:27:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:9875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgHYE1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:27:50 -0400
IronPort-SDR: 7l0vMn7HOlvjNM7FrZXgXMe3rH3xPaV5G3KuH+kmOOWX5vDsDZ7HXYAptk97pT0X9DPUBY7RaV
 1AtKleVoIK2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="155298961"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="155298961"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 21:27:49 -0700
IronPort-SDR: F4Y1iPanVoCpVDL+8UTBQa6AMueNRRfZN53Hio0LiXEay0M7VaF8nUzPhdyo1G2F5FX0hZmJ6Z
 PiUwz5GuoUIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="499168171"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2020 21:27:48 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAQYl-00006D-C0; Tue, 25 Aug 2020 04:27:47 +0000
Date:   Tue, 25 Aug 2020 12:27:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fsgsbase] BUILD SUCCESS
 5f1dd4dda5c8796c405e856aaa11e187f6885924
Message-ID: <5f44932f.DEi+U1sStWmjQbZS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/fsgsbase
branch HEAD: 5f1dd4dda5c8796c405e856aaa11e187f6885924  x86/fsgsbase: Replace static_cpu_has() with boot_cpu_has()

elapsed time: 721m

configs tested: 74
configs skipped: 52

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
arm                              zx_defconfig
arc                              alldefconfig
arm                          badge4_defconfig
sh                          sdk7780_defconfig
sh                          r7785rp_defconfig
arm                             rpc_defconfig
h8300                    h8300h-sim_defconfig
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
i386                 randconfig-a002-20200824
i386                 randconfig-a004-20200824
i386                 randconfig-a005-20200824
i386                 randconfig-a003-20200824
i386                 randconfig-a006-20200824
i386                 randconfig-a001-20200824
x86_64               randconfig-a015-20200824
x86_64               randconfig-a016-20200824
x86_64               randconfig-a012-20200824
x86_64               randconfig-a014-20200824
x86_64               randconfig-a011-20200824
x86_64               randconfig-a013-20200824
i386                 randconfig-a013-20200824
i386                 randconfig-a012-20200824
i386                 randconfig-a011-20200824
i386                 randconfig-a016-20200824
i386                 randconfig-a015-20200824
i386                 randconfig-a014-20200824
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
