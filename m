Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1C3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349EA20838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMTmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:42:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:27188 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgHMTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:42:45 -0400
IronPort-SDR: JB/uoo35apGL+7loUSkZV9vJs8FoW0Ol6TBHy0Y/z9Zfx/pF+DcmiIkL4CEI2WVnBDgX85i4h7
 6Kk4+BNsMMsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="155428381"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="155428381"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 12:42:44 -0700
IronPort-SDR: 7/qZih2+X1s8a6fCKgSt3GdR4AzfyKeecrijkRqa63DeEPPQPDhqLFPiyUAlgj+83hKKyCmEJY
 qaXE1tV364ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="470336804"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2020 12:42:43 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k6J7a-0000m7-DB; Thu, 13 Aug 2020 19:42:42 +0000
Date:   Fri, 14 Aug 2020 03:41:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 f107cee94ba4d2c7357fde59a1d84346c73d4958
Message-ID: <5f359780.t9GJyTDqT63NoWsH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: f107cee94ba4d2c7357fde59a1d84346c73d4958  genirq: Unlock irq descriptor after errors

elapsed time: 723m

configs tested: 126
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           corgi_defconfig
arm                   milbeaut_m10v_defconfig
arm                            dove_defconfig
openrisc                    or1ksim_defconfig
powerpc                           allnoconfig
sh                           se7750_defconfig
xtensa                    xip_kc705_defconfig
csky                             alldefconfig
m68k                       bvme6000_defconfig
arm                            lart_defconfig
sh                            migor_defconfig
sh                        sh7785lcr_defconfig
powerpc64                           defconfig
sh                          sdk7780_defconfig
sh                          sdk7786_defconfig
powerpc                          g5_defconfig
microblaze                      mmu_defconfig
mips                        vocore2_defconfig
nds32                            alldefconfig
sh                                  defconfig
mips                      fuloong2e_defconfig
mips                malta_qemu_32r6_defconfig
mips                            e55_defconfig
arm                           stm32_defconfig
arm                            xcep_defconfig
arc                             nps_defconfig
arm                     am200epdkit_defconfig
arm                          collie_defconfig
arm                     eseries_pxa_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
h8300                     edosk2674_defconfig
mips                     decstation_defconfig
sh                             sh03_defconfig
powerpc                     mpc512x_defconfig
sh                          lboxre2_defconfig
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
x86_64               randconfig-a006-20200811
x86_64               randconfig-a001-20200811
x86_64               randconfig-a003-20200811
x86_64               randconfig-a005-20200811
x86_64               randconfig-a004-20200811
x86_64               randconfig-a002-20200811
i386                 randconfig-a005-20200813
i386                 randconfig-a001-20200813
i386                 randconfig-a002-20200813
i386                 randconfig-a003-20200813
i386                 randconfig-a006-20200813
i386                 randconfig-a004-20200813
i386                 randconfig-a005-20200812
i386                 randconfig-a001-20200812
i386                 randconfig-a002-20200812
i386                 randconfig-a003-20200812
i386                 randconfig-a006-20200812
i386                 randconfig-a004-20200812
i386                 randconfig-a005-20200811
i386                 randconfig-a001-20200811
i386                 randconfig-a002-20200811
i386                 randconfig-a003-20200811
i386                 randconfig-a006-20200811
i386                 randconfig-a004-20200811
i386                 randconfig-a016-20200812
i386                 randconfig-a011-20200812
i386                 randconfig-a013-20200812
i386                 randconfig-a015-20200812
i386                 randconfig-a012-20200812
i386                 randconfig-a014-20200812
i386                 randconfig-a016-20200813
i386                 randconfig-a011-20200813
i386                 randconfig-a013-20200813
i386                 randconfig-a015-20200813
i386                 randconfig-a012-20200813
i386                 randconfig-a014-20200813
x86_64               randconfig-a006-20200813
x86_64               randconfig-a001-20200813
x86_64               randconfig-a005-20200813
x86_64               randconfig-a003-20200813
x86_64               randconfig-a004-20200813
x86_64               randconfig-a002-20200813
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
