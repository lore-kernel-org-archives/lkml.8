Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E21C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8366120786
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgG0VGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:06:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:45224 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgG0VGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:06:48 -0400
IronPort-SDR: dEeJyMysDGKD87F4alkx9Nzulvn6y7TyyIeiEtA1sEPvOi+COS5A56hxm0G5sFp9QGI2ySDk+7
 tJBHGquPostQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="139148547"
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="139148547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 14:06:48 -0700
IronPort-SDR: dKoq50hnMWhSYGg1kcrUd9G10wWxcFNeiw3Q0kr0w0LcmzkbPs9fKCFSwIaoCige2tkH+gHUUC
 dug/P7koDd8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="285911347"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2020 14:06:46 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0AKb-000238-Uf; Mon, 27 Jul 2020 21:06:45 +0000
Date:   Tue, 28 Jul 2020 05:05:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.core/entry] BUILD REGRESSION
 85546baab915492f05f29b91c4003bf15891e89b
Message-ID: <5f1f419a.ul1MND6j1Dag8Zi1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  WIP.core/entry
branch HEAD: 85546baab915492f05f29b91c4003bf15891e89b  entry: Fix !CONFIG_SECCOMP stub

Error/Warning in current branch:

arch/arm64/kernel/ptrace.c:1863:6: error: too few arguments to function 'secure_computing'
arch/riscv/kernel/ptrace.c:162:6: error: too few arguments to function 'secure_computing'
arch/riscv/kernel/ptrace.c:164:6: error: too few arguments to function 'secure_computing'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-allnoconfig
|   `-- arch-arm64-kernel-ptrace.c:error:too-few-arguments-to-function-secure_computing
|-- riscv-allnoconfig
|   `-- arch-riscv-kernel-ptrace.c:error:too-few-arguments-to-function-secure_computing
|-- riscv-defconfig
|   `-- arch-riscv-kernel-ptrace.c:error:too-few-arguments-to-function-secure_computing
`-- riscv-randconfig-m031-20200727
    `-- arch-riscv-kernel-ptrace.c:error:too-few-arguments-to-function-secure_computing

elapsed time: 1728m

configs tested: 70
configs skipped: 1

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
i386                                defconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
openrisc                            defconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
xtensa                              defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a003-20200727
i386                 randconfig-a005-20200727
i386                 randconfig-a004-20200727
i386                 randconfig-a006-20200727
i386                 randconfig-a002-20200727
i386                 randconfig-a001-20200727
i386                 randconfig-a016-20200727
i386                 randconfig-a013-20200727
i386                 randconfig-a012-20200727
i386                 randconfig-a015-20200727
i386                 randconfig-a011-20200727
i386                 randconfig-a014-20200727
x86_64               randconfig-a005-20200727
x86_64               randconfig-a004-20200727
x86_64               randconfig-a003-20200727
x86_64               randconfig-a006-20200727
x86_64               randconfig-a002-20200727
x86_64               randconfig-a001-20200727
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
sparc64                             defconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                              defconfig

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
