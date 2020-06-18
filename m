Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF63C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D5A20771
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFRX5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgFRX4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:56:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3B8208B3;
        Thu, 18 Jun 2020 23:56:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jm4Of-003lRp-05; Thu, 18 Jun 2020 19:56:41 -0400
Message-ID: <20200618235640.884948657@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 19:56:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        YangHui <yanghui.def@gmail.com>
Subject: [for-linus][PATCH 12/17] tracing: Remove unused event variable in tracing_iter_reset
References: <20200618235556.451120786@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YangHui <yanghui.def@gmail.com>

We do not use the event variable, just remove it.

Signed-off-by: YangHui <yanghui.def@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ec44b0e2a19c..bb62269724d5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3570,7 +3570,6 @@ static void *s_next(struct seq_file *m, void *v, loff_t *pos)
 
 void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 {
-	struct ring_buffer_event *event;
 	struct ring_buffer_iter *buf_iter;
 	unsigned long entries = 0;
 	u64 ts;
@@ -3588,7 +3587,7 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 	 * that a reset never took place on a cpu. This is evident
 	 * by the timestamp being before the start of the buffer.
 	 */
-	while ((event = ring_buffer_iter_peek(buf_iter, &ts))) {
+	while (ring_buffer_iter_peek(buf_iter, &ts)) {
 		if (ts >= iter->array_buffer->time_start)
 			break;
 		entries++;
-- 
2.26.2


