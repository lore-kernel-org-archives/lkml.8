Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E2C20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgFDQSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:18:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:64026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgFDQSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:18:54 -0400
IronPort-SDR: 2XA3lqAwREO9vAMCwPjXwbRVbQp6B1i3g712zXuLL2igBg1UwWpmM2uiZV/W5YksWjbVEtTa7F
 oS0rsbmUWjSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 09:18:54 -0700
IronPort-SDR: 3iesOQnqNij0d8jQrL1vlVnsBWlqzag1PwNzpIyAUCSuuFsTtf4Ia+xDhPP7ofX5yP13y0Vvbo
 mXfiE+oCQBqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="258931335"
Received: from lkp-server02.sh.intel.com (HELO 6de3076d9aaa) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2020 09:18:52 -0700
Received: from kbuild by 6de3076d9aaa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgsZv-00002L-Vn; Thu, 04 Jun 2020 16:18:51 +0000
Date:   Fri, 05 Jun 2020 00:18:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8abcfb969c86dffd06fc02bb9d727dd52977f336
Message-ID: <5ed91ed1.FU5f3IsxWGEZM/2w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 8abcfb969c86dffd06fc02bb9d727dd52977f336  Merge branch 'WIP.core/headers'

elapsed time: 480m

configs tested: 98
configs skipped: 1

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
arm                         hackkit_defconfig
sh                         apsh4a3a_defconfig
arm                            mmp2_defconfig
arm                        neponset_defconfig
arm                         orion5x_defconfig
arm                       aspeed_g4_defconfig
sh                          r7780mp_defconfig
riscv                            allyesconfig
mips                        bcm47xx_defconfig
arm                           tegra_defconfig
mips                           ci20_defconfig
arm                         ebsa110_defconfig
arm                          moxart_defconfig
arm                     eseries_pxa_defconfig
arm                           stm32_defconfig
arm                     am200epdkit_defconfig
powerpc                    gamecube_defconfig
nios2                            alldefconfig
arm                              zx_defconfig
microblaze                    nommu_defconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
powerpc                             defconfig
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
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
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
