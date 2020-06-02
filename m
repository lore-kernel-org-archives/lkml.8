Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218E520734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFBTRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:17:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:24532 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgFBTRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:17:37 -0400
IronPort-SDR: j340/DQcYZoaC9uoKuG2d8NmKUBtG+4fT+yr4b5qly9hmWDcgMAij0k4ja4kPcQkkA0zMB7OmW
 yV4J+0qm5ueQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 12:17:36 -0700
IronPort-SDR: Iu+egTn+x5WEFDQIsSnNAfQ+wW5nU5r1NIfiZXSOKuWAJzE+UAqSvC4hY5+0IgfWatTkQrc4xs
 5oq9U64uUgBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; 
   d="scan'208";a="268806835"
Received: from lkp-server01.sh.intel.com (HELO e5a7ad696f24) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2020 12:17:35 -0700
Received: from kbuild by e5a7ad696f24 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgCPm-00008P-Ed; Tue, 02 Jun 2020 19:17:34 +0000
Date:   Wed, 03 Jun 2020 03:16:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS
 0c1b20be12a0b937b76c34fb481b2e881c01fa10
Message-ID: <5ed6a594.x/CUGBf5oZ9xtid+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: 0c1b20be12a0b937b76c34fb481b2e881c01fa10  torture:  Remove qemu dependency on EFI firmware

elapsed time: 911m

configs tested: 115
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
arm                         cm_x300_defconfig
arm64                            alldefconfig
arm                   milbeaut_m10v_defconfig
arm                          ep93xx_defconfig
mips                     loongson1b_defconfig
sh                        sh7763rdp_defconfig
ia64                              allnoconfig
sh                           se7619_defconfig
arm                            qcom_defconfig
sh                          kfr2r09_defconfig
sh                          r7780mp_defconfig
riscv                    nommu_virt_defconfig
sparc                       sparc32_defconfig
sh                          urquell_defconfig
mips                      pic32mzda_defconfig
mips                       bmips_be_defconfig
alpha                            alldefconfig
mips                  maltasmvp_eva_defconfig
sh                        dreamcast_defconfig
sh                          lboxre2_defconfig
arm                           corgi_defconfig
arm                         bcm2835_defconfig
sh                         microdev_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            u300_defconfig
arm                          simpad_defconfig
arm                          moxart_defconfig
sh                               j2_defconfig
sparc64                          allyesconfig
arm                            mps2_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         hackkit_defconfig
mips                     cu1000-neo_defconfig
x86_64                              defconfig
ia64                             allmodconfig
powerpc                  storcenter_defconfig
mips                  decstation_64_defconfig
sh                   rts7751r2dplus_defconfig
sh                     magicpanelr2_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
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
