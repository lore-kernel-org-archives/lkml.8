Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00220C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C262067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgFCLNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:13:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:50603 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgFCLNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:13:24 -0400
IronPort-SDR: fdaDDy6Zkvf5Zwsa0jBnNVl2y9JTjk1OKqEnxkED21pb+G3RXSlnkJuNhsvK6r+6NPPWTgEiGx
 nKGnX6riwuiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:13:22 -0700
IronPort-SDR: rLJ+wzd6YmUAaZuaP8xbJW2vGaJtEviBy5312HzuHTvFsnLVuV6nyJXxwRR02/GUgZQVsvFMAN
 H34DBEO7Hibw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="269042364"
Received: from lkp-server01.sh.intel.com (HELO dad89584b564) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 04:13:21 -0700
Received: from kbuild by dad89584b564 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgRKi-00007Z-Pm; Wed, 03 Jun 2020 11:13:20 +0000
Date:   Wed, 03 Jun 2020 19:13:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS
 f5978744fd874b7775e73958d64f3e0b2082957b
Message-ID: <5ed785ca.ghCYKBzvQH+wTPpj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: f5978744fd874b7775e73958d64f3e0b2082957b  torture:  Remove qemu dependency on EFI firmware

elapsed time: 481m

configs tested: 105
configs skipped: 3

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
arc                              allyesconfig
ia64                                defconfig
arm                      pxa255-idp_defconfig
mips                        vocore2_defconfig
powerpc                           allnoconfig
arm                         nhk8815_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         s5pv210_defconfig
arm                       multi_v4t_defconfig
sh                        edosk7705_defconfig
arm                              alldefconfig
sh                          rsk7203_defconfig
powerpc                     pq2fads_defconfig
powerpc                     mpc83xx_defconfig
sh                            migor_defconfig
s390                          debug_defconfig
arm                         axm55xx_defconfig
um                             i386_defconfig
m68k                          sun3x_defconfig
arm                           efm32_defconfig
powerpc                    mvme5100_defconfig
mips                      bmips_stb_defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sh                          kfr2r09_defconfig
m68k                       m5208evb_defconfig
c6x                         dsk6455_defconfig
m68k                            mac_defconfig
m68k                          multi_defconfig
i386                              allnoconfig
i386                             allyesconfig
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
