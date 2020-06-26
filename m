Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0577AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 02:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28492084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 02:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgFZCgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 22:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgFZCgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 22:36:16 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D53E020773;
        Fri, 26 Jun 2020 02:36:12 +0000 (UTC)
Date:   Thu, 25 Jun 2020 22:36:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200625223611.1dbb3b35@oasis.local.home>
In-Reply-To: <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
        <20200625143525.2f3a2902@oasis.local.home>
        <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 15:35:02 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Those performance and reentrancy concerns are why I always stick to local_t
> (long), and never use a full 64-bit type for anything that has to
> do with concurrent store/load between execution contexts in lttng.

Although the adding of this patch slows the recording down by around 7
nanoseconds (average 55ns brought to 62ns), but I can wrap it so that
it stays local64_t for 64 bit and use this for 32 bit.

I added three primitives:

 bool rb_time_read(rb_time_t *t, u64 *val)

It loads val with t if t wasn't being updated at the time. If it is, it
returns false and val is not touched, otherwise it returns true and val
has a real value (either before, or updated by an interrupt).

 void rb_time_set(rb_time_t *t, u64 val)

This will update t with val, and wont return until it has done so. It
will overwrite any update that interrupted the process.

 bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set);

This will attempt to do a cmpxchg on t, if it matches "expect" it will
write "set". If it gets interrupted, then it will detect that, and return
false. Otherwise it will return true if it fully changed the value.


This is all I need, and is rather trivial to implement. The trick is
the order of rb_time_t is always written from:

  start_cnt
  top
  bottom
  end_cnt

This means that end_cnt will never be greater than start_cnt. If we see
that it is, it means that the process was interrupted with another
update. That process that interrupted a write, would complete its write.

I don't plan on applying this, but if it turns out that local64_t is a
problem on 32 bit archs (and I hear complaints), I add this (and but
still use local64_t on 64 bit archs).

-- Steve

Index: linux-trace.git/kernel/trace/ring_buffer.c
===================================================================
--- linux-trace.git.orig/kernel/trace/ring_buffer.c
+++ linux-trace.git/kernel/trace/ring_buffer.c
@@ -446,6 +446,22 @@ enum {
 	RB_CTX_MAX
 };
 
+struct rb_time_struct {
+	local_t		start_cnt;
+	local_t		top;
+	local_t		bottom;
+	local_t		end_cnt;
+};
+
+struct rb_time_read {
+	unsigned long	start_cnt;
+	unsigned long	top;
+	unsigned long	bottom;
+	unsigned long	end_cnt;
+};
+
+typedef struct rb_time_struct rb_time_t;
+
 /*
  * head_page == tail_page && head == tail then buffer is empty.
  */
