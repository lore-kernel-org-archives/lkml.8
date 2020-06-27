Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA60C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F423A208B6
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgF0BN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 21:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgF0BNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 21:13:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D292137B;
        Sat, 27 Jun 2020 01:13:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jozPi-003zY7-36; Fri, 26 Jun 2020 21:13:50 -0400
Message-ID: <20200627011349.968148275@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Jun 2020 21:00:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        bristot <bristot@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Subject: [PATCH 3/3] ring-buffer: Add rb_time_t 64 bit operations for speeding up 32 bit
References: <20200627010041.517736087@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

After a discussion with the new time algorithm to have nested events still
have proper time keeping but required using local64_t atomic operations.
Mathieu was concerned about the performance this would have on 32 bit
machines, as in most cases, atomic 64 bit operations on them can be
expensive.

As the ring buffer's timing needs do not require full features of local64_t,
a wrapper is made to implement a new rb_time_t operation that uses two longs
on 32 bit machines but still uses the local64_t operations on 64 bit
machines. There's a switch that can be made in the file to force 64 bit to
use the 32 bit version just for testing purposes.

All reads do not need to succeed if a read happened while the stamp being
read is in the process of being updated. The requirement is that all reads
must succed that were done by an interrupting event (where this event was
interrupted by another event that did the write). Or if the event itself did
the write first. That is: rb_time_set(t, x) followed by rb_time_read(t) will
always succeed (even if it gets interrupted by another event that writes to
t. The result of the read will be either the previous set, or a set
performed by an interrupting event.

If the read is done by an event that interrupted another event that was in
the process of setting the time stamp, and no other event came along to
write to that time stamp, it will fail and the rb_time_read() will return
that it failed (the value to read will be undefined).

A set will always write to the time stamp and return with a valid time
stamp, such that any read after it will be valid.

A cmpxchg may fail if it interrupted an event that was in the process of
updating the time stamp just like the reads do. Other than that, it will act
like a normal cmpxchg.

The way this works is that the rb_time_t is made of of three fields. A cnt,
that gets updated atomically everyting a modification is made. A top that
represents the most significant 30 bits of the time, and a bottom to
represent the least significant 30 bits of the time. Notice, that the time
values is only 60 bits long (where the ring buffer only uses 59 bits, which
gives us 18 years of nanoseconds!).

The top two bits of both the top and bottom is a 2 bit counter that gets set
by the value of the least two significant bits of the cnt. A read of the top
and the bottom where both the top and bottom have the same most significant
top 2 bits, are considered a match and a valid 60 bit number can be created
from it. If they do not match, then the number is considered invalid, and
this must only happen if an event interrupted another event in the midst of
updating the time stamp.

This is only used for 32 bits machines as 64 bit machines can get better
performance out of the local64_t. This has been tested heavily by forcing 64
bit to use this logic.

Link: https://lore.kernel.org/r/20200625225345.18cf5881@oasis.local.home

Inspired-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 260 +++++++++++++++++++++++++++++++++----
 1 file changed, 237 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 986ddc8eba93..c2c0d25ea004 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -449,6 +449,27 @@ enum {
 	RB_CTX_MAX
 };
 
+#if BITS_PER_LONG == 32
+#define RB_TIME_32
+#endif
+
+/* To test on 64 bit machines */
+//#define RB_TIME_32
+
+#ifdef RB_TIME_32
+
+struct rb_time_struct {
+	local_t		cnt;
+	local_t		top;
+	local_t		bottom;
+};
+#else
+struct rb_time_struct {
+	local64_t	time;
+};
+#endif
+typedef struct rb_time_struct rb_time_t;
+
 /*
  * head_page == tail_page && head == tail then buffer is empty.
  */
@@ -485,8 +506,8 @@ struct ring_buffer_per_cpu {
 	unsigned long			read;
 	unsigned long			read_bytes;
 	unsigned long			next_write;
-	local64_t			write_stamp;
-	local64_t			before_stamp;
+	rb_time_t			write_stamp;
+	rb_time_t			before_stamp;
 	u64				read_stamp;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
@@ -529,6 +550,189 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+#ifdef RB_TIME_32
+
+/*
+ * On 32 bit machines, local64_t is very expensive. As the ring
+ * buffer doesn't need all the features of a true 64 bit atomic,
+ * on 32 bit, it uses these functions (64 still uses local64_t).
+ *
+ * For the ring buffer, 64 bit required operations for the time is
+ * the following:
+ *
+ *  - Only need 59 bits (uses 60 to make it even).
+ *  - Reads may fail if it interrupted a modification of the time stamp.
+ *      It will succeed if it did not interrupt another write even if
+ *      the read itself is interrupted by a write.
+ *      It returns whether it was successful or not.
+ *
+ *  - Writes always succeed and will overwrite other writes and writes
+ *      that were done by events interrupting the current write.
+ *
+ *  - A write followed by a read of the same time stamp will always succeed,
+ *      but may not contain the same value.
+ *
+ *  - A cmpxchg will fail if it interrupted another write or cmpxchg.
+ *      Other than that, it acts like a normal cmpxchg.
+ *
+ * The 60 bit time stamp is broken up by 30 bits in a top and bottom half
+ *  (bottom being the least significant 30 bits of the 60 bit time stamp).
+ *
+ * The two most significant bits of each half holds a 2 bit counter (0-3).
+ * Each update will increment this counter by one.
+ * When reading the top and bottom, if the two counter bits match then the
+ *  top and bottom together make a valid 60 bit number.
+ */
+#define RB_TIME_SHIFT	30
+#define RB_TIME_VAL_MASK ((1 << RB_TIME_SHIFT) - 1)
+
+static inline int rb_time_cnt(unsigned long val)
+{
+	return (val >> RB_TIME_SHIFT) & 3;
+}
+
+static inline u64 rb_time_val(unsigned long top, unsigned long bottom)
+{
+	u64 val;
+
+	val = top & RB_TIME_VAL_MASK;
+	val <<= RB_TIME_SHIFT;
+	val |= bottom & RB_TIME_VAL_MASK;
+
+	return val;
+}
+
+static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
+{
+	unsigned long top, bottom;
+	unsigned long c;
+
+	/*
+	 * If the read is interrupted by a write, then the cnt will
+	 * be different. Loop until both top and bottom have been read
+	 * without interruption.
+	 */
+	do {
+		c = local_read(&t->cnt);
+		top = local_read(&t->top);
+		bottom = local_read(&t->bottom);
+	} while (c != local_read(&t->cnt));
+
+	*cnt = rb_time_cnt(top);
+
+	/* If top and bottom counts don't match, this interrupted a write */
+	if (*cnt != rb_time_cnt(bottom))
+		return false;
+
+	*ret = rb_time_val(top, bottom);
+	return true;
+}
+
+static bool rb_time_read(rb_time_t *t, u64 *ret)
+{
+	unsigned long cnt;
+
+	return __rb_time_read(t, ret, &cnt);
+}
+
+static inline unsigned long rb_time_val_cnt(unsigned long val, unsigned long cnt)
+{
+	return (val & RB_TIME_VAL_MASK) | ((cnt & 3) << RB_TIME_SHIFT);
+}
+
+static inline void rb_time_split(u64 val, unsigned long *top, unsigned long *bottom)
+{
+	*top = (unsigned long)((val >> RB_TIME_SHIFT) & RB_TIME_VAL_MASK);
+	*bottom = (unsigned long)(val & RB_TIME_VAL_MASK);
+}
+
+static inline void rb_time_val_set(local_t *t, unsigned long val, unsigned long cnt)
+{
+	val = rb_time_val_cnt(val, cnt);
+	local_set(t, val);
+}
+
+static void rb_time_set(rb_time_t *t, u64 val)
+{
+	unsigned long cnt, top, bottom;
+
+	rb_time_split(val, &top, &bottom);
+
+	/* Writes always succeed with a valid number even if it gets interrupted. */
+	do {
+		cnt = local_inc_return(&t->cnt);
+		rb_time_val_set(&t->top, top, cnt);
+		rb_time_val_set(&t->bottom, bottom, cnt);
+	} while (cnt != local_read(&t->cnt));
+}
+
+static inline bool
+rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
+{
+	unsigned long ret;
+
+	ret = local_cmpxchg(l, expect, set);
+	return ret == expect;
+}
+
+static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
+{
+	unsigned long cnt, top, bottom;
+	unsigned long cnt2, top2, bottom2;
+	u64 val;
+
+	/* The cmpxchg always fails if it interrupted an update */
+	 if (!__rb_time_read(t, &val, &cnt2))
+		 return false;
+
+	 if (val != expect)
+		 return false;
+
+	 cnt = local_read(&t->cnt);
+	 if ((cnt & 3) != cnt2)
+		 return false;
+
+	 cnt2 = cnt + 1;
+
+	 rb_time_split(val, &top, &bottom);
+	 top = rb_time_val_cnt(top, cnt);
+	 bottom = rb_time_val_cnt(bottom, cnt);
+
+	 rb_time_split(set, &top2, &bottom2);
+	 top2 = rb_time_val_cnt(top2, cnt2);
+	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
+
+	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
+		return false;
+	if (!rb_time_read_cmpxchg(&t->top, top, top2))
+		return false;
+	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
+		return false;
+	return true;
+}
+
+#else /* 64 bits */
+
+/* local64_t always succeeds */
+
+static inline bool rb_time_read(rb_time_t *t, u64 *ret)
+{
+	*ret = local64_read(&t->time);
+	return true;
+}
+static void rb_time_set(rb_time_t *t, u64 val)
+{
+	local64_set(&t->time, val);
+}
+
+static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
+{
+	u64 val;
+	val = local64_cmpxchg(&t->time, expect, set);
+	return val == expect;
+}
+#endif
+
 /**
  * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
@@ -2546,7 +2750,8 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 
 	delta = rb_time_delta(event);
 
-	write_stamp = local64_read(&cpu_buffer->write_stamp);
+	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
+		return 0;
 
 	/* Make sure the write stamp is read before testing the location */
 	barrier();
@@ -2555,11 +2760,10 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		unsigned long write_mask =
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
 		unsigned long event_length = rb_event_length(event);
-		u64 ret;
 
-		ret = local64_cmpxchg(&cpu_buffer->write_stamp, write_stamp, write_stamp - delta);
 		/* Something came in, can't discard */
-		if (ret != write_stamp)
+		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
+				       write_stamp, write_stamp - delta))
 			return 0;
 
 		/*
@@ -2890,11 +3094,13 @@ static noinline void
 rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		   struct rb_event_info *info)
 {
+	u64 write_stamp;
+
 	WARN_ONCE(info->delta > (1ULL << 59),
 		  KERN_WARNING "Delta way too big! %llu ts=%llu write stamp = %llu\n%s",
 		  (unsigned long long)info->delta,
 		  (unsigned long long)info->ts,
-		  (unsigned long long)local64_read(&cpu_buffer->write_stamp),
+		  (unsigned long long)(rb_time_read(&cpu_buffer->write_stamp, &write_stamp) ? write_stamp : 0),
 		  sched_clock_stable() ? "" :
 		  "If you just came from a suspend/resume,\n"
 		  "please switch to the trace global clock:\n"
@@ -2910,14 +3116,16 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *tail_page;
 	unsigned long tail, write, w, next;
 	u64 before, after;
+	bool a_ok;
+	bool b_ok;
 
 	/* Don't let the compiler play games with cpu_buffer->tail_page */
 	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
 
  /*A*/	w = local_read(&tail_page->write) & RB_WRITE_MASK;
 	barrier();
