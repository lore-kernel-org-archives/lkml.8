Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E4C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969EB20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581343034;
	bh=IWC4nbYsn8wiAFqXOmw689pbM07Zng40OjaVFbq6MzM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QZHLkOG1fQBQeHvjJ51TIWMUxRCZB7uLBmPXHMKbk9W2Do/uAuHAYQb3clLIkRXjk
	 IEYe0psNDFMmHqawsmYK1+F3rBc2fatwzaLILRD2md09FKGbG3MbhMM7QmvZpFvz5U
	 n6bhG9M6FUxtAntipawXb6jIB1jezwo1rrdaOJiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgBJN5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgBJN5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:57:13 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18FF8206ED;
        Mon, 10 Feb 2020 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581343033;
        bh=IWC4nbYsn8wiAFqXOmw689pbM07Zng40OjaVFbq6MzM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r2gFg7CTyh1h4iPpRtqdScLeq6c6Zqbv+XwWy5fRSTl3eN5DZM7PEf9yeZ/tY832p
         6vfK22OXgdMs6ea2yBziTDrCeDS4vp/4tIFXk7MAntOhDARzVkZ0m+ZF3p1Kgjq0Fw
         HG6vLtgFcOKuxfn9vRF64BD/6bD5JBu/Tn+FO6Yo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C19B73522700; Mon, 10 Feb 2020 05:57:10 -0800 (PST)
Date:   Mon, 10 Feb 2020 05:57:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200210135710.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
 <20200210094616.GC14879@hirez.programming.kicks-ass.net>
 <20200210133652.GV2935@paulmck-ThinkPad-P72>
 <20200210134432.GK14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210134432.GK14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 02:44:32PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 10, 2020 at 05:36:52AM -0800, Paul E. McKenney wrote:
> 
> > > Furthermore, using srcu would be detrimental, because of how it has
> > > smp_mb() in the read side primitives.
> > 
> > Note that rcu_irq_enter() and rcu_irq_exit() also contain value-returning
> > atomics, which imply full memory barriers.
> 
> There is a whole lot of perf that doesn't go through tracepoints. It
> makes absolutely no sense to make all that more expensive just because
> tracepoints are getting 'funny'.

OK.

> > > The best we can do is move that rcu_irq_enter/exit_*() crud into the
> > > perf tracepoint glue I suppose.
> > 
> > One approach would be to define a synchronize_preempt_disable() that
> > waits only for pre-existing disabled-preemption regions (including
> > of course diabled-irq and NMI-handler regions.  Something like Steve
> > Rostedt's workqueue-baed schedule_on_each_cpu(ftrace_sync) implementation
> > might work.
> > 
> > There are of course some plusses and minuses:
> > 
> > +	Works on preempt-disable regions in idle-loop code without
> > 	the need to invoke rcu_idle_exit() and rcu_idle_enter()..
> > 
> > +	Straightforward implementation.
> > 
> > -	Does not work on preempt-disable regions on offline CPUs.
> > 	(I have no idea if this really matters.)
> 
> I'd hope not ;-)

Me too, but I have harbored a great many hopes over the decades.  ;-)

> > -	Schedules on idle CPUs, so usage needs to be restricted to
> > 	avoid messing up energy-efficient systems.  (It should be
> > 	just fine to use this for tracing.)
> 
> Unless you're tracing energy usage -- weird some people actually do that
> :-)

Would they be changing tracing of their energy usage often in production?

							Thanx, Paul
