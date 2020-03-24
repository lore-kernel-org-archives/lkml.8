Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B061C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 03:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603FF206F9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585020010;
	bh=G1swHfFuXPNEQWBC8/W9FX68fY6fJuschbhXndD6CEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fK9ByEjC6g0jGZ+muXckUGohXNRMAoQbD4sqdyJKa9dSwFOnRwM3vrQanXcSuSkNS
	 FhKbRbJu80dw4JxmPfec2Pp5Py5Lxp/LPa8X0kBUDITl54G+Va4+4TiYLGJTmv5FBc
	 KgLMG46F0fDLUL3P5mYve2dzVN7wv3quIKeQ8+SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCXDUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgCXDUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 23:20:09 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33F520637;
        Tue, 24 Mar 2020 03:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585020008;
        bh=G1swHfFuXPNEQWBC8/W9FX68fY6fJuschbhXndD6CEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0gb/Kr+jEj4BvuqSOj+cCqP+JhYrEfS/dogDpfj+MYTXEmU33YmPxi+Fr/MMjRgz
         pCNMpdA0S2nu7E9Zcj51uvpYiSKCUwQU5HC7tW8WmK2p1wLxgAv8cwrmnx6x46B2Iy
         xP/+swrMqWzTd+Sc1hnvBlNE3GtVr/mxGflt6a7I=
Date:   Tue, 24 Mar 2020 04:20:05 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/3] lockdep/irq: Be more strict about IRQ-threadable
 code end
Message-ID: <20200324032004.GA13214@lenoir>
References: <20200323033207.32370-1-frederic@kernel.org>
 <20200323033207.32370-2-frederic@kernel.org>
 <20200323135320.GJ2452@worktop.programming.kicks-ass.net>
 <20200323153039.GA5755@lenoir>
 <20200323163105.GM2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323163105.GM2452@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 05:31:05PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 23, 2020 at 04:30:40PM +0100, Frederic Weisbecker wrote:
> > On Mon, Mar 23, 2020 at 02:53:20PM +0100, Peter Zijlstra wrote:
> > > On Mon, Mar 23, 2020 at 04:32:05AM +0100, Frederic Weisbecker wrote:
> > > > --- a/kernel/irq/handle.c
> > > > +++ b/kernel/irq/handle.c
> > > > @@ -144,18 +144,24 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
> > > >  
> > > >  	for_each_action_of_desc(desc, action) {
> > > >  		irqreturn_t res;
> > > > +		bool threadable;
> > > >  
> > > >  		/*
> > > >  		 * If this IRQ would be threaded under force_irqthreads, mark it so.
> > > >  		 */
> > > > -		if (irq_settings_can_thread(desc) &&
> > > > -		    !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)))
> > > > +		threadable = (irq_settings_can_thread(desc) &&
> > > > +			      !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)));
> > > > +
> > > > +		if (threadable)
> > > >  			trace_hardirq_threaded();
> > > >  
> > > >  		trace_irq_handler_entry(irq, action);
> > > >  		res = action->handler(irq, action->dev_id);
> > > >  		trace_irq_handler_exit(irq, action, res);
> > > >  
> > > > +		if (threadable)
> > > > +			trace_hardirq_unthreaded();
> > > 
> > > AFAICT this doesn't work for nested IRQ handlers.
> > 
> > So current->hardirq_threaded should be a counter perhaps?
> 
> Yeah, see how the old code used the hardirq_context counter for exactly
> that. Also note how the old code was actually cheaper than this
> (minimally, but still).

But, how are nested hardirq handled currently? Isn't it with hardirq_context counter?
