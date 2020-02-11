Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658CEC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D5320873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgBKOFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbgBKOFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:05:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ABBC20870;
        Tue, 11 Feb 2020 14:05:05 +0000 (UTC)
Date:   Tue, 11 Feb 2020 09:05:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211090503.68c0d70f@gandalf.local.home>
In-Reply-To: <20200211114954.GK14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
        <20200211114954.GK14914@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 12:49:54 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 10, 2020 at 05:06:43PM -0500, Steven Rostedt wrote:
> > +	if (!rcu_watching) {						\
> > +		/* Can not use RCU if rcu is not watching and in NMI */	\
> > +		if (in_nmi())						\
> > +			return;						\
> > +		rcu_irq_enter_irqson();					\
> > +	}								\  
> 
> I saw the same weirdness in __trace_stack(), and I'm confused by it.
> 
> How can we ever get to: in_nmi() && !rcu_watching() ? That should be a
> BUG.  In particular, nmi_enter() has rcu_nmi_enter().
> 
> Paul, can that really happen?

The stack tracer connects to the function tracer and is called at all
the places that function tracing can be called from. As I like being
able to trace RCU internal functions (especially as they are complex),
I don't want to set them all to notrace. But, for callbacks that
require RCU to be watching, we need this check, because there's some
internal state that we can be in an NMI and RCU is not watching (as
there's some places in nmi_enter that can be traced!).

And if we are tracing preempt_enable and preempt_disable (as Joel added
trace events there), it may be the case for trace events too.

-- Steve

