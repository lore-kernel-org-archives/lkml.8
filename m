Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBEFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227CA2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cMUotIed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgG2IuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG2IuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:50:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC78C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6doAh1qguYtZHcO6gHIS2SyAHj8bF03MyqeLpi3tHN0=; b=cMUotIedINHNHLeg6fxFHwiKm7
        tzsUup7U4Wi1Je0WNlnlCFmzkGVqRk5kuZjc+YvTMPmhaq4HpnR7iRus2OhNtvt2PeamjLVWFifVH
        TLGEUwqcwcKTWvNsoHjAU9ZMePEj50IgAx9fx3kfPKMqx4T01Ps0+X5iDbjLe6YhQq+fRUfXnSTv5
        i8F0WrRNlb8hFg+Pn3Bql0V2v5c2ohZgdGx6DWlAK5VcxDZdZ1xYBauXcijc48gAO2ByE/CiZ/V00
        RDoPhcvk8Zc/BiJbj2mdAiBdkySQLbceXO/A6jFlqINaHDc+gpcyFjuWPYc8aOyQjS42ZARSEaRJ/
        om2ejxGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0hmW-0002KJ-ME; Wed, 29 Jul 2020 08:49:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C736304B6D;
        Wed, 29 Jul 2020 10:49:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 466D52BD93BFD; Wed, 29 Jul 2020 10:49:47 +0200 (CEST)
Date:   Wed, 29 Jul 2020 10:49:47 +0200
From:   peterz@infradead.org
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729084947.GY119549@hirez.programming.kicks-ass.net>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 02:35:00PM -0700, Fenghua Yu wrote:

> #DB for bus lock detect fixes all issues in #AC for split lock detect:
> 1) It's architectural ... just need to look at one CPUID bit to know it
>    exists
> 2) The IA32_DEBUGCTL MSR, which reports bus lock in #DB, is per-thread.
>    So each process or guest can have different behavior.

And it generates a whole new problem due to #DB being an IST, and

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index b038695f36c5..58725567da39 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -812,6 +812,16 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
>  	if (!user && !dr6)
>  		return;
>  
> +	/* Handle bus lock. */
> +	if (!(dr6 & DR_BUS_LOCK)) {
> +		cond_local_irq_enable(regs);
> +		if (user)
> +			handle_user_bus_lock(regs);
> +		else
> +			handle_kernel_bus_lock(regs);
> +		goto out;
> +	}
> +
>  	/*
>  	 * If dr6 has no reason to give us about the origin of this trap,
>  	 * then it's very likely the result of an icebp/int01 trap.

we very much rely on #DB never recursing, which we carefully crafted by
disallowing hardare breakpoints on noinstr code and clearing DR7 early.

But now it can... please keep the pieces.
