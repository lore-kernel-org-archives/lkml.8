Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4DCC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B6F2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRMTR9zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgBJNpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:45:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50500 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgBJNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nL1HBSQ6qLcMuvNZWsGlA8njZfsgNFQQf7UGR8jZzYI=; b=ZRMTR9zHMMyaMiGOGCXpsEwBON
        FTR4GGptH+Q4+rjNao7cC8s93MBMwbxu0eOLedlxsd+/s/IYLIeDnxnJUhizq0oJyaCfeC3k5auvc
        Nu+6yYtTM6JwjDRvTlrhYWqFxAMSJ+6AO+NTSOCzEBInHJa+yTYTJtnm+5sNBZId+H6jrExvc6f3l
        Mp2CZKIjg70QvAx0Ui2F2Ay+5T0kBDdhSL+HMSXvTHJx//fp3qIRKkJBWDgaHlZMuv6+KqJ6jah0T
        7SfCeylLNT8CduluOGg9FqfgwaX+ua7HM3AUsfWubyLaCsOAHQt/6MAm0/lXryGsDnKZAQgF+3W17
        fz7PK00A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j19MY-0006kI-RY; Mon, 10 Feb 2020 13:44:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96A2C300446;
        Mon, 10 Feb 2020 14:42:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C501F208447BD; Mon, 10 Feb 2020 14:44:32 +0100 (CET)
Date:   Mon, 10 Feb 2020 14:44:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200210134432.GK14897@hirez.programming.kicks-ass.net>
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
 <20200210094616.GC14879@hirez.programming.kicks-ass.net>
 <20200210133652.GV2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210133652.GV2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:36:52AM -0800, Paul E. McKenney wrote:

> > Furthermore, using srcu would be detrimental, because of how it has
> > smp_mb() in the read side primitives.
> 
> Note that rcu_irq_enter() and rcu_irq_exit() also contain value-returning
> atomics, which imply full memory barriers.

There is a whole lot of perf that doesn't go through tracepoints. It
makes absolutely no sense to make all that more expensive just because
tracepoints are getting 'funny'.

> > The best we can do is move that rcu_irq_enter/exit_*() crud into the
> > perf tracepoint glue I suppose.
> 
> One approach would be to define a synchronize_preempt_disable() that
> waits only for pre-existing disabled-preemption regions (including
> of course diabled-irq and NMI-handler regions.  Something like Steve
> Rostedt's workqueue-baed schedule_on_each_cpu(ftrace_sync) implementation
> might work.
> 
> There are of course some plusses and minuses:
> 
> +	Works on preempt-disable regions in idle-loop code without
> 	the need to invoke rcu_idle_exit() and rcu_idle_enter()..
> 
> +	Straightforward implementation.
> 
> -	Does not work on preempt-disable regions on offline CPUs.
> 	(I have no idea if this really matters.)

I'd hope not ;-)

> -	Schedules on idle CPUs, so usage needs to be restricted to
> 	avoid messing up energy-efficient systems.  (It should be
> 	just fine to use this for tracing.)

Unless you're tracing energy usage -- weird some people actually do that
:-)
