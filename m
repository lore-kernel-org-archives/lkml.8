Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A1CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 05:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4C2207D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 05:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFMFyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 01:54:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:50041 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgFMFyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 01:54:43 -0400
IronPort-SDR: nr9LMtqzkPeCG1ijEMfpjQymP1lg4uJF71B4GtQJn6plpXqJEnW8C9EGv+Q8zvwjz2X//HUmpZ
 Ltg8qE6gm51g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 22:54:43 -0700
IronPort-SDR: b0Q/yQdGWhUOlISjGlMsSbj6OLNtmlxK+okOJCVpodRNZuugLw3cKafODodEhtkBcwhHIvBDRG
 /cQKmR16HBiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,506,1583222400"; 
   d="scan'208";a="380921861"
Received: from lkp-server02.sh.intel.com (HELO de5642daf266) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2020 22:54:42 -0700
Received: from kbuild by de5642daf266 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjz7p-0000FM-9Y; Sat, 13 Jun 2020 05:54:41 +0000
Date:   Sat, 13 Jun 2020 13:54:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2bef5106d9ae4b0b2612db2f477c4ab990dd44cb
Message-ID: <5ee46a1a.mpTrJXr3DAbDr1rB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 2bef5106d9ae4b0b2612db2f477c4ab990dd44cb  Merge branch 'x86/entry'

elapsed time: 482m

configs tested: 111
configs skipped: 2

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
arm                            zeus_defconfig
arm                         socfpga_defconfig
parisc                generic-64bit_defconfig
mips                        qi_lb60_defconfig
arm                             ezx_defconfig
arm                          pxa168_defconfig
xtensa                         virt_defconfig
arm                          moxart_defconfig
arm                              zx_defconfig
sh                   sh7770_generic_defconfig
arm                          imote2_defconfig
arm                        clps711x_defconfig
sh                 kfr2r09-romimage_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                          iss_defconfig
riscv                          rv32_defconfig
c6x                        evmc6474_defconfig
s390                       zfcpdump_defconfig
arc                        vdk_hs38_defconfig
arc                           tb10x_defconfig
openrisc                         allyesconfig
arm                           efm32_defconfig
powerpc                     pq2fads_defconfig
arm                          tango4_defconfig
c6x                        evmc6472_defconfig
arm                          ixp4xx_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a015-20200612
i386                 randconfig-a011-20200612
i386                 randconfig-a014-20200612
i386                 randconfig-a016-20200612
i386                 randconfig-a013-20200612
i386                 randconfig-a012-20200612
riscv                            allyesconfig
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
