Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32485C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0517620789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpQG+gFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbgFYFeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389269AbgFYFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:34:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F12C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:34:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so4291197wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HS9gdqMc+SPZZ7m3mwfkUTxekM/Q1K/XkwerNb18rq0=;
        b=WpQG+gFzcVPSFXw5JlvVu1GrcCwqi9Ga3xnsxiLK8j8RGt3nFQ9mL6ojFvOfFreiYm
         3k5zxXiPkbypGaKJcVWryZS7lJweYzmvIb75+/zGitlVf/DJXxsjkcLexgcy9AFnbZdS
         dP9WqdOptJUyF4QhofW4sb+XKHBQehgQhs9gfqjz36Jo8FJEPqKDajXI5uVnkJmQUk4W
         ZzlQpcMAF9E0IdjGjqbJqlH0yX5qOa5nYJJ0t0mZAROFkP01u6IF5WPjnzWt3LaISKda
         9PisUWthADKfRra9RAUmeiGKvPD+N6Yms+nuylI2uplOf41hfcDMe2SE+NjukwnupSfw
         hWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HS9gdqMc+SPZZ7m3mwfkUTxekM/Q1K/XkwerNb18rq0=;
        b=N28vGWvsO5OHJ9ElAyn2ThrLZZgkyfnLyt4uuWsHQznMigUD3vfSISeNG7bYBAK4II
         egi14YA009v3Mpioo9k7ubUalLYN/DFVvLOuaBgSRwJ+UCvdcSZAOUPPsQyS9J0sSdE0
         ELb5cvMA/lr9/zcoYsZhcKc4LjzRZsxqjdU7ApB1cCdcXHkKtz6F+0wgUy30iftZBQsG
         IZCpDCdWiF8KHcbEr0wS8sxu773kulzPUwTyPOOZC6A2YKMBShvrQNzmgGDACtv11pUL
         Gros9KolRA/qQRCv/0H9+oHfpZ9Cq/pk1+6MNAbgK+FjFCV89PI5YShTxzK3fB4LBWU9
         h4Wg==
X-Gm-Message-State: AOAM532GIUOkRdmkk6L8Q/I1pSHr0ZvDlkHquOX1Sj0Jf80VSD1L1y7e
        xgpJFyGgy16AZNQsXd91Vu/cLRbO
X-Google-Smtp-Source: ABdhPJw87jXeKChNW4foOmwtrZOpmbZsGQErTFmT8VakEIJKkNfJsApiEcP318hWeAbcutKOzrIixw==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr1436000wmd.104.1593063256240;
        Wed, 24 Jun 2020 22:34:16 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id r1sm21546790wrt.73.2020.06.24.22.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 22:34:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Paul McKenney <paulmck@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: speed up buffer resets by avoiding synchronize_rcu for each CPU
Date:   Thu, 25 Jun 2020 15:34:03 +1000
Message-Id: <20200625053403.2386972-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Paul McKenney <paulmck@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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
index b8e1ca48be50..3f1fd02bd14a 100644
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
@@ -4484,6 +4487,26 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -4492,7 +4515,6 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
-	unsigned long flags;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return;
@@ -4503,24 +4525,42 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
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
@@ -4528,10 +4568,27 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
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
index ec44b0e2a19c..9a26a1c875ae 100644
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
2.23.0

