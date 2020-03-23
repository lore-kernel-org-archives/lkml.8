Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EDE20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Anw38VSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCWQbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:31:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCWQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=omo/Na5ZROj4u9t7Bqw1Dw8ScS4aH9K7KDqXAWCXJOw=; b=Anw38VSd8Ip4H76yWLh85U4fU/
        dYOPEDmJJniFncpwq7kP0/IdBpnZQ7ryQW1ENsMJ0TdH9fmSO/UFTHc/bFJts0aV5d/uZgKsEXFzb
        Ot+2T65qP9saMOjfypOXJ6/n0ler2+vxvkDymGg7dwq8Mub/fRzBzsUoPoEDib7zuv5frybBptAhI
        F8q/m1HTMhZn7brg3Ptat9RghQD9TWewhVKVOtGqYYauqtSqeeM/hHaWIx/EyS4kivpay96VBUJiH
        JzPoAnftvS9QZ8HekoORxE5Hpoq5/R4AGSrUVlGMihgAoWqX8zpyh5tKzgV6qTj+LonAq/XwxITCp
        M3z/w0tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGPym-000288-U3; Mon, 23 Mar 2020 16:31:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E0FD983505; Mon, 23 Mar 2020 17:31:06 +0100 (CET)
Date:   Mon, 23 Mar 2020 17:31:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/3] lockdep/irq: Be more strict about IRQ-threadable
 code end
Message-ID: <20200323163105.GM2452@worktop.programming.kicks-ass.net>
References: <20200323033207.32370-1-frederic@kernel.org>
 <20200323033207.32370-2-frederic@kernel.org>
 <20200323135320.GJ2452@worktop.programming.kicks-ass.net>
 <20200323153039.GA5755@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323153039.GA5755@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:30:40PM +0100, Frederic Weisbecker wrote:
> On Mon, Mar 23, 2020 at 02:53:20PM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 23, 2020 at 04:32:05AM +0100, Frederic Weisbecker wrote:
> > > --- a/kernel/irq/handle.c
> > > +++ b/kernel/irq/handle.c
> > > @@ -144,18 +144,24 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
> > >  
> > >  	for_each_action_of_desc(desc, action) {
> > >  		irqreturn_t res;
> > > +		bool threadable;
> > >  
> > >  		/*
> > >  		 * If this IRQ would be threaded under force_irqthreads, mark it so.
> > >  		 */
> > > -		if (irq_settings_can_thread(desc) &&
> > > -		    !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)))
> > > +		threadable = (irq_settings_can_thread(desc) &&
> > > +			      !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)));
> > > +
> > > +		if (threadable)
> > >  			trace_hardirq_threaded();
> > >  
> > >  		trace_irq_handler_entry(irq, action);
> > >  		res = action->handler(irq, action->dev_id);
> > >  		trace_irq_handler_exit(irq, action, res);
> > >  
> > > +		if (threadable)
> > > +			trace_hardirq_unthreaded();
> > 
> > AFAICT this doesn't work for nested IRQ handlers.
> 
> So current->hardirq_threaded should be a counter perhaps?

Yeah, see how the old code used the hardirq_context counter for exactly
that. Also note how the old code was actually cheaper than this
(minimally, but still).