-	before = local64_read(&cpu_buffer->before_stamp);
-	after = local64_read(&cpu_buffer->write_stamp);
+	b_ok = rb_time_read(&cpu_buffer->before_stamp, &before);
+	a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
 	barrier();
 	info->ts = rb_time_stamp(cpu_buffer->buffer);
 
@@ -2937,7 +3145,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If interrupting an event time update, we may need an absolute timestamp.
 	 * Don't bother if this is the start of a new page (w == 0).
 	 */
-	if (unlikely(before != after && w))
+	if (unlikely(!a_ok || !b_ok || (before != after && w)))
 		info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
 
 	/*
@@ -2951,7 +3159,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	next = READ_ONCE(cpu_buffer->next_write);
 	WRITE_ONCE(cpu_buffer->next_write, w + info->length);
 
- /*B*/	local64_set(&cpu_buffer->before_stamp, info->ts);
+ /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);
 
  /*C*/	write = local_add_return(info->length, &tail_page->write);
 
@@ -2964,21 +3172,23 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	if (unlikely(write > BUF_PAGE_SIZE)) {
 		if (tail != w) {
 			/* before and after may now different, fix it up*/
-			before = local64_read(&cpu_buffer->before_stamp);
-			after = local64_read(&cpu_buffer->write_stamp);
-			if (before != after)
-				(void)local64_cmpxchg(&cpu_buffer->before_stamp, before, after);
+			b_ok = rb_time_read(&cpu_buffer->before_stamp, &before);
+			a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
+			if (a_ok && b_ok && before != after)
+				(void)rb_time_cmpxchg(&cpu_buffer->before_stamp, before, after);
 		}
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
 
 	if (likely(tail == w)) {
 		u64 save_before;
+		bool s_ok;
 
 		/* Nothing interrupted us between A and C */
- /*D*/		local64_set(&cpu_buffer->write_stamp, info->ts);
+ /*D*/		rb_time_set(&cpu_buffer->write_stamp, info->ts);
 		barrier();
- /*E*/		save_before = local64_read(&cpu_buffer->before_stamp);
+ /*E*/		s_ok = rb_time_read(&cpu_buffer->before_stamp, &save_before);
+		RB_WARN_ON(cpu_buffer, !s_ok);
 		if (likely(!(info->add_timestamp &
 			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
@@ -2990,27 +3200,31 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		if (unlikely(info->ts != save_before)) {
 			/* SLOW PATH - Interrupted between C and E */
 
-			after = local64_read(&cpu_buffer->write_stamp);
+			a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
+			RB_WARN_ON(cpu_buffer, !a_ok);
+
 			/* Write stamp must only go forward */
 			if (save_before > after) {
 				/*
 				 * We do not care about the result, only that
 				 * it gets updated atomically.
 				 */
-				(void)local64_cmpxchg(&cpu_buffer->write_stamp, after, save_before);
+				(void)rb_time_cmpxchg(&cpu_buffer->write_stamp, after, save_before);
 			}
 		}
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
-		after = local64_read(&cpu_buffer->write_stamp);
+		a_ok = rb_time_read(&cpu_buffer->write_stamp, &after);
+		/* Was interrupted before here, write_stamp must be valid */
+		RB_WARN_ON(cpu_buffer, !a_ok);
 		ts = rb_time_stamp(cpu_buffer->buffer);
 		barrier();
  /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
 		    after < ts) {
 			/* Nothing came after this event between C and E */
 			info->delta = ts - after;
-			(void)local64_cmpxchg(&cpu_buffer->write_stamp, after, info->ts);
+			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp, after, info->ts);
 			info->ts = ts;
 		} else {
 			/*
@@ -4569,8 +4783,8 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->read = 0;
 	cpu_buffer->read_bytes = 0;
 
-	local64_set(&cpu_buffer->write_stamp, 0);
-	local64_set(&cpu_buffer->before_stamp, 0);
+	rb_time_set(&cpu_buffer->write_stamp, 0);
+	rb_time_set(&cpu_buffer->before_stamp, 0);
 	cpu_buffer->next_write = 0;
 
 	cpu_buffer->lost_events = 0;
-- 
2.26.2


