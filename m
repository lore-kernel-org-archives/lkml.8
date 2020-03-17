Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F5BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAB420754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCQVzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgCQVzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:55:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EC8020752;
        Tue, 17 Mar 2020 21:55:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jEKB6-000Etl-K0; Tue, 17 Mar 2020 17:55:12 -0400
Message-Id: <20200317215512.503132827@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 17:54:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 1/5] tracing: Have hwlat ts be first instance and record count of
 instances
References: <20200317215455.885042360@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The hwlat tracer runs a loop of width time during a given window. It then
reports the max latency over a given threshold and records a timestamp. But
this timestamp is the time after the width has finished, and not the time it
actually triggered.

Record the actual time when the latency was greater than the threshold as
well as the number of times it was greater in a given width per window.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 32 ++++++++++++++++++++++----------
 kernel/trace/trace_entries.h   |  4 +++-
 kernel/trace/trace_hwlat.c     | 24 +++++++++++++++++-------
 kernel/trace/trace_output.c    |  4 ++--
 4 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index ff658e27d25b..99a0890e20ec 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2126,6 +2126,8 @@ periodically make a CPU constantly busy with interrupts disabled.
   # cat trace
   # tracer: hwlat
   #
+  # entries-in-buffer/entries-written: 13/13   #P:8
+  #
   #                              _-----=> irqs-off
   #                             / _----=> need-resched
   #                            | / _---=> hardirq/softirq
@@ -2133,12 +2135,18 @@ periodically make a CPU constantly busy with interrupts disabled.
   #                            ||| /     delay
   #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
   #              | |       |   ||||       |         |
-             <...>-3638  [001] d... 19452.055471: #1     inner/outer(us):   12/14    ts:1499801089.066141940
-             <...>-3638  [003] d... 19454.071354: #2     inner/outer(us):   11/9     ts:1499801091.082164365
-             <...>-3638  [002] dn.. 19461.126852: #3     inner/outer(us):   12/9     ts:1499801098.138150062
-             <...>-3638  [001] d... 19488.340960: #4     inner/outer(us):    8/12    ts:1499801125.354139633
-             <...>-3638  [003] d... 19494.388553: #5     inner/outer(us):    8/12    ts:1499801131.402150961
-             <...>-3638  [003] d... 19501.283419: #6     inner/outer(us):    0/12    ts:1499801138.297435289 nmi-total:4 nmi-count:1
+             <...>-1729  [001] d...   678.473449: #1     inner/outer(us):   11/12    ts:1581527483.343962693 count:6
+             <...>-1729  [004] d...   689.556542: #2     inner/outer(us):   16/9     ts:1581527494.889008092 count:1
+             <...>-1729  [005] d...   714.756290: #3     inner/outer(us):   16/16    ts:1581527519.678961629 count:5
+             <...>-1729  [001] d...   718.788247: #4     inner/outer(us):    9/17    ts:1581527523.889012713 count:1
+             <...>-1729  [002] d...   719.796341: #5     inner/outer(us):   13/9     ts:1581527524.912872606 count:1
+             <...>-1729  [006] d...   844.787091: #6     inner/outer(us):    9/12    ts:1581527649.889048502 count:2
+             <...>-1729  [003] d...   849.827033: #7     inner/outer(us):   18/9     ts:1581527654.889013793 count:1
+             <...>-1729  [007] d...   853.859002: #8     inner/outer(us):    9/12    ts:1581527658.889065736 count:1
+             <...>-1729  [001] d...   855.874978: #9     inner/outer(us):    9/11    ts:1581527660.861991877 count:1
+             <...>-1729  [001] d...   863.938932: #10    inner/outer(us):    9/11    ts:1581527668.970010500 count:1 nmi-total:7 nmi-count:1
+             <...>-1729  [007] d...   878.050780: #11    inner/outer(us):    9/12    ts:1581527683.385002600 count:1 nmi-total:5 nmi-count:1
+             <...>-1729  [007] d...   886.114702: #12    inner/outer(us):    9/12    ts:1581527691.385001600 count:1
 
 
 The above output is somewhat the same in the header. All events will have
@@ -2148,7 +2156,7 @@ interrupts disabled 'd'. Under the FUNCTION title there is:
 	This is the count of events recorded that were greater than the
 	tracing_threshold (See below).
 
- inner/outer(us):   12/14
+ inner/outer(us):   11/11
 
       This shows two numbers as "inner latency" and "outer latency". The test
       runs in a loop checking a timestamp twice. The latency detected within
@@ -2156,11 +2164,15 @@ interrupts disabled 'd'. Under the FUNCTION title there is:
       after the previous timestamp and the next timestamp in the loop is
       the "outer latency".
 
- ts:1499801089.066141940
+ ts:1581527483.343962693
+
+      The absolute timestamp that the first latency was recorded in the window.
+
+ count:6
 
-      The absolute timestamp that the event happened.
+      The number of times a latency was detected during the window.
 
