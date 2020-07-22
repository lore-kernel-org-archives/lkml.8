Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F61C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B169C2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgGVVvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:51:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:41792 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgGVVvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:51:12 -0400
IronPort-SDR: HwsQbk0TWSfuuENpSsI/MWJAzMpADdtIL5KWSu1RLHIxnC6d62S/eo2YuTlXWJPMZiPuSuFQpm
 5NejZhbQ1CzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="215054053"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="215054053"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 14:51:11 -0700
IronPort-SDR: hXRvpcYPNFUqC1zkGA6YRhuyoy9gCwpTUaay6IEA8VgoTeuJWInt7jEBpZvxo4pLqooSuV+bYG
 FWkYS3tPDYXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="272122519"
Received: from lkp-server01.sh.intel.com (HELO 7a9a14fb1d52) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2020 14:51:10 -0700
Received: from kbuild by 7a9a14fb1d52 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jyMdp-00007c-FR; Wed, 22 Jul 2020 21:51:09 +0000
Date:   Thu, 23 Jul 2020 05:49:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 2ac5413e5edca6910d2ae157187a889e94be2b62
Message-ID: <5f18b486.vJDfkMwCF6rwI58A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  perf/core
branch HEAD: 2ac5413e5edca6910d2ae157187a889e94be2b62  x86/perf: Fix a typo

elapsed time: 802m

configs tested: 107
configs skipped: 4

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
c6x                                 defconfig
c6x                        evmc6474_defconfig
sh                               alldefconfig
mips                         bigsur_defconfig
arm                           sama5_defconfig
arm                           omap1_defconfig
mips                            e55_defconfig
c6x                         dsk6455_defconfig
m68k                         amcore_defconfig
arm                          simpad_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
arm                      footbridge_defconfig
s390                             alldefconfig
c6x                               allnoconfig
powerpc                       ppc64_defconfig
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
openrisc                         allyesconfig
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
i386                 randconfig-a001-20200719
i386                 randconfig-a006-20200719
i386                 randconfig-a002-20200719
i386                 randconfig-a005-20200719
i386                 randconfig-a003-20200719
i386                 randconfig-a004-20200719
x86_64               randconfig-a005-20200719
x86_64               randconfig-a002-20200719
x86_64               randconfig-a006-20200719
x86_64               randconfig-a001-20200719
x86_64               randconfig-a003-20200719
x86_64               randconfig-a004-20200719
i386                 randconfig-a015-20200719
i386                 randconfig-a011-20200719
i386                 randconfig-a016-20200719
i386                 randconfig-a012-20200719
i386                 randconfig-a013-20200719
i386                 randconfig-a014-20200719
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
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
