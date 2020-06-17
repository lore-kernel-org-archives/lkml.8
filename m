Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3832082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFQWBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:01:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:64267 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgFQWBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:01:38 -0400
IronPort-SDR: ZTxUTwedU8zfNokmnhtQfHSuMwsdR6nxL94l3NvsX2APF/Wu4HBmlaw5BM55Q5+xjMs2TGv/UJ
 HYUmyw5x0aIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 15:01:38 -0700
IronPort-SDR: ghAb02lFo4C2CJ4JhiraEh5yUJGCqCviIy114e9ObRA5heLbT15ZkRYJTQ2teosNiYb+leIaN3
 7vFHo7Jh+B7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="450410847"
Received: from lkp-server02.sh.intel.com (HELO cd649bb48ab3) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2020 15:01:36 -0700
Received: from kbuild by cd649bb48ab3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlg7k-00006e-3d; Wed, 17 Jun 2020 22:01:36 +0000
Date:   Thu, 18 Jun 2020 06:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 14bda4e5293ed9722f1dc39b543024e37707d6c6
Message-ID: <5eea92a5.C/UHrYSh/AweW1+S%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  objtool/core
branch HEAD: 14bda4e5293ed9722f1dc39b543024e37707d6c6  Merge branch 'objtool/core' of git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux into objtool/core

elapsed time: 738m

configs tested: 96
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
arc                      axs103_smp_defconfig
sh                   secureedge5410_defconfig
powerpc                      pmac32_defconfig
openrisc                    or1ksim_defconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a006-20200617
i386                 randconfig-a002-20200617
i386                 randconfig-a001-20200617
i386                 randconfig-a004-20200617
i386                 randconfig-a005-20200617
i386                 randconfig-a003-20200617
i386                 randconfig-a015-20200617
i386                 randconfig-a011-20200617
i386                 randconfig-a014-20200617
i386                 randconfig-a016-20200617
i386                 randconfig-a013-20200617
i386                 randconfig-a012-20200617
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
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
