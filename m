Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFCFC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBB9206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P/9Hm6oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgBKRa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:30:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBKRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tft67AgEbN+sLqwt5f8HWk481eltg1oxQ1lCTGDpTog=; b=P/9Hm6oJRIT5xdd1KPyt2tWa6k
        k3L048HX2u2u5DGjEJ7nG0LUVBLPsUIjzynccEFGJQHIlwn4+XO209jpVIh6EHJWBzZiWAMScP2D3
        fxLjhCt1rCVw1lsGEHHo7zqTEPZUodOIZOQh/wvNKahC/yHyZFHRNJHEq+G8Sb9GnnDNJF/soinVt
        atnPjUh7uwVd5iqeczgILth/spiJR0gFR2ttvR8EpiOH5okXo7sca989qc/rojiVN42aL1Hc8y1x6
        uYPa3kyEyyPHuAtpMPhii4Y1YuVjrJMHfZvnZX3aRZHmgJxWwsXkUTx9y9xvnPhY47Q5nprE6ZxlV
        MDY5Ip5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1ZMC-0000jn-Vl; Tue, 11 Feb 2020 17:29:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5826300F7A;
        Tue, 11 Feb 2020 18:28:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D9F12B91EB95; Tue, 11 Feb 2020 18:29:52 +0100 (CET)
Date:   Tue, 11 Feb 2020 18:29:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
Message-ID: <20200211172952.GY14914@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home>
 <20200211153452.GW14914@hirez.programming.kicks-ass.net>
 <20200211111828.48058768@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211111828.48058768@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:18:28AM -0500, Steven Rostedt wrote:
> On Tue, 11 Feb 2020 16:34:52 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > +		if (unlikely(in_nmi()))
> > > +			goto out;  
> > 
> > unless I'm mistaken, we can simply do rcu_nmi_enter() in this case, and
> > rcu_nmi_exit() on the other end.
> > 
> > > +		rcu_irq_enter_irqson();
> 
> The thing is, I don't think this can ever happen. 

Per your own argument it should be true in the trace_preempt_off()
tracepoint from nmi_enter():

  <idle>
    // rcu_is_watching() := false
    <NMI>
      nmi_enter()
        preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET)
	  __preempt_count_add()
	  // in_nmi() := true
	  preempt_latency_start()
	    // .oO -- we'll never hit this tracepoint because idle has
	    // preempt_count() == 1, so we'll have:
	    //   preempt_count() != val

	    // .oO-2 we should be able to this this when the NMI
	    // hits userspace and we have NOHZ_FULL on.
	rcu_nmi_enter() // function tracer


But the point is, if we ever do hit it, rcu_nmi_enter() is the right
thing to call when '!rcu_is_watching() && in_nmi()', because, as per the
rcu_nmi_enter() comments, that function fully supports nested NMIs.

How about something like so? And then you get to use the same in
__trace_stack() or something, and anywhere else you're doing this dance.

---

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index da0af631ded5..e987236abf95 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -89,4 +89,52 @@ extern void irq_exit(void);
 		arch_nmi_exit();				\
 	} while (0)
 
+/*
+ * Tracing vs rcu_is_watching()
+ * ----------------------------
+ *
+ * tracepoints and function-tracing can happen when RCU isn't watching (idle,
+ * or early IRQ/NMI entry).
+ *
+ * When it happens during idle or early during IRQ entry, tracing will have
+ * to inform RCU that it ought to pay attention, this is done by calling
+ * rcu_irq_enter_irqon().
+ *
+ * On NMI entry, we must be very careful that tracing only happens after we've
+ * incremented preempt_count(), otherwise we cannot tell we're in NMI and take
+ * the special path.
+ */
+
+#define __TR_IRQ	1
+#define __TR_NMI	2
+
+#define trace_rcu_enter()					\
+({								\
+	unsigned long state = 0;				\
+	if (!rcu_is_watching())	{				\
+		if (in_nmi()) {					\
+			state = __TR_NMI;			\
+			rcu_nmi_enter();			\
+		} else {					\
+			state = __TR_IRQ;			\
+			rcu_irq_enter_irqson();			\
+		}						\
+	}							\
+	state;							\
+})
+
+#define trace_rcu_exit(state)					\
+do {								\
+	switch (state) {					\
+	case __TR_IRQ:						\
+		rcu_irq_exit_irqson();				\
+		break;						\
+	case __IRQ_NMI:						\
+		rcu_nmi_exit();					\
+		break;						\
+	default:						\
+		break;						\
+	}							\
+} while (0)
+
 #endif /* LINUX_HARDIRQ_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e453589da97c..8f34592a1355 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 {
 	struct perf_sample_data data;
 	struct perf_event *event;
+	unsigned long rcu_flags;
 
 	struct perf_raw_record raw = {
 		.frag = {
@@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	perf_sample_data_init(&data, 0, 0);
 	data.raw = &raw;
 
+	rcu_flags = trace_rcu_enter();
+
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
@@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	}
 
 	perf_swevent_put_recursion_context(rctx);
+
+	trace_rcu_exit(rcu_flags);
 }
 EXPORT_SYMBOL_GPL(perf_tp_event);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 45f79bcc3146..62f87807bbe6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3781,7 +3781,7 @@ static inline void preempt_latency_start(int val)
 	}
 }
 
-void preempt_count_add(int val)
+void notrace preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -3813,7 +3813,7 @@ static inline void preempt_latency_stop(int val)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }
 
-void preempt_count_sub(int val)
+void notrace preempt_count_sub(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
