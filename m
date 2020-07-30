Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F51FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3854C2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgG3Fx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:53:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:41627 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3FxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:53:24 -0400
IronPort-SDR: AHeDwTAylFJsiyGxNYgwM3lvi/vglBwtyk7bIZVb7APewc4y8c3eq1LHboksAPOhV30nTJ1bjk
 tB9kAtsbRBFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139077538"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="139077538"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 22:53:23 -0700
IronPort-SDR: PRC3j8OG+6j/rSu44XNIo0mtp1yNF+6pddSgd4gjyjX5CMceKE9CKxhJAI1YDXcSOmYXOH6B8y
 u/L4/uY8QRZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="330637364"
Received: from lkp-server01.sh.intel.com (HELO aff35d61a1e5) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Jul 2020 22:53:22 -0700
Received: from kbuild by aff35d61a1e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k11VJ-00006S-UA; Thu, 30 Jul 2020 05:53:21 +0000
Date:   Thu, 30 Jul 2020 13:53:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/kaslr] BUILD SUCCESS
 4b23103abfba11df3daf26ca006489a467da5b65
Message-ID: <5f22603c.vUV8r+MXmRJx49Zd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  WIP.x86/kaslr
branch HEAD: 4b23103abfba11df3daf26ca006489a467da5b65  x86/kaslr: Add a check that the random address is in range

elapsed time: 720m

configs tested: 66
configs skipped: 46

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200729
x86_64               randconfig-a005-20200729
x86_64               randconfig-a002-20200729
x86_64               randconfig-a006-20200729
x86_64               randconfig-a003-20200729
x86_64               randconfig-a001-20200729
i386                 randconfig-a003-20200729
i386                 randconfig-a004-20200729
i386                 randconfig-a005-20200729
i386                 randconfig-a002-20200729
i386                 randconfig-a006-20200729
i386                 randconfig-a001-20200729
i386                 randconfig-a016-20200729
i386                 randconfig-a012-20200729
i386                 randconfig-a013-20200729
i386                 randconfig-a014-20200729
i386                 randconfig-a011-20200729
i386                 randconfig-a015-20200729
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
