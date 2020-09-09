Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A3C10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B0921D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgIISU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:20:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:50565 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIISUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:20:54 -0400
IronPort-SDR: YN1LAWgC2/12RsdyHbuvZHcBkVAh8iAZZZmCQComvX3gTw50wSsRcJCfGosvcWuhRVH6Zj4ni4
 lseqfwuK1X5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="157675415"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="157675415"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 11:20:53 -0700
IronPort-SDR: 0X3f4HDZDd/UL7ET0LNATUE+dfEK5vvQBE6PcJX+AHRv6QP9F/y5p1xiTNr0QTcV0JKI6QbVU7
 XSWIhB6Xqhyw==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="449298417"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 11:20:52 -0700
Date:   Wed, 9 Sep 2020 11:20:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200909182051.GA31883@agluck-desk2.amr.corp.intel.com>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
 <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
 <20200908152539.GE25236@zn.tnic>
 <20200909113022.GA12237@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909113022.GA12237@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 01:30:22PM +0200, Borislav Petkov wrote:
> I guess something as straightforward as this:

Do we think there will be other places where we want this
MSR-or-die behaviour?  If there are, then most of this
belongs elsewhere from arch/x86/kernel/cpu/mce/core.c

> ---
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 0ba24dfffdb2..9893caaf2696 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -373,10 +373,27 @@ static int msr_to_offset(u32 msr)
>  	return -1;
>  }
>  
> +__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
> +				      struct pt_regs *regs, int trapnr,
> +				      unsigned long error_code,
> +				      unsigned long fault_addr)
> +{
> +	if (pr_warn_once("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",

The "_once" version seems a little pointless when the next statement in the function
is "panic()".

"warn" seems understated for an error that is going to crash the system.
Just go for "pr_emerg()".

There seems no consistency on using "rIP" or "RIP" ... but I think "RIP"
is slightly ahead.

> +			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
> +		show_stack_regs(regs);
> +
> +	panic("MCA Architectural violation!\n");

nitpick: I don't thing Architectural needs to be capitalized.

> +
> +	while (true)
> +		cpu_relax();

Ugh. Is this why you have warn_once() ... because panic might return?

Above comments also apply to the wrmsr path.

-Tony
