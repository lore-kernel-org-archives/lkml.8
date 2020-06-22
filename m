Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AE4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54389253DB
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 04:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgFVERG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 00:17:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:20973 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgFVERG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 00:17:06 -0400
IronPort-SDR: bxks6M6GR+uyoSbV4Lzss0wz8okfQa46E6WwqLKmOGb/Vb8LQMj2NLr9SLFEhlkopW8DVCu+f9
 rzY65CwPQh8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="132087751"
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; 
   d="scan'208";a="132087751"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 21:17:05 -0700
IronPort-SDR: vCc/J8Xm8ndfGBMuIA1dgpW1VTVMA4yIVCdQibepTS0K6ILhicU1IbOQQPT1MhnoDXgY3Ge+6o
 0NPJBE5cAAUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; 
   d="scan'208";a="292732855"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2020 21:17:03 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnDtH-000023-5L; Mon, 22 Jun 2020 04:17:03 +0000
Date:   Mon, 22 Jun 2020 12:16:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 d831090dafcc38c0c5671e69c3c7efa422bf4242
Message-ID: <5ef0309e.BgFwLHUno67FGexq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: d831090dafcc38c0c5671e69c3c7efa422bf4242  kcsan: Disable branch tracing in core runtime

elapsed time: 721m

configs tested: 133
configs skipped: 7

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
m68k                       m5475evb_defconfig
parisc                           alldefconfig
sh                          r7785rp_defconfig
x86_64                              defconfig
powerpc                     skiroot_defconfig
arm                         lubbock_defconfig
arc                             nps_defconfig
xtensa                       common_defconfig
i386                              allnoconfig
arm                        clps711x_defconfig
mips                      fuloong2e_defconfig
sh                ecovec24-romimage_defconfig
arm                          collie_defconfig
arm                          imote2_defconfig
sparc                               defconfig
arm                         socfpga_defconfig
mips                 pnx8335_stb225_defconfig
m68k                          sun3x_defconfig
mips                             allmodconfig
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
sh                                  defconfig
mips                           xway_defconfig
sh                        sh7785lcr_defconfig
i386                             allyesconfig
powerpc                  mpc885_ads_defconfig
powerpc                      tqm8xx_defconfig
arm                             pxa_defconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6474_defconfig
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
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a006-20200621
i386                 randconfig-a002-20200621
i386                 randconfig-a003-20200621
i386                 randconfig-a001-20200621
i386                 randconfig-a005-20200621
i386                 randconfig-a004-20200621
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
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
