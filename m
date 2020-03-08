Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E26C18E5A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5E5208CD
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgCHXX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:23:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57236 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgCHXXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:54 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gh-00035J-Rn; Mon, 09 Mar 2020 00:23:37 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C108B1040AA;
        Mon,  9 Mar 2020 00:23:29 +0100 (CET)
Message-Id: <20200308222609.731890049@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:07 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 08/13] tracing: Provide lockdep less trace_hardirqs_on/off() variants
References: <20200308222359.370649591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 include/linux/irqflags.h        |    4 ++++
 kernel/trace/trace_preemptirq.c |   23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -29,6 +29,8 @@
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+  extern void __trace_hardirqs_on(void);
+  extern void __trace_hardirqs_off(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
 # define trace_hardirq_context(p)	((p)->hardirq_context)
@@ -52,6 +54,8 @@ do {						\
 	current->softirq_context--;		\
 } while (0)
 #else
+# define __trace_hardirqs_on()		do { } while (0)
+# define __trace_hardirqs_off()		do { } while (0)
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
 # define trace_hardirq_context(p)	0
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -19,6 +19,17 @@
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
+void __trace_hardirqs_on(void)
+{
+	if (this_cpu_read(tracing_irq_cpu)) {
+		if (!in_nmi())
+			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
+}
+NOKPROBE_SYMBOL(__trace_hardirqs_on);
+
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
@@ -33,6 +44,18 @@ void trace_hardirqs_on(void)
 EXPORT_SYMBOL(trace_hardirqs_on);
 NOKPROBE_SYMBOL(trace_hardirqs_on);
 
+void __trace_hardirqs_off(void)
+{
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
+		if (!in_nmi())
+			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+	}
+
+}
+NOKPROBE_SYMBOL(__trace_hardirqs_off);
+
 void trace_hardirqs_off(void)
 {
 	if (!this_cpu_read(tracing_irq_cpu)) {

