Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A99321702
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGQBho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:37:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:55211 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgGQBhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:37:43 -0400
IronPort-SDR: 4uP0hL5j3UAru6FY7ZcAPpiQZ/gOj/7DM66OMQ4s4RWuFErzQ09lTOj/CiqnixA5AImQXpqCPu
 7axyIKsJK6/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129605825"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="129605825"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 18:37:42 -0700
IronPort-SDR: OuLoXk40UH9vUfGDNey8WozvVHFqYYUoBIrgoxndx1tG1+efaz1otftGCadNzQNl7jCZREtqZr
 tLtnDYc0Q8qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="486310475"
Received: from lkp-server01.sh.intel.com (HELO 70d1600e1569) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2020 18:37:42 -0700
Received: from kbuild by 70d1600e1569 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwFJk-0000GN-6p; Fri, 17 Jul 2020 01:37:40 +0000
Date:   Fri, 17 Jul 2020 09:36:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 790ce3b40017bbd759a3d81e23c05d42b3d34b90
Message-ID: <5f110082.vazFwFjraSE7jeG/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: 790ce3b40017bbd759a3d81e23c05d42b3d34b90  x86/idtentry: Remove stale comment

elapsed time: 722m

configs tested: 28
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
