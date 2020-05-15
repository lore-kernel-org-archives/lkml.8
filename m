Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E07C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D007720671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgEOBXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:23:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:18213 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOBXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:23:34 -0400
IronPort-SDR: NxY1u+COr2AJ2HFqZddeUjER97cqfJMVqpA9OQi5sLWu0Y/aEDOYlSawJPwP8KxQj0l/yqz0lL
 4ujfPKdKxVlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 18:23:33 -0700
IronPort-SDR: 716VIDaeK6cKbyNcXE8WXDg0uk9xoEckrljiXWaLbUMpyrJYx6AII5OT0hFZj1rVusWKDFpfjU
 LMRDjM1ZYwow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="438127658"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 May 2020 18:23:31 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZP4V-000Fj6-9E; Fri, 15 May 2020 09:23:31 +0800
Date:   Fri, 15 May 2020 09:22:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:lkmm-dev] BUILD SUCCESS
 67e6bf52edb83db3258a655a19b843ce6760a86d
Message-ID: <5ebdeedf.OYQX5t/GwNvGJvWe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  lkmm-dev
branch HEAD: 67e6bf52edb83db3258a655a19b843ce6760a86d  tools/memory-model: Use "-unroll 0" to keep --hw runs finite

elapsed time: 484m

configs tested: 128
configs skipped: 46

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
arm                          exynos_defconfig
powerpc                      pmac32_defconfig
mips                         rt305x_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
powerpc                       holly_defconfig
arm                        oxnas_v6_defconfig
powerpc                           allnoconfig
mips                           ip27_defconfig
sparc                            alldefconfig
mips                  decstation_64_defconfig
mips                            e55_defconfig
m68k                          multi_defconfig
arm                       cns3420vb_defconfig
mips                     loongson1c_defconfig
arm                             rpc_defconfig
mips                      loongson3_defconfig
s390                       zfcpdump_defconfig
powerpc                       maple_defconfig
sh                           se7722_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
s390                                defconfig
arc                      axs103_smp_defconfig
arm                         cm_x2xx_defconfig
arm                         palmz72_defconfig
ia64                             allmodconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6678_defconfig
sh                            shmin_defconfig
arm                        neponset_defconfig
powerpc                          g5_defconfig
arm                          iop32x_defconfig
arm                         vf610m4_defconfig
mips                        nlm_xlr_defconfig
mips                        nlm_xlp_defconfig
arm                      jornada720_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
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
i386                 randconfig-a006-20200514
i386                 randconfig-a005-20200514
i386                 randconfig-a003-20200514
i386                 randconfig-a001-20200514
i386                 randconfig-a004-20200514
i386                 randconfig-a002-20200514
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
x86_64                              defconfig
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
