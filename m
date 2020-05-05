Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ABFC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4822073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgEEN37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:29:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:33543 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbgEEN34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:29:56 -0400
IronPort-SDR: BnVvHeIgoSe30u24RTY8ODTP96r6ST85USBWPf5sLzc+2GmRwi6Kq2us1FsCUOGvFvYoh2Tvvo
 L5FBB/0EVdcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 06:29:54 -0700
IronPort-SDR: r+V/9vVlabBbOfexucc33nJzv7qUOJNq0vQgU/tJ/3bUnCkEpvdlWWZxEk5z6dwtb26M1IARkJ
 esp8DKP1YwPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="294966944"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2020 06:29:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jVxdv-0006tG-7U; Tue, 05 May 2020 21:29:51 +0800
Date:   Tue, 5 May 2020 21:29:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Balbir Singh <sblbir@amazon.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, jpoimboe@redhat.com, tony.luck@intel.com,
        keescook@chromium.org, benh@kernel.crashing.org, x86@kernel.org,
        dave.hansen@intel.com, thomas.lendacky@amd.com,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v5 4/6] arch/x86/kvm: Refactor L1D flushing
Message-ID: <202005052105.LDHP5Zeq%lkp@intel.com>
References: <20200504041343.9651-5-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504041343.9651-5-sblbir@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/auto-latest]
[also build test WARNING on linus/master v5.7-rc4 next-20200505]
[cannot apply to kvm/linux-next tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Balbir-Singh/Optionally-flush-L1D-on-context-switch/20200505-044116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 9a31ac1743a00b816d5393acf61ce16713d319a1

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> arch/x86/kernel/l1d_flush.c:7:8: warning: Local variable 'l1d_flush_pages' shadows outer variable [shadowVariable]
    void *l1d_flush_pages = NULL;
          ^
   arch/x86/kernel/l1d_flush.c:83:14: note: Shadowed declaration
   static void *l1d_flush_pages;
                ^
   arch/x86/kernel/l1d_flush.c:7:8: note: Shadow variable
    void *l1d_flush_pages = NULL;
          ^

vim +/l1d_flush_pages +7 arch/x86/kernel/l1d_flush.c

5228007f200e15 Balbir Singh 2020-05-04   3  
604f3d173bf63d Balbir Singh 2020-05-04   4  static void *l1d_flush_alloc_pages(void)
5228007f200e15 Balbir Singh 2020-05-04   5  {
5228007f200e15 Balbir Singh 2020-05-04   6  	struct page *page;
5228007f200e15 Balbir Singh 2020-05-04  @7  	void *l1d_flush_pages = NULL;
5228007f200e15 Balbir Singh 2020-05-04   8  	int i;
5228007f200e15 Balbir Singh 2020-05-04   9  
5228007f200e15 Balbir Singh 2020-05-04  10  	/*
5228007f200e15 Balbir Singh 2020-05-04  11  	 * This allocation for l1d_flush_pages is not tied to a VM/task's
5228007f200e15 Balbir Singh 2020-05-04  12  	 * lifetime and so should not be charged to a memcg.
5228007f200e15 Balbir Singh 2020-05-04  13  	 */
5228007f200e15 Balbir Singh 2020-05-04  14  	page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
5228007f200e15 Balbir Singh 2020-05-04  15  	if (!page)
5228007f200e15 Balbir Singh 2020-05-04  16  		return NULL;
5228007f200e15 Balbir Singh 2020-05-04  17  	l1d_flush_pages = page_address(page);
5228007f200e15 Balbir Singh 2020-05-04  18  
5228007f200e15 Balbir Singh 2020-05-04  19  	/*
5228007f200e15 Balbir Singh 2020-05-04  20  	 * Initialize each page with a different pattern in
5228007f200e15 Balbir Singh 2020-05-04  21  	 * order to protect against KSM in the nested
5228007f200e15 Balbir Singh 2020-05-04  22  	 * virtualization case.
5228007f200e15 Balbir Singh 2020-05-04  23  	 */
5228007f200e15 Balbir Singh 2020-05-04  24  	for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
5228007f200e15 Balbir Singh 2020-05-04  25  		memset(l1d_flush_pages + i * PAGE_SIZE, i + 1,
5228007f200e15 Balbir Singh 2020-05-04  26  				PAGE_SIZE);
5228007f200e15 Balbir Singh 2020-05-04  27  	}
5228007f200e15 Balbir Singh 2020-05-04  28  	return l1d_flush_pages;
5228007f200e15 Balbir Singh 2020-05-04  29  }
5228007f200e15 Balbir Singh 2020-05-04  30  

:::::: The code at line 7 was first introduced by commit
:::::: 5228007f200e157bfc7a4add32def7c7f32c0550 arch/x86/kvm: Refactor l1d flush lifecycle management

:::::: TO: Balbir Singh <sblbir@amazon.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
