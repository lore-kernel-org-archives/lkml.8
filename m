Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2420C20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGBV7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGBV6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C04F521527;
        Thu,  2 Jul 2020 21:58:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E1-004Bkb-Qs; Thu, 02 Jul 2020 17:58:33 -0400
Message-ID: <20200702215833.709172905@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [for-next][PATCH 15/18] ring-buffer: Consolidate add_timestamp to remove some branches
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Reorganize a little the logic to handle adding the absolute time stamp,
extended and forced time stamps, in such a way to remove a branch or two.
This is just a micro optimization.

Also add before and after time stamps to the rb_event_info structure to
display those values in the rb_check_timestamps() code, if something were to
go wrong.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 139 +++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 66 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 888bc9177937..ce125cbe98a5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -416,6 +416,8 @@ struct rb_irq_work {
 struct rb_event_info {
 	u64			ts;
 	u64			delta;
+	u64			before;
+	u64			after;
 	unsigned long		length;
 	struct buffer_page	*tail_page;
 	int			add_timestamp;
@@ -2619,6 +2621,33 @@ rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 static inline bool rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
 				     struct ring_buffer_event *event);
 
+#ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
+static inline bool sched_clock_stable(void)
+{
+	return true;
+}
+#endif
+
+static noinline void
+rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
+		   struct rb_event_info *info)
+{
+	u64 write_stamp;
+
+	WARN_ONCE(info->delta > (1ULL << 59),
+		  KERN_WARNING "Delta way too big! %llu ts=%llu before=%llu after=%llu write stamp=%llu\n%s",
+		  (unsigned long long)info->delta,
+		  (unsigned long long)info->ts,
+		  (unsigned long long)info->before,
+		  (unsigned long long)info->after,
+		  (unsigned long long)(rb_time_read(&cpu_buffer->write_stamp, &write_stamp) ? write_stamp : 0),
+		  sched_clock_stable() ? "" :
+		  "If you just came from a suspend/resume,\n"
+		  "please switch to the trace global clock:\n"
+		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
+		  "or add trace_clock=global to the kernel command line\n");
+}
+
 /**
  * rb_update_event - update event type and data
  * @cpu_buffer: The per cpu buffer of the @event
@@ -2646,6 +2675,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 		bool abs = info->add_timestamp &
 			(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
 
+		rb_check_timestamp(cpu_buffer, info);
 		event = rb_add_time_stamp(event, abs ? info->delta : delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
 		delta = 0;
@@ -2692,13 +2722,6 @@ static unsigned rb_calculate_event_length(unsigned length)
 	return length;
 }
 
-#ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
-static inline bool sched_clock_stable(void)
-{
-	return true;
-}
-#endif
-
 static __always_inline bool
 rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
 		   struct ring_buffer_event *event)
@@ -3092,24 +3115,6 @@ int ring_buffer_unlock_commit(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
 
-static noinline void
-rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
-		   struct rb_event_info *info)
-{
-	u64 write_stamp;
-
-	WARN_ONCE(info->delta > (1ULL << 59),
-		  KERN_WARNING "Delta way too big! %llu ts=%llu write stamp = %llu\n%s",
-		  (unsigned long long)info->delta,
-		  (unsigned long long)info->ts,
-		  (unsigned long long)(rb_time_read(&cpu_buffer->write_stamp, &write_stamp) ? write_stamp : 0),
-		  sched_clock_stable() ? "" :
-		  "If you just came from a suspend/resume,\n"
-		  "please switch to the trace global clock:\n"
-		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
-		  "or add trace_clock=global to the kernel command line\n");
-}
-
 static struct ring_buffer_event *
 __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct rb_event_info *info)
@@ -3117,7 +3122,6 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	struct ring_buffer_event *event;
 	struct buffer_page *tail_page;
 	unsigned long tail, write, w;
-	u64 before, after;
 	bool a_ok;
 	bool b_ok;
 
@@ -3126,40 +3130,31 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
  /*A*/	w = local_read(&tail_page->write) & RB_WRITE_MASK;
 	barrier();
-	b_ok = rb_time_read(&cpu_buffer->before_stamp, &before);
-	a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
+	b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
+	a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
 	barrier();
 	info->ts = rb_time_stamp(cpu_buffer->buffer);
 
