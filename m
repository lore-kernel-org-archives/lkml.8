Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27372C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B152082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406954AbgFYSJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405552AbgFYSJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:09:07 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD8220789;
        Thu, 25 Jun 2020 18:09:04 +0000 (UTC)
Date:   Thu, 25 Jun 2020 14:09:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200625140903.2a1d3e6e@oasis.local.home>
In-Reply-To: <20200625094454.732790f7@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After running my ring buffer benchmark on this update, it went from
55ns to 85ns per event. A 30ns increase! At first I freaked out, but
then noticed that I unnecessarily take the time stamp counter twice,
which is the most expensive operation.

Here's a diff to my patch (I'll send a v2 later) that removes the
double taking of the time stamp.

It also removes the double testing of the absolute value. Which I have
another patch that consolidates that with the info add_timestamp field.
But that patch wont be folded into this.

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a5c3f1608de8..7370c483c6cd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2908,6 +2908,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *tail_page;
 	unsigned long tail, write, w, next;
 	u64 delta, before, after;
+	bool abs = false;
 
 	/* Don't let the compiler play games with cpu_buffer->tail_page */
 	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
@@ -2916,6 +2917,19 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	barrier();
 	before = READ_ONCE(cpu_buffer->before_stamp);
 	after = local64_read(&cpu_buffer->write_stamp);
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
+
 	/*
 	 * If preempting an event time update, we may need absolute timestamp.
 	 * Don't bother if this is the start of a new page (w == 0).
@@ -2933,7 +2947,6 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	next = READ_ONCE(cpu_buffer->next_write);
 	WRITE_ONCE(cpu_buffer->next_write, w + info->length);
 
-	info->ts = rb_time_stamp(cpu_buffer->buffer);
  /*B*/	WRITE_ONCE(cpu_buffer->before_stamp, info->ts);
 
  /*C*/	write = local_add_return(info->length, &tail_page->write);
@@ -3021,8 +3034,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (unlikely(!tail && info->add_timestamp != RB_ADD_STAMP_FORCE &&
-		     !ring_buffer_time_stamp_abs(cpu_buffer->buffer)))
+	if (unlikely(!tail && info->add_timestamp != RB_ADD_STAMP_FORCE && !abs))
 		info->delta = 0;
 
 	/* We reserved something on the buffer */
@@ -3056,7 +3068,6 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	struct rb_event_info info;
 	int nr_loops = 0;
-	u64 write_stamp;
 
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
@@ -3093,18 +3104,6 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 1000))
 		goto out_fail;
 
-	write_stamp = local64_read(&cpu_buffer->write_stamp);
-	info.ts = rb_time_stamp(cpu_buffer->buffer);
-
-	if (ring_buffer_time_stamp_abs(buffer)) {
-		info.delta = info.ts;
-		rb_handle_timestamp(cpu_buffer, &info);
-	} else {
-		info.delta = info.ts - write_stamp ;
-		if (unlikely(test_time_stamp(info.delta)))
-			rb_handle_timestamp(cpu_buffer, &info);
-	}
-
 	event = __rb_reserve_next(cpu_buffer, &info);
 
 	if (unlikely(PTR_ERR(event) == -EAGAIN)) {
