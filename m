Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32F7206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgDOVdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:33:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:5778 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgDOVdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:33:18 -0400
IronPort-SDR: UQ/6rZ25akvI9J9BkFHDr4kBQy2n7g2DQlfX8yhK4db+hdq/5x8wh4hSdT5f81oxWr9Hj1IUrI
 U8Jt1A7i0I6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 14:33:14 -0700
IronPort-SDR: EMbqJJKkZhqKJ2n7QJZYovomGe3KUWl9G29ZhK2GXNNE7e7LJJGR0eJLiqcq/XSQ8Fyi6RPoVl
 ja0pyQKQg2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="454075011"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 14:33:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jOpei-000EVE-TC; Thu, 16 Apr 2020 05:33:12 +0800
Date:   Thu, 16 Apr 2020 05:32:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b0e387c3ec0170b429f15c53b6183fe1c691403b
Message-ID: <5e977d7b.b7P54FR4e1Jt1AuL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: b0e387c3ec0170b429f15c53b6183fe1c691403b  x86/umip: Make umip_insns static

elapsed time: 732m

configs tested: 79
configs skipped: 63

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm64                            allyesconfig
sparc                            allyesconfig
arc                              allyesconfig
alpha                               defconfig
um                             i386_defconfig
h8300                    h8300h-sim_defconfig
i386                                defconfig
ia64                              allnoconfig
nios2                         10m50_defconfig
nds32                               defconfig
mips                      malta_kvm_defconfig
riscv                          rv32_defconfig
parisc                generic-64bit_defconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
ia64                                defconfig
parisc                generic-32bit_defconfig
m68k                       m5475evb_defconfig
microblaze                    nommu_defconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
mips                      fuloong2e_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
i386                 randconfig-a002-20200415
x86_64               randconfig-a001-20200415
x86_64               randconfig-a002-20200415
i386                 randconfig-a003-20200415
i386                 randconfig-a001-20200415
x86_64               randconfig-a003-20200415
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                                  defconfig
x86_64                                   rhel

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