- nmi-total:4 nmi-count:1
+ nmi-total:7 nmi-count:1
 
       On architectures that support it, if an NMI comes in during the
       test, the time spent in NMI is reported in "nmi-total" (in
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index f22746f3c132..a523da0dae0a 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -325,14 +325,16 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		__field_desc(	long,	timestamp,	tv_nsec		)
 		__field(	unsigned int,		nmi_count	)
 		__field(	unsigned int,		seqnum		)
+		__field(	unsigned int,		count		)
 	),
 
-	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llu\tnmi-ts:%llu\tnmi-count:%u\n",
+	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llu\tcount:%d\tnmi-ts:%llu\tnmi-count:%u\n",
 		 __entry->seqnum,
 		 __entry->tv_sec,
 		 __entry->tv_nsec,
 		 __entry->duration,
 		 __entry->outer_duration,
+		 __entry->count,
 		 __entry->nmi_total_ts,
 		 __entry->nmi_count)
 );
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index a48808c43249..e2be7bb7ef7e 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -83,6 +83,7 @@ struct hwlat_sample {
 	u64			nmi_total_ts;	/* Total time spent in NMIs */
 	struct timespec64	timestamp;	/* wall time */
 	int			nmi_count;	/* # NMIs during this sample */
+	int			count;		/* # of iteratons over threash */
 };
 
 /* keep the global state somewhere. */
@@ -124,6 +125,7 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
 	entry->timestamp		= sample->timestamp;
 	entry->nmi_total_ts		= sample->nmi_total_ts;
 	entry->nmi_count		= sample->nmi_count;
+	entry->count			= sample->count;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		trace_buffer_unlock_commit_nostack(buffer, event);
@@ -167,12 +169,14 @@ void trace_hwlat_callback(bool enter)
 static int get_sample(void)
 {
 	struct trace_array *tr = hwlat_trace;
+	struct hwlat_sample s;
 	time_type start, t1, t2, last_t2;
-	s64 diff, total, last_total = 0;
+	s64 diff, outer_diff, total, last_total = 0;
 	u64 sample = 0;
 	u64 thresh = tracing_thresh;
 	u64 outer_sample = 0;
 	int ret = -1;
+	unsigned int count = 0;
 
 	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
 
@@ -186,6 +190,7 @@ static int get_sample(void)
 
 	init_time(last_t2, 0);
 	start = time_get(); /* start timestamp */
+	outer_diff = 0;
 
 	do {
 
@@ -194,14 +199,14 @@ static int get_sample(void)
 
 		if (time_u64(last_t2)) {
 			/* Check the delta from outer loop (t2 to next t1) */
-			diff = time_to_us(time_sub(t1, last_t2));
+			outer_diff = time_to_us(time_sub(t1, last_t2));
 			/* This shouldn't happen */
-			if (diff < 0) {
+			if (outer_diff < 0) {
 				pr_err(BANNER "time running backwards\n");
 				goto out;
 			}
-			if (diff > outer_sample)
-				outer_sample = diff;
+			if (outer_diff > outer_sample)
+				outer_sample = outer_diff;
 		}
 		last_t2 = t2;
 
@@ -217,6 +222,12 @@ static int get_sample(void)
 		/* This checks the inner loop (t1 to t2) */
 		diff = time_to_us(time_sub(t2, t1));     /* current diff */
 
+		if (diff > thresh || outer_diff > thresh) {
+			if (!count)
+				ktime_get_real_ts64(&s.timestamp);
+			count++;
+		}
+
 		/* This shouldn't happen */
 		if (diff < 0) {
 			pr_err(BANNER "time running backwards\n");
@@ -236,7 +247,6 @@ static int get_sample(void)
 
 	/* If we exceed the threshold value, we have found a hardware latency */
 	if (sample > thresh || outer_sample > thresh) {
-		struct hwlat_sample s;
 		u64 latency;
 
 		ret = 1;
@@ -249,9 +259,9 @@ static int get_sample(void)
 		s.seqnum = hwlat_data.count;
 		s.duration = sample;
 		s.outer_duration = outer_sample;
-		ktime_get_real_ts64(&s.timestamp);
 		s.nmi_total_ts = nmi_total_ts;
 		s.nmi_count = nmi_count;
+		s.count = count;
 		trace_hwlat_sample(&s);
 
 		latency = max(sample, outer_sample);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b4909082f6a4..e25a7da79c6b 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1158,12 +1158,12 @@ trace_hwlat_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, entry);
 
-	trace_seq_printf(s, "#%-5u inner/outer(us): %4llu/%-5llu ts:%lld.%09ld",
+	trace_seq_printf(s, "#%-5u inner/outer(us): %4llu/%-5llu ts:%lld.%09ld count:%d",
 			 field->seqnum,
 			 field->duration,
 			 field->outer_duration,
 			 (long long)field->timestamp.tv_sec,
-			 field->timestamp.tv_nsec);
+			 field->timestamp.tv_nsec, field->count);
 
 	if (field->nmi_count) {
 		/*
-- 
2.25.1


