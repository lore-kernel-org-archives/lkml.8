Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF650C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCBB208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgG0WaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:30:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:31412 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0WaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:30:14 -0400
IronPort-SDR: Tz2eJyROIqZ5CQQ3CBvqHfyZWlkvmCqwGpceT2/yZk/uAW7qDtgwDxVtCoblyUoJFxLjG0Hwow
 cbE6DtAdlCaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="169234127"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="169234127"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 15:30:13 -0700
IronPort-SDR: 9vhGkQma2R7buA8er1qw9M6kxN6CJhujFQxcjMIhKxJdVSqgn37TkThb7DN/BXl9k0MJmPBGww
 Z1xpGzJ7xA6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="285932204"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jul 2020 15:30:07 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0BdG-00024O-QY; Mon, 27 Jul 2020 22:30:06 +0000
Date:   Tue, 28 Jul 2020 06:29:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/entry] BUILD REGRESSION
 f87032aec41e0b00ae5fa9103eb8e7b2d1f8416b
Message-ID: <5f1f553d.ASRyXJ4YwT6tZVv9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  WIP.x86/entry
branch HEAD: f87032aec41e0b00ae5fa9103eb8e7b2d1f8416b  Merge branch 'locking/nmi' into x86/entry

Error/Warning in current branch:

include/linux/irqflags.h:40:41: error: expected expression before ')' token

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-allyesconfig
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
|-- i386-randconfig-c001-20200727
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
|-- x86_64-allmodconfig
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
|-- x86_64-allyesconfig
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
|-- x86_64-lkp
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
`-- x86_64-rhel-7.6-kselftests
    `-- include-linux-irqflags.h:error:expected-expression-before-)-token

elapsed time: 1718m

configs tested: 50
configs skipped: 1

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
sparc64                             defconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                              defconfig

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
