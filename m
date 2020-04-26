Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF124C55185
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89C0206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDZBMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:12:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:56108 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgDZBMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 21:12:39 -0400
IronPort-SDR: Ohg5ZgjfqGPCzbG9hMZU1spJUefCZctE3/xpvi1nIal1E9PAaQIOLbARWtdEzNwdCFNySTaT8I
 MKa+K5/j/Trw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2020 18:12:39 -0700
IronPort-SDR: E0PaXR6SgtLoPZZ6Fl30EBuRJNdficUP+tz/52yiPZcHuZ702sL2SzLvUa75IZj/qLDqmv0lZV
 /UXgXJyt7Ycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,318,1583222400"; 
   d="scan'208";a="275033011"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Apr 2020 18:12:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jSVqX-0004u5-Kl; Sun, 26 Apr 2020 09:12:37 +0800
Date:   Sun, 26 Apr 2020 09:12:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 9adbf3c609af92a57a73000a3cb8f4c2d307dfa3
Message-ID: <5ea4dfe2.ahqjhJBQsD3Deak2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/microcode
branch HEAD: 9adbf3c609af92a57a73000a3cb8f4c2d307dfa3  x86/microcode: Fix return value for microcode late loading

elapsed time: 4642m

configs tested: 12
configs skipped: 97

The following configs have been built successfully.
More configs may be tested in the coming days.

i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
