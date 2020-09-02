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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE83C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408A6207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN1D82+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIBUBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgIBUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:01:33 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2254C061249
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:01:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d20so939215qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7pDoBXPlYeWPUtZm+sZHbNINSW/2NZCcI7xwI04WHX0=;
        b=ZN1D82+sQ4JgKdDSBDMH3VV3v9i6jgSL4Haligr/VKnZnzkg/mFZnfLqHdMgGzXniu
         Lb6/1JsfMclFv+6GoU4D87MK31TkT/zYWRchGgH+uxkhSP/xNQflm8x2l6dKegk+CMMG
         sh/ZM4eLtQR4Xe0jkI4ILbwQ5aHa/uQThxUWTuuNrwwAKXdtJc8dvCnqCi4jWjKw9ozj
         GPWCO0GW+jhnQtV/U1dB3zqvz1r81KgAh+yMbRcp13N9GixLniThDJod9WDozdNaHJv2
         ksIRKJ7VY6qgRG1mBQHO4+1PhTabAdVdorypXfCyyGuCIAZmiIEsq+FEg7ZTFQp6GjMK
         icZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7pDoBXPlYeWPUtZm+sZHbNINSW/2NZCcI7xwI04WHX0=;
        b=A53nZlQ3mpoI5zGl/j9hIFtGDmnxudXMgnBxrnvWx2eI9HLw1GBzTbpuQ1W1qYCpNM
         B24+9exb4Qcted2hzHHwzKUjPXFZIq5u42/roi9tLOoe0735kkUS6AbzfveWEuCCqXir
         dORzlAOSpmvzG8IemVsUXbhGYKHtprIpqw8zcrSuhyCNX+T9XCJUQIFVacJZqsoWexNV
         QEdZt257XZQiL9JtcE7ryw34Ta/v2s4ANDOOA4ZEFAMnrIJSzTpPbVkcWmnw1WyPxts8
         jOIbYhdSNCFid+wq3ax5yM6ZBPKHkfA6heOZwESHlktfkN/Q2CYM2w/xJfV0UKMDoK/Z
         jPaw==
X-Gm-Message-State: AOAM533RbZAbvDU9T0JDLl4CGnxVR7Y1+5anqXPcAQrlhmG8ByfNNkT0
        NJoF2vR7e+g5UWg49KOP3X76mZbh8UYS2vxu
X-Google-Smtp-Source: ABdhPJy/LK0AJ2tVcWREsO/Vbms666qF83apK7H9FHByRjprPgvdHn8Ka3j1EKSPphV25JjWepj9PQ==
X-Received: by 2002:a05:620a:127b:: with SMTP id b27mr8280131qkl.398.1599076892123;
        Wed, 02 Sep 2020 13:01:32 -0700 (PDT)
Received: from ubuntu (69-220-158-6.lightspeed.rlghnc.sbcglobal.net. [69.220.158.6])
        by smtp.gmail.com with ESMTPSA id i10sm563915qkh.15.2020.09.02.13.01.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2020 13:01:31 -0700 (PDT)
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
Subject: [RFC PATCH 6/7] tracing: Use ramtrace alloc and free methods while using persistent RAM
Date:   Wed,  2 Sep 2020 13:00:21 -0700
Message-Id: <6fe6de0e7093a61c8b8ff151bf9cef67e5ca7343.1599072725.git.nachukannan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If persistent RAM is being used to record trace entries, allocate and
free pages using ramtrace_alloc_page and ramtrace_free_page.

Signed-off-by: Nachammai Karuppiah <nachukannan@gmail.com>
---
 kernel/trace/ring_buffer.c | 122 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 34e50c1..c99719e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -353,6 +353,18 @@ static void free_buffer_page(struct buffer_page *bpage)
 	kfree(bpage);
 }
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+static void
+free_buffer_page_cpu(struct buffer_page *bpage, int cpu, bool use_pstore)
+{
+	if (use_pstore) {
+		ramtrace_free_page(bpage->page, cpu);
+		kfree(bpage);
+	} else
+		free_buffer_page(bpage);
+}
+#endif
+
 /*
  * We need to fit the time_stamp delta into 27 bits.
  */
@@ -1200,7 +1212,12 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	return 0;
 }
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu,
+				bool use_pstore)
+#else
 static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
