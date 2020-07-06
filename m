Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD83CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECB5206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgGFIFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:05:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:10219 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgGFIFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:05:52 -0400
IronPort-SDR: fdR69CBSH/hRPG3Z1UAemsHy6iTruD033IrCNj/Wq0v2KF6D3zF+ZaK7LFHSAt3jNM3/5WN92x
 VIPxnQgtBCEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="147377255"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="147377255"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 01:05:50 -0700
IronPort-SDR: 6HsmcXyDEUY6BxwIoJfUHAYxBBcNaU9HWXgXbEOazpaYkeXfwfnHmeLfBLVOxXAANC5f0eRRfO
 qurpA2LjFP3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="305196255"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2020 01:05:49 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsM8K-00008g-OK; Mon, 06 Jul 2020 08:05:48 +0000
Date:   Mon, 06 Jul 2020 16:05:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 8fa88a88d573093868565a1afba43b5ae5b3a316
Message-ID: <5f02db4c.CqbEdFDnSQ4Yk8d8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: 8fa88a88d573093868565a1afba43b5ae5b3a316  genirq: Remove preflow handler support

elapsed time: 2881m

configs tested: 235
configs skipped: 34

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sh                                  defconfig
arm                          moxart_defconfig
arm                            qcom_defconfig
arm                          iop32x_defconfig
mips                           ip28_defconfig
powerpc                     pq2fads_defconfig
arm                         at91_dt_defconfig
sh                           cayman_defconfig
arm                       aspeed_g4_defconfig
m68k                         amcore_defconfig
arc                             nps_defconfig
arm                        trizeps4_defconfig
microblaze                    nommu_defconfig
h8300                       h8s-sim_defconfig
arc                        nsim_700_defconfig
c6x                        evmc6472_defconfig
m68k                        m5272c3_defconfig
arc                        nsimosci_defconfig
riscv                            alldefconfig
h8300                    h8300h-sim_defconfig
arm                         s3c2410_defconfig
mips                        vocore2_defconfig
mips                           ip27_defconfig
sh                         apsh4a3a_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                            titan_defconfig
powerpc                     skiroot_defconfig
sh                               allmodconfig
arm                         assabet_defconfig
powerpc                      ppc40x_defconfig
h8300                     edosk2674_defconfig
nios2                         10m50_defconfig
arm                          pxa3xx_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      ppc6xx_defconfig
mips                          ath25_defconfig
ia64                             allmodconfig
xtensa                              defconfig
arm                      jornada720_defconfig
powerpc                       maple_defconfig
mips                      pistachio_defconfig
h8300                               defconfig
arm                          simpad_defconfig
xtensa                         virt_defconfig
sh                          landisk_defconfig
sh                          rsk7264_defconfig
arm                          ep93xx_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
um                           x86_64_defconfig
powerpc                          g5_defconfig
powerpc                      pmac32_defconfig
microblaze                          defconfig
sh                          r7785rp_defconfig
openrisc                         allyesconfig
arm                           efm32_defconfig
sh                               alldefconfig
powerpc                    mvme5100_defconfig
mips                          rb532_defconfig
xtensa                          iss_defconfig
m68k                       m5475evb_defconfig
arm                         s5pv210_defconfig
arm                        vexpress_defconfig
arm                         lpc32xx_defconfig
mips                   sb1250_swarm_defconfig
sparc                            alldefconfig
mips                  mips_paravirt_defconfig
sh                        dreamcast_defconfig
sh                     sh7710voipgw_defconfig
nios2                            alldefconfig
m68k                            q40_defconfig
mips                      malta_kvm_defconfig
sh                        edosk7760_defconfig
powerpc                  mpc885_ads_defconfig
arm                   milbeaut_m10v_defconfig
openrisc                    or1ksim_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
arm                           tegra_defconfig
m68k                             alldefconfig
arc                      axs103_smp_defconfig
ia64                          tiger_defconfig
arm                         vf610m4_defconfig
mips                        jmr3927_defconfig
arm                         nhk8815_defconfig
arm                             pxa_defconfig
powerpc                      mgcoge_defconfig
arm                         bcm2835_defconfig
mips                        maltaup_defconfig
m68k                            mac_defconfig
sh                     magicpanelr2_defconfig
mips                             allyesconfig
powerpc                     mpc5200_defconfig
s390                          debug_defconfig
ia64                                defconfig
s390                             alldefconfig
sh                            shmin_defconfig
sh                           se7705_defconfig
parisc                           alldefconfig
arm                          imote2_defconfig
mips                         rt305x_defconfig
sh                          rsk7269_defconfig
sparc64                          alldefconfig
powerpc                         wii_defconfig
arm                  colibri_pxa300_defconfig
arm                            mps2_defconfig
arm                        oxnas_v6_defconfig
arm                           viper_defconfig
arm                         orion5x_defconfig
m68k                          multi_defconfig
arm                       imx_v4_v5_defconfig
arm                             rpc_defconfig
arm                         mv78xx0_defconfig
s390                                defconfig
arm                         socfpga_defconfig
mips                            e55_defconfig
arm                              zx_defconfig
arc                          axs103_defconfig
arm                          prima2_defconfig
powerpc                      ppc64e_defconfig
h8300                            alldefconfig
arc                                 defconfig
arm                         ebsa110_defconfig
powerpc                       ppc64_defconfig
m68k                       bvme6000_defconfig
mips                           xway_defconfig
ia64                              allnoconfig
arm                          tango4_defconfig
powerpc                        cell_defconfig
um                            kunit_defconfig
powerpc                          alldefconfig
arm                           stm32_defconfig
arc                            hsdk_defconfig
sh                             espt_defconfig
um                             i386_defconfig
sh                           se7721_defconfig
alpha                            allyesconfig
arm                           corgi_defconfig
mips                malta_qemu_32r6_defconfig
arm                            pleb_defconfig
arm                          lpd270_defconfig
mips                         tb0219_defconfig
powerpc                  storcenter_defconfig
m68k                       m5249evb_defconfig
arm                      footbridge_defconfig
arm                          badge4_defconfig
powerpc                          allmodconfig
sh                              ul2_defconfig
arm                          pxa168_defconfig
arm                        neponset_defconfig
sh                            migor_defconfig
alpha                               defconfig
mips                           gcw0_defconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
sh                   sh7770_generic_defconfig
sparc64                          allmodconfig
microblaze                        allnoconfig
powerpc                      chrp32_defconfig
mips                 pnx8335_stb225_defconfig
sh                         ecovec24_defconfig
sh                          polaris_defconfig
sh                   sh7724_generic_defconfig
mips                          ath79_defconfig
parisc                generic-64bit_defconfig
mips                 decstation_r4k_defconfig
sh                           se7206_defconfig
xtensa                generic_kc705_defconfig
m68k                        mvme16x_defconfig
m68k                           sun3_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc                            allyesconfig
sparc64                          allyesconfig
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
