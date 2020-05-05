Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768E8C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE562085B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgEEOOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729475AbgEEON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA2C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:58 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKL-0000aY-MG; Tue, 05 May 2020 16:13:41 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 33338FFC8D;
        Tue,  5 May 2020 16:13:41 +0200 (CEST)
Message-Id: <20200505134100.270771162@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 1 22/36] tracing: Provide lockdep less
 trace_hardirqs_on/off() variants
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_hardirqs_on/off() is only partially safe vs. RCU idle. The tracer
core itself is safe, but the resulting tracepoints can be utilized by
e.g. BPF which is unsafe.

Provide variants which do not contain the lockdep invocation so the lockdep
and tracer invocations can be split at the call site and placed properly.

The new variants also do not use rcuidle as they are going to be called
from entry code after/before context tracking.

Name them so they match the lockdep counterparts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Renamed to trace_hardirqs_on/off_prepare().
V2: New patch
---
 include/linux/irqflags.h        |    4 ++++
 kernel/trace/trace_preemptirq.c |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -29,6 +29,8 @@
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+  extern void trace_hardirqs_on_prepare(void);
+  extern void trace_hardirqs_off_prepare(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
 # define lockdep_hardirq_context(p)	((p)->hardirq_context)
@@ -96,6 +98,8 @@ do {						\
 	  } while (0)
 
 #else
+# define trace_hardirqs_on_prepare()		do { } while (0)
+# define trace_hardirqs_off_prepare()		do { } while (0)
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
 # define lockdep_hardirq_context(p)	0
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -19,6 +19,24 @@
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
+/*
+ * Like trace_hardirqs_on() but without the lockdep invocation. This is
+ * used in the low level entry code where the ordering vs. RCU is important
+ * and lockdep uses a staged approach which splits the lockdep hardirq
+ * tracking into a RCU on and a RCU off section.
+ */
+void trace_hardirqs_on_prepare(void)
+{
+	if (this_cpu_read(tracing_irq_cpu)) {
+		if (!in_nmi())
+			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
+}
+EXPORT_SYMBOL(trace_hardirqs_on_prepare);
+NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
+
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
@@ -33,6 +51,25 @@ void trace_hardirqs_on(void)
 EXPORT_SYMBOL(trace_hardirqs_on);
 NOKPROBE_SYMBOL(trace_hardirqs_on);
 
+/*
+ * Like trace_hardirqs_off() but without the lockdep invocation. This is
+ * used in the low level entry code where the ordering vs. RCU is important
+ * and lockdep uses a staged approach which splits the lockdep hardirq
+ * tracking into a RCU on and a RCU off section.
+ */
+void trace_hardirqs_off_prepare(void)
+{
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
+		if (!in_nmi())
+			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+	}
+
+}
+EXPORT_SYMBOL(trace_hardirqs_off_prepare);
+NOKPROBE_SYMBOL(trace_hardirqs_off_prepare);
+
 void trace_hardirqs_off(void)
 {
 	if (!this_cpu_read(tracing_irq_cpu)) {

