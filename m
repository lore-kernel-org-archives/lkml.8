Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A49C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F493206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581427397;
	bh=ocJn6FrQOTXH/4cI+RnnTS3BKjm2ap6x4uOQMQlIFtA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=UVDuM+xNK4cSlTRI5TuFEZLeluGdFRkw1LDJx9fwcpqFLMPrWoKRgLdasr+dza2W9
	 124ej3xlREOta4UWBzhf1rm/IEPeqdPhiVReXccmp9d4noU2P0OjkdFZ9gxbkqs/6o
	 1XjQPYJqodwgZCo3IcXC3QDizaw8PHpyZEl1S82k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgBKNXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbgBKNXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:23:16 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AFFC20675;
        Tue, 11 Feb 2020 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581427395;
        bh=ocJn6FrQOTXH/4cI+RnnTS3BKjm2ap6x4uOQMQlIFtA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bxfuUUj9bEYCciBb/K5QvU2mp5l7hQjI4/YcjjgqWzAedEopTOKr1mVS7cn6KAW58
         r8nOY0zhD6NE+YhqngFBhIoFVkCNKwEjqY/v7xPn8nEq1QjGMEe+5bD7K6g/ktjRMz
         6gVerKMREiv4ofn2bjcUTit8EMNlTO6Sm8g0xVG0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C421F3520CB5; Tue, 11 Feb 2020 05:23:13 -0800 (PST)
Date:   Tue, 11 Feb 2020 05:23:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211132313.GJ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200210170643.3544795d@gandalf.local.home>
 <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
 <20200211120015.GL14914@hirez.programming.kicks-ass.net>
 <20200211130301.GH2935@paulmck-ThinkPad-P72>
 <20200211131637.GS14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211131637.GS14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:16:37PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2020 at 05:03:01AM -0800, Paul E. McKenney wrote:
> 
> > > It is not the fact that perf issues rcu_read_lock() that is the problem.
> > > As we established yesterday, I can probably remove most rcu_read_lock()
> > > calls from perf today (yay RCU flavour unification).
> > 
> > Glad some aspect of this unification is actually helping you.  ;-)
> 
> rcu_read_lock() is exceedingly cheap though, so I never really worried
> about it. But now that RCU includes RCU-sched (again) we can go and
> remove a bunch of them.
> 
> > > As per nmi_enter() calling rcu_nmi_enter() I've always assumed that NMIs
> > > are fully covered by RCU.
> > > 
> > > If this isn't so, RCU it terminally broken :-)
> > 
> > All RCU can do is respond to calls to rcu_nmi_enter() and rcu_nmi_exit().
> > It has not yet figured out how to force people to add these calls where
> > they are needed.  ;-)
> > 
> > But yes, it would be very nice if architectures arranged things so
> > that all NMI handlers were visible to RCU.  And we no longer have
> > half-interrupts, so maybe there is hope...
> 
> Well,.. you could go back to simply _always_ watching :-)

The idle loop always was unwatched, even back in DYNIX/ptx.  And watching
the idle loop requires waking up idle CPUs, which makes lots of people
quite unhappy.  But it could be done with something sort of like
synchronize_rcu_tasks(), as long as this didn't need to be used in
production on battery-powered systems.

							Thanx, Paul
