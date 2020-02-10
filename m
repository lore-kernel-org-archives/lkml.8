Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D1C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC772085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341822;
	bh=nB7K6kpxye76S3Jb8ETTHL7QodfEBqCDjkWsssZduzE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PcN/cytndSnx3f6vUFu7971feNKxelaYhf0AxS7Xv4YKBYzVP8DM1ItDvdTfiy48z
	 UPw3dbrm0f7XtEK8sNLHgdtaNccwTS1J8zJTYxbNi3Rp8gPubAu3gfgWu9Teq14/EK
	 CK15oXyK6YZl0KrrorITj0vQsJ75r9trCqpjV1qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbgBJNhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:37:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgBJNg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:36:58 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB6120714;
        Mon, 10 Feb 2020 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581341817;
        bh=nB7K6kpxye76S3Jb8ETTHL7QodfEBqCDjkWsssZduzE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qL0E8isKyNkFKrWHVRu6fEZ8YKQGgpCkWyrklytg5HLFiuRVbWyMcACAdGDyWyvKL
         tXWa6K4S1TnaIaRebnAETuYUEj8+xmvoxHFOJ5wFKfj8iGowNk3Di/J1v98QyddiKJ
         k5TPJaaxpzQm/HzKDSK8Ary0+sya0jZdvGiHG7/E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 02E833522700; Mon, 10 Feb 2020 05:36:53 -0800 (PST)
Date:   Mon, 10 Feb 2020 05:36:52 -0800
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
Message-ID: <20200210133652.GV2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
 <20200210094616.GC14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210094616.GC14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:46:16AM +0100, Peter Zijlstra wrote:
> On Sat, Feb 08, 2020 at 11:31:25AM -0500, Mathieu Desnoyers wrote:
> > ----- On Feb 7, 2020, at 3:56 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> > 
> > > Hi,
> > > These patches remove SRCU usage from tracepoints. The reason for proposing the
> > > reverts is because the whole point of SRCU was to avoid having to call
> > > rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
> > > Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
> > > was breaking..
> > 
> > I think the original patch re-enabling the rcu_irq_enter/exit_irqson() is a
> > tracepoint band-aid over what should actually been fixed within perf instead.
> > 
> > Perf should not do rcu_read_lock/unlock()/synchronize_rcu(), but rather use
> > tracepoint_synchronize_unregister() to match the read-side provided by
> > tracepoints.
> > 
> > If perf can then just rely on the underlying synchronization provided by each
> > instrumentation providers (tracepoint, kprobe, ...) and not explicitly add its own
> > unneeded synchronization on top (e.g. rcu_read_lock/unlock), then it should simplify
> > all this.
> 
> It can't. At this point it doesn't know where the event came from. Also,
> the whole perf stuff is per definition non-preemptible, as it needs to
> run from NMI context.
> 
> Furthermore, using srcu would be detrimental, because of how it has
> smp_mb() in the read side primitives.

Note that rcu_irq_enter() and rcu_irq_exit() also contain value-returning
atomics, which imply full memory barriers.

> The best we can do is move that rcu_irq_enter/exit_*() crud into the
> perf tracepoint glue I suppose.

One approach would be to define a synchronize_preempt_disable() that
waits only for pre-existing disabled-preemption regions (including
of course diabled-irq and NMI-handler regions.  Something like Steve
Rostedt's workqueue-baed schedule_on_each_cpu(ftrace_sync) implementation
might work.

There are of course some plusses and minuses:

+	Works on preempt-disable regions in idle-loop code without
	the need to invoke rcu_idle_exit() and rcu_idle_enter()..

+	Straightforward implementation.

-	Does not work on preempt-disable regions on offline CPUs.
	(I have no idea if this really matters.)

-	Schedules on idle CPUs, so usage needs to be restricted to
	avoid messing up energy-efficient systems.  (It should be
	just fine to use this for tracing.)

Thoughts?

							Thanx, Paul
