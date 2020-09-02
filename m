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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A20C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5875207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNoYpFCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIBUBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBUBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:01:21 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425DFC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:01:21 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n10so178766qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vXJzHQSiPEjxLjmmiXf2/SYXLzuLuNI6bAhwXQSBPgs=;
        b=QNoYpFCtQqdTNUYoop/dWiIX/oJtGGTgb8xUcONSLuzyZj6E5O/R1TK/m+9oEgMwOg
         APbIK4ym4iaTMbH/kuGi5NnuHkk/qEDiiVLE033jXR3OyMvjJ2FZksQLr+VRb/ZX9sjc
         7M7zWE4ADoqgikRSR4MmfrUQke9v6SS8Fe/kPfN6VNK20XtIk2drdTZnnTai47HVQJaU
         98yBoCvL6tthD3GDL2o/BpspYVVttdVKDuzhVDVw4VPV6lNzqL/X015oanT8U5ZauZHn
         s5B5iXYRn7eMfZVvPS11t6P0B2KUCIkOqjBwEllo++0TMEljZVGAM4PLLeeT5OpEE2+Q
         2LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vXJzHQSiPEjxLjmmiXf2/SYXLzuLuNI6bAhwXQSBPgs=;
        b=gYrhkC8uMa4HwOEKAlOPSme4Ap/yJlrpT2opc7toPiqUnfjoHXp9zzF/9mzivyb35n
         0++jty3h3a7U8DT/AFHYDMJsGcaDM6TqGXcfznNN+w6NKIxEDULk5i3FCWpQWSWQNkBk
         WV92h7VjKXO4uylFRXjKTLUoJPM7hftkDarCv9srLqJHWfwLHdUiAGYQwrCP3s8IMQ8/
         WJQyd2vBLm3je+SnhX9OOKfv+LZGlOTl7ljg75oxzZE9Kz92Sqacg5bGM1iqEtcAxjyn
         wQNJF9NXmCxeru+jMsz/R/PFFPz+330Ayobrv6NOGJnNPQ02F7ME/wEaQ32cKiFKIDA1
         8YZw==
X-Gm-Message-State: AOAM5323gub2ZyvEyOXZXLjDxphceMDWJp8yzhxjILA5MR4r2y64bHD1
        Td2x0DptgZ/H57nsUjcTq0E=
X-Google-Smtp-Source: ABdhPJyIDhkEuDWM/f3C1+ijuCMVUQfBeojQukm63jNLS1CelkphME6Z1W42SJnyMAnUF0jDm/7Wuw==
X-Received: by 2002:ac8:3fdd:: with SMTP id v29mr8297710qtk.383.1599076880374;
        Wed, 02 Sep 2020 13:01:20 -0700 (PDT)
Received: from ubuntu (69-220-158-6.lightspeed.rlghnc.sbcglobal.net. [69.220.158.6])
        by smtp.gmail.com with ESMTPSA id g8sm552278qkl.28.2020.09.02.13.01.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2020 13:01:19 -0700 (PDT)
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
Subject: [RFC PATCH 1/7] tracing: Add support to allocate pages from persistent memory
Date:   Wed,  2 Sep 2020 13:00:16 -0700
Message-Id: <071107ae4f422057a2689d97867326169fa32112.1599072725.git.nachukannan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support in ring buffer to allocate pages from persistent RAM
buffer. This feature supports switching to persistent memory and vice-versa.
A new option 'persist' has been added and once this is enabled, the pages in
ring buffer are freed up and new pages are allocated from persistent
memory.

Signed-off-by: Nachammai Karuppiah <nachukannan@gmail.com>
---
 kernel/trace/Kconfig       |  10 ++
 kernel/trace/ring_buffer.c | 257 ++++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.c       |  12 ++-
 kernel/trace/trace.h       |   3 +-
 4 files changed, 279 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a4020c0..f72a9df 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -739,6 +739,16 @@ config GCOV_PROFILE_FTRACE
 	  Note that on a kernel compiled with this config, ftrace will
 	  run significantly slower.
 
+config TRACE_EVENTS_TO_PSTORE
+	bool "Enable users to store trace records in persistent storage"
+	default n
+	help
+	  This option enables users to store trace records in a
+	  persistent RAM buffer so that they can be retrieved after
+	  system reboot.
+
+	  If unsure, say N.
+
 config FTRACE_SELFTEST
 	bool
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f15471c..60b587a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -25,7 +25,7 @@
 #include <linux/list.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
-
+#include <linux/ramtrace.h>
 #include <asm/local.h>
 
 static void update_pages_handler(struct work_struct *work);
