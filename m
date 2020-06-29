Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1A1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CC720672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbgF2Tha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733008AbgF2Tae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E47CC2558F;
        Mon, 29 Jun 2020 16:25:08 +0000 (UTC)
Date:   Mon, 29 Jun 2020 12:25:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH 1/3 V2] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200629122507.49004c53@oasis.local.home>
In-Reply-To: <20200629224919.c2419732a5fc39ac2e1c38b9@kernel.org>
References: <20200629025224.485251097@goodmis.org>
        <20200629025258.957440797@goodmis.org>
        <20200629224919.c2419732a5fc39ac2e1c38b9@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 22:49:19 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Looks good to me :)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Masami!

I added a more general description to the design which makes more
sense in English terms, before going into the more detailed
pseudo implementation of the design.

Look at where it states:
 "The basic idea is that there's two main paths taken."
  
The patch is the same:

-- Steve

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Sun, 28 Jun 2020 22:52:25 -0400
Subject: [PATCH] ring-buffer: Have nested events still record running time
 stamp

Up until now, if an event is interrupted while it is recorded by an
interrupt, and that interrupt records events, the time of those events will
all be the same. This is because events only record the delta of the time
since the previous event (or beginning of a page), and to handle updating
the time keeping for that of nested events is extremely racy. After years of
thinking about this and several failed attempts, I finally have a solution
to solve this puzzle.

The problem is that you need to atomically calculate the delta and then
update the time stamp you made the delta from, as well as then record it
into the buffer, all this while at any time an interrupt can come in and
do the same thing. This is easy to solve with heavy weight atomics, but that
would be detrimental to the performance of the ring buffer. The current
state of affairs sacrificed the time deltas for nested events for
performance.

The reason for previous failed attempts at solving this puzzle was because I
was trying to completely avoid slow atomic operations like cmpxchg. I final
came to the conclusion to always avoid cmpxchg is not possible, which is why
those previous attempts always failed. But it is possible to pick one path
(the most common case) and avoid cmpxchg in that path, which is the "fast
path". The most common case is that an event will not be interrupted and
have other events added into it. An event can detect if it has
interrupted another event, and for these cases we can make it the slow
path and use the heavy operations like cmpxchg.

One more player was added to the game that made this possible, and that is
the "absolute timestamp" (by Tom Zanussi) that allows us to inject a full 59
bit time stamp. (Of course this breaks if a machine is running for more than
18 years without a reboot!).

There's barrier() placements around for being paranoid, even when they
are not needed because of other atomic functions near by. But those
should not hurt, as if they are not needed, they basically become a nop.

Note, this also makes the race window much smaller, which means there
are less slow paths to slow down the performance.

The basic idea is that there's two main paths taken.

 1) Not being interrupted between time stamps and reserving buffer space.
    In this case, the time stamps taken are true to the location in the
    buffer.

 2) Was interrupted by another path between taking time stamps and reserving
    buffer space.

The objective is to know what the delta is from the last reserved location
in the buffer.

As it is possible to detect if an event is interrupting another event before
reserving data, space is added to the length to be reserved to inject a full
time stamp along with the event being reserved.

When an event is not interrupted, the write stamp is always the time of the
last event written to the buffer.

In path 1, there's two sub paths we care about:

 a) The event did not interrupt another event.
 b) The event interrupted another event.

In case a, as the write stamp was read and known to be correct, the delta
between the current time stamp and the write stamp is the delta between the
current event and the previously recorded event.

In case b, extra space was reserved to just put the full time stamp into the
buffer. Which is done, as stated, in this path the time stamp taken is known
to match the location in the buffer.

In path 2, there's also two sub paths we care about:

 a) The event was not interrupted by another event since it reserved space
    on the buffer and re-reading the write stamp.
 b) The event was interrupted by another event.

In case a, the write stamp is that of the last event that interrupted this
event between taking the time stamps and reserving. As no event came in
after re-reading the write stamp, that event is known to be the time of the
event directly before this event and the delta can be the new time stamp and
the write stamp.

In case b, one or more events came in between reserving the event and
re-reading he write stamp. Since this event's buffer reservation is between
other events at this path, there's no way to know what the delta is. But
because an event interrupted this event after it started, its fine to just
give a zero delta, and take the same time stamp as the events that happened
within the event being recorded.

