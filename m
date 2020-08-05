Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3078DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CF422CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgHET62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:58:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:59149 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbgHEQnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:43:20 -0400
IronPort-SDR: fpgWkWNcSberW51hNT7x2/+p7CKVpW+G+7kxMxQ9+e68Mc2OhuS9TsZ8BsCrFuym+5/7070ICn
 qSBBQd9CiCHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153723581"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="153723581"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 08:55:21 -0700
IronPort-SDR: 8Ldgirbk9WR0+0MEOYNpC6S72cOf5baWD0xHSTkzDhWRVg+D9Bgo8uRMUEhCenD9Cu9gKGYHd9
 y6XjT332rDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="276132211"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Aug 2020 08:55:20 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3Ll9-0000pk-Le; Wed, 05 Aug 2020 15:55:19 +0000
Date:   Wed, 05 Aug 2020 23:54:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.07.24b] BUILD SUCCESS
 304e23263bcbd11f1172ba03989be60beb8382c1
Message-ID: <5f2ad641.NZUBeh4D+NafibVk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.07.24b
branch HEAD: 304e23263bcbd11f1172ba03989be60beb8382c1  fixup! squash! tools/memory-model: Add a simple entry point document

elapsed time: 724m

configs tested: 125
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       mainstone_defconfig
sh                   sh7770_generic_defconfig
mips                       rbtx49xx_defconfig
ia64                         bigsur_defconfig
arm                          simpad_defconfig
sh                          polaris_defconfig
microblaze                      mmu_defconfig
powerpc64                           defconfig
sh                          rsk7201_defconfig
arm                         axm55xx_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
powerpc                       holly_defconfig
powerpc                     pq2fads_defconfig
c6x                                 defconfig
arm                           u8500_defconfig
powerpc                    amigaone_defconfig
sh                           se7712_defconfig
arc                           tb10x_defconfig
sh                           se7780_defconfig
mips                   sb1250_swarm_defconfig
mips                         tb0287_defconfig
sh                        dreamcast_defconfig
sh                          r7780mp_defconfig
arm                        realview_defconfig
arm                           sunxi_defconfig
microblaze                    nommu_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1c_defconfig
arm                          lpd270_defconfig
arc                      axs103_smp_defconfig
powerpc                    mvme5100_defconfig
mips                        bcm47xx_defconfig
c6x                         dsk6455_defconfig
powerpc                  storcenter_defconfig
m68k                       m5275evb_defconfig
arm                  colibri_pxa270_defconfig
ia64                      gensparse_defconfig
arm                         orion5x_defconfig
m68k                             alldefconfig
arm                     am200epdkit_defconfig
arm                         nhk8815_defconfig
mips                     loongson1b_defconfig
sh                         apsh4a3a_defconfig
m68k                       m5249evb_defconfig
powerpc                      chrp32_defconfig
mips                        omega2p_defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
arm                         shannon_defconfig
arm                     davinci_all_defconfig
xtensa                generic_kc705_defconfig
arm                          moxart_defconfig
sh                           sh2007_defconfig
sh                           se7751_defconfig
powerpc                       ppc64_defconfig
arc                        vdk_hs38_defconfig
arm                      tct_hammer_defconfig
arm                             ezx_defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a005-20200805
i386                 randconfig-a004-20200805
i386                 randconfig-a001-20200805
i386                 randconfig-a003-20200805
i386                 randconfig-a002-20200805
i386                 randconfig-a006-20200805
x86_64               randconfig-a013-20200805
x86_64               randconfig-a011-20200805
x86_64               randconfig-a012-20200805
x86_64               randconfig-a016-20200805
x86_64               randconfig-a015-20200805
x86_64               randconfig-a014-20200805
i386                 randconfig-a011-20200805
i386                 randconfig-a012-20200805
i386                 randconfig-a013-20200805
i386                 randconfig-a014-20200805
i386                 randconfig-a015-20200805
i386                 randconfig-a016-20200805
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