@@ -479,6 +479,9 @@ struct ring_buffer_per_cpu {
 	struct completion		update_done;
 
 	struct rb_irq_work		irq_work;
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	bool				use_pstore;
+#endif
 };
 
 struct trace_buffer {
@@ -513,6 +516,15 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+/* This semaphore is being used to ensure that buffer_data_page memory
+ * is not switched to persistent storage or vice versa while a reader page
+ * is swapped out. All consuming reads need to be finished before memory
+ * switch happens.
+ */
+DECLARE_RWSEM(trace_read_sem);
+#endif
+
 /**
  * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
@@ -1705,6 +1717,247 @@ static void update_pages_handler(struct work_struct *work)
 	complete(&cpu_buffer->update_done);
 }
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+static void free_buffer_data_page(struct buffer_data_page *page, int cpu,
+				  bool persist)
+{
+	if (persist)
+		ramtrace_free_page(page, cpu);
+	else
+		free_page((unsigned long)page);
+
+}
+
+static int rb_allocate_persistent_pages(struct buffer_data_page **pages,
+					int nr_pages, int cpu)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		void *address = ramtrace_alloc_page(cpu);
+
+		if (!address)
+			goto free_pages;
+		pages[i] = address;
+	}
+	return 0;
+
+free_pages:
+	for (i = 0; i < nr_pages; i++)
+		ramtrace_free_page(pages[i], cpu);
+
+	return -ENOMEM;
+}
+
+static int
+rb_allocate_buffer_data_pages(struct buffer_data_page **pages, int nr_pages,
+			      int cpu)
+{
+	bool user_thread = current->mm != NULL;
+	gfp_t mflags;
+	long i;
+
+	/*
+	 * Check if the available memory is there first.
+	 * Note, si_mem_available() only gives us a rough estimate of available
+	 * memory. It may not be accurate. But we don't care, we just want
+	 * to prevent doing any allocation when it is obvious that it is
+	 * not going to succeed.
+	 */
+	i = si_mem_available();
+	if (i < nr_pages)
+		return -ENOMEM;
+
+	/*
+	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
+	 * gracefully without invoking oom-killer and the system is not
+	 * destabilized.
+	 */
+	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
+
+	/*
+	 * If a user thread allocates too much, and si_mem_available()
+	 * reports there's enough memory, even though there is not.
+	 * Make sure the OOM killer kills this thread. This can happen
+	 * even with RETRY_MAYFAIL because another task may be doing
+	 * an allocation after this task has taken all memory.
+	 * This is the task the OOM killer needs to take out during this
+	 * loop, even if it was triggered by an allocation somewhere else.
+	 */
+	if (user_thread)
+		set_current_oom_origin();
+	for (i = 0; i < nr_pages; i++) {
+		struct page *page;
+
+		page = alloc_pages_node(cpu_to_node(cpu), mflags, 0);
+		if (!page)
+			goto free_pages;
+		pages[i] = page_address(page);
+		rb_init_page(pages[i]);
+
+		if (user_thread && fatal_signal_pending(current))
+			goto free_pages;
+	}
+
+	if (user_thread)
+		clear_current_oom_origin();
+	return 0;
+free_pages:
+	for (i = 0; i < nr_pages; i++)
+		free_page((unsigned long)pages[i]);
+
+	return -ENOMEM;
+}
+
+static void rb_switch_memory(struct trace_buffer *buffer, bool persist)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct list_head *head;
+	struct buffer_page *bpage;
+	struct buffer_data_page ***new_pages;
+	unsigned long flags;
+	int cpu, nr_pages;
+
+	new_pages = kmalloc_array(buffer->cpus, sizeof(void *), GFP_KERNEL);
+
+	for_each_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+		nr_pages = cpu_buffer->nr_pages;
+		/* Include the reader page */
+		new_pages[cpu] = kmalloc_array(nr_pages + 1, sizeof(void *), GFP_KERNEL);
+		if (persist) {
+			if (rb_allocate_persistent_pages(new_pages[cpu],
+						nr_pages + 1, cpu) < 0)
+			goto out;
+		} else {
+			if (rb_allocate_buffer_data_pages(new_pages[cpu],
+					nr_pages + 1, cpu) < 0)
+				goto out;
+		}
+	}
+
+	for_each_buffer_cpu(buffer, cpu) {
+		int i = 0;
+
+		cpu_buffer = buffer->buffers[cpu];
+		nr_pages = cpu_buffer->nr_pages;
+		/* Acquire the reader lock to ensure reading is disabled.*/
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+		if (RB_WARN_ON(cpu_buffer, local_read(&cpu_buffer->committing)))
+			goto out;
+		/* Prevent another thread from grabbing free_page. */
+		arch_spin_lock(&cpu_buffer->lock);
+
+		free_buffer_data_page(cpu_buffer->reader_page->page,
+				      cpu, cpu_buffer->use_pstore);
+		cpu_buffer->reader_page->page = new_pages[cpu][i++];
+		rb_head_page_deactivate(cpu_buffer);
+
+		head = cpu_buffer->pages;
+		if (head) {
+			list_for_each_entry(bpage, head, list) {
+				free_buffer_data_page(bpage->page, cpu,
+						      cpu_buffer->use_pstore);
+				bpage->page = new_pages[cpu][i++];
+				rb_init_page(bpage->page);
+			}
+			bpage = list_entry(head, struct buffer_page, list);
+			free_buffer_data_page(bpage->page, cpu,
+					      cpu_buffer->use_pstore);
+			bpage->page = new_pages[cpu][nr_pages];
+			rb_init_page(bpage->page);
+		}
+		kfree(new_pages[cpu]);
+
+		if (cpu_buffer->free_page) {
+			free_buffer_data_page(cpu_buffer->free_page, cpu,
+					      cpu_buffer->use_pstore);
+			cpu_buffer->free_page = 0;
+		}
+
+		cpu_buffer->use_pstore = persist;
+
+		rb_reset_cpu(cpu_buffer);
+		arch_spin_unlock(&cpu_buffer->lock);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+
+	kfree(new_pages);
+	return;
+out:
+	for_each_buffer_cpu(buffer, cpu) {
+		int i = 0;
+
+		cpu_buffer = buffer->buffers[cpu];
+		for (i = 0; i < cpu_buffer->nr_pages + 1; i++) {
+			if (new_pages[cpu][i])
+				free_buffer_data_page(new_pages[cpu][i], cpu,
+						      persist);
+		}
+		kfree(new_pages[cpu]);
+	}
+	kfree(new_pages);
+}
+
+void pstore_tracing_off(void);
+
+/**
+ * ring_buffer_switch_memory - If boolean argument 'persist' is true, switch
+ * to persistent memory and if false, switch to non persistent memory.
+ */
+int
+ring_buffer_switch_memory(struct trace_buffer *buffer, const char *tracer_name,
+			  int clock_id, bool persist)
+{
+	int cpu;
+	int online_cpu = 0;
+	int nr_pages_total = 0;
+
+	if (RB_WARN_ON(buffer, !down_write_trylock(&trace_read_sem)))
+		return -EBUSY;
+
+	if (persist) {
+		/* Quit if there is no reserved ramtrace region available */
+		if (!is_ramtrace_available())
+			return -ENOMEM;
+
+		/* Disable pstore_trace buffers which are used for reading
+		 * previous boot data pages.
+		 */
+		pstore_tracing_off();
+
+		/* Estimate the number of pages needed. */
+		for_each_buffer_cpu(buffer, cpu) {
+			online_cpu++;
+			/* count the reader page as well */
+			nr_pages_total += buffer->buffers[cpu]->nr_pages + 1;
+		}
+		/* Initialize ramtrace pages */
+		if (init_ramtrace_pages(online_cpu, nr_pages_total, tracer_name, clock_id))
+			return -ENOMEM;
+	}
+
+
+	ring_buffer_record_disable(buffer);
+
+	/* Make sure all pending commits have finished */
+	synchronize_rcu();
+
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+
+	rb_switch_memory(buffer, persist);
+
+	mutex_unlock(&buffer->mutex);
+
+	ring_buffer_record_enable(buffer);
+	up_write(&trace_read_sem);
+	return 0;
+
+}
+#endif
+
 /**
  * ring_buffer_resize - resize the ring buffer
  * @buffer: the buffer to resize.
@@ -4716,6 +4969,7 @@ void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 
  out:
 	rb_init_page(bpage);
+	down_read(&trace_read_sem);
 
 	return bpage;
 }
@@ -4753,6 +5007,7 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 
  out:
 	free_page((unsigned long)bpage);
+	up_read(&trace_read_sem);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb62269..2b3d8e9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -48,6 +48,7 @@
 #include <linux/fsnotify.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/ramtrace.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -265,7 +266,8 @@ unsigned long long ns2usecs(u64 nsec)
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
-	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK)
+	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK |			\
+	 TRACE_ITER_PERSIST)
 
 /*
  * The global_trace is the descriptor that holds the top-level tracing
@@ -4851,6 +4853,14 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		trace_printk_control(enabled);
 	}
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	if (mask == TRACE_ITER_PERSIST) {
+		ring_buffer_switch_memory(tr->array_buffer.buffer,
+					  tr->current_trace->name,
+					  tr->clock_id, enabled);
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 13db400..2a4ab72 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1336,7 +1336,8 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-		BRANCH_FLAGS
+		BRANCH_FLAGS					\
+		C(PERSIST,		"persist"),
 
 /*
  * By defining C, we can make TRACE_FLAGS a list of bit names
-- 
2.7.4