Here's the implementation of the design of this solution:

 All this is per cpu, and only needs to worry about nested events (not
 parallel events).

The players:

 write_tail: The index in the buffer where new events can be written to.
     It is incremented via local_add() to reserve space for a new event.

 before_stamp: A time stamp set by all events before reserving space.

 write_stamp: A time stamp updated by events after it has successfully
     reserved space.

	/* Save the current position of write */
 [A]	w = local_read(write_tail);
	barrier();
	/* Read both before and write stamps before touching anything */
	before = local_read(before_stamp);
	after = local_read(write_stamp);
	barrier();

	/*
	 * If before and after are the same, then this event is not
	 * interrupting a time update. If it is, then reserve space for adding
	 * a full time stamp (this can turn into a time extend which is
	 * just an extended time delta but fill up the extra space).
	 */
	if (after != before)
		abs = true;

	ts = clock();

	/* Now update the before_stamp (everyone does this!) */
 [B]	local_set(before_stamp, ts);

	/* Now reserve space on the buffer */
 [C]	write = local_add_return(len, write_tail);

	/* Set tail to be were this event's data is */
	tail = write - len;

 	if (w == tail) {

		/* Nothing interrupted this between A and C */
 [D]		local_set(write_stamp, ts);
		barrier();
 [E]		save_before = local_read(before_stamp);

 		if (!abs) {
			/* This did not interrupt a time update */
			delta = ts - after;
		} else {
			delta = ts; /* The full time stamp will be in use */
		}
		if (ts != save_before) {
			/* slow path - Was interrupted between C and E */
			/* The update to write_stamp could have overwritten the update to
			 * it by the interrupting event, but before and after should be
			 * the same for all completed top events */
			after = local_read(write_stamp);
			if (save_before > after)
				local_cmpxchg(write_stamp, after, save_before);
		}
	} else {
		/* slow path - Interrupted between A and C */

		after = local_read(write_stamp);
		temp_ts = clock();
		barrier();
 [F]		if (write == local_read(write_tail) && after < temp_ts) {
			/* This was not interrupted since C and F
			 * The last write_stamp is still valid for the previous event
			 * in the buffer. */
			delta = temp_ts - after;
			/* OK to keep this new time stamp */
			ts = temp_ts;
		} else {
			/* Interrupted between C and F
			 * Well, there's no use to try to know what the time stamp
			 * is for the previous event. Just set delta to zero and
			 * be the same time as that event that interrupted us before
			 * the reservation of the buffer. */

			delta = 0;
		}
		/* No need to use full timestamps here */
		abs = 0;
	}

Link: https://lkml.kernel.org/r/20200625094454.732790f7@oasis.local.home
Link: https://lore.kernel.org/r/20200627010041.517736087@goodmis.org
Link: http://lkml.kernel.org/r/20200629025258.957440797@goodmis.org

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 276 ++++++++++++++++++++++++-------------
 1 file changed, 181 insertions(+), 95 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 00867ff82412..026238c55b0c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -27,6 +27,7 @@
 #include <linux/oom.h>
 
 #include <asm/local.h>
+#include <asm/local64.h>
 
 static void update_pages_handler(struct work_struct *work);
 
@@ -418,6 +419,17 @@ struct rb_event_info {
 	int			add_timestamp;
 };
 