-	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
+	if ((info->add_timestamp & RB_ADD_STAMP_ABSOLUTE)) {
 		info->delta = info->ts;
-		info->add_timestamp = RB_ADD_STAMP_ABSOLUTE;
 	} else {
-		info->delta = info->ts - after;
-	}
-
-	if (likely(a_ok && b_ok)) {
-		if (unlikely(test_time_stamp(info->delta))) {
-			rb_check_timestamp(cpu_buffer, info);
-			info->add_timestamp |= RB_ADD_STAMP_EXTEND;
+		/*
+		 * If interrupting an event time update, we may need an
+		 * absolute timestamp.
+		 * Don't bother if this is the start of a new page (w == 0).
+		 */
+		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
+			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
+			info->length += RB_LEN_TIME_EXTEND;
+		} else {
+			info->delta = info->ts - info->after;
+			if (unlikely(test_time_stamp(info->delta))) {
+				info->add_timestamp |= RB_ADD_STAMP_EXTEND;
+				info->length += RB_LEN_TIME_EXTEND;
+			}
 		}
 	}
 
-	/*
-	 * If interrupting an event time update, we may need an absolute timestamp.
-	 * Don't bother if this is the start of a new page (w == 0).
-	 */
-	if (unlikely(!a_ok || !b_ok || (before != after && w)))
-		info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
-
-	/*
-	 * If the time delta since the last event is too big to
-	 * hold in the time field of the event, then we append a
-	 * TIME EXTEND event ahead of the data event.
-	 */
-	if (unlikely(info->add_timestamp))
-		info->length += RB_LEN_TIME_EXTEND;
-
  /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);
 
  /*C*/	write = local_add_return(info->length, &tail_page->write);
@@ -3173,10 +3168,11 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	if (unlikely(write > BUF_PAGE_SIZE)) {
 		if (tail != w) {
 			/* before and after may now different, fix it up*/
-			b_ok = rb_time_read(&cpu_buffer->before_stamp, &before);
-			a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
-			if (a_ok && b_ok && before != after)
-				(void)rb_time_cmpxchg(&cpu_buffer->before_stamp, before, after);
+			b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
+			a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
+			if (a_ok && b_ok && info->before != info->after)
+				(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
+						      info->before, info->after);
 		}
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
@@ -3193,7 +3189,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		if (likely(!(info->add_timestamp &
 			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
-			info->delta = info->ts - after;
+			info->delta = info->ts - info->after;
 		else
 			/* Just use full timestamp for inerrupting event */
 			info->delta = info->ts;
@@ -3201,31 +3197,33 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		if (unlikely(info->ts != save_before)) {
 			/* SLOW PATH - Interrupted between C and E */
 
-			a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
+			a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
 			RB_WARN_ON(cpu_buffer, !a_ok);
 
 			/* Write stamp must only go forward */
-			if (save_before > after) {
+			if (save_before > info->after) {
 				/*
 				 * We do not care about the result, only that
 				 * it gets updated atomically.
 				 */
-				(void)rb_time_cmpxchg(&cpu_buffer->write_stamp, after, save_before);
+				(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
+						      info->after, save_before);
 			}
 		}
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
+		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
 		/* Was interrupted before here, write_stamp must be valid */
 		RB_WARN_ON(cpu_buffer, !a_ok);
 		ts = rb_time_stamp(cpu_buffer->buffer);
 		barrier();
  /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-		    after < ts) {
+		    info->after < ts) {
 			/* Nothing came after this event between C and E */
-			info->delta = ts - after;
-			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp, after, info->ts);
+			info->delta = ts - info->after;
+			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
+					      info->after, info->ts);
 			info->ts = ts;
 		} else {
 			/*
@@ -3277,6 +3275,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	struct rb_event_info info;
 	int nr_loops = 0;
+	int add_ts_default;
 
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
@@ -3297,8 +3296,16 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 #endif
 
 	info.length = rb_calculate_event_length(length);
+
+	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
+		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
+		info.length += RB_LEN_TIME_EXTEND;
+	} else {
+		add_ts_default = RB_ADD_STAMP_NONE;
+	}
+
  again:
-	info.add_timestamp = RB_ADD_STAMP_NONE;
+	info.add_timestamp = add_ts_default;
 	info.delta = 0;
 
 	/*
@@ -3316,7 +3323,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	event = __rb_reserve_next(cpu_buffer, &info);
 
 	if (unlikely(PTR_ERR(event) == -EAGAIN)) {
-		if (info.add_timestamp)
+		if (info.add_timestamp & (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND))
 			info.length -= RB_LEN_TIME_EXTEND;
 		goto again;
 	}
-- 
2.26.2


