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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839EAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54973207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6hFlpGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIBUBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgIBUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:01:32 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7E6C061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:01:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b13so220982qvl.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:in-reply-to:references:content-transfer-encoding;
        bh=Fn+xZCemAkc+evpdgvmDulDMkXTwS0jfWjyz/NsWJdY=;
        b=u6hFlpGO6OaUfDS3P4u7d6Z/f1LIUxpjlqS2qs3OAmtKlVgSYs5WxewZUsS1F4LSO/
         5vsbIoH1LRSNx+DNvyUkZmeBQ34xdMtNLaXzfpkxuNhFv0VAAS8z9+MikjXA5XW62HrA
         qLFrmIRn2H+AcUXiEl/Oawgypl/yIqQXhoMPbv7hupJtCydAxpW0QyHHiEOVl2Gg13It
         Bj1Wt08oEwhk7Pd9YIcBH51zpP7FfBQph+IwIlzEW90dPzd2k+Wr2UsOOdX0zRtQkv84
         CZj4SAvmW0Y8AtDosnDB9pBtLyMK8OFs1RQDmV6ub/HnkAjCPm/N+LyxlI35aGlshT8V
         Bfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:in-reply-to:references
         :content-transfer-encoding;
        bh=Fn+xZCemAkc+evpdgvmDulDMkXTwS0jfWjyz/NsWJdY=;
        b=pk29JZr8NM9/Xc31DdHnbgDAuYq0pn5mULm/YTSQd2piaVwDcDj3rRbOHUo1fanBro
         GY8plSYQhER3QT2iSJQG3cHATNpeEWHgod8OZthqP1H9ehNLUzBinCNLKi3P69z/qX6o
         d17Fy5G93J3uAyp/PE6cxYJw7mrd1NtOEZErB7e9CiCSROoysBsqaXFlmIo/OZ5En0hh
         rf6LfkpdCOMwpT2bg+7L7dYEw2nzbfNaKwThpFwRW4RoFb6OUW42mrohw0gV+8OkmD0g
         7XHn+zMAL4ZMlZ51WIpWOLM5MQxLA4DavhmKtaB6aIndZf0vkwPvM5o7KKhZwWHZMq6t
         7vJQ==
X-Gm-Message-State: AOAM532fC/aa/wyvSvq98YhIrz5xN008iQUf9zwzadX4uhb/7r23HV/X
        g1GJC2RBR5q8oFwqyZwj9d8=
X-Google-Smtp-Source: ABdhPJzRshMnZZIe5jkbPV/7pzpZgjOnHL0/nuyzUuDLJEwVbnfikLVUe/gHWHpZR7Twn9ti3nug8Q==
X-Received: by 2002:a0c:ec02:: with SMTP id y2mr8607449qvo.140.1599076889542;
        Wed, 02 Sep 2020 13:01:29 -0700 (PDT)
Received: from ubuntu (69-220-158-6.lightspeed.rlghnc.sbcglobal.net. [69.220.158.6])
        by smtp.gmail.com with ESMTPSA id v202sm563398qka.5.2020.09.02.13.01.28
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2020 13:01:29 -0700 (PDT)
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
Subject: [RFC PATCH 4/7] pstore: Allocate and free page-sized memory in persistent RAM buffer
Date:   Wed,  2 Sep 2020 13:00:19 -0700
Message-Id: <7ef58794de70cc8afe301c373dcf073536668b40.1599072725.git.nachukannan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ramtrace backend acts as a page allocator and manages
the persistent RAM buffer.

ramtrace supports allocation and deallocation of page-sized memory
through methods, ramtrace_alloc_page and ramtrace_free_page.
This functionality is required by ring buffer in trace when the user
switches to persistent storage.

Just prior to allocating pages for recording trace entries, ramtrace
backend frees up the list used to maintain pages pertaining to previous
boot. After this, reading previous boot trace entries from
/sys/fs/pstore is disabled.

Signed-off-by: Nachammai Karuppiah <nachukannan@gmail.com>
---
 fs/pstore/ramtrace.c     | 336 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ramtrace.h |  13 ++
 2 files changed, 349 insertions(+)

diff --git a/fs/pstore/ramtrace.c b/fs/pstore/ramtrace.c
index ca48a76..de6d09e8 100644
--- a/fs/pstore/ramtrace.c
+++ b/fs/pstore/ramtrace.c
@@ -19,6 +19,17 @@ module_param(mem_size, ulong, 0400);
 MODULE_PARM_DESC(mem_size,
 		"size of reserved RAM used to store trace data");
 