@@ -482,8 +498,8 @@ struct ring_buffer_per_cpu {
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
@@ -526,6 +542,78 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+static bool rb_time_read(rb_time_t *t, u64 *ret)
+{
+	struct rb_time_read r;
+	u64 val;
+
+	do {
+		r.start_cnt = local_read(&t->start_cnt);
+		r.top = local_read(&t->top);
+		r.bottom = local_read(&t->bottom);
+		r.end_cnt = local_read(&t->end_cnt);
+	} while (r.start_cnt < r.end_cnt);
+
+	if (r.start_cnt != r.end_cnt)
+		return false;
+
+	val = r.top;
+	val <<= 32;
+	val |= r.bottom;
+	*ret = val;
+	return true;
+}
+
+static inline void rb_time_read_set(struct rb_time_read *r, u64 val)
+{
+	r->top = (unsigned long)(val >> 32);
+	r->bottom = (unsigned long)(val & ((1ULL << 32) - 1));
+}
+
+static void rb_time_set(rb_time_t *t, u64 val)
+{
+	struct rb_time_read r;
+
+	rb_time_read_set(&r, val);
+
+	do {
+		r.start_cnt = local_inc_return(&t->start_cnt);
+		local_set(&t->top, r.top);
+		local_set(&t->bottom, r.bottom);
+		local_set(&t->end_cnt, r.start_cnt);
+	} while (r.start_cnt != local_read(&t->start_cnt));
+}
+
+static bool rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
+{
+	unsigned long ret;
+
+	ret = local_cmpxchg(l, expect, set);
+	return ret == expect;
+}
+
+static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
+{
+	struct rb_time_read e, s;
+
+	rb_time_read_set(&e, expect);
+	rb_time_read_set(&s, set);
+
+	e.start_cnt = local_read(&t->start_cnt);
+	e.end_cnt = local_read(&t->end_cnt);
+
+	s.start_cnt = e.start_cnt + 1;
+	s.end_cnt = e.start_cnt;
+
+	if (!rb_time_read_cmpxchg(&t->start_cnt, e.start_cnt, s.start_cnt))
+		return false;
+	if (!rb_time_read_cmpxchg(&t->top, e.top, s.top))
+		return false;
+	if (!rb_time_read_cmpxchg(&t->bottom, e.bottom, s.bottom))
+		return false;
+	return rb_time_read_cmpxchg(&t->end_cnt, e.end_cnt, s.end_cnt);
+}
+
 /**
  * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
@@ -2543,7 +2631,8 @@ rb_try_to_discard(struct ring_buffer_per
 
 	delta = rb_time_delta(event);
 
-	write_stamp = local64_read(&cpu_buffer->write_stamp);
+	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
+		return 0;
 
 	/* Make sure the write stamp is read before testing the location */
 	barrier();
@@ -2552,11 +2641,10 @@ rb_try_to_discard(struct ring_buffer_per
 		unsigned long write_mask =
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
 		unsigned long event_length = rb_event_length(event);
-		u64 ret;
 
-		ret = local64_cmpxchg(&cpu_buffer->write_stamp, write_stamp, write_stamp - delta);
 		/* Something came in, can't discard */
-		if (ret != write_stamp)
+		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
+				     write_stamp, write_stamp - delta))
 			return 0;
 
 		/*
@@ -2887,11 +2975,13 @@ static noinline void
 rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -2909,14 +2999,16 @@ __rb_reserve_next(struct ring_buffer_per
 	unsigned long tail, write, w, next;
 	u64 delta, before, after;
 	bool abs = false;
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
 
@@ -2934,7 +3026,7 @@ __rb_reserve_next(struct ring_buffer_per
 	 * If interrupting an event time update, we may need an absolute timestamp.
 	 * Don't bother if this is the start of a new page (w == 0).
 	 */
-	if (unlikely(before != after && w))
+	if (unlikely(!a_ok || !b_ok || (before != after && w)))
 		info->add_timestamp = RB_ADD_STAMP_FORCE;
 	/*
 	 * If the time delta since the last event is too big to
@@ -2947,7 +3039,7 @@ __rb_reserve_next(struct ring_buffer_per
 	next = READ_ONCE(cpu_buffer->next_write);
 	WRITE_ONCE(cpu_buffer->next_write, w + info->length);
 
- /*B*/	local64_set(&cpu_buffer->before_stamp, info->ts);
+ /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);
 
  /*C*/	write = local_add_return(info->length, &tail_page->write);
 
@@ -2960,21 +3052,23 @@ __rb_reserve_next(struct ring_buffer_per
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
 		if (likely(info->add_timestamp != RB_ADD_STAMP_FORCE))
 			/* This did not interrupt any time update */
 			info->delta = info->ts - after;
@@ -2985,27 +3079,29 @@ __rb_reserve_next(struct ring_buffer_per
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
@@ -4567,8 +4663,8 @@ rb_reset_cpu(struct ring_buffer_per_cpu
 	cpu_buffer->read = 0;
 	cpu_buffer->read_bytes = 0;
 
-	local64_set(&cpu_buffer->write_stamp, 0);
-	local64_set(&cpu_buffer->before_stamp, 0);
+	rb_time_set(&cpu_buffer->write_stamp, 0);
+	rb_time_set(&cpu_buffer->before_stamp, 0);
 	cpu_buffer->next_write = 0;
 
 	cpu_buffer->lost_events = 0;
