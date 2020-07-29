Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EBDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1AB206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgG2WHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:07:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:56214 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgG2WHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:07:13 -0400
IronPort-SDR: 6wCsUYW4D+KQDPN/nc8EoC8uZuUsgOePZg8PBAlzYtJKCyWu3R0Vlgnnm+hhc3k6+pGQibo8fQ
 18J0/ZJ5/73A==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="215992564"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="215992564"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 15:07:11 -0700
IronPort-SDR: l7uLFWhAyNIIaNuytBhKLQL2Fl0tUcKcY08CMTa8QXzAWxluOxBFLnCEd0e4027kn0ef/jFqX9
 Qr7kS2sgjH/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="304362819"
Received: from lkp-server02.sh.intel.com (HELO 1bde1f275adc) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2020 15:07:09 -0700
Received: from kbuild by 1bde1f275adc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0uE9-0000Em-5M; Wed, 29 Jul 2020 22:07:09 +0000
Date:   Thu, 30 Jul 2020 06:07:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/fifo] BUILD REGRESSION
 4fd5750af02ab7bba7c58a073060cc1da8a69173
Message-ID: <5f21f309.rWbpyDU6e2WAKOrB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  sched/fifo
branch HEAD: 4fd5750af02ab7bba7c58a073060cc1da8a69173  sched,tracing: Convert to sched_set_fifo()

Error/Warning in current branch:

drivers/pinctrl/core.c:1356: error: Cannot parse struct or union!

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- alpha-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- alpha-randconfig-r002-20200729
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- arc-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- arc-randconfig-r005-20200729
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- arc-randconfig-r021-20200728
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- c6x-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- ia64-allmodconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- ia64-randconfig-r035-20200729
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- mips-allmodconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- mips-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- nds32-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- nios2-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- nios2-randconfig-r031-20200729
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- parisc-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- parisc-randconfig-c004-20200729
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- s390-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- sh-allmodconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- sparc-allyesconfig
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- sparc-randconfig-r025-20200728
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
|-- sparc64-randconfig-r001-20200729
|   `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union
`-- xtensa-allyesconfig
    `-- drivers-pinctrl-core.c:error:Cannot-parse-struct-or-union

elapsed time: 721m

configs tested: 66
configs skipped: 1

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
x86_64               randconfig-a004-20200729
x86_64               randconfig-a005-20200729
x86_64               randconfig-a002-20200729
x86_64               randconfig-a006-20200729
x86_64               randconfig-a003-20200729
x86_64               randconfig-a001-20200729
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
