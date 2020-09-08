Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1027C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B72F2074D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgIHSB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:01:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:17156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731606AbgIHR72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:59:28 -0400
IronPort-SDR: dxWIhuJ9uEGq59T5BmAc1ktPKug225/8S+3XFDwiK6p0jd/CvhXieFMVJ5RG7GlNxq1pSaICh3
 5DnZKZSxkF8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="243012923"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="243012923"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:59:21 -0700
IronPort-SDR: WARO9DJMBbdZU31c3kTwLwETLAhMPcS0hnrIUw7KAImr2M0Q6PsVL7nJiRlxDio9c6MmQ0fotY
 hqlbo+byZkkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="304175944"
Received: from lkp-server01.sh.intel.com (HELO fc0154cbc871) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2020 10:59:20 -0700
Received: from kbuild by fc0154cbc871 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kFhtn-0000Ce-Cv; Tue, 08 Sep 2020 17:59:19 +0000
Date:   Wed, 09 Sep 2020 01:58:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.09.04b] BUILD SUCCESS
 e6195051140a6189b588b79e208e380dd8504a13
Message-ID: <5f57c661.egqPb8FPh/s3aoyZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.09.04b
branch HEAD: e6195051140a6189b588b79e208e380dd8504a13  squash! scftorture: Add an alternative IPI vector

elapsed time: 720m

configs tested: 147
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          pxa3xx_defconfig
x86_64                           allyesconfig
m68k                          amiga_defconfig
xtensa                              defconfig
sh                        edosk7705_defconfig
arm                         nhk8815_defconfig
mips                           ip27_defconfig
arm                   milbeaut_m10v_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
mips                 decstation_r4k_defconfig
alpha                               defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     ep8248e_defconfig
arm                          pxa910_defconfig
arm                        spear3xx_defconfig
arm                         lpc18xx_defconfig
m68k                       m5208evb_defconfig
mips                        bcm47xx_defconfig
powerpc                      tqm8xx_defconfig
mips                           rs90_defconfig
xtensa                       common_defconfig
arm                            u300_defconfig
c6x                        evmc6457_defconfig
sh                   sh7724_generic_defconfig
mips                          ath79_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
powerpc                     mpc5200_defconfig
h8300                     edosk2674_defconfig
sh                          urquell_defconfig
sh                        apsh4ad0a_defconfig
c6x                        evmc6472_defconfig
xtensa                           alldefconfig
powerpc                      ppc64e_defconfig
mips                       capcella_defconfig
arm                         assabet_defconfig
riscv                          rv32_defconfig
m68k                       m5275evb_defconfig
arm                            hisi_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
arm                      pxa255-idp_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     powernv_defconfig
arm                            lart_defconfig
csky                             alldefconfig
arm                         lubbock_defconfig
arm                          badge4_defconfig
xtensa                           allyesconfig
mips                malta_kvm_guest_defconfig
s390                          debug_defconfig
c6x                        evmc6678_defconfig
arc                              allyesconfig
arm                        spear6xx_defconfig
powerpc                      ppc6xx_defconfig
powerpc                    gamecube_defconfig
s390                       zfcpdump_defconfig
arm                       mainstone_defconfig
sh                            shmin_defconfig
mips                           ci20_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
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
x86_64               randconfig-a006-20200907
x86_64               randconfig-a004-20200907
x86_64               randconfig-a003-20200907
x86_64               randconfig-a005-20200907
x86_64               randconfig-a001-20200907
x86_64               randconfig-a002-20200907
i386                 randconfig-a004-20200908
i386                 randconfig-a005-20200908
i386                 randconfig-a006-20200908
i386                 randconfig-a002-20200908
i386                 randconfig-a001-20200908
i386                 randconfig-a003-20200908
i386                 randconfig-a004-20200907
i386                 randconfig-a005-20200907
i386                 randconfig-a006-20200907
i386                 randconfig-a002-20200907
i386                 randconfig-a003-20200907
i386                 randconfig-a001-20200907
x86_64               randconfig-a013-20200908
x86_64               randconfig-a016-20200908
x86_64               randconfig-a011-20200908
x86_64               randconfig-a012-20200908
x86_64               randconfig-a015-20200908
x86_64               randconfig-a014-20200908
i386                 randconfig-a016-20200907
i386                 randconfig-a015-20200907
i386                 randconfig-a011-20200907
i386                 randconfig-a013-20200907
i386                 randconfig-a014-20200907
i386                 randconfig-a012-20200907
i386                 randconfig-a016-20200908
i386                 randconfig-a015-20200908
i386                 randconfig-a011-20200908
i386                 randconfig-a013-20200908
i386                 randconfig-a014-20200908
i386                 randconfig-a012-20200908
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20200907
x86_64               randconfig-a011-20200907
x86_64               randconfig-a016-20200907
x86_64               randconfig-a012-20200907
x86_64               randconfig-a015-20200907
x86_64               randconfig-a014-20200907

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
