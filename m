Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6240C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877ED207C4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEPAKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbgEPAKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67965C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:38 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkP2-00022I-Iw; Sat, 16 May 2020 02:10:08 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 13D39100605;
        Sat, 16 May 2020 02:10:08 +0200 (CEST)
Message-Id: <20200515235124.466962628@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:45:48 +0200
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V6 01/37] tracing/hwlat: Use ktime_get_mono_fast_ns()
References: <20200515234547.710474468@linutronix.de>
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

Timestamping in the hardware latency detector uses sched_clock() underneath
and depends on CONFIG_GENERIC_SCHED_CLOCK=n because sched clocks from that
subsystem are not NMI safe.

ktime_get_mono_fast_ns() is NMI safe and available on all architectures.

Replace the time getter, get rid of the CONFIG_GENERIC_SCHED_CLOCK=n
dependency and cleanup the horrible macro maze which encapsulates u64 math
in u64 macros.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/trace/trace_hwlat.c |   59 +++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -131,29 +131,19 @@ static void trace_hwlat_sample(struct hw
 		trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
-/* Macros to encapsulate the time capturing infrastructure */
-#define time_type	u64
-#define time_get()	trace_clock_local()
-#define time_to_us(x)	div_u64(x, 1000)
-#define time_sub(a, b)	((a) - (b))
-#define init_time(a, b)	(a = b)
-#define time_u64(a)	a
-
+/*
+ * Timestamping uses ktime_get_mono_fast(), the NMI safe access to
+ * CLOCK_MONOTONIC.
+ */
 void trace_hwlat_callback(bool enter)
 {
 	if (smp_processor_id() != nmi_cpu)
 		return;
 
-	/*
-	 * Currently trace_clock_local() calls sched_clock() and the
-	 * generic version is not NMI safe.
-	 */
-	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
-		if (enter)
-			nmi_ts_start = time_get();
-		else
-			nmi_total_ts += time_get() - nmi_ts_start;
-	}
+	if (enter)
+		nmi_ts_start = ktime_get_mono_fast_ns();
+	else
+		nmi_total_ts += ktime_get_mono_fast_ns() - nmi_ts_start;
 
 	if (enter)
 		nmi_count++;
@@ -165,20 +155,22 @@ void trace_hwlat_callback(bool enter)
  * Used to repeatedly capture the CPU TSC (or similar), looking for potential
  * hardware-induced latency. Called with interrupts disabled and with
  * hwlat_data.lock held.
+ *
+ * Use ktime_get_mono_fast() here as well because it does not wait on the
+ * timekeeping seqcount like ktime_get_mono().
  */
 static int get_sample(void)
 {
 	struct trace_array *tr = hwlat_trace;
 	struct hwlat_sample s;
-	time_type start, t1, t2, last_t2;
+	u64 start, t1, t2, last_t2, thresh;
 	s64 diff, outer_diff, total, last_total = 0;
 	u64 sample = 0;
-	u64 thresh = tracing_thresh;
 	u64 outer_sample = 0;
 	int ret = -1;
 	unsigned int count = 0;
 
-	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
+	thresh = div_u64(tracing_thresh, NSEC_PER_USEC);
 
 	nmi_cpu = smp_processor_id();
 	nmi_total_ts = 0;
@@ -188,18 +180,20 @@ static int get_sample(void)
 
 	trace_hwlat_callback_enabled = true;
 
-	init_time(last_t2, 0);
-	start = time_get(); /* start timestamp */
+	/* start timestamp */
+	start = ktime_get_mono_fast_ns();
 	outer_diff = 0;
+	last_t2 = 0;
 
 	do {
 
-		t1 = time_get();	/* we'll look for a discontinuity */
-		t2 = time_get();
+		/* we'll look for a discontinuity */
+		t1 = ktime_get_mono_fast_ns();
+		t2 = ktime_get_mono_fast_ns();
 
-		if (time_u64(last_t2)) {
+		if (last_t2) {
 			/* Check the delta from outer loop (t2 to next t1) */
-			outer_diff = time_to_us(time_sub(t1, last_t2));
+			outer_diff = div_u64(t1 - last_t2, NSEC_PER_USEC);
 			/* This shouldn't happen */
 			if (outer_diff < 0) {
 				pr_err(BANNER "time running backwards\n");
@@ -210,7 +204,8 @@ static int get_sample(void)
 		}
 		last_t2 = t2;
 
-		total = time_to_us(time_sub(t2, start)); /* sample width */
+		/* sample width */
+		total = div_u64(t2 - start, NSEC_PER_USEC);
 
 		/* Check for possible overflows */
 		if (total < last_total) {
@@ -220,7 +215,7 @@ static int get_sample(void)
 		last_total = total;
 
 		/* This checks the inner loop (t1 to t2) */
-		diff = time_to_us(time_sub(t2, t1));     /* current diff */
+		diff = div_u64(t2 - t1, NSEC_PER_USEC);
 
 		if (diff > thresh || outer_diff > thresh) {
 			if (!count)
@@ -251,15 +246,11 @@ static int get_sample(void)
 
 		ret = 1;
 
-		/* We read in microseconds */
-		if (nmi_total_ts)
-			do_div(nmi_total_ts, NSEC_PER_USEC);
-
 		hwlat_data.count++;
 		s.seqnum = hwlat_data.count;
 		s.duration = sample;
 		s.outer_duration = outer_sample;
-		s.nmi_total_ts = nmi_total_ts;
+		s.nmi_total_ts = div_u64(nmi_total_ts, NSEC_PER_USEC);
 		s.nmi_count = nmi_count;
 		s.count = count;
 		trace_hwlat_sample(&s);

