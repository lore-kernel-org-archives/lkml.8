Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BCF2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGIMe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:34:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:58877 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgGIMe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:34:29 -0400
IronPort-SDR: ISz3MHLtZRjP6PI2Wnz/4M5oOhIi9O/KMzPS2B2XtTkDGPcARZVTJPKaONDYOSPRMT9nPg4o7a
 Zy3JExFvWpmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="146071306"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="146071306"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 05:34:28 -0700
IronPort-SDR: 1uMOXgoWBELbK18jUlVXoNj5Q+9MKptGG07GRx9dNquO5dirlwEgU/OR4T7Kko8oAp+BMqQ9Qm
 Gh/OtsWWbnBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="306419297"
Received: from lkp-server01.sh.intel.com (HELO 5019aad283e6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2020 05:34:27 -0700
Received: from kbuild by 5019aad283e6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtVkw-00002L-ED; Thu, 09 Jul 2020 12:34:26 +0000
Date:   Thu, 09 Jul 2020 20:33:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.07.06a] BUILD SUCCESS
 3b69dc4d0fad073eb5554dacdccddf6c21577802
Message-ID: <5f070eb6.gs+CirEBfEhamM1t%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.07.06a
branch HEAD: 3b69dc4d0fad073eb5554dacdccddf6c21577802  lib: Add backtrace_idle parameter to force backtrace of idle CPUs

elapsed time: 730m

configs tested: 111
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
powerpc                     pq2fads_defconfig
sh                               j2_defconfig
sh                          sdk7786_defconfig
arm                          pxa910_defconfig
um                            kunit_defconfig
arm                         lpc18xx_defconfig
ia64                        generic_defconfig
mips                        vocore2_defconfig
arc                     haps_hs_smp_defconfig
m68k                       bvme6000_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           efm32_defconfig
arc                                 defconfig
mips                      pistachio_defconfig
arm                          simpad_defconfig
xtensa                         virt_defconfig
parisc                            allnoconfig
mips                      pic32mzda_defconfig
arm                       netwinder_defconfig
openrisc                 simple_smp_defconfig
arm                             pxa_defconfig
mips                 decstation_r4k_defconfig
mips                         tb0226_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
sh                        sh7785lcr_defconfig
mips                      maltasmvp_defconfig
mips                           ci20_defconfig
m68k                             alldefconfig
arc                      axs103_smp_defconfig
arm                          prima2_defconfig
sh                           sh2007_defconfig
mips                      maltaaprp_defconfig
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
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
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
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
