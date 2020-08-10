Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E954C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088C520709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FbpMeU3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHJL55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgHJL54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:57:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6867DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 04:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gqyJ8i0+3p3zR2fv1FbnPgCav7H1sId+M8Sn7KLYr8Q=; b=FbpMeU3z5DW+glCcIxhbkmWMFa
        m1Jzku8SkBrMnn3WWnGy85+yM4zXn1sAAcZFVk4tSq8Z+G5bPP40WZvHV2pOh40kLzImfFGMV9pPH
        /nqQgJ4A5xAoVwzw7CExYUr4ueOGQkkAV/k2thPQZenXwFkEn+pdSTTViFvvU9I9wnsXgrxV/B1He
        RAlz62dp1AJHzfItlj+AISJIurmvkUgTsDVyd821jUXXg2S9b+Um7RiUXsp22R4cWo9LiNrPd9KnK
        F4HcnwFXT0BwWdjVBwwkluhJwnhF4G50r43NCtSSALQKNJ/Ox+UetPKlXrvPF4Kay01louVIE5Tq6
        gxZyJK3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k56R1-0007OC-AQ; Mon, 10 Aug 2020 11:57:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E713A3003E5;
        Mon, 10 Aug 2020 13:57:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99B1A200D4159; Mon, 10 Aug 2020 13:57:43 +0200 (CEST)
Date:   Mon, 10 Aug 2020 13:57:43 +0200
From:   peterz@infradead.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        paulmck@kernel.org, rjw@rjwysocki.net
Subject: Re: [RFC][PATCH 2/3] locking,entry: #PF vs TRACE_IRQFLAGS
Message-ID: <20200810115743.GU2674@hirez.programming.kicks-ass.net>
References: <20200807192336.405068898@infradead.org>
 <20200807193018.060388629@infradead.org>
 <20200807162148.48d96247@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807162148.48d96247@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 04:21:48PM -0400, Steven Rostedt wrote:
> On Fri, 07 Aug 2020 21:23:38 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Much of the complexity in irqenter_{enter,exit}() is due to #PF being
> > the sole exception that can schedule from kernel context.
> > 
> > One additional wrinkle with #PF is that it is non-maskable, it can
> > happen _anywhere_. Due to this, and the wonders of tracing, we can get
> > the 'normal' NMI nesting vs TRACE_IRQFLAGS:
> > 
> > 	local_irq_disable()
> > 	  raw_local_irq_disable();
> > 	  trace_hardirqs_off();
> > 
> > 	local_irq_enable();
> 
> Do you mean to have that ';' there? That is, it the below is called
> from local_irq_enable(), right? A ';' means that local_irq_enable()
> is completed.

Indeed, it's just really hard not to type ';' at the end :-)

> 
> > 	  trace_hardirqs_on();
> > 	  <#PF>
> > 	    trace_hardirqs_off()
> > 	    ...
> > 	    if (!regs_irqs_disabled(regs)
> 
> regs has it disabled, so this is false, right?

Yup, I'll add: // false, after it to clarify.

> > 	      trace_hardirqs_on();
> > 	  </#PF>
> 
> I missed the '/' in the above. At first I thought this was another page
> fault :-/
> 
> > 	  // WHOOPS -- lockdep thinks IRQs are disabled again!
> > 	  raw_local_irqs_enable();
> > 
> > Rework irqenter_{enter,exit}() to save/restore the software state.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/entry-common.h |    1 
> >  kernel/entry/common.c        |   52 ++++++++++++++++++++-----------------------
> >  2 files changed, 26 insertions(+), 27 deletions(-)
> > 
> > --- a/include/linux/entry-common.h
> > +++ b/include/linux/entry-common.h
> > @@ -310,6 +310,7 @@ void irqentry_exit_to_user_mode(struct p
> >  #ifndef irqentry_state
> >  typedef struct irqentry_state {
> >  	bool	exit_rcu;
> > +	bool	irqs_enabled;
> 
> Instead of passing a structure around, should we look at converting
> "irqentry_state" into a flags field?

Probably, on x86_64-linux sizeof(_Bool) == 1, so it's two bytes and that
fits perfectly fine in a normal return value, but yeah, this is common
code now and we can't rely on sizeof(_Bool) being sane.
