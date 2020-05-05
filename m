Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D9C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958302083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgEEOOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729266AbgEEOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE6DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKZ-0000mL-DX; Tue, 05 May 2020 16:13:55 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D0D251001F5;
        Tue,  5 May 2020 16:13:54 +0200 (CEST)
Message-Id: <20200505134101.340485295@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:35 +0200
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
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 33/36] x86,tracing: Robustify ftrace_nmi_enter()
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

From: Peter Zijlstra <peterz@infradead.org>

  ftrace_nmi_enter()
     trace_hwlat_callback()
       trace_clock_local()
         sched_clock()
           paravirt_sched_clock()
           native_sched_clock()

All must not be traced or kprobed, it will be called from do_debug()
before the kprobe handler.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/paravirt.h |    2 +-
 arch/x86/kernel/tsc.c           |    4 ++--
 include/linux/ftrace_irq.h      |    4 ++--
 kernel/trace/trace_clock.c      |    3 ++-
 kernel/trace/trace_hwlat.c      |    2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,7 +17,7 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
-static inline unsigned long long paravirt_sched_clock(void)
+static __always_inline unsigned long long paravirt_sched_clock(void)
 {
 	return PVOP_CALL0(unsigned long long, time.sched_clock);
 }
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -207,7 +207,7 @@ static void __init cyc2ns_init_secondary
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
-u64 native_sched_clock(void)
+noinstr u64 native_sched_clock(void)
 {
 	if (static_branch_likely(&__use_tsc)) {
 		u64 tsc_now = rdtsc();
@@ -240,7 +240,7 @@ u64 native_sched_clock_from_tsc(u64 tsc)
 /* We need to define a real function for sched_clock, to override the
    weak default version */
 #ifdef CONFIG_PARAVIRT
-unsigned long long sched_clock(void)
+noinstr unsigned long long sched_clock(void)
 {
 	return paravirt_sched_clock();
 }
--- a/include/linux/ftrace_irq.h
+++ b/include/linux/ftrace_irq.h
@@ -7,7 +7,7 @@ extern bool trace_hwlat_callback_enabled
 extern void trace_hwlat_callback(bool enter);
 #endif
 
-static inline void ftrace_nmi_enter(void)
+static __always_inline void ftrace_nmi_enter(void)
 {
 #ifdef CONFIG_HWLAT_TRACER
 	if (trace_hwlat_callback_enabled)
@@ -15,7 +15,7 @@ static inline void ftrace_nmi_enter(void
 #endif
 }
 
-static inline void ftrace_nmi_exit(void)
+static __always_inline void ftrace_nmi_exit(void)
 {
 #ifdef CONFIG_HWLAT_TRACER
 	if (trace_hwlat_callback_enabled)
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -22,6 +22,7 @@
 #include <linux/sched/clock.h>
 #include <linux/ktime.h>
 #include <linux/trace_clock.h>
+#include <linux/kprobes.h>
 
 /*
  * trace_clock_local(): the simplest and least coherent tracing clock.
@@ -29,7 +30,7 @@
  * Useful for tracing that does not cross to other CPUs nor
  * does it go through idle events.
  */
-u64 notrace trace_clock_local(void)
+u64 noinstr trace_clock_local(void)
 {
 	u64 clock;
 
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -139,7 +139,7 @@ static void trace_hwlat_sample(struct hw
 #define init_time(a, b)	(a = b)
 #define time_u64(a)	a
 
-void trace_hwlat_callback(bool enter)
+noinstr void trace_hwlat_callback(bool enter)
 {
 	if (smp_processor_id() != nmi_cpu)
 		return;

