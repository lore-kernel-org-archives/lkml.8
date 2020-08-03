Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B68EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2436F208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0EpRGiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgHCQTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:19:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82677C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+X2IPA8w3AbMhwVklKrJu4k2WfkxfIz34eHAn+KBd8I=; b=D0EpRGiSVtJ6LO7Eaf7VyJ1Gek
        3itGsR4hHeZFbtEKVRqN7OFhlauCD2RhQtS5oSJKKmnmtrZPtxtnWsiDy53XcSrIqm7OVimTzsOQD
        j6RJLmM1JvmxmXOfxhyT55HcT9LJmny5r5FkUZS9mnaogZeKdHumyjJOOB6LvLQ30dsgQOJgVcem1
        p5IxkQTQLplQg9U1rTuGE0W4fAvUGwHbd3iGKQYnD3wEv0BvIt/D+odDHZ0+pldDjV3n+KSlIBBLJ
        TvJckvu3/ptgN28NAunRGiNUZ3k9IuAx7fMYv5e1WDSuu/cHT+vbek5gvGNkZw7c/4vkDvAe+j0Zg
        waso5uOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2dBL-0000Lf-Vd; Mon, 03 Aug 2020 16:19:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E1823010D2;
        Mon,  3 Aug 2020 18:19:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8D2B2BEFF78F; Mon,  3 Aug 2020 18:19:21 +0200 (CEST)
Date:   Mon, 3 Aug 2020 18:19:21 +0200
From:   peterz@infradead.org
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mbenes@suse.de" <mbenes@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>
Subject: Re: [RFC][PATCH] objtool,x86_64,paravirt: Add pv_ops[] support
Message-ID: <20200803161921.GG2674@hirez.programming.kicks-ass.net>
References: <20200803143231.GE2674@hirez.programming.kicks-ass.net>
 <MW2PR2101MB10521C4F5E19F12E174623F7D74D0@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB10521C4F5E19F12E174623F7D74D0@MW2PR2101MB1052.namprd21.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 03:18:57PM +0000, Michael Kelley wrote:
> From: peterz@infradead.org Sent: Monday, August 3, 2020 7:33 AM

> > It requires call sites are the normal indirect call, and not mangled
> > retpoison (slow_down_io() had those), it also requires pv_ops[]
> > assignments are single instructions and not laundered through some
> > pointless intermediate helper (hyperv).

^^^

> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> > index 09aa44cb8a91..bed769a84637 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -418,6 +418,13 @@ static struct clocksource hyperv_cs_msr = {
> >  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> >  };
> > 
> > +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> > +{
> > +#ifdef CONFIG_PARAVIRT
> > +	pv_ops.time.sched_clock = sched_clock;
> > +#endif
> > +}
> > +
> 
> Moving this function to hyperv_timer.c is problematic because we
> want hyperv_timer.c to be architecture independent.  We're in the
> process of supporting Linux guests running on Hyper-V on ARM64, and
> there's a different implementation of hv_setup_sched_clock() on ARM64.

Then stick it in a header or something. The important part is that the
compiler generates:

4b737:       48 c7 05 00 00 00 00    movq   $0x0,0x0(%rip)        # 4b742 <hv_init_clocksource+0x4d>
4b73e:       00 00 00 00
		4b73a: R_X86_64_PC32    pv_ops
		4b73e: R_X86_64_32S     .text+0x827880

Where:

96378: 0000000000827880    32 FUNC    LOCAL  DEFAULT    4 read_hv_sched_clock_msr

Otherwise objtool cannot find the assignment and you get to keep the
pieces.
