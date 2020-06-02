Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B7520885
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFBBES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:04:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:48807 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBBES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:04:18 -0400
IronPort-SDR: tPwq41ZAz5Pwjl9bFctvBqTwYHXR7OD7h2uCowHgXl9cPdr0Y4L8WG5Wp2kk9wCYjkQPM+GkT7
 oCEArx9PLvYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 18:04:17 -0700
IronPort-SDR: jpxz4ICWBxin5jvyTBXEVDHG+ZiJWHotn5yR+ZC/Ohejeb5DevtDcpAry97iZO+arTd22cfBBN
 BzlzXSVOQSPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="286459799"
Received: from lkp-server01.sh.intel.com (HELO 368809eeee4d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2020 18:04:16 -0700
Received: from kbuild by 368809eeee4d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfvLj-00002F-B8; Tue, 02 Jun 2020 01:04:15 +0000
Date:   Tue, 02 Jun 2020 09:03:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 f8a4bcabadd6b7b15606a049d8600f1cebb6b364
Message-ID: <5ed5a578.VacLmr4mfdXAX++C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: f8a4bcabadd6b7b15606a049d8600f1cebb6b364  Merge branches 'x86/apic', 'x86/misc' and 'x86/splitlock' into x86/urgent

elapsed time: 480m

configs tested: 88
configs skipped: 86

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
x86_64                              defconfig
s390                                defconfig
sh                           cayman_defconfig
h8300                       h8s-sim_defconfig
arm                       imx_v4_v5_defconfig
mips                     decstation_defconfig
arm                          collie_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
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
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
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
i386                 randconfig-a001-20200601
i386                 randconfig-a006-20200601
i386                 randconfig-a002-20200601
i386                 randconfig-a005-20200601
i386                 randconfig-a003-20200601
i386                 randconfig-a004-20200601
x86_64               randconfig-a002-20200601
x86_64               randconfig-a006-20200601
x86_64               randconfig-a001-20200601
x86_64               randconfig-a003-20200601
x86_64               randconfig-a004-20200601
x86_64               randconfig-a005-20200601
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
