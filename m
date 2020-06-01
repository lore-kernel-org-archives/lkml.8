Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5393CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F132073E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgFAFRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:17:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:8334 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgFAFRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:17:50 -0400
IronPort-SDR: yr7ILpyouMhssohd7AS3Spxeo+QwtR8F7DDpjR9PJtfJko175IP0Vk05sSI1d9Z+8cu61Do7jv
 hmKDBUaTHnuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:17:50 -0700
IronPort-SDR: TvYpq6yEBiYn0w/nxfHq1xwMmf8jqfObGszJQy+dTEg6nsX0Hyogr5eCgtjkddx8VLxnUULDBU
 zbgSsnf9Nw9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="415685513"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2020 22:17:49 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcpY-0000DM-Ad; Mon, 01 Jun 2020 05:17:48 +0000
Date:   Mon, 01 Jun 2020 13:16:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/kcsan] BUILD SUCCESS
 f05e1242fbb2d149ceaa87310cf67d03fe007a25
Message-ID: <5ed48f37.LoxA1pvxLLvO0VOU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/kcsan
branch HEAD: f05e1242fbb2d149ceaa87310cf67d03fe007a25  compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse

i386-tinyconfig vmlinux size:

+-------+------------------------------------+---------------------------------------------------------------------------+
| DELTA |               SYMBOL               |                                  COMMIT                                   |
+-------+------------------------------------+---------------------------------------------------------------------------+
| -5517 | TOTAL                              | ffed638b6a21..f05e1242fbb2 (ALL COMMITS)                                  |
| -5517 | TOTAL                              | 777f73c4e791 compiler.h: Remove data_race() and unnecessary checks from { |
| -5517 | TEXT                               | 777f73c4e791 compiler.h: Remove data_race() and unnecessary checks from { |
|  +136 | arch/x86/events/zhaoxin/built-in.* | a5dead405f6b compiler_types.h: Optimize __unqual_scalar_typeof compilatio |
|  -136 | arch/x86/events/zhaoxin/built-in.* | e87c5783e9e4 ubsan, kcsan: Don't combine sanitizer with kcov on clang     |
|   +65 | get_page_from_freelist()           | 777f73c4e791 compiler.h: Remove data_race() and unnecessary checks from { |
|   -98 | __wakeup_flusher_threads_bdi()     | 777f73c4e791 compiler.h: Remove data_race() and unnecessary checks from { |
+-------+------------------------------------+---------------------------------------------------------------------------+

elapsed time: 5453m

configs tested: 153
configs skipped: 17

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
powerpc                      ppc44x_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc64_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
powerpc                      mgcoge_defconfig
nds32                             allnoconfig
s390                              allnoconfig
arm                         vf610m4_defconfig
arm                          pxa168_defconfig
mips                           ip27_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           mtx1_defconfig
sh                            shmin_defconfig
microblaze                          defconfig
arm                         shannon_defconfig
powerpc                      ppc6xx_defconfig
powerpc64                        alldefconfig
microblaze                    nommu_defconfig
powerpc                  mpc885_ads_defconfig
arm                       aspeed_g5_defconfig
mips                        maltaup_defconfig
arc                             nps_defconfig
arm                             pxa_defconfig
c6x                        evmc6678_defconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
arm                        multi_v7_defconfig
arm                       mainstone_defconfig
arm                            hisi_defconfig
powerpc                     mpc83xx_defconfig
m68k                          multi_defconfig
m68k                             allyesconfig
um                           x86_64_defconfig
sh                            titan_defconfig
arm                       netwinder_defconfig
parisc                generic-32bit_defconfig
sh                          rsk7264_defconfig
arm                        spear6xx_defconfig
sh                   sh7770_generic_defconfig
m68k                           sun3_defconfig
sh                           se7619_defconfig
arm                         ebsa110_defconfig
arm                            lart_defconfig
sh                         microdev_defconfig
x86_64                              defconfig
arm                          badge4_defconfig
arm                        oxnas_v6_defconfig
arc                     haps_hs_smp_defconfig
arm                         at91_dt_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
arm                      footbridge_defconfig
arm                            dove_defconfig
h8300                            alldefconfig
um                               alldefconfig
nds32                            alldefconfig
arm                         s3c6400_defconfig
m68k                        mvme16x_defconfig
mips                      pistachio_defconfig
arc                           tb10x_defconfig
arm                        mvebu_v7_defconfig
powerpc                mpc7448_hpc2_defconfig
c6x                         dsk6455_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
arm                       cns3420vb_defconfig
arm                        spear3xx_defconfig
mips                          rm200_defconfig
arm                        mvebu_v5_defconfig
arm                         assabet_defconfig
xtensa                           alldefconfig
powerpc                      tqm8xx_defconfig
sh                           se7750_defconfig
xtensa                         virt_defconfig
arm                        multi_v5_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
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
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
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
