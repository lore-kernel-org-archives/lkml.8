Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1031C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C712083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M61J0++F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIBUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIBUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:01:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F411C061247
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:01:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w16so918537qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2MZxRkSoiXq40E5On97w+UGAgJenSMXy4s5B6M2dNG4=;
        b=M61J0++FgAOgxm5e02Yh2fb4ztyWA/tk7y97rwkGUuYgU4ADFDOVbxt81YdJoWD8rz
         EedasooYQGGFFrmersvTIuTo5HBWMxAwXLr8TZpXsoHl+2XCI3TPR98N22W55sWHbt4L
         BuCkTqVrIiGMCR67WrvpEE7Qa+RvU3xT9rQXvdGeB+wsSJUNzub0gHFh0tlKNOe3CcHB
         cn09xApDVic0u/M3V5W2a/0npeOEkLZLFJ8hvn8MdL5VNESWhT6fe1FpkP+uhDgM3umj
         l9SkjlWJchfsw5gsy3irbaLzTKQSPYwTcEiz1d1uWguZ4SLDMWz8sr7uRr6K+jPeEYrd
         Nd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2MZxRkSoiXq40E5On97w+UGAgJenSMXy4s5B6M2dNG4=;
        b=BQk7uy1w5KfIFEEk1cCeUCdPXlckhiYhQwMiTokBTjw8447rav74PQgDj5wSrySB9R
         8tz/mwabg1gpudzFi0vq9ZJN0X4iQkITKFmKb3XLaRWexB/W5marOz9DnFhrHl4pSSQw
         r2ci8n7JBE6QmUhgOJ455NGSjgOo+dMJt4EKOw8I8xx47UX/H+R7D4CLVZhcKEQ99TSC
         WAHUXOsq6fM/PBsXH27YdTgJabqQ6kCOoe2E015cgqPDHaK1ehVJSeqjfyIiuL/VeEZ1
         +DokwoxDWG8b/uI7a3MkKwlMzMfzl0diQ7PUAOrQqapHamnjra+OifateEUfoldfoebV
         NWRw==
X-Gm-Message-State: AOAM532CsFiCqxM3hiYx65yx6Dx/i4qY7zsQ/zKbA9juBZe/WcdFXThy
        wBRxUSfz+L71hg3YOmWUTkWI8VqLjKtOelNZ
X-Google-Smtp-Source: ABdhPJxXQp9zWk6yMcTDFyW1p35Okpjyhpnh//OqiGSal+U+Eo5gcHorj+8rKT+FlTFvc5fm0eZmQA==
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr8034198qkx.404.1599076890662;
        Wed, 02 Sep 2020 13:01:30 -0700 (PDT)
Received: from ubuntu (69-220-158-6.lightspeed.rlghnc.sbcglobal.net. [69.220.158.6])
        by smtp.gmail.com with ESMTPSA id i7sm479842qkb.131.2020.09.02.13.01.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2020 13:01:30 -0700 (PDT)
From:   Nachammai Karuppiah <nachukannan@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        Nachammai Karuppiah <nachukannan@gmail.com>
Subject: [RFC PATCH 5/7] tracing: Add support to iterate through pages retrieved from pstore
Date:   Wed,  2 Sep 2020 13:00:20 -0700
Message-Id: <c8bb8901205bb2de2e7c3dbca79d5001ed385792.1599072725.git.nachukannan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new trace_array, pstore_trace. This descriptor holds the
top-level buffers used for managing the pages retrieved from
persistent RAM. Since pstore_trace uses the pages that pertain to
previous boot, there is no write that happens to these buffers. The
reads are non-consuming and hence we do not have to serialize the
readers.

The buffers in pstore_trace are disabled once the user switches live
tracing to use persistent RAM buffer.

During the first seq_start method call to read the previous boot
trace entries, the top-level buffers of pstore_trace are set up.
The pages retrieved from pstore are used to construct
cpu_buffer->pages for pstore_trace.

