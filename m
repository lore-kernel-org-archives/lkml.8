Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC645C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46C620842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBJUDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgBJUDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:03:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C23120838;
        Mon, 10 Feb 2020 20:03:50 +0000 (UTC)
Date:   Mon, 10 Feb 2020 15:03:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200210150348.7d0979e6@gandalf.local.home>
In-Reply-To: <20200210195302.GA231192@google.com>
References: <20200207205656.61938-1-joel@joelfernandes.org>
        <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
        <20200210094616.GC14879@hirez.programming.kicks-ass.net>
        <20200210120552.1a06a7aa@gandalf.local.home>
        <1966694237.616758.1581355984287.JavaMail.zimbra@efficios.com>
        <20200210133045.3beb774e@gandalf.local.home>
        <20200210195302.GA231192@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 14:53:02 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 1fb11daa5c53..a83fd076a312 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  		 * For rcuidle callers, use srcu since sched-rcu	\
> >  		 * doesn't work from the idle path.			\
> >  		 */							\
> > -		if (rcuidle) {						\
> > +		if (rcuidle)						\
> >  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> > -			rcu_irq_enter_irqson();				\
> > -		}							\  
> 
> This would still break out-of-tree modules or future code that does
> rcu_read_lock() right in a tracepoint callback right?

Yes, and that's fine.

> 
> Or are we saying that rcu_read_lock() in a tracepoint callback is not
> allowed? I believe this should then at least be documented somewhere.  Also,

No, it's only not allowed if you you attached to a tracepoint that can
be called without rcu watching. That's up to the caller to figure it
out. Tracepoints were never meant to be a generic thing people should
use without knowing what they are really doing.

> what about code in tracepoint callback that calls rcu_read_lock() indirectly
> through a path in the kernel, and also code that may expect RCU readers when
> doing preempt_disable()?

Then they need to know what they are doing.

> 
> So basically we are saying with this patch:
> 1. Don't call in a callback: rcu_read_lock() or preempt_disable() and expect RCU to do
> anything for you.

We can just say, "If you plan on using RCU, be aware that it man not be
watching and you get do deal with the fallout. Use rcu_is_watching() to
figure it out."

> 2. Don't call code that does anything that 1. needs.
> 
> Is that intended? thanks,
> 

No, look what the patch did for perf. Why make *all* callbacks suffer
if only some use RCU? If you use RCU from a callback, then you need to
figure it out. The same goes for attaching to the function tracer.

-- Steve
