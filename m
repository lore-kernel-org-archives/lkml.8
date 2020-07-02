Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB3921D7A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgGBV6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgGBV6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E602021D7D;
        Thu,  2 Jul 2020 21:58:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E1-004Bl7-W5; Thu, 02 Jul 2020 17:58:34 -0400
Message-ID: <20200702215833.863304556@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 16/18] ring-buffer: Move the add_timestamp into its own function
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Make a helper function rb_add_timestamp() that moves the adding of the
extended time stamps into its own function. Also, remove the noinline and
inline for the functions it calls, as recent benchmarks appear they do not
make a difference (just let gcc decide).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ce125cbe98a5..a30ca7ec2200 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2596,8 +2596,8 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	return NULL;
 }
 
-/* Slow path, do not inline */
-static noinline struct ring_buffer_event *
+/* Slow path */
+static struct ring_buffer_event *
 rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 {
 	if (abs)
@@ -2628,7 +2628,7 @@ static inline bool sched_clock_stable(void)
 }
 #endif
 
-static noinline void
+static void
 rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		   struct rb_event_info *info)
 {
@@ -2648,6 +2648,21 @@ rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  "or add trace_clock=global to the kernel command line\n");
 }
 
+static void rb_add_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
+				      struct ring_buffer_event **event,
+				      struct rb_event_info *info,
+				      u64 *delta,
+				      unsigned int *length)
+{
+	bool abs = info->add_timestamp &
+		(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
+
+	rb_check_timestamp(cpu_buffer, info);
+	*event = rb_add_time_stamp(*event, info->delta, abs);
+	*length -= RB_LEN_TIME_EXTEND;
+	*delta = 0;
+}
+
 /**
  * rb_update_event - update event type and data
  * @cpu_buffer: The per cpu buffer of the @event
@@ -2671,15 +2686,8 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If we need to add a timestamp, then we
 	 * add it to the start of the reserved space.
 	 */
-	if (unlikely(info->add_timestamp)) {
-		bool abs = info->add_timestamp &
-			(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
-
-		rb_check_timestamp(cpu_buffer, info);
-		event = rb_add_time_stamp(event, abs ? info->delta : delta, abs);
-		length -= RB_LEN_TIME_EXTEND;
-		delta = 0;
-	}
+	if (unlikely(info->add_timestamp))
+		rb_add_timestamp(cpu_buffer, &event, info, &delta, &length);
 
 	event->time_delta = delta;
 	length -= RB_EVNT_HDR_SIZE;
-- 
2.26.2


