Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E267C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4333206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kyk5tFIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgG2VJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:09:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDB8C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ldeactPP2MK53RYxP/W+cgHYIxH/k2Qar+sK5RkMayk=; b=Kyk5tFIQBUsugNqJFDyrrX6A9i
        QrpTpj/seDaVNothU/mPzdCb4H78qVfvxVOg9vi+UXmCAteIEeUG7h4CnQvb0vole3qVXIztWbvGp
        F2b07+7kC6xAUxJ4Cb8gQlm3+hT0+TTnGIn46aaUGb6e/OWGBJ9aLxZlQeyXWFEoKsLffa78zw9jE
        w/OzAiXcuIBkjEaU+ArvkjjhSScm0INsZ8ZxNpsFWW5j3NEXgPyz7gSDhOH43F6hok8TsxsDWpyo/
        Vyo+5upX3hLo3XRgv+t6g4Ec+uJfcKVRLO4Yc7r/ssRmrIvaxYsPrWIqtDSseWXY0ms0iCHMVgLfY
        mBm9nDdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0tKT-00027f-Sh; Wed, 29 Jul 2020 21:09:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 757D230411F;
        Wed, 29 Jul 2020 23:09:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 658482B60F0CB; Wed, 29 Jul 2020 23:09:35 +0200 (CEST)
Date:   Wed, 29 Jul 2020 23:09:35 +0200
From:   peterz@infradead.org
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729210935.GE2655@hirez.programming.kicks-ass.net>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729084947.GY119549@hirez.programming.kicks-ass.net>
 <20200729204057.GB318595@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729204057.GB318595@otcwcpicx6.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:40:57PM +0000, Fenghua Yu wrote:
> On Wed, Jul 29, 2020 at 10:49:47AM +0200, peterz@infradead.org wrote:
> > On Fri, Jul 17, 2020 at 02:35:00PM -0700, Fenghua Yu wrote:
> > 
> > > #DB for bus lock detect fixes all issues in #AC for split lock detect:
> > > 1) It's architectural ... just need to look at one CPUID bit to know it
> > >    exists
> > > 2) The IA32_DEBUGCTL MSR, which reports bus lock in #DB, is per-thread.
> > >    So each process or guest can have different behavior.
> > 
> > And it generates a whole new problem due to #DB being an IST, and

> > we very much rely on #DB never recursing, which we carefully crafted by
> > disallowing hardare breakpoints on noinstr code and clearing DR7 early.
> > 
> > But now it can... please keep the pieces.
> 
> Can we disable Bus Lock Detection before handle it and re-enable it
> after handle it? Will that resolve the recursion issue?

Because WRMSR is cheap, right?

You have to unconditionally {dis,en}able it on #DB entry/exit. Not only
when it's a DR_BUS_LOCK, _always_. Then maybe. I'm too tired to think
through the IST mess.

IST's suck, they're horrible crap.

Suppose we get a #DB, then we get an NMI right before it does WRMSR, so
BUS_LOCK is still on, then the NMI does a dodgy LOCK op, we die.

So that means, you get to disable it on every NMI-like exception too,
but we happen to care about performance for those, you loose.


Also, what happens if you have a hardware watchpoint on the instruction
that causes DR_BUS_LOCK? Does that work as expected?


