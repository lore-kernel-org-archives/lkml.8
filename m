Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBBBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C178320774
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgF2CxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgF2CxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:53:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DBB320781;
        Mon, 29 Jun 2020 02:53:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jpjul-0043O6-92; Sun, 28 Jun 2020 22:52:59 -0400
Message-ID: <20200629025259.154892368@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 28 Jun 2020 22:52:26 -0400
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
Subject: [PATCH 2/3 V2] ring-buffer: Incorporate absolute timestamp into add_timestamp logic
References: <20200629025224.485251097@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of calling out the absolute test for each time to check if the
ring buffer wants absolute time stamps for all its recording, incorporate it
with the add_timestamp field and turn it into flags for faster processing
between wanting a absolute tag and needing to force one.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 40 +++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 026238c55b0c..7ee6619951ea 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -422,13 +422,15 @@ struct rb_event_info {
 /*
  * Used for the add_timestamp
  *  NONE
- *  NORMAL - may be for either time extend or absolute
+ *  EXTEND - wants a time extend
+ *  ABSOLUTE - the buffer requests all events to have absolute time stamps
  *  FORCE - force a full time stamp.
  */
 enum {
-	RB_ADD_STAMP_NONE,
-	RB_ADD_STAMP_NORMAL,
-	RB_ADD_STAMP_FORCE
+	RB_ADD_STAMP_NONE		= 0,
+	RB_ADD_STAMP_EXTEND		= BIT(1),
+	RB_ADD_STAMP_ABSOLUTE		= BIT(2),
+	RB_ADD_STAMP_FORCE		= BIT(3)
 };
 /*
  * Used for which event context the event is in.
@@ -2434,8 +2436,8 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	 * add it to the start of the reserved space.
 	 */
 	if (unlikely(info->add_timestamp)) {
-		bool abs = info->add_timestamp == RB_ADD_STAMP_FORCE ||
-			ring_buffer_time_stamp_abs(cpu_buffer->buffer);
+		bool abs = info->add_timestamp &
+			(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
 
 		event = rb_add_time_stamp(event, abs ? info->delta : delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
@@ -2884,8 +2886,8 @@ int ring_buffer_unlock_commit(struct trace_buffer *buffer,
 EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
 
 static noinline void
-rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
-		    struct rb_event_info *info)
+rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
+		   struct rb_event_info *info)
 {
 	WARN_ONCE(info->delta > (1ULL << 59),
 		  KERN_WARNING "Delta way too big! %llu ts=%llu write stamp = %llu\n%s",
@@ -2897,7 +2899,6 @@ rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  "please switch to the trace global clock:\n"
 		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
 		  "or add trace_clock=global to the kernel command line\n");
-	info->add_timestamp = RB_ADD_STAMP_NORMAL;
 }
 
 static struct ring_buffer_event *
@@ -2908,7 +2909,6 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *tail_page;
 	unsigned long tail, write, w;
 	u64 before, after;
-	bool abs = false;
 
 	/* Don't let the compiler play games with cpu_buffer->tail_page */
 	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
@@ -2922,20 +2922,23 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		info->delta = info->ts;
-		abs = true;
+		info->add_timestamp = RB_ADD_STAMP_ABSOLUTE;
 	} else {
 		info->delta = info->ts - after;
 	}
 
-	if (unlikely(test_time_stamp(info->delta)))
-		rb_handle_timestamp(cpu_buffer, info);
+	if (unlikely(test_time_stamp(info->delta))) {
+		rb_check_timestamp(cpu_buffer, info);
+		info->add_timestamp |= RB_ADD_STAMP_EXTEND;
+	}
 
 	/*
 	 * If interrupting an event time update, we may need an absolute timestamp.
 	 * Don't bother if this is the start of a new page (w == 0).
 	 */
 	if (unlikely(before != after && w))
-		info->add_timestamp = RB_ADD_STAMP_FORCE;
+		info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
+
 	/*
 	 * If the time delta since the last event is too big to
 	 * hold in the time field of the event, then we append a
@@ -2972,7 +2975,8 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
  /*D*/		local64_set(&cpu_buffer->write_stamp, info->ts);
 		barrier();
  /*E*/		save_before = local64_read(&cpu_buffer->before_stamp);
-		if (likely(info->add_timestamp != RB_ADD_STAMP_FORCE))
+		if (likely(!(info->add_timestamp &
+			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
 			info->delta = info->ts - after;
 		else
@@ -3015,15 +3019,15 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			 */
 			info->delta = 0;
 		}
-		if (info->add_timestamp == RB_ADD_STAMP_FORCE)
-			info->add_timestamp = RB_ADD_STAMP_NORMAL;
+		info->add_timestamp &= ~RB_ADD_STAMP_FORCE;
 	}
 
 	/*
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (unlikely(!tail && info->add_timestamp != RB_ADD_STAMP_FORCE && !abs))
+	if (unlikely(!tail && !(info->add_timestamp &
+				(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 		info->delta = 0;
 
 	/* We reserved something on the buffer */
-- 
2.26.2


