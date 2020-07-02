Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7534C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C498320780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGBV7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgGBV6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78F5421919;
        Thu,  2 Jul 2020 21:58:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E1-004BjZ-HM; Thu, 02 Jul 2020 17:58:33 -0400
Message-ID: <20200702215833.415117675@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [for-next][PATCH 13/18] ring-buffer: speed up buffer resets by avoiding synchronize_rcu for
 each CPU
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

On a 144 thread system, `perf ftrace` takes about 20 seconds to start
up, due to calling synchronize_rcu() for each CPU.

  cat /proc/108560/stack
    0xc0003e7eb336f470
    __switch_to+0x2e0/0x480
    __wait_rcu_gp+0x20c/0x220
    synchronize_rcu+0x9c/0xc0
    ring_buffer_reset_cpu+0x88/0x2e0
    tracing_reset_online_cpus+0x84/0xe0
    tracing_open+0x1d4/0x1f0

On a system with 10x more threads, it starts to become an annoyance.

Batch these up so we disable all the per-cpu buffers first, then
synchronize_rcu() once, then reset each of the buffers. This brings
the time down to about 0.5s.

Link: https://lkml.kernel.org/r/20200625053403.2386972-1-npiggin@gmail.com

Tested-by: Anton Blanchard <anton@ozlabs.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 85 +++++++++++++++++++++++++++++++------
 kernel/trace/trace.c        |  4 +-
 3 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index c76b2f3b3ac4..136ea0997e6d 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -143,6 +143,7 @@ bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
 unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
 
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
+void ring_buffer_reset_online_cpus(struct trace_buffer *buffer);
 void ring_buffer_reset(struct trace_buffer *buffer);
 
 #ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 802bb38d9c81..ed1941304f69 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -270,6 +270,9 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 #define for_each_buffer_cpu(buffer, cpu)		\
 	for_each_cpu(cpu, buffer->cpumask)
 
+#define for_each_online_buffer_cpu(buffer, cpu)		\
+	for_each_cpu_and(cpu, buffer->cpumask, cpu_online_mask)
+
 #define TS_SHIFT	27
 #define TS_MASK		((1ULL << TS_SHIFT) - 1)
 #define TS_DELTA_TEST	(~TS_MASK)
@@ -4790,6 +4793,26 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_head_page_activate(cpu_buffer);
 }
 
+/* Must have disabled the cpu buffer then done a synchronize_rcu */
+static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	if (RB_WARN_ON(cpu_buffer, local_read(&cpu_buffer->committing)))
+		goto out;
+
+	arch_spin_lock(&cpu_buffer->lock);
+
+	rb_reset_cpu(cpu_buffer);
+
+	arch_spin_unlock(&cpu_buffer->lock);
+
+ out:
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+}
+
 /**
  * ring_buffer_reset_cpu - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
@@ -4798,7 +4821,6 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
-	unsigned long flags;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return;
@@ -4809,24 +4831,42 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 	/* Make sure all commits have finished */
 	synchronize_rcu();
 
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	reset_disabled_cpu_buffer(cpu_buffer);
 
-	if (RB_WARN_ON(cpu_buffer, local_read(&cpu_buffer->committing)))
-		goto out;
+	atomic_dec(&cpu_buffer->record_disabled);
+	atomic_dec(&cpu_buffer->resize_disabled);
+}
+EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
-	arch_spin_lock(&cpu_buffer->lock);
+/**
+ * ring_buffer_reset_cpu - reset a ring buffer per CPU buffer
+ * @buffer: The ring buffer to reset a per cpu buffer of
+ * @cpu: The CPU buffer to be reset
+ */
+void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int cpu;
 
-	rb_reset_cpu(cpu_buffer);
+	for_each_online_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
 
-	arch_spin_unlock(&cpu_buffer->lock);
+		atomic_inc(&cpu_buffer->resize_disabled);
+		atomic_inc(&cpu_buffer->record_disabled);
+	}
 
- out:
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	/* Make sure all commits have finished */
+	synchronize_rcu();
 
-	atomic_dec(&cpu_buffer->record_disabled);
-	atomic_dec(&cpu_buffer->resize_disabled);
+	for_each_online_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+
+		reset_disabled_cpu_buffer(cpu_buffer);
+
+		atomic_dec(&cpu_buffer->record_disabled);
+		atomic_dec(&cpu_buffer->resize_disabled);
+	}
 }
-EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
 /**
  * ring_buffer_reset - reset a ring buffer
@@ -4834,10 +4874,27 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
  */
 void ring_buffer_reset(struct trace_buffer *buffer)
 {
+	struct ring_buffer_per_cpu *cpu_buffer;
 	int cpu;
 
-	for_each_buffer_cpu(buffer, cpu)
-		ring_buffer_reset_cpu(buffer, cpu);
+	for_each_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+
+		atomic_inc(&cpu_buffer->resize_disabled);
+		atomic_inc(&cpu_buffer->record_disabled);
+	}
+
+	/* Make sure all commits have finished */
+	synchronize_rcu();
+
+	for_each_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+
+		reset_disabled_cpu_buffer(cpu_buffer);
+
+		atomic_dec(&cpu_buffer->record_disabled);
+		atomic_dec(&cpu_buffer->resize_disabled);
+	}
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64c5b8146cca..4aab712f9567 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2003,7 +2003,6 @@ static void tracing_reset_cpu(struct array_buffer *buf, int cpu)
 void tracing_reset_online_cpus(struct array_buffer *buf)
 {
 	struct trace_buffer *buffer = buf->buffer;
-	int cpu;
 
 	if (!buffer)
 		return;
@@ -2015,8 +2014,7 @@ void tracing_reset_online_cpus(struct array_buffer *buf)
 
 	buf->time_start = buffer_ftrace_now(buf, buf->cpu);
 
-	for_each_online_cpu(cpu)
-		ring_buffer_reset_cpu(buffer, cpu);
+	ring_buffer_reset_online_cpus(buffer);
 
 	ring_buffer_record_enable(buffer);
 }
-- 
2.26.2


