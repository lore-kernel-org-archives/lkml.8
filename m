Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44880C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B97204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHLJ6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:58:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:38806 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgHLJ6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:58:38 -0400
IronPort-SDR: FikZYCu5QxUXRPwX0DshuyjNJf9YME71fPoQ0QWjtNjkDEUQA0bp/SrIevhscfeveaKf55pPvv
 g7Y4ayGNK4RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153891470"
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="153891470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 02:58:37 -0700
IronPort-SDR: E8aE+WbLcn6LCu/ICRtamVDvaNjNxN2Qc+rwkKSyTriN6HqapQXN6nKVp1gBESSh5+MOVN8nUF
 6XQdFbxYnDVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="439346508"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Aug 2020 02:58:36 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5nWl-00001B-IF; Wed, 12 Aug 2020 09:58:35 +0000
Date:   Wed, 12 Aug 2020 17:57:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.08.10a] BUILD SUCCESS
 9dd4d242c535c30266a08806314ea6b016f94617
Message-ID: <5f33bd24.Gs5FxkDxP/MG38Ea%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.08.10a
branch HEAD: 9dd4d242c535c30266a08806314ea6b016f94617  tools/memory-model: Document categories of ordering primitives

elapsed time: 724m

configs tested: 73
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         axm55xx_defconfig
powerpc                     ep8248e_defconfig
arc                        nsim_700_defconfig
arm                            hisi_defconfig
arm                  colibri_pxa270_defconfig
arm                       mainstone_defconfig
sh                            shmin_defconfig
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
x86_64               randconfig-a006-20200811
x86_64               randconfig-a001-20200811
x86_64               randconfig-a003-20200811
x86_64               randconfig-a005-20200811
x86_64               randconfig-a004-20200811
x86_64               randconfig-a002-20200811
i386                 randconfig-a005-20200811
i386                 randconfig-a001-20200811
i386                 randconfig-a002-20200811
i386                 randconfig-a003-20200811
i386                 randconfig-a006-20200811
i386                 randconfig-a004-20200811
i386                 randconfig-a016-20200811
i386                 randconfig-a011-20200811
i386                 randconfig-a015-20200811
i386                 randconfig-a013-20200811
i386                 randconfig-a012-20200811
i386                 randconfig-a014-20200811
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
