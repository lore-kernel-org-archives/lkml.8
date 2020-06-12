Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27CBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887E420878
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591971987;
	bh=atjW46QNtnS8Y/KXlo++XpkVRSaZZCmd4cUh/5IL8Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=azl8gzI2hNbcS5YS03NpfhmhcF7lcm8LMnoa5Y/T2VlxB7X6QqdrJ9wyBUaxI5F1E
	 XcsyBVLwr8tKrc1TcTbNI6nnbnsEk/ZKwiE0OI/hKEvTAKuqIyB6ToMmWNgsJzVTKq
	 iRjOtbgoLu3Qve8VMxXIsAzDYTLv4n21Ir1tg154=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgFLO00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgFLO0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:26:25 -0400
Received: from localhost (lfbn-ncy-1-150-120.w83-194.abo.wanadoo.fr [83.194.232.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625662074B;
        Fri, 12 Jun 2020 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591971984;
        bh=atjW46QNtnS8Y/KXlo++XpkVRSaZZCmd4cUh/5IL8Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jf0ZO9Byvv4MMEO2a22RpHiRwJQ3yGIMVrEHTRwfMEtBFVxwVh9XjL9hlleu9AYzq
         BiDf7R1PjOyYspYxchWS8g1P2kvh+wrsNqTK0H9X1ksNJkdm3LKUq0iOlpm+lSUOxC
         D5QXQmd9NKwv7cXnlA6WbDsp2Ql0FbFf3blGxv3g=
Date:   Fri, 12 Jun 2020 16:26:22 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
Message-ID: <20200612142621.GA8009@lenoir>
References: <20200611235305.GA32342@paulmck-ThinkPad-P72>
 <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
 <871rmkzcc8.fsf@nanos.tec.linutronix.de>
 <87wo4cxubv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo4cxubv.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:55:00PM +0200, Thomas Gleixner wrote:
> The idea of conditionally calling into rcu_irq_enter() only when RCU is
> not watching turned out to be not completely thought through.
> 
> Paul noticed occasional premature end of grace periods in RCU torture
> testing. Bisection led to the commit which made the invocation of
> rcu_irq_enter() conditional on !rcu_is_watching().
> 
> It turned out that this conditional breaks RCU assumptions about the idle
> task when the scheduler tick happens to be a nested interrupt. Nested
> interrupts can happen when the first interrupt invokes softirq processing
> on return which enables interrupts. If that nested tick interrupt does not
> invoke rcu_irq_enter() then the nest accounting in RCU claims that this is
> the first interrupt which might mark a quiescient state and end grace
> periods prematurely.
> 
> Change the condition from !rcu_is_watching() to is_idle_task(current) which
> enforces that interrupts in the idle task unconditionally invoke
> rcu_irq_enter() independent of the RCU state.
> 
> This is also correct vs. user mode entries in NOHZ full scenarios because
> user mode entries bring RCU out of EQS and force the RCU irq nesting state
> accounting to nested. As only the first interrupt can enter from user mode
> a nested tick interrupt will enter from kernel mode and as the nesting
> state accounting is forced to nesting it will not do anything stupid even
> if rcu_irq_enter() has not been invoked.
> 
> Fixes: 3eeec3858488 ("x86/entry: Provide idtentry_entry/exit_cond_rcu()")
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

So, in the end the call to rcu_irq_enter() in irq_enter() is going to
be useless in x86, right?