+struct ramtrace_pagelist {
+	struct list_head list;
+	void *page;
+};
+
+struct tr_persistent_info {
+	char                    *tracer_name;
+	int		       trace_clock;
+	unsigned int            nr_cpus;
+	struct list_head        **data_pages;
+};
 
 struct ramtrace_context {
 	phys_addr_t phys_addr;	/* Physical address of the persistent memory */
@@ -37,6 +48,50 @@ struct ramtrace_context {
 	int read_buffer_status;
 };
 
+/*
+ * The first page in the ramtrace area is the metadata page, followed by
+ * bitmap pages and then the buffer_data_page allocated by trace.
+ * Each bitmap page can represent upto page_size * 8 number of pages.
+ * The number of bitmaps needed per cpu is determined by the size of the
+ * pstore memory. Each CPU is allocated sufficient bitmap pages to represent
+ * the entire memory region.
+ * The figure below illustrates how the ramtrace memory area is organized.
+ *
+ * +------------------------------------------+
+ * | metadata                                 |
+ * +------------------------------------------+
+ * | CPU 1 Bitmap 1 to buffer pages           |
+ * +------------------------------------------+
+ * | CPU 1 Bitmap 2 to buffer pages           |
+ * +------------------------------------------+
+ * | . . .                                    |
+ * +------------------------------------------+
+ * | CPU 1 Bitmap K to buffer pages           |
+ * +------------------------------------------+
+ * | CPU 2 Bitmap 1 to buffer pages           |
+ * +------------------------------------------+
+ * | CPU 2 Bitmap 2 to buffer pages           |
+ * +------------------------------------------+
+ * | . . .                                    |
+ * +------------------------------------------+
+ * | CPU 2 Bitmap K to buffer pages           |
+ * +------------------------------------------+
+ * | . . .      . . .                         |
+ * +------------------------------------------+
+ * | CPU N Bitmap K to buffer pages           |
+ * +------------------------------------------+
+ * | buffer_data_page 1 belonging to any CPU  |
+ * +------------------------------------------+
+ * | buffer_data_page 2 belonging to any CPU  |
+ * +------------------------------------------+
+ * | . . .                                    |
+ * +------------------------------------------+
+ * | buffer_data_page (K x 4096)              |
+ * | belonging to any CPU                     |
+ * +------------------------------------------+
+ */
+
+static void ramtrace_read_pages(void);
 static int ramtrace_pstore_open(struct pstore_info *psi);
 static ssize_t ramtrace_pstore_read(struct pstore_record *record);
 static int ramtrace_pstore_erase(struct pstore_record *record);
@@ -122,6 +177,227 @@ static int ramtrace_pstore_erase(struct pstore_record *record)
 
 static struct platform_device *dummy;
 
+bool is_ramtrace_available(void)
+{
+	return (trace_ctx.size > 0) ? 1 : 0;
+}
+
+int ramtrace_available_mem(void)
+{
+	return trace_ctx.pages_available;
+}
+
+/**
+ * ramtrace_init_bitmap: Initialize bitmap pages.
+ *
+ * This method allocates and initializes bitmap pages.
+ */
+static void ramtrace_init_bitmap(unsigned int npages)
+{
+	int i;
+	unsigned long flags;
+	struct ramtrace_pagelist *freelist = trace_ctx.freelist;
+
+	trace_ctx.bitmap_pages = kmalloc_array(npages, sizeof(void *),
+					       GFP_KERNEL);
+	spin_lock_irqsave(&trace_ctx.lock, flags);
+	for (i = 0; i < npages; i++) {
+		struct ramtrace_pagelist *freelist_node;
+		void *page;
+
+		freelist_node = list_next_entry(freelist, list);
+		page = freelist_node->page;
+		memset(page, 0, PAGE_SIZE);
+		trace_ctx.bitmap_pages[i] = page;
+		list_del(&freelist_node->list);
+		kfree(freelist_node);
+	}
+	spin_unlock_irqrestore(&trace_ctx.lock, flags);
+	trace_ctx.base_address = trace_ctx.bitmap_pages[npages - 1] + PAGE_SIZE;
+}
+
+
+static void ramtrace_write_int(int **buffer, int n)
+{
+	**buffer = n;
+	(*buffer)++;
+}
+
+void ramtrace_set_clock_id(int clock_id)
+{
+	*(trace_ctx.clock_id) = clock_id;
+}
+
+void ramtrace_set_tracer_name(const char *tracer_name)
+{
+	sprintf(trace_ctx.tracer_name, "%s", tracer_name);
+}
+
+/*
+ * init_ramtrace_pages: Initialize metadata page, bitmap and trace context.
+ *
+ * Below is the layout of the metadata page.
+ * +------------------------------------------+
+ * | Kernel Version                           |
+ * +------------------------------------------+
+ * | tracer_name                              |
+ * +------------------------------------------+
+ * | Number of CPU’s Buffers = N              |
+ * +------------------------------------------+
+ * | trace_clock_name                         |
+ * +------------------------------------------+
+ * | pages per cpu			      |
+ * +------------------------------------------+
+ */
+
+int
+init_ramtrace_pages(int cpu, unsigned long npages, const char *tracer_name,
+		    int clock_id)
+{
+	const char kernel_version[] = UTS_RELEASE;
+	struct ramtrace_pagelist *freelist_node;
+	void *metapage;
+	unsigned long flags;
+	int n_bitmap = 0;
+	int ramtrace_pages;
+
+
+	ramtrace_pages = (trace_ctx.size >> PAGE_SHIFT) - 1;
+
+	/* Calculate number of bitmap pages required for npages */
+	n_bitmap = ramtrace_pages / ((PAGE_SIZE << 3) + cpu);
+
+	if (ramtrace_pages % (PAGE_SIZE << 3) > cpu)
+		n_bitmap++;
+	if (ramtrace_pages - n_bitmap < npages)
+		return 1;
+
+	spin_lock_irqsave(&trace_ctx.lock, flags);
+	freelist_node = list_next_entry(trace_ctx.freelist, list);
+	metapage = freelist_node->page;
+	list_del(&freelist_node->list);
+	spin_unlock_irqrestore(&trace_ctx.lock, flags);
+
+	pstore_tracing_erase();
+	free_persist_info();
+
+	/* Initialize metadata page */
+	ramtrace_write_int((int **)&metapage, cpu);
+	trace_ctx.clock_id = (int *)metapage;
+	ramtrace_write_int((int **)&metapage, clock_id);
+	ramtrace_write_int((int **)&metapage, n_bitmap);
+	sprintf(metapage, "%s", kernel_version);
+	metapage += strlen(kernel_version) + 1;
+	trace_ctx.tracer_name = (char *)metapage;
+	sprintf(metapage, "%s", tracer_name);
+
+	kfree(freelist_node);
+	trace_ctx.cpu = cpu;
+	trace_ctx.num_bitmap_per_cpu = n_bitmap;
+	trace_ctx.pages_available = ramtrace_pages - n_bitmap;
+	ramtrace_init_bitmap(cpu * n_bitmap);
+	return 0;
+}
+
+static void ramtrace_set_bit(char *bitmap, int index)
+{
+	bitmap[index >> 3] |= (1 << index % 8);
+}
+
+static bool ramtrace_is_allocated(char *bitmap, int index)
+{
+	return bitmap[index >> 3] & (1 << index % 8);
+}
+
+static void ramtrace_reset_bit(char *bitmap, int index)
+{
+	bitmap[index >> 3] &= ~(1 << index % 8);
+}
+
+
+void *ramtrace_alloc_page(int cpu)
+{
+	void *address = NULL;
+	struct ramtrace_pagelist *freelist = trace_ctx.freelist;
+
+	if (!list_empty(&freelist->list)) {
+		struct ramtrace_pagelist *freelist_node;
+		char *bitmap_page;
+		unsigned long page_num;
+		unsigned long flags;
+		int index, bitmap_page_index;
+
+		/* Acquire lock and obtain a page from freelist */
+		spin_lock_irqsave(&trace_ctx.lock, flags);
+		freelist_node = list_next_entry(freelist, list);
+		list_del(&freelist_node->list);
+		trace_ctx.pages_available--;
+		spin_unlock_irqrestore(&trace_ctx.lock, flags);
+
+		address = freelist_node->page;
+		memset(address, 0, PAGE_SIZE);
+
+		/* Determine the bitmap index for the allocated page */
+		page_num = (address - trace_ctx.base_address) >> PAGE_SHIFT;
+
+		/* Every bitmap page represents PAGE_SIZE * 8 or
+		 * 1 << (PAGE_SHIFT + 3) pages. Determine the nth bitmap for
+		 * this cpu assosciated with the allocated page address.
+		 */
+		bitmap_page_index = page_num >> (PAGE_SHIFT + 3);
+		bitmap_page = trace_ctx.bitmap_pages[trace_ctx.num_bitmap_per_cpu * cpu + bitmap_page_index];
+		/* Determine the index */
+		index = page_num - (bitmap_page_index << (PAGE_SHIFT + 3));
+
+		ramtrace_set_bit(bitmap_page, index);
+
+	}
+	return address;
+
+}
+
+void ramtrace_free_page(void *page_address, int cpu)
+{
+	void *bitmap;
+	int index;
+
+	/*
+	 * Determine the page number by calculating the offset from the base
+	 * address and divide it by page size.
+	 * Each bitmap can hold page_size * 8 indices. In case we have more
+	 * than one bitmap per cpu, divide page_num by (page size * 8).
+	 */
+	unsigned long page_num = (page_address - trace_ctx.base_address) >> PAGE_SHIFT;
+	int bitmap_page_index = page_num >> (PAGE_SHIFT + 3);
+
+	if (page_address == NULL)
+		return;
+	bitmap = (char *)(trace_ctx.bitmap_pages[trace_ctx.num_bitmap_per_cpu * cpu + bitmap_page_index]);
+	/*
+	 * When a single bitmap per cpu is used, page_num gives the index
+	 * in the bitmap. In case of multiple bitmaps per cpu,
+	 * page_num - bitmap_page_index * page_size * 8 gives the index.
+	 * Note: When page_num is less than (page_size * 8), bitmap_page_index
+	 * is zero.
+	 * */
+	index = page_num - (bitmap_page_index << (PAGE_SHIFT + 3));
+	if (ramtrace_is_allocated(bitmap, index)) {
+		struct ramtrace_pagelist *freelist_node =
+			kmalloc(sizeof(struct ramtrace_pagelist), GFP_KERNEL);
+		unsigned long flags;
+
+		freelist_node->page = page_address;
+		spin_lock_irqsave(&trace_ctx.lock, flags);
+		list_add_tail(&freelist_node->list, &(trace_ctx.freelist->list));
+		trace_ctx.pages_available++;
+		spin_unlock_irqrestore(&trace_ctx.lock, flags);
+
+		ramtrace_reset_bit(bitmap, index);
+	}
+
+}
+
+
 static int ramtrace_parse_dt(struct platform_device *pdev,
 			    struct ramtrace_platform_data *pdata)
 {
@@ -232,6 +508,32 @@ ramtrace_read_bitmap(int n_cpu, int n_bitmap, struct list_head **per_cpu)
 
 }
 
+struct list_head *ramtrace_get_read_buffer(int n_cpu)
+{
+	if (n_cpu >= (trace_ctx.persist_info)->nr_cpus)
+		return NULL;
+
+	return (trace_ctx.persist_info)->data_pages[n_cpu];
+}
+
+int ramtrace_get_prev_boot_nr_cpus(void)
+{
+	return (trace_ctx.persist_info)->nr_cpus;
+}
+
+int ramtrace_get_prev_boot_clock_id(void)
+{
+	return (trace_ctx.persist_info)->trace_clock;
+}
+
+char *ramtrace_get_prev_boot_tracer_name(void)
+{
+	return (trace_ctx.persist_info)->tracer_name;
+}
+
+
+
+
 static void ramtrace_read_pages(void)
 {
 	void *metapage = trace_ctx.vaddr;
@@ -270,6 +572,40 @@ static void ramtrace_read_pages(void)
 out:
 	trace_ctx.persist_info = persist;
 }
+
+/**
+ * free_persist_info - free the list pertaining to previous boot.
+ *
+ * Free the list and array that was allocated to manage previous boot data.
+ * Note: There is no need to free the ramtrace pages memory area.
+ */
+static void free_persist_info(void)
+{
+	struct tr_persistent_info *persist;
+	int i;
+
+	persist = trace_ctx.persist_info;
+
+	if (persist) {
+		for (i = 0; i < persist->nr_cpus; i++) {
+			struct ramtrace_pagelist *node, *tmp;
+			struct list_head *page_list = persist->data_pages[i];
+
+			if (page_list == NULL)
+				continue;
+			list_for_each_entry_safe(node, tmp, page_list, list) {
+				list_del(&node->list);
+				kfree(node);
+			}
+			kfree(page_list);
+		}
+		kfree(persist->data_pages);
+		kfree(persist->tracer_name);
+		kfree(persist);
+	}
+	trace_ctx.persist_info = NULL;
+}
+
 static int ramtrace_init_mem(struct ramtrace_context *ctx)
 {
 
diff --git a/include/linux/ramtrace.h b/include/linux/ramtrace.h
index faf459f..8f9936c 100644
--- a/include/linux/ramtrace.h
+++ b/include/linux/ramtrace.h
@@ -13,3 +13,16 @@ struct ramtrace_platform_data {
 	unsigned long	mem_size;
 	phys_addr_t	mem_address;
 };
+
+void *ramtrace_alloc_page(int cpu);
+void ramtrace_free_page(void *address, int cpu);
+void ramtrace_dump(void);
+int init_ramtrace_pages(int cpu, unsigned long npages,
+			const char *tracer_name, int clock_id);
+bool is_ramtrace_available(void);
+struct list_head *ramtrace_get_read_buffer(int cpu);
+char *ramtrace_get_prev_boot_tracer_name(void);
+int ramtrace_get_prev_boot_clock_id(void);
+int ramtrace_get_prev_boot_nr_cpus(void);
+int ramtrace_available_mem(void);
+void ramtrace_set_tracer_name(const char *tracer_name);
-- 
2.7.4

