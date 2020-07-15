Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C722065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgGOJXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:23:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:55198 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbgGOJXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:23:47 -0400
IronPort-SDR: 6MECR/mdu1hZCHOTqjfpLOH6oolGTeZVakstF31Z0LBzMYtyp9bUMCEm5V/BjvcBmnzNHLj/pL
 gcsxWgXjuNOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="128675166"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="128675166"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 02:23:47 -0700
IronPort-SDR: +yhAI4yuWih4miWHj/upq+Xknm2prgWKgQcXWJn677L39lhKlJigRG2x4TvAWHd3Pl4pif8+S4
 0Y5Sx5e1g99w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="326110851"
Received: from lkp-server01.sh.intel.com (HELO b157d87b7ee7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Jul 2020 02:23:46 -0700
Received: from kbuild by b157d87b7ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvddh-00008f-H2; Wed, 15 Jul 2020 09:23:45 +0000
Date:   Wed, 15 Jul 2020 17:22:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.07.10a] BUILD SUCCESS
 475a5da3202544a8cbb3342f842a763df423b989
Message-ID: <5f0ecae9.B36+NWa6ZvW1RngG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.07.10a
branch HEAD: 475a5da3202544a8cbb3342f842a763df423b989  rcutorture: Add CONFIG_PROVE_RCU_LIST to TREE05

elapsed time: 720m

configs tested: 108
configs skipped: 12

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
h8300                     edosk2674_defconfig
sh                          polaris_defconfig
mips                           xway_defconfig
xtensa                          iss_defconfig
powerpc                      pmac32_defconfig
mips                      maltaaprp_defconfig
sh                           se7206_defconfig
mips                malta_qemu_32r6_defconfig
sparc64                             defconfig
mips                      pistachio_defconfig
powerpc                       maple_defconfig
arm                          badge4_defconfig
microblaze                          defconfig
i386                             allyesconfig
arm                         s3c6400_defconfig
m68k                         amcore_defconfig
c6x                               allnoconfig
xtensa                generic_kc705_defconfig
mips                           ip27_defconfig
mips                  mips_paravirt_defconfig
c6x                        evmc6474_defconfig
powerpc                      pasemi_defconfig
sh                        dreamcast_defconfig
openrisc                         alldefconfig
m68k                        m5407c3_defconfig
arm                          ep93xx_defconfig
arm                          moxart_defconfig
sparc                               defconfig
mips                        maltaup_defconfig
mips                          rb532_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlp_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                            defconfig
arm                  colibri_pxa270_defconfig
ia64                      gensparse_defconfig
mips                      fuloong2e_defconfig
sh                          r7780mp_defconfig
ia64                                defconfig
powerpc                      ppc6xx_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