+/*
+ * Used for the add_timestamp
+ *  NONE
+ *  NORMAL - may be for either time extend or absolute
+ *  FORCE - force a full time stamp.
+ */
+enum {
+	RB_ADD_STAMP_NONE,
+	RB_ADD_STAMP_NORMAL,
+	RB_ADD_STAMP_FORCE
+};
 /*
  * Used for which event context the event is in.
  *  NMI     = 0
@@ -470,7 +482,8 @@ struct ring_buffer_per_cpu {
 	size_t				shortest_full;
 	unsigned long			read;
 	unsigned long			read_bytes;
-	u64				write_stamp;
+	local64_t			write_stamp;
+	local64_t			before_stamp;
 	u64				read_stamp;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
@@ -2416,16 +2429,13 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	unsigned length = info->length;
 	u64 delta = info->delta;
 
-	/* Only a commit updates the timestamp */
-	if (unlikely(!rb_event_is_commit(cpu_buffer, event)))
-		delta = 0;
-
 	/*
 	 * If we need to add a timestamp, then we
 	 * add it to the start of the reserved space.
 	 */
 	if (unlikely(info->add_timestamp)) {
-		bool abs = ring_buffer_time_stamp_abs(cpu_buffer->buffer);
+		bool abs = info->add_timestamp == RB_ADD_STAMP_FORCE ||
+			ring_buffer_time_stamp_abs(cpu_buffer->buffer);
 
 		event = rb_add_time_stamp(event, abs ? info->delta : delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
@@ -2480,6 +2490,39 @@ static inline bool sched_clock_stable(void)
 }
 #endif
 
+static __always_inline bool
+rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
+		   struct ring_buffer_event *event)
+{
+	unsigned long addr = (unsigned long)event;
+	unsigned long index;
+
+	index = rb_event_index(event);
+	addr &= PAGE_MASK;
+
+	return cpu_buffer->commit_page->page == (void *)addr &&
+		rb_commit_index(cpu_buffer) == index;
+}
+
+static u64 rb_time_delta(struct ring_buffer_event *event)
+{
+	switch (event->type_len) {
+	case RINGBUF_TYPE_PADDING:
+		return 0;
+
+	case RINGBUF_TYPE_TIME_EXTEND:
+		return ring_buffer_event_time_stamp(event);
+
+	case RINGBUF_TYPE_TIME_STAMP:
+		return 0;
+
+	case RINGBUF_TYPE_DATA:
+		return event->time_delta;
+	default:
+		return 0;
+	}
+}
+
 static inline int
 rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct ring_buffer_event *event)
@@ -2488,6 +2531,8 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *bpage;
 	unsigned long index;
 	unsigned long addr;
+	u64 write_stamp;
+	u64 delta;
 
 	new_index = rb_event_index(event);
 	old_index = new_index + rb_event_ts_length(event);
@@ -2496,10 +2541,32 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
+	delta = rb_time_delta(event);
+
+	write_stamp = local64_read(&cpu_buffer->write_stamp);
+
+	/* Make sure the write stamp is read before testing the location */
+	barrier();
+
 	if (bpage->page == (void *)addr && rb_page_write(bpage) == old_index) {
 		unsigned long write_mask =
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
 		unsigned long event_length = rb_event_length(event);
+		u64 ret;
+
+		ret = local64_cmpxchg(&cpu_buffer->write_stamp, write_stamp, write_stamp - delta);
+		/* Something came in, can't discard */
+		if (ret != write_stamp)
+			return 0;
+
+		/*
+		 * If an event were to come in now, it would see that the
+		 * write_stamp and the before_stamp are different, and assume
+		 * that this event just added itself before updating
+		 * the write stamp. The interrupting event will fix the
+		 * write stamp for us, and use the before stamp as its delta.
+		 */
+
 		/*
 		 * This is on the tail page. It is possible that
 		 * a write could come in and move the tail page
@@ -2551,10 +2618,6 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
 		rb_inc_page(cpu_buffer, &cpu_buffer->commit_page);
-		/* Only update the write stamp if the page has an event */
-		if (rb_page_write(cpu_buffer->commit_page))
-			cpu_buffer->write_stamp =
-				cpu_buffer->commit_page->page->time_stamp;
 		/* add barrier to keep gcc from optimizing too much */
 		barrier();
 	}
@@ -2626,54 +2689,10 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
 		event->time_delta = 1;
 }
 
-static __always_inline bool
-rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
-		   struct ring_buffer_event *event)
-{
-	unsigned long addr = (unsigned long)event;
-	unsigned long index;
-
-	index = rb_event_index(event);
-	addr &= PAGE_MASK;
-
-	return cpu_buffer->commit_page->page == (void *)addr &&
-		rb_commit_index(cpu_buffer) == index;
-}
-
-static __always_inline void
-rb_update_write_stamp(struct ring_buffer_per_cpu *cpu_buffer,
-		      struct ring_buffer_event *event)
-{
-	u64 delta;
-
-	/*
-	 * The event first in the commit queue updates the
-	 * time stamp.
-	 */
-	if (rb_event_is_commit(cpu_buffer, event)) {
-		/*
-		 * A commit event that is first on a page
-		 * updates the write timestamp with the page stamp
-		 */
-		if (!rb_event_index(event))
-			cpu_buffer->write_stamp =
-				cpu_buffer->commit_page->page->time_stamp;
-		else if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
-			delta = ring_buffer_event_time_stamp(event);
-			cpu_buffer->write_stamp += delta;
-		} else if (event->type_len == RINGBUF_TYPE_TIME_STAMP) {
-			delta = ring_buffer_event_time_stamp(event);
-			cpu_buffer->write_stamp = delta;
-		} else
-			cpu_buffer->write_stamp += event->time_delta;
-	}
-}
-
 static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
 		      struct ring_buffer_event *event)
 {
 	local_inc(&cpu_buffer->entries);
-	rb_update_write_stamp(cpu_buffer, event);
 	rb_end_commit(cpu_buffer);
 }
 
