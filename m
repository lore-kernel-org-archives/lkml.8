Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C094C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 16:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D323E2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 16:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFNQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 12:43:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:48021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgFNQnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 12:43:42 -0400
IronPort-SDR: TTuok41/MnHsgtVAqDF+UKKiQAEFrDyqj4PeI10jhGBWkED0ibv1gTTl95GR78Dv8jHb1Wk8gh
 5EwI0NiZV5Tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 09:43:41 -0700
IronPort-SDR: bf+OuVodIyPgtGubF0PW147bIHSJ81sI1mA0T2GAzUFoR62aZ+7b22cZZI61QLL97NB8w+OmyG
 B8Mg18IJ81gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,511,1583222400"; 
   d="scan'208";a="308317834"
Received: from lkp-server02.sh.intel.com (HELO de5642daf266) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2020 09:43:40 -0700
Received: from kbuild by de5642daf266 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jkVjQ-0000mn-5i; Sun, 14 Jun 2020 16:43:40 +0000
Date:   Mon, 15 Jun 2020 00:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b8b7f4dc10459dcacafa3441dd44c6fbe880e886
Message-ID: <5ee653ab.QWO8S7+Ka84gFsGv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: b8b7f4dc10459dcacafa3441dd44c6fbe880e886  Merge branch 'WIP.core/headers'

elapsed time: 481m

configs tested: 115
configs skipped: 2

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
sh                          rsk7269_defconfig
arc                        nsim_700_defconfig
powerpc                       holly_defconfig
sparc64                          alldefconfig
arm                       multi_v4t_defconfig
powerpc                        cell_defconfig
powerpc                    amigaone_defconfig
arm                           stm32_defconfig
mips                      loongson3_defconfig
arm                        multi_v7_defconfig
powerpc                    adder875_defconfig
arm                       aspeed_g5_defconfig
mips                       capcella_defconfig
mips                          ath25_defconfig
mips                        bcm63xx_defconfig
arm                            zeus_defconfig
arc                                 defconfig
sh                             sh03_defconfig
riscv                             allnoconfig
sh                           se7750_defconfig
powerpc                     pq2fads_defconfig
arm                       versatile_defconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
arm                           sama5_defconfig
arm                           viper_defconfig
m68k                          multi_defconfig
h8300                       h8s-sim_defconfig
xtensa                generic_kc705_defconfig
m68k                          amiga_defconfig
arm                           tegra_defconfig
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
i386                 randconfig-a015-20200614
i386                 randconfig-a011-20200614
i386                 randconfig-a014-20200614
i386                 randconfig-a013-20200614
i386                 randconfig-a016-20200614
i386                 randconfig-a012-20200614
riscv                            allyesconfig
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
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
