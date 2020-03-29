Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A4C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8A2207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgC2SnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbgC2SnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7A220842;
        Sun, 29 Mar 2020 18:43:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIctw-002FuU-Oz; Sun, 29 Mar 2020 14:43:16 -0400
Message-Id: <20200329184316.644936337@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 08/21] ring-buffer: Do not die if rb_iter_peek() fails more than thrice
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As the iterator will be reading a live buffer, and if the event being read
is on a page that a writer crosses, it will fail and try again, the
condition in rb_iter_peek() that only allows a retry to happen three times
is no longer valid. Allow rb_iter_peek() to retry more than three times
without killing the ring buffer, but only if rb_iter_head_event() had failed
at least once.

Link: http://lkml.kernel.org/r/20200317213416.452888193@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3d718add73c1..475338fda969 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4012,6 +4012,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
+	bool failed = false;
 
 	if (ts)
 		*ts = 0;
@@ -4038,10 +4039,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	 * to a data event, we should never loop more than three times.
 	 * Once for going to next page, once on time extend, and
 	 * finally once to get the event.
-	 * (We never hit the following condition more than thrice).
+	 * We should never hit the following condition more than thrice,
+	 * unless the buffer is very small, and there's a writer
+	 * that is causing the reader to fail getting an event.
 	 */
-	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3))
+	if (++nr_loops > 3) {
+		RB_WARN_ON(cpu_buffer, !failed);
 		return NULL;
+	}
 
 	if (rb_per_cpu_empty(cpu_buffer))
 		return NULL;
@@ -4052,8 +4057,10 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	}
 
 	event = rb_iter_head_event(iter);
-	if (!event)
+	if (!event) {
+		failed = true;
 		goto again;
+	}
 
 	switch (event->type_len) {
 	case RINGBUF_TYPE_PADDING:
-- 
2.25.1