@@ -2872,13 +2891,13 @@ rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  KERN_WARNING "Delta way too big! %llu ts=%llu write stamp = %llu\n%s",
 		  (unsigned long long)info->delta,
 		  (unsigned long long)info->ts,
-		  (unsigned long long)cpu_buffer->write_stamp,
+		  (unsigned long long)local64_read(&cpu_buffer->write_stamp),
 		  sched_clock_stable() ? "" :
 		  "If you just came from a suspend/resume,\n"
 		  "please switch to the trace global clock:\n"
 		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
 		  "or add trace_clock=global to the kernel command line\n");
-	info->add_timestamp = 1;
+	info->add_timestamp = RB_ADD_STAMP_NORMAL;
 }
 
 static struct ring_buffer_event *
@@ -2887,8 +2906,36 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	struct ring_buffer_event *event;
 	struct buffer_page *tail_page;
-	unsigned long tail, write;
+	unsigned long tail, write, w;
+	u64 before, after;
+	bool abs = false;
+
+	/* Don't let the compiler play games with cpu_buffer->tail_page */
+	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
+
+ /*A*/	w = local_read(&tail_page->write) & RB_WRITE_MASK;
+	barrier();
+	before = local64_read(&cpu_buffer->before_stamp);
+	after = local64_read(&cpu_buffer->write_stamp);
+	barrier();
+	info->ts = rb_time_stamp(cpu_buffer->buffer);
+
+	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
+		info->delta = info->ts;
+		abs = true;
+	} else {
+		info->delta = info->ts - after;
+	}
+
+	if (unlikely(test_time_stamp(info->delta)))
+		rb_handle_timestamp(cpu_buffer, info);
 
+	/*
+	 * If interrupting an event time update, we may need an absolute timestamp.
+	 * Don't bother if this is the start of a new page (w == 0).
+	 */
+	if (unlikely(before != after && w))
+		info->add_timestamp = RB_ADD_STAMP_FORCE;
 	/*
 	 * If the time delta since the last event is too big to
 	 * hold in the time field of the event, then we append a
@@ -2897,25 +2944,88 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	if (unlikely(info->add_timestamp))
 		info->length += RB_LEN_TIME_EXTEND;
 
-	/* Don't let the compiler play games with cpu_buffer->tail_page */
-	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
-	write = local_add_return(info->length, &tail_page->write);
+ /*B*/	local64_set(&cpu_buffer->before_stamp, info->ts);
+
+ /*C*/	write = local_add_return(info->length, &tail_page->write);
 
 	/* set write to only the index of the write */
 	write &= RB_WRITE_MASK;
+
 	tail = write - info->length;
 