Signed-off-by: Nachammai Karuppiah <nachukannan@gmail.com>
---
 include/linux/ring_buffer.h |  19 +++
 include/linux/trace.h       |  13 ++
 kernel/trace/ring_buffer.c  | 284 +++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        | 300 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h        |   2 +
 5 files changed, 616 insertions(+), 2 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index c76b2f3..ece71c9 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -18,6 +18,13 @@ struct ring_buffer_event {
 	u32		array[];
 };
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+struct data_page {
+	struct list_head        list;
+	struct buffer_data_page *page;
+};
+#endif
+
 /**
  * enum ring_buffer_type - internal ring buffer types
  *
@@ -210,4 +217,16 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+struct trace_buffer *reconstruct_ring_buffer(void);
+
+void ring_buffer_order_pages(struct list_head *pages);
+int ring_buffer_switch_memory(struct trace_buffer *buffer,
+			      const char *tracer_name, int clock_id,
+			      bool persist);
+void ring_buffer_set_tracer_name(struct trace_buffer *buffer,
+				 const char *tracer_name);
+void ring_buffer_free_pstore_trace(struct trace_buffer *buffer);
+#endif
+
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/linux/trace.h b/include/linux/trace.h
index 7fd86d3..8f37b70 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -32,6 +32,19 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
 void trace_array_put(struct trace_array *tr);
 struct trace_array *trace_array_get_by_name(const char *name);
 int trace_array_destroy(struct trace_array *tr);
+
+
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+struct trace_iterator;
+
+void *pstore_trace_start(struct seq_file *m, loff_t *pos);
+void *pstore_trace_next(struct seq_file *m, void *v, loff_t *pos);
+int pstore_trace_show(struct seq_file *m, void *v);
+void pstore_trace_stop(struct seq_file *m, void *v);
+int pstore_tracing_release(struct trace_iterator *iter);
+void pstore_tracing_erase(void);
+#endif
+
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 60b587a..34e50c1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1296,6 +1296,92 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	return 0;
 }
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+static int rb_reconstruct_pages(struct ring_buffer_per_cpu *cpu_buffer,
+				struct list_head *dpages, int cpu)
+{
+	struct buffer_page *bpage, *tmp;
+	struct data_page *dpage;
+	LIST_HEAD(pages);
+
+	list_for_each_entry(dpage, dpages, list) {
+		bpage = kzalloc(ALIGN(sizeof(*bpage), cache_line_size()),
+				GFP_KERNEL);
+		if (!bpage)
+			goto free_pages;
+
+		list_add_tail(&bpage->list, &pages);
+		bpage->page = dpage->page;
+	}
+
+	if (!list_empty(&pages)) {
+		cpu_buffer->pages = pages.next;
+		list_del(&pages);
+	} else
+		cpu_buffer->pages = NULL;
+
+	return 0;
+
+free_pages:
+	list_for_each_entry_safe(bpage, tmp, &pages, list) {
+		list_del(&bpage->list);
+		kfree(bpage);
+	}
+	return -ENOMEM;
+}
+
+static struct ring_buffer_per_cpu *
+__reconstruct_cpu_buffer(struct trace_buffer *rb, struct list_head *dpages,
+			 void *page, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct buffer_page *bpage;
+	struct data_page *dpage;
+
+	cpu_buffer = kzalloc(ALIGN(sizeof(*cpu_buffer), cache_line_size()),
+				GFP_KERNEL);
+	if (!cpu_buffer)
+		return NULL;
+
+	cpu_buffer->buffer = rb;
+	raw_spin_lock_init(&cpu_buffer->reader_lock);
+	lockdep_set_class(&cpu_buffer->reader_lock, rb->reader_lock_key);
+	cpu_buffer->lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+
+	bpage = kzalloc(ALIGN(sizeof(*bpage), cache_line_size()),
+			GFP_KERNEL);
+	if (!bpage)
+		goto fail_free_buffer;
+
+	bpage->page = page;
+
+	rb_check_bpage(cpu_buffer, bpage);
+	cpu_buffer->reader_page = bpage;
+	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
+	INIT_LIST_HEAD(&cpu_buffer->new_pages);
+
+	if (rb_reconstruct_pages(cpu_buffer, dpages, cpu) < 0)
+		goto fail_free_reader;
+	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
+
+	cpu_buffer->head_page = list_entry(cpu_buffer->pages,
+					struct buffer_page, list);
+	cpu_buffer->commit_page = list_entry(cpu_buffer->pages->prev,
+					struct buffer_page, list);
+
+	rb_head_page_activate(cpu_buffer);
+
+	return cpu_buffer;
+
+fail_free_reader:
+	free_buffer_page(cpu_buffer->reader_page);
+
+fail_free_buffer:
+	kfree(cpu_buffer);
+	return NULL;
+}
+#endif /* CONFIG_TRACE_EVENTS_TO_PSTORE */
+
 static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 {
@@ -1378,6 +1464,81 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+/**
+ * reconstruct_ring_buffer - reconstruct ring_buffer for pstore trace
+ */
+struct trace_buffer *reconstruct_ring_buffer(void)
+{
+	struct trace_buffer *buffer;
+	static struct lock_class_key __key;
+	void *page;
+	int bsize;
+	int i, cpu;
+
+	buffer = kzalloc(ALIGN(sizeof(*buffer), cache_line_size()),
+		     GFP_KERNEL);
+	if (!buffer)
+		return NULL;
+
+	if (!zalloc_cpumask_var(&buffer->cpumask, GFP_KERNEL))
+		goto release_buffer;
+	buffer->cpus = ramtrace_get_prev_boot_nr_cpus();
+
+	buffer->reader_lock_key = &__key;
+
+	bsize = sizeof(void *) * buffer->cpus;
+	buffer->buffers = kzalloc(ALIGN(bsize, cache_line_size()),
+				GFP_KERNEL);
+	if (!buffer->buffers)
+		goto release_cpumask_var;
+
+	/*
+	 * Allocate an empty reader page. This page doesn't contain any data
+	 * and is set as the reader page. The same reader page is used for all
+	 * CPU. Since this is an empty page and guaranteed to be empty always,
+	 * all CPUs can use the same page. The pages retrieved from PSTORE are
+	 * used to populate cpu_buffer->pages list.
+	 */
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, 0);
+	if (!page)
+		goto release_buffers;
+	page = page_address(page);
+	rb_init_page(page);
+	for (i = 0; i < buffer->cpus; i++) {
+		struct list_head *dpages = ramtrace_get_read_buffer(i);
+
+		if (dpages) {
+			buffer->buffers[i] = __reconstruct_cpu_buffer(buffer,
+								dpages, page, i);
+			if (!buffer->buffers[i])
+				goto release_reader_page;
+			cpumask_set_cpu(i, buffer->cpumask);
+		}
+
+	}
+	if (cpumask_empty(buffer->cpumask))
+		goto release_reader_page;
+
+	return buffer;
+
+release_reader_page:
+	free_page((unsigned long)page);
+release_buffers:
+	for_each_buffer_cpu(buffer, cpu) {
+		if (buffer->buffers[cpu])
+			rb_free_cpu_buffer(buffer->buffers[cpu]);
+	}
+	kfree(buffer->buffers);
+release_cpumask_var:
+	free_cpumask_var(buffer->cpumask);
+release_buffer:
+	kfree(buffer);
+	return NULL;
+}
+#endif /* CONFIG_TRACE_EVENTS_TO_PSTORE */
+
 /**
  * __ring_buffer_alloc - allocate a new ring_buffer
  * @size: the size in bytes per cpu that is needed.
@@ -1478,12 +1639,75 @@ ring_buffer_free(struct trace_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free);
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+static void
+rb_free_pstore_trace_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct list_head *head = cpu_buffer->pages;
+	struct buffer_page *bpage, *tmp;
+
+	kfree(cpu_buffer->reader_page);
+
+	if (head) {
+		rb_head_page_deactivate(cpu_buffer);
+		list_for_each_entry_safe(bpage, tmp, head, list) {
+			list_del_init(&bpage->list);
+			kfree(bpage);
+		}
+
+		bpage = list_entry(head, struct buffer_page, list);
+		kfree(bpage);
+	}
+	kfree(cpu_buffer);
+}
+
+/**
+ * ring_buffer_free_pstore_trace - free pstore_trace buffers.
+ *
+ * Free top-level buffers and buffer_page pertaining to previous boot trace
+ * provided by pstore_trace descriptor.
+ */
+void ring_buffer_free_pstore_trace(struct trace_buffer *buffer)
+{
+	int cpu;
+	void *page = NULL;
+
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!page) {
+			page = buffer->buffers[cpu]->reader_page->page;
+	printk("reader page %px\n", page);
+	free_page((unsigned long)page);
+			}
+		rb_free_pstore_trace_cpu_buffer(buffer->buffers[cpu]);
+	}
+	kfree(buffer->buffers);
+	free_cpumask_var(buffer->cpumask);
+
+	kfree(buffer);
+}
+#endif
+
 void ring_buffer_set_clock(struct trace_buffer *buffer,
 			   u64 (*clock)(void))
 {
 	buffer->clock = clock;
 }
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+void ring_buffer_set_tracer_name(struct trace_buffer *buffer,
+				 const char *tracer_name)
+{
+	int cpu;
+
+	get_online_cpus();
+	for_each_buffer_cpu(buffer, cpu)
+		if (buffer->buffers[cpu]->use_pstore && cpu_online(cpu)) {
+			ramtrace_set_tracer_name(tracer_name);
+			break;
+		}
+}
+#endif
+
 void ring_buffer_set_time_stamp_abs(struct trace_buffer *buffer, bool abs)
 {
 	buffer->time_stamp_abs = abs;
@@ -5251,6 +5475,66 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+void ring_buffer_order_pages(struct list_head *pages)
+{
+	struct data_page *temp, *data_page, *min_page;
+	u64 min_ts = 0;
+	u64 prev_ts;
+	int count = 0;
+
+	min_page = NULL;
+
+	/* Find the oldest page and move the list head before it.
+	 * While starting from the oldest page, the list should mostly be in
+	 * order except for few out of order pages as long as the buffer had
+	 * not been repeatedly expanded and shrunk.
+	 */
+	list_for_each_entry_safe(data_page, temp, pages, list) {
+		u64 ts = data_page->page->time_stamp;
+
+		if (ts == 0) {
+			list_del(&data_page->list);
+			kfree(data_page);
+		} else {
+			count++;
+			if (ts < min_ts || min_ts == 0) {
+				min_ts = ts;
+				min_page = data_page;
+			}
+		}
+	}
+
+	if (min_ts) {
+		/* move the list head before the oldest page */
+		list_move_tail(pages, &min_page->list);
+		prev_ts = min_ts;
+		data_page = min_page;
+		list_for_each_entry(data_page, pages, list) {
+			u64 ts = data_page->page->time_stamp;
+
+			if (ts >= prev_ts)
+				prev_ts = ts;
+			else {
+				struct data_page *node, *swap_page;
+
+				/* Move out of order page to the right place */
+				list_for_each_entry(node, pages, list) {
+					if (node->page->time_stamp > ts) {
+						swap_page = data_page;
+						data_page = list_entry(data_page->list.prev, struct data_page, list);
+						list_del(&swap_page->list);
+						list_add_tail(&swap_page->list, &node->list);
+						break;
+					}
+				}
+			}
+		}
+	}
+
+}
+#endif /* CONFIG_TRACE_EVENTS_TO_PSTORE */
+
 #ifdef CONFIG_RING_BUFFER_STARTUP_TEST
 /*
  * This is a basic integrity check of the ring buffer.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2b3d8e9..16e50ba8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -277,6 +277,16 @@ static struct trace_array global_trace = {
 	.trace_flags = TRACE_DEFAULT_FLAGS,
 };
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+/*
+ * The pstore_trace is the descriptor that holds the top-level tracing
+ * buffers for the pages retrieved from persistent storage.
+ */
+static struct trace_array pstore_trace = {
+	.trace_flags = TRACE_DEFAULT_FLAGS,
+};
+#endif
+
 LIST_HEAD(ftrace_trace_arrays);
 
 int trace_array_get(struct trace_array *this_tr)
@@ -650,6 +660,26 @@ int tracing_is_enabled(void)
 	return !global_trace.buffer_disabled;
 }
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+/**
+ * pstore_tracing_is_enabled - Show if pstore_trace has been disabled
+ *
+ * This is similar to tracing_is_enabled() but checks pstore_trace instead.
+ * pstore_trace holds the tracing buffers for the pages pertaining to previous
+ * boot retrieved from pstore.
+ */
+int pstore_tracing_is_enabled(void)
+{
+	/*
+	 * For quick access (irqsoff uses this in fast path), just
+	 * return the mirror variable of the state of the ring buffer.
+	 * It's a little racy, but we don't really care.
+	 */
+	smp_rmb();
+	return !pstore_trace.buffer_disabled;
+}
+#endif
+
 /*
  * trace_buf_size is the size in bytes that is allocated
  * for a buffer. Note, the number of bytes is always rounded
@@ -1299,6 +1329,21 @@ void tracing_off(void)
 }
 EXPORT_SYMBOL_GPL(tracing_off);
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+
+/**
+ * pstore_tracing_off - turn off tracing buffers.
+ *
+ * Incase of pstore_trace, turning off tracing buffers stops readers from
+ * retrieving any more data. This is needed once the global_trace tries to
+ * use pstore memory.
+ */
+void pstore_tracing_off(void)
+{
+	tracer_tracing_off(&pstore_trace);
+}
+#endif
+
 void disable_trace_on_warning(void)
 {
 	if (__disable_trace_on_warning) {
@@ -5826,7 +5871,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -5945,6 +5990,9 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	tr->current_trace = t;
 	tr->current_trace->enabled++;
 	trace_branch_enable(tr);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	ring_buffer_set_tracer_name(tr->array_buffer.buffer, tr->current_trace->name);
+#endif
  out:
 	mutex_unlock(&trace_types_lock);
 
@@ -7056,9 +7104,257 @@ static int snapshot_raw_open(struct inode *inode, struct file *filp)
 
 	return ret;
 }
-
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+/*
+ * pstore_trace_set_up - set up pstore_trace descriptor.
+ *
+ * This method is called during the seq_start method call to setup the
+ * pstore_trace for the very first read operation. The pages from pstore are
+ * read and ring buffer is constructed.
+ */
+static struct trace_array *pstore_trace_set_up(void)
+{
+	struct trace_array *p_tr = &pstore_trace;
+	struct tracer *t;
+	char *tracer_name;
+
+	/*
+	 * Create the top level buffers during first seq_start call.
+	 * Use the previously created one in the subsequent calls.
+	 */
+	if (p_tr->array_buffer.buffer)
+		return p_tr;
+
+	tracer_name = ramtrace_get_prev_boot_tracer_name();
+	mutex_lock(&trace_types_lock);
+	for (t = trace_types; t; t = t->next) {
+		if (strcmp(t->name, tracer_name) == 0)
+			break;
+	}
+	mutex_unlock(&trace_types_lock);
+	if (!t)
+		goto release_tr_info;
+	p_tr->current_trace = t;
+
+	p_tr->clock_id = ramtrace_get_prev_boot_clock_id();
+
+	p_tr->array_buffer.tr = p_tr;
+
+	p_tr->array_buffer.buffer = reconstruct_ring_buffer();
+	if (!p_tr->array_buffer.buffer)
+		goto release_tr_info;
+
+	raw_spin_lock_init(&p_tr->start_lock);
+
+	INIT_LIST_HEAD(&p_tr->systems);
+	INIT_LIST_HEAD(&p_tr->events);
+	INIT_LIST_HEAD(&p_tr->hist_vars);
+	INIT_LIST_HEAD(&p_tr->err_log);
+
+	ftrace_init_trace_array(p_tr);
+	list_add(&p_tr->list, &ftrace_trace_arrays);
+
+	return p_tr;
+
+release_tr_info:
+	return NULL;
+}
+
+static struct trace_iterator *pstore_iter_setup(void)
+{
+	struct trace_array *p_tr;
+	struct trace_iterator *iter;
+	int cpu, cpus;
+
+	p_tr = pstore_trace_set_up();
+	if (!p_tr)
+		return NULL;
+
+	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
+	if (!iter)
+		goto out;
+
+	iter->buffer_iter = kcalloc(nr_cpu_ids, sizeof(*iter->buffer_iter),
+			GFP_KERNEL);
+	if (!iter->buffer_iter)
+		goto release;
+
+	memset(iter->buffer_iter, 0, nr_cpu_ids * sizeof(*iter->buffer_iter));
+	iter->trace = p_tr->current_trace;
+	iter->trace->use_max_tr = false;
+
+	if (!zalloc_cpumask_var(&iter->started, GFP_KERNEL))
+		goto fail;
+
+	iter->tr = p_tr;
+	iter->array_buffer = &p_tr->array_buffer;
+
+	iter->snapshot = true;
+
+	iter->pos = -1;
+	iter->cpu_file = RING_BUFFER_ALL_CPUS;
+	mutex_init(&iter->mutex);
+
+	if (iter->trace && iter->trace->open)
+		iter->trace->open(iter);
+
+	if (trace_clocks[p_tr->clock_id].in_ns)
+		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
+
+	cpus = ramtrace_get_prev_boot_nr_cpus();
+	for (cpu = 0; cpu < cpus; cpu++) {
+		iter->buffer_iter[cpu] =
+		  ring_buffer_read_prepare(iter->array_buffer->buffer, cpu,
+					   GFP_KERNEL);
+	}
+	ring_buffer_read_prepare_sync();
+	for (cpu = 0; cpu < cpus; cpu++)
+		ring_buffer_read_start(iter->buffer_iter[cpu]);
+
+	return iter;
+
+fail:
+	kfree(iter->buffer_iter);
+release:
+	kfree(iter);
+out:
+	return ERR_PTR(-ENOMEM);
+}
+
+void *pstore_trace_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct trace_iterator *iter = m->private;
+	int i = (int) *pos;
+	void *ent;
+
+	WARN_ON_ONCE(iter->leftover);
+
+	(*pos)++;
+
+	/* can't go backwards */
+	if (iter->idx > i)
+		return NULL;
+
+	if (iter->idx < 0)
+		ent = trace_find_next_entry_inc(iter);
+	else
+		ent = iter;
+
+	while (ent && iter->idx < i)
+		ent = trace_find_next_entry_inc(iter);
+
+	iter->pos = *pos;
+
+	if (ent == NULL)
+		return NULL;
+	return iter;
+}
+/*
+ * Below are the seq_operation methods used to read the previous boot
+ * data pages from pstore. In this case, there is no producer and no
+ * consuming read. So we do not have to serialize readers.
+ */
+void *pstore_trace_start(struct seq_file *m, loff_t *pos)
+{
+	struct trace_iterator *iter = m->private;
+	void *p = NULL;
+	loff_t l = 0;
+
+	/*
+	 * pstore_trace is disabled once the user starts utilizing the
+	 * ramtrace pstore region to write the trace records.
+	 */
+	if (!pstore_tracing_is_enabled())
+		return NULL;
+	if (iter == NULL) {
+		iter = pstore_iter_setup();
+		if (!iter)
+			return NULL;
+		m->private = iter;
+	}
+
+
+	if (*pos != iter->pos) {
+		iter->ent = NULL;
+		iter->cpu = 0;
+		iter->idx = -1;
+		iter->leftover = 0;
+		for (p = iter; p && l < *pos; p = pstore_trace_next(m, p, &l))
+			;
+	} else {
+		if (!iter->leftover) {
+			l = *pos - 1;
+			p = pstore_trace_next(m, iter, &l);
+		} else
+			p = iter;
+	}
+
+	return p;
+}
+
+int pstore_trace_show(struct seq_file *m, void *v)
+{
+	struct trace_iterator *iter = v;
+	int ret;
+
+	if (iter->ent == NULL) {
+		if (iter->tr) {
+			seq_printf(m, "# tracer: %s\n", iter->trace->name);
+			seq_puts(m, "#\n");
+		}
+	} else if (iter->leftover) {
+		ret = trace_print_seq(m, &iter->seq);
+		iter->leftover = ret;
+
+	} else {
+		print_trace_line(iter);
+		ret = trace_print_seq(m, &iter->seq);
+		iter->leftover = ret;
+	}
+	return 0;
+}
+
+void pstore_trace_stop(struct seq_file *m, void *v)
+{
+}
+
+int pstore_tracing_release(struct trace_iterator *iter)
+{
+	int cpu;
+
+	if (!iter)
+		return 0;
+	mutex_lock(&trace_types_lock);
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		if (iter->buffer_iter[cpu])
+			ring_buffer_read_finish(iter->buffer_iter[cpu]);
+
+	if (iter->trace && iter->trace->close)
+		iter->trace->close(iter);
+
+	mutex_unlock(&trace_types_lock);
+	mutex_destroy(&iter->mutex);
+	free_cpumask_var(iter->started);
+	kfree(iter->buffer_iter);
+	kfree(iter);
+
+	return 0;
+}
+
+void pstore_tracing_erase(void)
+{
+	struct trace_array *trace = &pstore_trace;
+
+	if (!trace->array_buffer.buffer)
+		return;
+	ring_buffer_free_pstore_trace(trace->array_buffer.buffer);
+	trace->array_buffer.buffer = NULL;
+
+}
+#endif /* CONFIG_TRACE_EVENTS_TO_PSTORE */
+
 
 static const struct file_operations tracing_thresh_fops = {
 	.open		= tracing_open_generic,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2a4ab72..66670f8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2078,4 +2078,6 @@ static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
 	iter->pos = -1;
 }
 
+void pstore_tracing_off(void);
+
 #endif /* _LINUX_KERNEL_TRACE_H */
-- 
2.7.4

