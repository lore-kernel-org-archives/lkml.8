Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD4C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFFF2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgH0TeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:34:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:53824 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgH0TeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:34:09 -0400
IronPort-SDR: zr9MTr3me4n6zvHndZ5ATHjzbvw0GSl1tGG92+Ylv7AeUu5MS2njA5WzsyASokukK2qJHxs+su
 5fip4yP2QySg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="220804766"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="220804766"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 12:34:08 -0700
IronPort-SDR: S1ZAxSndS4BY4kg0KGIYFpnTrQb6Fw+3l0EbcO45eLOhaoQHWiVKGxZ+BLIeUzDmnzHY6ocp6I
 rsnVuLbVEx4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="475355635"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2020 12:34:07 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBNew-0002F4-HV; Thu, 27 Aug 2020 19:34:06 +0000
Date:   Fri, 28 Aug 2020 03:33:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e027fffff799cdd70400c5485b1a54f482255985
Message-ID: <5f480a7f./1kTtw+7dkFga1zc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: e027fffff799cdd70400c5485b1a54f482255985  x86/irq: Unbreak interrupt affinity setting

elapsed time: 721m

configs tested: 114
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
arm                             rpc_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     pq2fads_defconfig
mips                           xway_defconfig
m68k                          sun3x_defconfig
sh                            shmin_defconfig
mips                          malta_defconfig
arm                           spitz_defconfig
mips                       rbtx49xx_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     mpc5200_defconfig
mips                           ip22_defconfig
arm                         hackkit_defconfig
arm                          moxart_defconfig
parisc                           alldefconfig
arm                        mvebu_v7_defconfig
arm                    vt8500_v6_v7_defconfig
sh                             sh03_defconfig
arm                         mv78xx0_defconfig
sh                               alldefconfig
m68k                          amiga_defconfig
sh                        edosk7705_defconfig
arm                         axm55xx_defconfig
sh                          urquell_defconfig
arm                         assabet_defconfig
h8300                    h8300h-sim_defconfig
h8300                               defconfig
sh                          sdk7780_defconfig
c6x                         dsk6455_defconfig
arc                              alldefconfig
arm                  colibri_pxa270_defconfig
mips                       lemote2f_defconfig
m68k                         apollo_defconfig
sh                        edosk7760_defconfig
sh                           sh2007_defconfig
sparc                            allyesconfig
sh                         microdev_defconfig
sh                           se7712_defconfig
arm                        magician_defconfig
nios2                            alldefconfig
arc                                 defconfig
c6x                        evmc6678_defconfig
sh                             shx3_defconfig
powerpc                    amigaone_defconfig
powerpc                     skiroot_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20200827
x86_64               randconfig-a002-20200827
x86_64               randconfig-a001-20200827
x86_64               randconfig-a005-20200827
x86_64               randconfig-a006-20200827
x86_64               randconfig-a004-20200827
i386                 randconfig-a002-20200827
i386                 randconfig-a004-20200827
i386                 randconfig-a003-20200827
i386                 randconfig-a005-20200827
i386                 randconfig-a006-20200827
i386                 randconfig-a001-20200827
i386                 randconfig-a013-20200827
i386                 randconfig-a012-20200827
i386                 randconfig-a011-20200827
i386                 randconfig-a016-20200827
i386                 randconfig-a015-20200827
i386                 randconfig-a014-20200827
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
