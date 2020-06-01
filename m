Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D619C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610E72073E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFAFQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:16:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:47457 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFAFQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:16:34 -0400
IronPort-SDR: A2Zv2cEvQnDpBFDegYj4cEq2/6wJVnhrorfPZP3QZiVFLaaMA4BZOhTHpW7RGltNxuuA3ndg3J
 rcpRzo4RTSoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:16:33 -0700
IronPort-SDR: G/cgBB8coZEVmJhH4shnTWgrdzxQo3rFMXGu6loKBN4DJiH0hYv5DEovgtcg6c+h55g42dspn5
 biY8VJx7czjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="286162829"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 May 2020 22:16:32 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcoK-0000CG-1R; Mon, 01 Jun 2020 05:16:32 +0000
Date:   Mon, 01 Jun 2020 13:15:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 aa61b7bb00f7c0738823237a06161d568442b93c
Message-ID: <5ed48eef.Rmq9LxsW6zOChLan%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: aa61b7bb00f7c0738823237a06161d568442b93c  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs into x86/urgent

i386-tinyconfig vmlinux size:

==============================================================================================================================
 TOTAL  TEXT  copy_xstate_to_kernel()  copy_part()                                                                            
==============================================================================================================================
  +204  +205                     +109          +96  aa61b7bb00f7 Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/k 
  +204  +205                     +109          +96  4bfe6cce133c..aa61b7bb00f7 (ALL COMMITS)                                  
==============================================================================================================================

elapsed time: 3621m

configs tested: 131
configs skipped: 114

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm                          pxa3xx_defconfig
arm                         palmz72_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
riscv                          rv32_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc64_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
sh                        sh7763rdp_defconfig
s390                              allnoconfig
mips                         tb0226_defconfig
m68k                          multi_defconfig
h8300                            allyesconfig
sh                             sh03_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
sh                          rsk7269_defconfig
ia64                        generic_defconfig
mips                             allyesconfig
xtensa                           allyesconfig
sh                          sdk7780_defconfig
mips                        jmr3927_defconfig
riscv                               defconfig
sh                           cayman_defconfig
arm                         ebsa110_defconfig
arm                            lart_defconfig
sh                         microdev_defconfig
x86_64                              defconfig
arm                        oxnas_v6_defconfig
arc                          axs101_defconfig
powerpc                       maple_defconfig
nds32                             allnoconfig
sh                               allmodconfig
arm                            qcom_defconfig
powerpc                    amigaone_defconfig
nios2                         10m50_defconfig
arm                         s3c6400_defconfig
openrisc                            defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
arm                       cns3420vb_defconfig
arm                        spear3xx_defconfig
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
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
arc                                 defconfig
arc                              allyesconfig
sh                                allnoconfig
microblaze                        allnoconfig
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
i386                 randconfig-a004-20200529
i386                 randconfig-a001-20200529
i386                 randconfig-a002-20200529
i386                 randconfig-a006-20200529
i386                 randconfig-a003-20200529
i386                 randconfig-a005-20200529
i386                 randconfig-a013-20200529
i386                 randconfig-a011-20200529
i386                 randconfig-a012-20200529
i386                 randconfig-a015-20200529
i386                 randconfig-a016-20200529
i386                 randconfig-a014-20200529
x86_64               randconfig-a002-20200529
x86_64               randconfig-a006-20200529
x86_64               randconfig-a005-20200529
x86_64               randconfig-a001-20200529
x86_64               randconfig-a004-20200529
x86_64               randconfig-a003-20200529
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
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
