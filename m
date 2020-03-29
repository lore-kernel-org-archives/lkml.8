Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D897C2D0F3
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7997D21556
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgC2Snf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbgC2SnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:43:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2140A20857;
        Sun, 29 Mar 2020 18:43:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jIctx-002FvW-1m; Sun, 29 Mar 2020 14:43:17 -0400
Message-Id: <20200329184316.939831283@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Mar 2020 14:43:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 10/21] ring-buffer: Make resize disable per cpu buffer instead of total
 buffer
References: <20200329184252.289087453@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When the ring buffer becomes writable for even when the trace file is read,
it must still not be resized. But since tracers can be activated while the
trace file is being read, the irqsoff tracer can modify the per CPU buffers,
and this can cause the reader of the trace file to update the wrong buffer's
resize disable bit, as the irqsoff tracer swaps out cpu buffers.

By making the resize disable per cpu_buffer, it makes the update follow the
per cpu_buffer even if it's swapped out with the snapshot buffer and keeps
the release of the trace file modifying the same data as the open did.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 43 ++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5979327254f9..e2de5b448c91 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -441,6 +441,7 @@ enum {
 struct ring_buffer_per_cpu {
 	int				cpu;
 	atomic_t			record_disabled;
+	atomic_t			resize_disabled;
 	struct trace_buffer	*buffer;
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
@@ -484,7 +485,6 @@ struct trace_buffer {
 	unsigned			flags;
 	int				cpus;
 	atomic_t			record_disabled;
-	atomic_t			resize_disabled;
 	cpumask_var_t			cpumask;
 
 	struct lock_class_key		*reader_lock_key;
@@ -1740,18 +1740,24 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 	size = nr_pages * BUF_PAGE_SIZE;
 
-	/*
-	 * Don't succeed if resizing is disabled, as a reader might be
-	 * manipulating the ring buffer and is expecting a sane state while
-	 * this is true.
-	 */
-	if (atomic_read(&buffer->resize_disabled))
-		return -EBUSY;
-
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 
+
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
+		/*
+		 * Don't succeed if resizing is disabled, as a reader might be
+		 * manipulating the ring buffer and is expecting a sane state while
+		 * this is true.
+		 */
+		for_each_buffer_cpu(buffer, cpu) {
+			cpu_buffer = buffer->buffers[cpu];
+			if (atomic_read(&cpu_buffer->resize_disabled)) {
+				err = -EBUSY;
+				goto out_err_unlock;
+			}
+		}
+
 		/* calculate the pages to update */
 		for_each_buffer_cpu(buffer, cpu) {
 			cpu_buffer = buffer->buffers[cpu];
@@ -1819,6 +1825,16 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		if (nr_pages == cpu_buffer->nr_pages)
 			goto out;
 
+		/*
+		 * Don't succeed if resizing is disabled, as a reader might be
+		 * manipulating the ring buffer and is expecting a sane state while
+		 * this is true.
+		 */
+		if (atomic_read(&cpu_buffer->resize_disabled)) {
+			err = -EBUSY;
+			goto out_err_unlock;
+		}
+
 		cpu_buffer->nr_pages_to_update = nr_pages -
 						cpu_buffer->nr_pages;
 
@@ -1888,6 +1904,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			free_buffer_page(bpage);
 		}
 	}
+ out_err_unlock:
 	mutex_unlock(&buffer->mutex);
 	return err;
 }
@@ -4294,7 +4311,7 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 
 	iter->cpu_buffer = cpu_buffer;
 
-	atomic_inc(&buffer->resize_disabled);
+	atomic_inc(&cpu_buffer->resize_disabled);
 	atomic_inc(&cpu_buffer->record_disabled);
 
 	return iter;
@@ -4369,7 +4386,7 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	atomic_dec(&cpu_buffer->record_disabled);
-	atomic_dec(&cpu_buffer->buffer->resize_disabled);
+	atomic_dec(&cpu_buffer->resize_disabled);
 	kfree(iter->event);
 	kfree(iter);
 }
@@ -4474,7 +4491,7 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return;
 
-	atomic_inc(&buffer->resize_disabled);
+	atomic_inc(&cpu_buffer->resize_disabled);
 	atomic_inc(&cpu_buffer->record_disabled);
 
 	/* Make sure all commits have finished */
@@ -4495,7 +4512,7 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	atomic_dec(&cpu_buffer->record_disabled);
-	atomic_dec(&buffer->resize_disabled);
+	atomic_dec(&cpu_buffer->resize_disabled);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
-- 
2.25.1


