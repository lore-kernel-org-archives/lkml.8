Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E792C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9DD20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="x47rc5fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgBJUaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:30:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36072 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgBJUaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:30:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so6233792qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rBGfXWGvSNHuOXIBGZlPItb5PRw9RMp9e06MvCgujCw=;
        b=x47rc5foaVZNrWkyWYHuGgsBgYc4U1L1DmHRs74Ie0inMjqKnmh4b3g6nsPnDsXGAZ
         PK12pynX5W778k4JgdnJQFbcstqmgbU4p5DC/XVkCQeFDGj5X7lknFCywSb6P1T1dWq5
         S9W0pxfSl/yPBZ+aMdDmuFgFbp2cTyp3vIPJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rBGfXWGvSNHuOXIBGZlPItb5PRw9RMp9e06MvCgujCw=;
        b=G5if3mFTHJT+dUrNLYLTt5JeohvvEw6gUCzAnHGhGca23oG0DmYP5iY0r/Y8TN8BQl
         FLkRq4Ejq8vZY0sMQYpIJDFfookpUkpK+qopC06LmIKr+TARkQrWyLfewFyQ5BQkoyLc
         aXLlnD5Hf9GDptGU26G+qTWiYYa/kvkunApS/glPa9yHY3rqJmUNP+ySHQOACJKWiqE/
         AcK/bfuuSSrB4MWWWbQ9S7XNcEIMB6BN3l3g4ULCIScYdqBqEDvCpU7C00yadO1v+3Zc
         qG/oorDjvMcRB7hOE/l/krIqRsweXOTDYsSzivocWu7lW7k1Kk8l8jp8KiOS0ko5EZC9
         6k7A==
X-Gm-Message-State: APjAAAUcg00mgYIfAJlahOoIzSNxNM3+DfaTDu2xkT5ielB5cC5n7cO1
        8dyn1dU8gvN9Df4qcZD8yKQ+bA==
X-Google-Smtp-Source: APXvYqxnN1gZoon6tuXHN5hO86FnC+G5KzzCM0+zIbCkUB5Qkmz/A15k0o56lEN53jZyFJBKK0jiag==
X-Received: by 2002:ac8:1e90:: with SMTP id c16mr11546777qtm.265.1581366609542;
        Mon, 10 Feb 2020 12:30:09 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 135sm747180qkj.55.2020.02.10.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 12:30:09 -0800 (PST)
Date:   Mon, 10 Feb 2020 15:30:08 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20200210203008.GA84085@google.com>
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
 <20200210094616.GC14879@hirez.programming.kicks-ass.net>
 <20200210120552.1a06a7aa@gandalf.local.home>
 <1966694237.616758.1581355984287.JavaMail.zimbra@efficios.com>
 <20200210133045.3beb774e@gandalf.local.home>
 <20200210195302.GA231192@google.com>
 <20200210150348.7d0979e6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210150348.7d0979e6@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, Feb 10, 2020 at 03:03:48PM -0500, Steven Rostedt wrote:
> On Mon, 10 Feb 2020 14:53:02 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > > index 1fb11daa5c53..a83fd076a312 100644
> > > --- a/include/linux/tracepoint.h
> > > +++ b/include/linux/tracepoint.h
> > > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > >  		 * For rcuidle callers, use srcu since sched-rcu	\
> > >  		 * doesn't work from the idle path.			\
> > >  		 */							\
> > > -		if (rcuidle) {						\
> > > +		if (rcuidle)						\
> > >  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> > > -			rcu_irq_enter_irqson();				\
> > > -		}							\  
> > 
> > This would still break out-of-tree modules or future code that does
> > rcu_read_lock() right in a tracepoint callback right?
> 
> Yes, and that's fine.
> 
> > 
> > Or are we saying that rcu_read_lock() in a tracepoint callback is not
> > allowed? I believe this should then at least be documented somewhere.  Also,
> 
> No, it's only not allowed if you you attached to a tracepoint that can
> be called without rcu watching. That's up to the caller to figure it
> out. Tracepoints were never meant to be a generic thing people should
> use without knowing what they are really doing.

Ok, right.

> > what about code in tracepoint callback that calls rcu_read_lock() indirectly
> > through a path in the kernel, and also code that may expect RCU readers when
> > doing preempt_disable()?
> 
> Then they need to know what they are doing.

Ok.

> > So basically we are saying with this patch:
> > 1. Don't call in a callback: rcu_read_lock() or preempt_disable() and expect RCU to do
> > anything for you.
> 
> We can just say, "If you plan on using RCU, be aware that it man not be
> watching and you get do deal with the fallout. Use rcu_is_watching() to
> figure it out."

Ok.

> > 2. Don't call code that does anything that 1. needs.
> > 
> > Is that intended? thanks,
> > 
> 
> No, look what the patch did for perf. Why make *all* callbacks suffer
> if only some use RCU? If you use RCU from a callback, then you need to
> figure it out. The same goes for attaching to the function tracer.

Only the callbacks on the rcuidle ones would suffer though, not all
callbacks.

Yes I saw the patch, it looks like a good idea to me and I am Ok with it.

thanks,

 - Joel


