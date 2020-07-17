Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E9BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC002070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 00:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGQA1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:27:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:3329 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGQA1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 20:27:03 -0400
IronPort-SDR: nH+sbXFBnfo/EmAwuQ9ckK1ZoKHJ9X775TGr/4owikqtmOKTku0dCkqWKcKPMU+vFBrdwLlldD
 HMMu9z8/QsTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137634999"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="137634999"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 17:27:02 -0700
IronPort-SDR: vGNfmrcvuhK7fz+ePeI1ej9o62F/YfAHn6TElGwHZIPePJaZIn3EyWsa2chP2WOLQBmYQ1NLuk
 yPzE1hbDlMDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="308831866"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2020 17:27:00 -0700
Date:   Fri, 17 Jul 2020 08:27:29 +0800
From:   Philip Li <philip.li@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
Subject: Re: [LKP] Re: db57e98d87 ("mm/sparse.c: fix ALIGN() without power of
 2 in .."): BUG: kernel reboot-without-warning in early-boot stage, last
 printk: early console in setup code
Message-ID: <20200717002729.GA18418@intel.com>
References: <20200716083159.GH3874@shao2-debian>
 <20200716150613.409103a2d1e4c3f5f63652b8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716150613.409103a2d1e4c3f5f63652b8@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:06:13PM -0700, Andrew Morton wrote:
> On Thu, 16 Jul 2020 16:32:00 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > commit db57e98d87908b8837352abe08515e42752270c1
> > Author:     Lecopzer Chen <lecopzer.chen@mediatek.com>
> > AuthorDate: Mon Sep 23 15:36:24 2019 -0700
> > Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> > CommitDate: Tue Sep 24 15:54:09 2019 -0700
> > 
> >     mm/sparse.c: fix ALIGN() without power of 2 in sparse_buffer_alloc()
> 
> Are we sure about this?  That patch is a year old - has something
> in the test setup changed to make it visible at this late stage?
sorry, kindly ignore this, this looks like a false positive which
probably due to test environment. We will double check, if any finding
related to kernel, we will provide udpdate.

Thanks

> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
