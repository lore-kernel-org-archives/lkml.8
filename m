Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB2C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DE1206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgEJOEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:04:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:38950 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgEJOEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:04:44 -0400
IronPort-SDR: BcBDwOTcOBLt/g7L31Pn/CAe7shbLCEwRiQngeuA2JcsbK9LCbdaco98R7Ty6LC6elN7S/FDIc
 KUcsiftVqfuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 07:04:43 -0700
IronPort-SDR: bl3XDiT7te0cAyBOPrwMvbKwKR5Am1GNLi3xLixuKpSfIxwZxOnvlK9IFSbKBgGa5/KYhhEwl0
 3Y4pne9HshlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,375,1583222400"; 
   d="scan'208";a="296642298"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2020 07:04:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jXmZN-000Aux-QD; Sun, 10 May 2020 22:04:41 +0800
Date:   Sun, 10 May 2020 22:03:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: arch/x86/kernel/apm_32.c:428:43: sparse: sparse: cast truncates bits
 from constant value (c0000400 becomes 400)
Message-ID: <202005102246.mLhqhR0Y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e99332e7b4cda6e60f5b5916cf9943a79dbef902
commit: 1651e700664b4597ddf4f8adfe435252a0d11277 x86: Fix bitops.h warning with a moved cast
date:   8 weeks ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        git checkout 1651e700664b4597ddf4f8adfe435252a0d11277
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/x86/kernel/apm_32.c:428:43: sparse: sparse: cast truncates bits from constant value (c0000400 becomes 400)

vim +428 arch/x86/kernel/apm_32.c

c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09  421  
c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09  422  /*
c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09  423   * Set up a segment that references the real mode segment 0x40
c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09  424   * that extends up to the end of page zero (that we have reserved).
c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09  425   * This is for buggy BIOS's that refer to (real mode) segment 0x40
c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09  426   * even though they are called in protected mode.
c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09  427   */
c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09 @428  static struct desc_struct bad_bios_desc = GDT_ENTRY_INIT(0x4092,
c7425314c755d5 arch/x86/kernel/apm_32.c Akinobu Mita   2009-08-09  429  			(unsigned long)__va(0x400UL), PAGE_SIZE - 0x400 - 1);
^1da177e4c3f41 arch/i386/kernel/apm.c   Linus Torvalds 2005-04-16  430  

:::::: The code at line 428 was first introduced by commit
:::::: c7425314c755d5f94da7c978205c85a7c6201212 x86: Introduce GDT_ENTRY_INIT(), initialize bad_bios_desc statically

:::::: TO: Akinobu Mita <akinobu.mita@gmail.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
