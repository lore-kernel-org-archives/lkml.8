Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2467EC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BB020709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGWLNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:13:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:19896 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgGWLNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:13:30 -0400
IronPort-SDR: GfNxsMdTIzhfBjl82cK4EJVZYffWBLXqC1Z5IGDpch+0xwsnUPAjlGquokMsrfxH9mVMtlW+v5
 /V1zgtJwSPXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="130066428"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="130066428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 04:13:29 -0700
IronPort-SDR: T0EJN5lymGPqXrV2fLtbQV2nNaM5MFsQsSVnEjsjzw8QakPk9cZvHltu+ylvpmC4ufKPgH7Mct
 STyzE7bj/+Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="488334692"
Received: from lkp-server01.sh.intel.com (HELO bd1a4a62506a) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 04:13:28 -0700
Received: from kbuild by bd1a4a62506a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jyZAG-0000G2-2w; Thu, 23 Jul 2020 11:13:28 +0000
Date:   Thu, 23 Jul 2020 19:12:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 83d0111cc01cd5ba7ee0a04af9ea7a1c801f13de
Message-ID: <5f197080.d3eVoZxTSxiGb7Uj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 83d0111cc01cd5ba7ee0a04af9ea7a1c801f13de  refperf: Avoid null pointer dereference when buf fails to allocate

elapsed time: 3849m

configs tested: 99
configs skipped: 2

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
sh                          rsk7264_defconfig
c6x                                 defconfig
c6x                        evmc6474_defconfig
arm                         shannon_defconfig
powerpc                       ppc64_defconfig
arm                      footbridge_defconfig
s390                             alldefconfig
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
c6x                               allnoconfig
openrisc                         allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
i386                 randconfig-a016-20200723
i386                 randconfig-a013-20200723
i386                 randconfig-a012-20200723
i386                 randconfig-a015-20200723
i386                 randconfig-a011-20200723
i386                 randconfig-a014-20200723
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
