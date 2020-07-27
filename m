Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD36D2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgG0S4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:56:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:55661 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0S4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:56:02 -0400
IronPort-SDR: vGBEV2E6bz2njcfM1LQfKgRPu4Cn2bnGK5cUo5WdnyKIc9YgUG2Dvy4sgja3zsZ2X5yL73ryg5
 wY4xko0Cq7NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="130657572"
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="130657572"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 11:56:01 -0700
IronPort-SDR: Ar7w+vhOs7cs+We/rDXMdsxQWkC8w8KE7VWY9eFwEoeZlDucekD2wjp56bEJmwV7BK6MI9KGts
 UjzxOn5Ia5SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="321914893"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2020 11:56:00 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k08I3-00020l-EK; Mon, 27 Jul 2020 18:55:59 +0000
Date:   Tue, 28 Jul 2020 02:54:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 13efa616124f7eec7d6a58adeeef31864aa03879
Message-ID: <5f1f22e7.cpkb30MrIWiDyqCy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  sched/core
branch HEAD: 13efa616124f7eec7d6a58adeeef31864aa03879  sched/uclamp: Remove unnecessary mutex_init()

elapsed time: 3396m

configs tested: 64
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
xtensa                              defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
arc                              allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
openrisc                            defconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200727
i386                 randconfig-a005-20200727
i386                 randconfig-a004-20200727
i386                 randconfig-a006-20200727
i386                 randconfig-a002-20200727
i386                 randconfig-a001-20200727
i386                 randconfig-a016-20200725
i386                 randconfig-a013-20200725
i386                 randconfig-a012-20200725
i386                 randconfig-a015-20200725
i386                 randconfig-a014-20200725
i386                 randconfig-a011-20200725
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
sparc64                             defconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                              defconfig
x86_64                                   rhel

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
