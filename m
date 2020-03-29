Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53906C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31997214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgC2Sna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgC2SnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9C620B80;
        Sun, 29 Mar 2020 18:43:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIctx-002Fx4-FR; Sun, 29 Mar 2020 14:43:17 -0400
Message-Id: <20200329184317.362371735@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 13/21] ring-buffer/tracing: Have iterator acknowledge dropped events
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Have the ring_buffer_iterator set a flag if events were dropped as it were
to go and peek at the next event. Have the trace file display this fact if
it happened with a "LOST EVENTS" message.

Link: http://lkml.kernel.org/r/20200317213417.045858900@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 16 ++++++++++++++++
 kernel/trace/trace.c        | 16 ++++++++++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0ae603b79b0e..c76b2f3b3ac4 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -138,6 +138,7 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts);
 void ring_buffer_iter_advance(struct ring_buffer_iter *iter);
 void ring_buffer_iter_reset(struct ring_buffer_iter *iter);
 int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
+bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
 
 unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af2f10d9f3f1..6f0b42ceeb00 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -510,6 +510,7 @@ struct ring_buffer_iter {
 	u64				read_stamp;
 	u64				page_stamp;
 	struct ring_buffer_event	*event;
+	int				missed_events;
 };
 
 /**
@@ -1988,6 +1989,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
 	iter->head = 0;
 	iter->next_event = 0;
+	iter->missed_events = 1;
 	return NULL;
 }
 
@@ -4191,6 +4193,20 @@ ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
 	return event;
 }
 
+/** ring_buffer_iter_dropped - report if there are dropped events
+ * @iter: The ring buffer iterator
+ *
+ * Returns true if there was dropped events since the last peek.
+ */
+bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter)
+{
+	bool ret = iter->missed_events != 0;
+
+	iter->missed_events = 0;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_iter_dropped);
+
 /**
  * ring_buffer_iter_peek - peek at the next event to be read
  * @iter: The ring buffer iterator
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 650fa81fffe8..5e634b9c1e0a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3388,11 +3388,15 @@ peek_next_entry(struct trace_iterator *iter, int cpu, u64 *ts,
 	struct ring_buffer_event *event;
 	struct ring_buffer_iter *buf_iter = trace_buffer_iter(iter, cpu);
 
-	if (buf_iter)
+	if (buf_iter) {
 		event = ring_buffer_iter_peek(buf_iter, ts);
-	else
+		if (lost_events)
+			*lost_events = ring_buffer_iter_dropped(buf_iter) ?
+				(unsigned long)-1 : 0;
+	} else {
 		event = ring_buffer_peek(iter->array_buffer->buffer, cpu, ts,
 					 lost_events);
+	}
 
 	if (event) {
 		iter->ent_size = ring_buffer_event_length(event);
@@ -4005,8 +4009,12 @@ enum print_line_t print_trace_line(struct trace_iterator *iter)
 	enum print_line_t ret;
 
 	if (iter->lost_events) {
-		trace_seq_printf(&iter->seq, "CPU:%d [LOST %lu EVENTS]\n",
-				 iter->cpu, iter->lost_events);
+		if (iter->lost_events == (unsigned long)-1)
+			trace_seq_printf(&iter->seq, "CPU:%d [LOST EVENTS]\n",
+					 iter->cpu);
+		else
+			trace_seq_printf(&iter->seq, "CPU:%d [LOST %lu EVENTS]\n",
+					 iter->cpu, iter->lost_events);
 		if (trace_seq_has_overflowed(&iter->seq))
 			return TRACE_TYPE_PARTIAL_LINE;
 	}
-- 
2.25.1