+	/* See if we shot pass the end of this buffer page */
+	if (unlikely(write > BUF_PAGE_SIZE)) {
+		if (tail != w) {
+			/* before and after may now different, fix it up*/
+			before = local64_read(&cpu_buffer->before_stamp);
+			after = local64_read(&cpu_buffer->write_stamp);
+			if (before != after)
+				(void)local64_cmpxchg(&cpu_buffer->before_stamp, before, after);
+		}
+		return rb_move_tail(cpu_buffer, tail, info);
+	}
+
+	if (likely(tail == w)) {
+		u64 save_before;
+
+		/* Nothing interrupted us between A and C */
+ /*D*/		local64_set(&cpu_buffer->write_stamp, info->ts);
+		barrier();
+ /*E*/		save_before = local64_read(&cpu_buffer->before_stamp);
+		if (likely(info->add_timestamp != RB_ADD_STAMP_FORCE))
+			/* This did not interrupt any time update */
+			info->delta = info->ts - after;
+		else
+			/* Just use full timestamp for inerrupting event */
+			info->delta = info->ts;
+		barrier();
+		if (unlikely(info->ts != save_before)) {
+			/* SLOW PATH - Interrupted between C and E */
+
+			after = local64_read(&cpu_buffer->write_stamp);
+			/* Write stamp must only go forward */
+			if (save_before > after) {
+				/*
+				 * We do not care about the result, only that
+				 * it gets updated atomically.
+				 */
+				(void)local64_cmpxchg(&cpu_buffer->write_stamp, after, save_before);
+			}
+		}
+	} else {
+		u64 ts;
+		/* SLOW PATH - Interrupted between A and C */
+		after = local64_read(&cpu_buffer->write_stamp);
+		ts = rb_time_stamp(cpu_buffer->buffer);
+		barrier();
+ /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
+		    after < ts) {
+			/* Nothing came after this event between C and E */
+			info->delta = ts - after;
+			(void)local64_cmpxchg(&cpu_buffer->write_stamp, after, info->ts);
+			info->ts = ts;
+		} else {
+			/*
+			 * Interrupted beween C and E:
+			 * Lost the previous events time stamp. Just set the
+			 * delta to zero, and this will be the same time as
+			 * the event this event interrupted. And the events that
+			 * came after this will still be correct (as they would
+			 * have built their delta on the previous event.
+			 */
+			info->delta = 0;
+		}
+		if (info->add_timestamp == RB_ADD_STAMP_FORCE)
+			info->add_timestamp = RB_ADD_STAMP_NORMAL;
+	}
+
 	/*
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (!tail && !ring_buffer_time_stamp_abs(cpu_buffer->buffer))
+	if (unlikely(!tail && info->add_timestamp != RB_ADD_STAMP_FORCE && !abs))
 		info->delta = 0;
 
-	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > BUF_PAGE_SIZE))
-		return rb_move_tail(cpu_buffer, tail, info);
-
 	/* We reserved something on the buffer */
 
 	event = __rb_page_index(tail_page, tail);
@@ -2944,9 +3054,9 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	struct rb_event_info info;
 	int nr_loops = 0;
-	u64 diff;
 
 	rb_start_commit(cpu_buffer);
+	/* The commit page can not change after this */
 
 #ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
 	/*
@@ -2965,7 +3075,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 
 	info.length = rb_calculate_event_length(length);
  again:
-	info.add_timestamp = 0;
+	info.add_timestamp = RB_ADD_STAMP_NONE;
 	info.delta = 0;
 
 	/*
@@ -2980,22 +3090,6 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 1000))
 		goto out_fail;
 
-	info.ts = rb_time_stamp(cpu_buffer->buffer);
-	diff = info.ts - cpu_buffer->write_stamp;
-
-	/* make sure this diff is calculated here */
-	barrier();
-
-	if (ring_buffer_time_stamp_abs(buffer)) {
-		info.delta = info.ts;
-		rb_handle_timestamp(cpu_buffer, &info);
-	} else /* Did the write stamp get updated already? */
-		if (likely(info.ts >= cpu_buffer->write_stamp)) {
-		info.delta = diff;
-		if (unlikely(test_time_stamp(info.delta)))
-			rb_handle_timestamp(cpu_buffer, &info);
-	}
-
 	event = __rb_reserve_next(cpu_buffer, &info);
 
 	if (unlikely(PTR_ERR(event) == -EAGAIN)) {
@@ -3004,11 +3098,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 		goto again;
 	}
 
-	if (!event)
-		goto out_fail;
-
-	return event;
-
+	if (likely(event))
+		return event;
  out_fail:
 	rb_end_commit(cpu_buffer);
 	return NULL;
@@ -3154,11 +3245,6 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
 	if (rb_try_to_discard(cpu_buffer, event))
 		goto out;
 
-	/*
-	 * The commit is still visible by the reader, so we
-	 * must still update the timestamp.
-	 */
-	rb_update_write_stamp(cpu_buffer, event);
  out:
 	rb_end_commit(cpu_buffer);
 
@@ -4475,8 +4561,8 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->read = 0;
 	cpu_buffer->read_bytes = 0;
 
-	cpu_buffer->write_stamp = 0;
-	cpu_buffer->read_stamp = 0;
+	local64_set(&cpu_buffer->write_stamp, 0);
+	local64_set(&cpu_buffer->before_stamp, 0);
 
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
-- 
2.25.4

