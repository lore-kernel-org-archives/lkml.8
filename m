Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5971C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958C62074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGFF55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:57:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:31382 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbgGFF55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:57:57 -0400
IronPort-SDR: Dg2z7DfGKwuwd9W37WuIor0XVjlDlEd4hrcBCRQHdqcnYLKoLeo09fEX1WG+vDbEZy7+2pJe/A
 fBO2/fMrQSXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="134819860"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="134819860"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 22:57:55 -0700
IronPort-SDR: jLJjc7Addgww33L3q1XL0kcE7QRMhbd8tK7Ckbwn1BPYsk/naMLC0vVm7XquzjEq3bZu0ptSVR
 tWykBflbcHsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="388100244"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2020 22:57:54 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsK8X-00005g-TP; Mon, 06 Jul 2020 05:57:53 +0000
Date:   Mon, 06 Jul 2020 13:57:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.07.02a] BUILD SUCCESS
 9e4ad971bf0a551b3922c94eda1f361be04dcde2
Message-ID: <5f02bd57.Ti8/XlCNu8BIv7uV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.07.02a
branch HEAD: 9e4ad971bf0a551b3922c94eda1f361be04dcde2  squash! kernel/smp: Provide CSD lock timeout diagnostics

elapsed time: 2235m

configs tested: 219
configs skipped: 34

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
m68k                        m5407c3_defconfig
sh                               allmodconfig
arm                         s5pv210_defconfig
arm                             ezx_defconfig
arm                  colibri_pxa270_defconfig
h8300                       h8s-sim_defconfig
arc                        nsim_700_defconfig
c6x                        evmc6472_defconfig
m68k                        m5272c3_defconfig
arc                        nsimosci_defconfig
powerpc                     pq2fads_defconfig
mips                      malta_kvm_defconfig
arm                          ep93xx_defconfig
openrisc                 simple_smp_defconfig
riscv                            alldefconfig
h8300                    h8300h-sim_defconfig
arm                         s3c2410_defconfig
mips                        vocore2_defconfig
mips                           ip27_defconfig
sh                         apsh4a3a_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                            titan_defconfig
powerpc                     skiroot_defconfig
arm                         cm_x300_defconfig
sh                 kfr2r09-romimage_defconfig
mips                         tb0219_defconfig
sh                               j2_defconfig
arm                          lpd270_defconfig
h8300                     edosk2674_defconfig
nios2                         10m50_defconfig
ia64                             allmodconfig
arm                         assabet_defconfig
xtensa                              defconfig
arm                      jornada720_defconfig
xtensa                         virt_defconfig
sh                          landisk_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
mips                  mips_paravirt_defconfig
sh                        dreamcast_defconfig
sh                     sh7710voipgw_defconfig
nios2                            alldefconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
powerpc                       maple_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
mips                          rb532_defconfig
arm                           tegra_defconfig
mips                          ath25_defconfig
mips                        jmr3927_defconfig
arm                         nhk8815_defconfig
arm                             pxa_defconfig
powerpc                      mgcoge_defconfig
arm                         bcm2835_defconfig
mips                        maltaup_defconfig
m68k                            mac_defconfig
sh                     magicpanelr2_defconfig
mips                             allyesconfig
arc                           tb10x_defconfig
ia64                         bigsur_defconfig
sh                           se7705_defconfig
parisc                           alldefconfig
powerpc                      ppc6xx_defconfig
arm                          imote2_defconfig
arm                        clps711x_defconfig
xtensa                    xip_kc705_defconfig
nios2                               defconfig
mips                         rt305x_defconfig
sh                          rsk7269_defconfig
sparc64                          alldefconfig
powerpc                         wii_defconfig
arm                  colibri_pxa300_defconfig
arm                            mps2_defconfig
arm                        oxnas_v6_defconfig
arm                       imx_v4_v5_defconfig
arm                             rpc_defconfig
arm                         mv78xx0_defconfig
s390                                defconfig
sh                           cayman_defconfig
arm                         socfpga_defconfig
h8300                               defconfig
mips                            e55_defconfig
powerpc                     powernv_defconfig
arm                         s3c6400_defconfig
m68k                          atari_defconfig
arm                           u8500_defconfig
mips                    maltaup_xpa_defconfig
arm                              zx_defconfig
powerpc                          g5_defconfig
arc                          axs103_defconfig
arm                           efm32_defconfig
arc                                 defconfig
arm                          prima2_defconfig
powerpc                      ppc64e_defconfig
h8300                            alldefconfig
sh                      rts7751r2d1_defconfig
mips                     loongson1b_defconfig
mips                           xway_defconfig
ia64                              allnoconfig
arm                         vf610m4_defconfig
arm                          tango4_defconfig
sh                            shmin_defconfig
mips                     cu1000-neo_defconfig
alpha                            allyesconfig
powerpc                      ppc44x_defconfig
powerpc                        cell_defconfig
um                            kunit_defconfig
powerpc                     mpc5200_defconfig
i386                             alldefconfig
mips                      fuloong2e_defconfig
mips                           jazz_defconfig
parisc                generic-64bit_defconfig
arm                           spitz_defconfig
powerpc                          allyesconfig
mips                         db1xxx_defconfig
arm                         lubbock_defconfig
arm                          iop32x_defconfig
sh                             espt_defconfig
um                             i386_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
mips                malta_qemu_32r6_defconfig
arm                            pleb_defconfig
m68k                       m5249evb_defconfig
sh                          r7785rp_defconfig
arm                      footbridge_defconfig
arm                          badge4_defconfig
arc                    vdk_hs38_smp_defconfig
arc                     nsimosci_hs_defconfig
powerpc                          allmodconfig
sh                              ul2_defconfig
arm                          pxa168_defconfig
arm                        neponset_defconfig
sh                            migor_defconfig
openrisc                    or1ksim_defconfig
alpha                               defconfig
sparc64                          allmodconfig
microblaze                        allnoconfig
sparc                               defconfig
arm                             mxs_defconfig
riscv                            allyesconfig
m68k                          sun3x_defconfig
sparc                       sparc32_defconfig
ia64                        generic_defconfig
arm                           sunxi_defconfig
powerpc                      chrp32_defconfig
mips                 pnx8335_stb225_defconfig
riscv                             allnoconfig
sh                         ecovec24_defconfig
sh                          polaris_defconfig
sh                   sh7724_generic_defconfig
mips                          ath79_defconfig
xtensa                          iss_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                                defconfig
ia64                             allyesconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
arc                              allyesconfig
sh                                allnoconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc                            allyesconfig
sparc64                          allyesconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
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
