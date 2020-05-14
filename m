Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDAF2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgENQJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:09:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:35694 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgENQJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:09:44 -0400
IronPort-SDR: BCWFWq36drzJtyDE/cLZpb5B1AiXUPDjJbA4hkHiI7H+R40mrA9f9b7wyhhh8Oo7jajSvKzbQH
 9cLRcky3T//g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 09:09:43 -0700
IronPort-SDR: rrkOfI0zTXWVyG6GVw1HsyvdPMltSrDmAgq0SOt/GJn1uoXykhCX2ACxfwGY86l+A5uYUEr5ls
 n8jlSeUndY2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="307150477"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2020 09:09:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZGQX-000Fns-0e; Fri, 15 May 2020 00:09:41 +0800
Date:   Fri, 15 May 2020 00:09:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 81706f403730787e8babf1b4e0e391a02b966580
Message-ID: <5ebd6d36.fDEp/k76ey+Bb3hD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 81706f403730787e8babf1b4e0e391a02b966580  Merge branch 'linus'

elapsed time: 480m

configs tested: 144
configs skipped: 10

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
sparc                            allyesconfig
m68k                             allyesconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
i386                                defconfig
arm                          exynos_defconfig
powerpc                      pmac32_defconfig
nios2                               defconfig
powerpc                     mpc5200_defconfig
arm                            qcom_defconfig
sh                               alldefconfig
arm                       aspeed_g5_defconfig
arm                        vexpress_defconfig
mips                         rt305x_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
powerpc                       holly_defconfig
arm                        oxnas_v6_defconfig
powerpc                           allnoconfig
sh                          sdk7780_defconfig
riscv                            alldefconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
sh                          polaris_defconfig
arc                     haps_hs_smp_defconfig
mips                           jazz_defconfig
ia64                              allnoconfig
powerpc                          g5_defconfig
arm                  colibri_pxa300_defconfig
arm                       cns3420vb_defconfig
mips                     loongson1c_defconfig
arm                             rpc_defconfig
mips                      loongson3_defconfig
m68k                            q40_defconfig
ia64                        generic_defconfig
arm                        magician_defconfig
arm                          imote2_defconfig
powerpc                      tqm8xx_defconfig
mips                           ip28_defconfig
arm                        clps711x_defconfig
m68k                           sun3_defconfig
mips                   sb1250_swarm_defconfig
arc                          axs101_defconfig
sh                            titan_defconfig
s390                                defconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6678_defconfig
sh                            shmin_defconfig
arm                        neponset_defconfig
sh                         microdev_defconfig
x86_64                              defconfig
arm                         s3c2410_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
sh                        sh7763rdp_defconfig
arm                             ezx_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         cobalt_defconfig
powerpc                       maple_defconfig
ia64                            zx1_defconfig
sh                         ecovec24_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                                defconfig
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
x86_64               randconfig-a012-20200514
x86_64               randconfig-a016-20200514
x86_64               randconfig-a015-20200514
x86_64               randconfig-a013-20200514
x86_64               randconfig-a014-20200514
x86_64               randconfig-a011-20200514
i386                 randconfig-a012-20200514
i386                 randconfig-a016-20200514
i386                 randconfig-a014-20200514
i386                 randconfig-a011-20200514
i386                 randconfig-a013-20200514
i386                 randconfig-a015-20200514
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
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
