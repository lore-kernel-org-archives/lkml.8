Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2DEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509FA206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgG1NMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:12:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:35863 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbgG1NMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:12:51 -0400
IronPort-SDR: yOqHqvNYjeHTlk0KNvua2+H8YKT2P7bES5sq/N1wylZC9nnzm5iH2EjpK96IRus493vhgdcmAL
 NX9UBrycFC+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="130764194"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="130764194"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 06:12:50 -0700
IronPort-SDR: yDM40H/wXXLihgs77EcLblOyRGbSBVjgQy5NEM1muqYzjbFb9udez25ARSvoXCGSx7mgbQARNf
 4kmPndw71xow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="273564332"
Received: from lkp-server01.sh.intel.com (HELO d27eb53fc52b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2020 06:12:49 -0700
Received: from kbuild by d27eb53fc52b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0PPU-0000tW-Jf; Tue, 28 Jul 2020 13:12:48 +0000
Date:   Tue, 28 Jul 2020 21:12:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 aa251fc5b936d3ddb4b4c4b36427eb9aa3347c82
Message-ID: <5f20243b.5xgIKcEccwbcoYls%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: aa251fc5b936d3ddb4b4c4b36427eb9aa3347c82  genirq/debugfs: Add missing irqchip flags

elapsed time: 1285m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          prima2_defconfig
arm                      footbridge_defconfig
mips                        nlm_xlr_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200728
i386                 randconfig-a004-20200728
i386                 randconfig-a005-20200728
i386                 randconfig-a002-20200728
i386                 randconfig-a006-20200728
i386                 randconfig-a001-20200728
x86_64               randconfig-a014-20200728
x86_64               randconfig-a012-20200728
x86_64               randconfig-a015-20200728
x86_64               randconfig-a016-20200728
x86_64               randconfig-a013-20200728
x86_64               randconfig-a011-20200728
i386                 randconfig-a016-20200728
i386                 randconfig-a012-20200728
i386                 randconfig-a013-20200728
i386                 randconfig-a014-20200728
i386                 randconfig-a011-20200728
i386                 randconfig-a015-20200728
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
