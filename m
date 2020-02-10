Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4103C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7722082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eBJUw0ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBJRdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:33:07 -0500
Received: from mail.efficios.com ([167.114.26.124]:45212 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJRdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:33:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D207F245781;
        Mon, 10 Feb 2020 12:33:04 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kuPWvdfNno79; Mon, 10 Feb 2020 12:33:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 72FB3245530;
        Mon, 10 Feb 2020 12:33:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 72FB3245530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581355984;
        bh=tLGk2wW+eFY4z3NFz2zYJ+bD12q+92b4IvzmbQrFWaw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eBJUw0iamiA8iDM2ykssDz7YT0Ry8yd8R8JU2jI+IOZmI91nPshqENc46oKsYjyVO
         Rn+SCenGdFwPQr96UESrIP0af79Sq9ZtNYK0bJ9QxNCo9e4IYhW2+HW59av6B8BgKj
         O7lstugh65LVHW2LE4PH3fW1S2vxEiVHYWq8Zi9tuvkb2cPviCLSEIow039jcWYwL3
         TOEfWrQdzOim2N/S5gYbYNSJw9jTI2vv6EaZiJDEy13eq321jZhOC2O65aH7NZksqT
         WSn+1iIAPXiEHLBZOPSxNgLV0YQBCRG2i8RVpVhYkH8mHvfwqS11m7bA+K3/DKdlAR
         JuR1Vp5FI5KbA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7RMEyuEJBMfW; Mon, 10 Feb 2020 12:33:04 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5B8CD245712;
        Mon, 10 Feb 2020 12:33:04 -0500 (EST)
Date:   Mon, 10 Feb 2020 12:33:04 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
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
Message-ID: <1966694237.616758.1581355984287.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200210120552.1a06a7aa@gandalf.local.home>
References: <20200207205656.61938-1-joel@joelfernandes.org> <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com> <20200210094616.GC14879@hirez.programming.kicks-ass.net> <20200210120552.1a06a7aa@gandalf.local.home>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: Revert SRCU from tracepoint infrastructure
Thread-Index: cU4abBwtS1928irOMYESy3r+/umCMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 10, 2020, at 12:05 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 10 Feb 2020 10:46:16 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> Furthermore, using srcu would be detrimental, because of how it has
>> smp_mb() in the read side primitives.
> 
> I didn't realize that there was a full memory barrier in the srcu read
> side. Seems to me that itself is rational for reverting it. And also a
> big NAK for any suggestion to have any of the function tracing to use
> it as well (which comes up here and there).

The rcu_irq_enter/exit_irqson() does atomic_add_return(), which is even worse
than a memory barrier.

Let me summarize my understanding of a few use-cases we have with tracepoints
and other instrumentation mechanisms and the guarantees they provide (or not):

* Tracepoints
  - Uses sched-rcu (typically)
  - Uses SRCU for _cpuidle callsites
  - Planned use of SRCU to allow syscall entry/exit instrumentation to
    take page faults. (currently all tracers paper over that issue by filling
    with zeroes rather than handle the fault)
  - Grace period waits for both sched-rcu and SRCU.

* kprobes/kretprobes
  - interrupts off around probe invocation

* Hardware performance counters
  - Probe invoked from NMI context 

- Software performance counters
  - preempt off around probe invocation

Moving _rcuidle instrumentation to SRCU aimed at removing a significant
overhead incurred by having all _rcuidle tracepoints perform the atomic_add_return
on the shared variable (which is frequent enough to impact performance).

There are a couple of approaches that perf could take in order to tackle this
without hurting performance for all other tracers:

- If perf wishes to keep using explicit rcu_read_lock/unlock in its probes:

Use is_rcu_watching() within the perf probe, and only invoke rcu_irq_enter/exit_irqson()
when needed.

As an alternative, perf could implement a "trampoline" which would only be used
when registering a perf probe to a _rcuidle tracepoint. That trampoline would
perform rcu_irq_entrer/exit_irqson() around the call to the real perf probe.

- If perf can remove the redundant RCU read-side lock/unlock and replace this
  by waiting for the relevant RCU/SRCU grace periods instead:

Basically, looking at all the instrumentation sources perf uses, all of them
already provide some kind of RCU guarantee, which makes the explicit rcu read-side
locks within the perf probes redundant. Removing the redundant rcu read-side lock/unlock
from the perf probes should bring a slight performance improvement as well.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
