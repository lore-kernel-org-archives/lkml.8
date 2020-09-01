Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4EEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A432B20719
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIAELB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:11:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:8899 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIAELA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:11:00 -0400
IronPort-SDR: NwubxJry0KTpn4dM8SS2fRmanmTtQHiDKETmuc6fO2yItJG6ylBQn8G++CYBL4b08zKn2RmWfR
 JPWRtTtIQYtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="156360290"
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; 
   d="scan'208";a="156360290"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 21:10:56 -0700
IronPort-SDR: 3Vr5g8NV+nJ2Vwb1nkWz9dxaxDkQGHfWYPFQi74ewYoTEPgHuItgHYaIhFoDvSVEm8nGzNFN3Y
 k+lNgsGpK1rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; 
   d="scan'208";a="330934898"
Received: from lkp-server02.sh.intel.com (HELO 713faec3b0e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2020 21:10:55 -0700
Received: from kbuild by 713faec3b0e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCxdG-0000Wa-Ie; Tue, 01 Sep 2020 04:10:54 +0000
Date:   Tue, 01 Sep 2020 12:10:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/fam0] BUILD SUCCESS
 a56dbff00095f3fc2c3fcb71dab2e536d42a4ff5
Message-ID: <5f4dc9c0.xY5yZXesL5ePuzmL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/fam0
branch HEAD: a56dbff00095f3fc2c3fcb71dab2e536d42a4ff5  scsi: target: tcmu: Replace zero-length array with flexible-array member

elapsed time: 726m

configs tested: 116
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
powerpc                     pq2fads_defconfig
arm                           h3600_defconfig
sh                           se7712_defconfig
powerpc64                        alldefconfig
openrisc                         alldefconfig
m68k                            mac_defconfig
powerpc                      pmac32_defconfig
sh                          lboxre2_defconfig
sh                           se7751_defconfig
arm                           u8500_defconfig
parisc                generic-32bit_defconfig
m68k                        mvme147_defconfig
powerpc                          allmodconfig
m68k                         apollo_defconfig
sh                          r7785rp_defconfig
powerpc                     mpc83xx_defconfig
powerpc                          allyesconfig
csky                                defconfig
arm                        mini2440_defconfig
arm                        cerfcube_defconfig
h8300                               defconfig
arm                       spear13xx_defconfig
arc                                 defconfig
m68k                          sun3x_defconfig
arm                            u300_defconfig
parisc                           allyesconfig
mips                       capcella_defconfig
powerpc                      ppc6xx_defconfig
sh                      rts7751r2d1_defconfig
m68k                            q40_defconfig
arm                           omap1_defconfig
arm                   milbeaut_m10v_defconfig
sh                        edosk7705_defconfig
mips                      malta_kvm_defconfig
sh                         microdev_defconfig
mips                      bmips_stb_defconfig
arm                            mps2_defconfig
nios2                               defconfig
arm                       imx_v6_v7_defconfig
mips                           rs90_defconfig
i386                             alldefconfig
powerpc                      ppc64e_defconfig
arm                            hisi_defconfig
nios2                         3c120_defconfig
powerpc                    adder875_defconfig
sh                            titan_defconfig
mips                           gcw0_defconfig
arm                         bcm2835_defconfig
arc                            hsdk_defconfig
arm                         s5pv210_defconfig
powerpc                         wii_defconfig
sh                        sh7757lcr_defconfig
sh                               alldefconfig
arm                           stm32_defconfig
mips                        jmr3927_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200831
i386                 randconfig-a002-20200831
i386                 randconfig-a004-20200831
i386                 randconfig-a006-20200831
i386                 randconfig-a005-20200831
i386                 randconfig-a003-20200831
x86_64               randconfig-a012-20200831
x86_64               randconfig-a015-20200831
x86_64               randconfig-a014-20200831
x86_64               randconfig-a011-20200831
x86_64               randconfig-a016-20200831
x86_64               randconfig-a013-20200831
i386                 randconfig-a013-20200831
i386                 randconfig-a011-20200831
i386                 randconfig-a012-20200831
i386                 randconfig-a015-20200831
i386                 randconfig-a016-20200831
i386                 randconfig-a014-20200831
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
