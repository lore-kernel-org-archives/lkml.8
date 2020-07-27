Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D565C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326C02074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgG0U2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:28:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:61642 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbgG0U2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:28:47 -0400
IronPort-SDR: ZQKpAEEqgDx37h/AigSaz6LLeCnTmKUZ0SKqhUzLkyJt7Au3H5ov1gnaroEXJPbEI0CkBU100i
 rqKRS5NNgT4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="131172027"
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="131172027"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 13:28:46 -0700
IronPort-SDR: /mul75YLWQQ+D9MMGB3w2vVwV6pnFt2IIaeJrcVxKw9oxeRf2T5Bi0AU/qzOeFhTsX/wWxrK3i
 7HEQn1wg+hkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="285897731"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2020 13:28:44 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k09jn-00022V-F0; Mon, 27 Jul 2020 20:28:43 +0000
Date:   Tue, 28 Jul 2020 04:28:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 90fc73928fec2f62bbee1476781754c7392a7b61
Message-ID: <5f1f38d1.yd6sgBUalKtYiwD2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 90fc73928fec2f62bbee1476781754c7392a7b61  x86/ioperm: Initialize pointer bitmap with NULL rather than 0

elapsed time: 1502m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
parisc                              defconfig
nios2                               defconfig
openrisc                            defconfig
c6x                              allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200727
x86_64               randconfig-a004-20200727
x86_64               randconfig-a003-20200727
x86_64               randconfig-a006-20200727
x86_64               randconfig-a002-20200727
x86_64               randconfig-a001-20200727
i386                 randconfig-a016-20200727
i386                 randconfig-a013-20200727
i386                 randconfig-a012-20200727
i386                 randconfig-a015-20200727
i386                 randconfig-a011-20200727
i386                 randconfig-a014-20200727
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
sparc64                             defconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                   rhel

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