+#endif
 {
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
@@ -1214,6 +1231,11 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 	 * to prevent doing any allocation when it is obvious that it is
 	 * not going to succeed.
 	 */
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	if (use_pstore)
+		i = ramtrace_available_mem();
+	else
+#endif
 	i = si_mem_available();
 	if (i < nr_pages)
 		return -ENOMEM;
@@ -1246,10 +1268,22 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 
 		list_add(&bpage->list, pages);
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+		if (use_pstore) {
+			void *address = ramtrace_alloc_page(cpu);
+
+			if (!address)
+				goto free_pages;
+			bpage->page = address;
+		} else {
+#endif
 		page = alloc_pages_node(cpu_to_node(cpu), mflags, 0);
 		if (!page)
 			goto free_pages;
 		bpage->page = page_address(page);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+		}
+#endif
 		rb_init_page(bpage->page);
 
 		if (user_thread && fatal_signal_pending(current))
@@ -1263,7 +1297,11 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 free_pages:
 	list_for_each_entry_safe(bpage, tmp, pages, list) {
 		list_del_init(&bpage->list);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+		free_buffer_page_cpu(bpage, cpu, use_pstore);
+#else
 		free_buffer_page(bpage);
+#endif
 	}
 	if (user_thread)
 		clear_current_oom_origin();
@@ -1278,7 +1316,12 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(!nr_pages);
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	if (__rb_allocate_pages(nr_pages, &pages, cpu_buffer->cpu,
+				cpu_buffer->use_pstore))
+#else
 	if (__rb_allocate_pages(nr_pages, &pages, cpu_buffer->cpu))
+#endif
 		return -ENOMEM;
 
 	/*
@@ -1414,10 +1457,23 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	rb_check_bpage(cpu_buffer, bpage);
 
 	cpu_buffer->reader_page = bpage;
+
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	if (cpu_buffer->use_pstore) {
+		void *address = ramtrace_alloc_page(cpu);
+
+		if (!address)
+			goto fail_free_reader;
+		bpage->page = address;
+	} else {
+#endif
 	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, 0);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	}
+#endif
 	rb_init_page(bpage->page);
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
@@ -1436,7 +1492,12 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	return cpu_buffer;
 
  fail_free_reader:
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	free_buffer_page_cpu(cpu_buffer->reader_page, cpu,
+			     cpu_buffer->use_pstore);
+#else
 	free_buffer_page(cpu_buffer->reader_page);
+#endif
 
  fail_free_buffer:
 	kfree(cpu_buffer);
@@ -1447,18 +1508,32 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *head = cpu_buffer->pages;
 	struct buffer_page *bpage, *tmp;
-
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	free_buffer_page_cpu(cpu_buffer->reader_page, cpu_buffer->cpu,
+			     cpu_buffer->use_pstore);
+#else
 	free_buffer_page(cpu_buffer->reader_page);
+#endif
 
 	rb_head_page_deactivate(cpu_buffer);
 
 	if (head) {
 		list_for_each_entry_safe(bpage, tmp, head, list) {
 			list_del_init(&bpage->list);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+			free_buffer_page_cpu(bpage, cpu_buffer->cpu,
+					     cpu_buffer->use_pstore);
+#else
 			free_buffer_page(bpage);
+#endif
 		}
 		bpage = list_entry(head, struct buffer_page, list);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+		free_buffer_page_cpu(bpage, cpu_buffer->cpu,
+				     cpu_buffer->use_pstore);
+#else
 		free_buffer_page(bpage);
+#endif
 	}
 
 	kfree(cpu_buffer);
@@ -1832,7 +1907,12 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		 * We have already removed references to this list item, just
 		 * free up the buffer_page and its page
 		 */
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+		free_buffer_page_cpu(to_remove_page, cpu_buffer->cpu,
+				     cpu_buffer->use_pstore);
+#else
 		free_buffer_page(to_remove_page);
+#endif
 		nr_removed--;
 
 	} while (to_remove_page != last_page);
@@ -1913,7 +1993,12 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 		list_for_each_entry_safe(bpage, tmp, &cpu_buffer->new_pages,
 					 list) {
 			list_del_init(&bpage->list);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+			free_buffer_page_cpu(bpage, cpu_buffer->cpu,
+					     cpu_buffer->use_pstore);
+#else
 			free_buffer_page(bpage);
+#endif
 		}
 	}
 	return success;
@@ -2252,8 +2337,14 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			 * allocated without receiving ENOMEM
 			 */
 			INIT_LIST_HEAD(&cpu_buffer->new_pages);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+			if (__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
+						&cpu_buffer->new_pages, cpu,
+						cpu_buffer->use_pstore)) {
+#else
 			if (__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
 						&cpu_buffer->new_pages, cpu)) {
+#endif
 				/* not enough memory for new pages */
 				err = -ENOMEM;
 				goto out_err;
@@ -2319,7 +2410,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);
 		if (cpu_buffer->nr_pages_to_update > 0 &&
 			__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+					    &cpu_buffer->new_pages, cpu_id,
+					    cpu_buffer->use_pstore)) {
+#else
 					    &cpu_buffer->new_pages, cpu_id)) {
+#endif
 			err = -ENOMEM;
 			goto out_err;
 		}
@@ -2379,7 +2475,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		list_for_each_entry_safe(bpage, tmp, &cpu_buffer->new_pages,
 					list) {
 			list_del_init(&bpage->list);
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+			free_buffer_page_cpu(bpage, cpu,
+					     cpu_buffer->use_pstore);
+#else
 			free_buffer_page(bpage);
+#endif
 		}
 	}
  out_err_unlock:
@@ -5184,13 +5285,22 @@ void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage)
 		goto out;
 
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	if (cpu_buffer->use_pstore) {
+		bpage = (struct buffer_data_page *)ramtrace_alloc_page(cpu);
+		if (!bpage)
+			return ERR_PTR(-ENOMEM);
+	} else {
+#endif
 	page = alloc_pages_node(cpu_to_node(cpu),
 				GFP_KERNEL | __GFP_NORETRY, 0);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
 	bpage = page_address(page);
-
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	}
+#endif
  out:
 	rb_init_page(bpage);
 	down_read(&trace_read_sem);
@@ -5229,7 +5339,13 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 	arch_spin_unlock(&cpu_buffer->lock);
 	local_irq_restore(flags);
 
- out:
+out:
+#ifdef CONFIG_TRACE_EVENTS_TO_PSTORE
+	if (cpu_buffer->use_pstore) {
+		ramtrace_free_page(bpage, cpu);
+		return;
+	}
+#endif
 	free_page((unsigned long)bpage);
 	up_read(&trace_read_sem);
 }
-- 
2.7.4

