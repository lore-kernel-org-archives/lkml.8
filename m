Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907BC07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042DF21D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIJSnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:43:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:42440 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgIJSmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:42:22 -0400
IronPort-SDR: DLVLzQZyH8/89emHnetFN/7vyngC7xbDIcQV8VgYLQwK4zu5Qo4CzTB5fB8/PTYPaLa0nT5pr8
 9uXElScXU82Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="156010366"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="156010366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 11:42:09 -0700
IronPort-SDR: Zcs5plhrRFs2sWIB5orwnncxOT0nrXtOrhIa+CQb58fgHpIQ2mSQddIrKy22DxKdpQKyspSKBw
 U16o4d5zRLpw==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="505931604"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 11:42:07 -0700
Date:   Thu, 10 Sep 2020 11:42:06 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200910184206.GA17305@agluck-desk2.amr.corp.intel.com>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
 <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
 <20200908152539.GE25236@zn.tnic>
 <20200909113022.GA12237@zn.tnic>
 <20200909182051.GA31883@agluck-desk2.amr.corp.intel.com>
 <20200909200321.GG12237@zn.tnic>
 <20200910182901.GK8357@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910182901.GK8357@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 08:29:19PM +0200, Borislav Petkov wrote:
> Ok, with all those changes, I don't think the following nice and juicy
> message can be overlooked:
> 
> [   32.267830] mce: MSR access error: RDMSR from 0x1234 at rIP: 0xffffffff8102ed62 (mce_rdmsrl+0x12/0x50)

With only one call site the rIP isn't super helpful at the moment. But
once you start selling those "MSR or die" T-shirts everyone will want
to use this :-)

> [   32.267838] Call Trace:
> [   32.267838]  <#MC>
> [   32.267838]  do_machine_check+0xbd/0x9f0
> [   32.267839]  ? trigger_mce+0x7/0x10
> [   32.267839]  exc_machine_check+0x77/0xd0
> [   32.267840]  asm_exc_machine_check+0x19/0x30

Do we need the stack trace twice? Once from your fixup
function, second from panic()?

-Tony
