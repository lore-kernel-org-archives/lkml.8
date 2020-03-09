Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C70C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D8420727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCIRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:02:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59735 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCIRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:02:49 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBLnU-0003Um-U4; Mon, 09 Mar 2020 18:02:33 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6A53E1040A7; Mon,  9 Mar 2020 18:02:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Instrumentation and RCU
Date:   Mon, 09 Mar 2020 18:02:32 +0100
Message-ID: <87mu8p797b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I'm starting a new conversation because there are about 20 different
threads which look at that problem in various ways and the information
is so scattered that creating a coherent picture is pretty much
impossible.

There are several problems to solve:

   1) Fragile low level entry code

   2) Breakpoint utilization

   3) RCU idle

   4) Callchain protection

#1 Fragile low level entry code

   While I understand the desire of instrumentation to observe
   everything we really have to ask the question whether it is worth the
   trouble especially with entry trainwrecks like x86, PTI and other
   horrors in that area.

   I don't think so and we really should just bite the bullet and forbid
   any instrumentation in that code unless it is explicitly designed
   for that case, makes sense and has a real value from an observation
   perspective.

   This is very much related to #3..

#2) Breakpoint utilization

    As recent findings have shown, breakpoint utilization needs to be
    extremly careful about not creating infinite breakpoint recursions.

    I think that's pretty much obvious, but falls into the overall
    question of how to protect callchains.

#3) RCU idle

    Being able to trace code inside RCU idle sections is very similar to
    the question raised in #1.

    Assume all of the instrumentation would be doing conditional RCU
    schemes, i.e.:

    if (rcuidle)
    	....
    else
        rcu_read_lock_sched()

    before invoking the actual instrumentation functions and of course
    undoing that right after it, that really begs the question whether
    it's worth it.

    Especially constructs like:

    trace_hardirqs_off()
       idx = srcu_read_lock()
       rcu_irq_enter_irqson();
       ...
       rcu_irq_exit_irqson();
       srcu_read_unlock(idx);

    if (user_mode)
       user_exit_irqsoff();
    else
       rcu_irq_enter();

    are really more than questionable. For 99.9999% of instrumentation
    users it's absolutely irrelevant whether this traces the interrupt
    disabled time of user_exit_irqsoff() or rcu_irq_enter() or not.

    But what's relevant is the tracer overhead which is e.g. inflicted
    with todays trace_hardirqs_off/on() implementation because that
    unconditionally uses the rcuidle variant with the scru/rcu_irq dance
    around every tracepoint.

    Even if the tracepoint sits in the ASM code it just covers about ~20
    low level ASM instructions more. The tracer invocation, which is
    even done twice when coming from user space on x86 (the second call
    is optimized in the tracer C-code), costs definitely way more
    cycles. When you take the scru/rcu_irq dance into account it's a
    complete disaster performance wise.

#4 Protecting call chains

   Our current approach of annotating functions with notrace/noprobe is
   pretty much broken.

   Functions which are marked NOPROBE or notrace call out into functions
   which are not marked and while this might be ok, there are enough
   places where it is not. But we have no way to verify that.

   That's just a recipe for disaster. We really cannot request from
   sysadmins who want to use instrumentation to stare at the code first
   whether they can place/enable an instrumentation point somewhere.
   That'd be just a bad joke.

   I really think we need to have proper text sections which are off
   limit for any form of instrumentation and have tooling to analyze the
   calls into other sections. These calls need to be annotated as safe
   and intentional.

Thoughts?

Thanks,

        tglx






   

