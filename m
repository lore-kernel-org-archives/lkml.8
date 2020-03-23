Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86E2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD30220735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584977444;
	bh=c/BmuNMOcm2EFTJiFoXTh1Vq5RGJMcdEbf3sn15wFTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BzAplZLnH8hcx5+UTZfTtiSLysYKY3A70kyis0vCYRnmGWBnpX1TA8upetpan0EIS
	 yUYlLxWkS02QbsD+zwsQXrMagHk8EsIW1C1raRlhCROFA9UJLKzsOm7z9OBUelJNOo
	 UwIdQre0SJ1t/fSyl3lYKkFTcTuHa+kfK/50nRQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgCWPan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgCWPan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:30:43 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46A99206C3;
        Mon, 23 Mar 2020 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584977442;
        bh=c/BmuNMOcm2EFTJiFoXTh1Vq5RGJMcdEbf3sn15wFTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBZ7ZpqambbEgbhVe5WIcsu4UpeB10qjYzxwqgDEbXzE9XTQvb67iuULkW6UyWID5
         f76NsPm8BzAZTrBUgF8MQHVNnUGchd/71x6SB9UUU0qDX3Q2yphEkGuu10cwduVZdL
         u0Y7keuyEj4nEEo8AB21fb/hLskbkCTsjntSPjPA=
Date:   Mon, 23 Mar 2020 16:30:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/3] lockdep/irq: Be more strict about IRQ-threadable
 code end
Message-ID: <20200323153039.GA5755@lenoir>
References: <20200323033207.32370-1-frederic@kernel.org>
 <20200323033207.32370-2-frederic@kernel.org>
 <20200323135320.GJ2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323135320.GJ2452@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:53:20PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 23, 2020 at 04:32:05AM +0100, Frederic Weisbecker wrote:
> > --- a/kernel/irq/handle.c
> > +++ b/kernel/irq/handle.c
> > @@ -144,18 +144,24 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
> >  
> >  	for_each_action_of_desc(desc, action) {
> >  		irqreturn_t res;
> > +		bool threadable;
> >  
> >  		/*
> >  		 * If this IRQ would be threaded under force_irqthreads, mark it so.
> >  		 */
> > -		if (irq_settings_can_thread(desc) &&
> > -		    !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)))
> > +		threadable = (irq_settings_can_thread(desc) &&
> > +			      !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)));
> > +
> > +		if (threadable)
> >  			trace_hardirq_threaded();
> >  
> >  		trace_irq_handler_entry(irq, action);
> >  		res = action->handler(irq, action->dev_id);
> >  		trace_irq_handler_exit(irq, action, res);
> >  
> > +		if (threadable)
> > +			trace_hardirq_unthreaded();
> 
> AFAICT this doesn't work for nested IRQ handlers.

So current->hardirq_threaded should be a counter perhaps?

> 
> >  		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
> >  			      irq, action->handler))
> >  			local_irq_disable();
> > -- 
> > 2.25.0
> > 
