Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7066C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 20:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31AF20771
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgFUUf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:35:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:19721 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbgFUUf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 16:35:26 -0400
IronPort-SDR: j/9c0RWSA30fkbIOZTVQcRBmBLZ9pIqEVLx96vKGHxOfMnYk5ORxVMSLLOsLg14AIgbcEizDbu
 PbzRcfUoQOMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="143573717"
X-IronPort-AV: E=Sophos;i="5.75,264,1589266800"; 
   d="scan'208";a="143573717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 13:35:25 -0700
IronPort-SDR: KR+twpeg0gcFEQRqPy1rWzTzNsSfOL6b2HPb6yETFSYs+TCs92/EDWVejEDdU/YuLfXppfNySh
 +j50wSNzBSvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,264,1589266800"; 
   d="scan'208";a="478183810"
Received: from lkp-server02.sh.intel.com (HELO 3aa54c81372e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2020 13:35:23 -0700
Received: from kbuild by 3aa54c81372e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jn6gU-0002re-Qs; Sun, 21 Jun 2020 20:35:22 +0000
Date:   Mon, 22 Jun 2020 04:35:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b8b01e308e5d08b6bc3629d885de7c6c62d7ba1c
Message-ID: <5eefc47c.JbnnJjbFLkt77RDX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: b8b01e308e5d08b6bc3629d885de7c6c62d7ba1c  Merge branch 'linus'

elapsed time: 724m

configs tested: 137
configs skipped: 9

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
sh                          landisk_defconfig
arm                              zx_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                         ecovec24_defconfig
mips                        vocore2_defconfig
mips                  decstation_64_defconfig
arm                         shannon_defconfig
mips                     loongson1b_defconfig
mips                         db1xxx_defconfig
m68k                          atari_defconfig
arm                             rpc_defconfig
mips                      pistachio_defconfig
sh                        edosk7760_defconfig
riscv                               defconfig
arm                           sunxi_defconfig
mips                   sb1250_swarm_defconfig
riscv                    nommu_k210_defconfig
sh                          polaris_defconfig
sparc64                           allnoconfig
arm                         lpc32xx_defconfig
arm                         nhk8815_defconfig
arm                        clps711x_defconfig
mips                      fuloong2e_defconfig
sparc                               defconfig
sh                ecovec24-romimage_defconfig
arm                          collie_defconfig
arm                          imote2_defconfig
arm                         socfpga_defconfig
mips                 pnx8335_stb225_defconfig
m68k                          sun3x_defconfig
arm                         hackkit_defconfig
c6x                        evmc6678_defconfig
arm                     am200epdkit_defconfig
i386                                defconfig
powerpc                       maple_defconfig
sh                           se7724_defconfig
sparc64                          alldefconfig
sh                        dreamcast_defconfig
arc                     nsimosci_hs_defconfig
microblaze                    nommu_defconfig
i386                             allyesconfig
sh                                  defconfig
mips                           xway_defconfig
sh                        sh7785lcr_defconfig
i386                              allnoconfig
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
arc                                 defconfig
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
i386                 randconfig-a006-20200621
i386                 randconfig-a002-20200621
i386                 randconfig-a003-20200621
i386                 randconfig-a001-20200621
i386                 randconfig-a005-20200621
i386                 randconfig-a004-20200621
x86_64               randconfig-a012-20200621
x86_64               randconfig-a011-20200621
x86_64               randconfig-a013-20200621
x86_64               randconfig-a014-20200621
x86_64               randconfig-a015-20200621
x86_64               randconfig-a016-20200621
i386                 randconfig-a013-20200621
i386                 randconfig-a016-20200621
i386                 randconfig-a012-20200621
i386                 randconfig-a014-20200621
i386                 randconfig-a015-20200621
i386                 randconfig-a011-20200621
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc64                             defconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
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
