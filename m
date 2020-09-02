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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86034C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9A12083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb1Hxxf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgIBUB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIBUB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:01:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D28C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:01:29 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id f11so215840qvw.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=afHET91uD4CXd+Bn3ri+xXpTcWaYwHFCsK+mh3uTl/U=;
        b=Tb1Hxxf2aPujU9ztVmz/pwmUUPwhVSSi2K0A7S4rknGbIDVoWbrgocQwamg3BMld0T
         9eoytiOGKhBmnjRHKxVjsQRwYcV+8xX3s2s+/6pp2tFYA56gUgt6q9re5BEnN2ZrtXdl
         av7aAqKi4odxwp53W92qLQM960HReTt9PtYEHBxxuP8XgSxDgkcCgvhbVlmLFV1BsnOX
         LxE3zWN37WqMUCondsLQF6EbXY2T3JE6KMDe2LD1JrmTvzrV5jVoXGcB7+Hfny/n0gqb
         +9Ha4SG+lJxWC7HEHKcsQwUjKs/X87VYMX+Po3yIIZs4EZ6krjNweVgHpJUqKSTOSBm6
         1SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=afHET91uD4CXd+Bn3ri+xXpTcWaYwHFCsK+mh3uTl/U=;
        b=RMcV0kZ+T2CBmjtpqyUhbmD93R9Y/g7nNq869wEdsks2f59Dp3qGipG0wHju8QfULh
         3NEt6UNs6MLn5XPGX0d6fWUojsc5jjTQgm5rMg2s7W7u7G4rOg1BgASBQwC8J/X637+o
         PEx5yaHD9VsPuewgq7Fukg2zdGXn9Kq+I+eyn8W9ahkKji4Q7raKPMiCiX/R8JTq442k
         JqBpF6NA6YJVzQY9/J9k9HUXmi1R8/tZIqhx3Hytzy8gqgQbDdLB/VYMlei9g7NnwLd+
         yovdPL5A1K3kdD8OTUVS4SdyuA5h8RKLqaD1jP99fbDEfFyTLF7hap2OtO2GgkczNEA2
         PT5Q==
X-Gm-Message-State: AOAM532nEwznfSntoOrPodl4tF+01iNQvIRDInpbj8xR9S9lTbxoWBrF
        7m+FR1ZTOuqD2X485hAo7lk=
X-Google-Smtp-Source: ABdhPJxHsvaC/b580/1QGKNygov/r1HHcE22ZmAt3zF7SvP/QW4YersIm0uAKH4vDkNO1nq1osUoxw==
X-Received: by 2002:ad4:430d:: with SMTP id c13mr8446929qvs.49.1599076888212;
        Wed, 02 Sep 2020 13:01:28 -0700 (PDT)
Received: from ubuntu (69-220-158-6.lightspeed.rlghnc.sbcglobal.net. [69.220.158.6])
        by smtp.gmail.com with ESMTPSA id c40sm354863qtb.72.2020.09.02.13.01.27
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2020 13:01:27 -0700 (PDT)
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
Subject: [RFC PATCH 3/7] pstore: Read and iterate through trace entries in PSTORE
Date:   Wed,  2 Sep 2020 13:00:18 -0700
Message-Id: <22eb826589419a5e6dc62a7b6876391a0dd4855c.1599072725.git.nachukannan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incase of trace records that are being read from pstore, the numerical
*pos is not enough to hold state from session to session. A trace
iterator is better suited for this. So for PSTORE_TYPE_TRACE record
types, the seq_file->private field holds pointer to trace_iterator and not
pstore_private. For this reason, PSTORE_TYPE_TRACE requires a different
file_operations implementation, pstore_trace_file_operations.

The method, ramtrace_read_pages initiates the retrieval of pages from
pstore.
The first page in the pstore is the metadata page. Below is the layout
of the metadata page.
  +------------------------------------------+
  | Kernel Version                           |
  +------------------------------------------+
  | tracer_name                              |
  +------------------------------------------+
  | Number of CPU’s Buffers = N              |
  +------------------------------------------+
  | trace_clock_name                         |
  +------------------------------------------+
  | Number of bitmap pages per cpu	     |
  +------------------------------------------+
The metadata page is then followed by bitmap pages which is a bitmap of
pages that are allocated per CPU. From the bitmaps, the list of
pages per cpu is computed and ordered by timestamp.

Signed-off-by: Nachammai Karuppiah <nachukannan@gmail.com>
---
 fs/pstore/inode.c    |  46 +++++++++++++++--
 fs/pstore/platform.c |   1 +
 fs/pstore/ramtrace.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index c331efe..173269a 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -147,13 +147,20 @@ static int pstore_file_open(struct inode *inode, struct file *file)
 	if (ps->record->type == PSTORE_TYPE_FTRACE)
 		sops = &pstore_ftrace_seq_ops;
 
+	if (ps->record->type == PSTORE_TYPE_TRACE)
+		sops = ps->record->psi->data;
+
 	err = seq_open(file, sops);
 	if (err < 0)
 		return err;
-
-	sf = file->private_data;
-	sf->private = ps;
-
+	/* Incase of PSTORE_TYPE_TRACE, the private field in seq_file
+	 * would be initialized later during seq_read and freed in
+	 * seq_release.
+	 */
+	if (ps->record->type != PSTORE_TYPE_TRACE) {
+		sf = file->private_data;
+		sf->private = ps;
+	}
 	return 0;
 }
 
@@ -173,6 +180,30 @@ static const struct file_operations pstore_file_operations = {
 	.release	= seq_release,
 };
 
+static ssize_t pstore_trace_file_read(struct file *file, char __user *userbuf,
+						size_t count, loff_t *ppos)
+{
+	return seq_read(file, userbuf, count, ppos);
+}
+
+extern int pstore_tracing_release(void *v);
+
+static int pstore_trace_file_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *s = file->private_data;
+	void *v = s->private;
+
+	pstore_tracing_release(v);
+	return seq_release(inode, file);
+}
+
+static const struct file_operations pstore_trace_file_operations = {
+	.open		= pstore_file_open,
+	.read		= pstore_trace_file_read,
+	.llseek		= pstore_file_llseek,
+	.release	= pstore_trace_file_release,
+};
+
 /*
  * When a file is unlinked from our file system we call the
  * platform driver to erase the record from persistent store.
@@ -369,7 +400,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	if (!inode)
 		goto fail;
 	inode->i_mode = S_IFREG | 0444;
-	inode->i_fop = &pstore_file_operations;
 	scnprintf(name, sizeof(name), "%s-%s-%llu%s",
 			pstore_type_to_name(record->type),
 			record->psi->name, record->id,
@@ -386,6 +416,12 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	private->dentry = dentry;
 	private->record = record;
 	inode->i_size = private->total_size = size;
+
+	if (record->type == PSTORE_TYPE_TRACE)
+		inode->i_fop = &pstore_trace_file_operations;
+	else
+		inode->i_fop = &pstore_file_operations;
+
 	inode->i_private = private;
 
 	if (record->time.tv_sec)
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 36714df..e3d5b43 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -58,6 +58,7 @@ static const char * const pstore_type_names[] = {
 	"powerpc-common",
 	"pmsg",
 	"powerpc-opal",
+	"trace",
 };
 
 static int pstore_new_entry;
diff --git a/fs/pstore/ramtrace.c b/fs/pstore/ramtrace.c
index 57f59e0..ca48a76 100644
--- a/fs/pstore/ramtrace.c
+++ b/fs/pstore/ramtrace.c
@@ -61,6 +61,18 @@ static struct ramtrace_context trace_ctx = {
 	.read_buffer_status = -1,
 };
 
+/*
+ * pstore_trace_seq_ops: This consists of the callback functions
+ * required by pstore to iterate through the trace entries
+ */
+
+static struct seq_operations pstore_trace_seq_ops = {
+	.start	= pstore_trace_start,
+	.next	= pstore_trace_next,
+	.stop	= pstore_trace_stop,
+	.show	= pstore_trace_show,
+};
+
 static int ramtrace_pstore_open(struct pstore_info *psi)
 {
 	/*
@@ -131,6 +143,133 @@ static int ramtrace_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int ramtrace_read_int(int **buffer)
+{
+	int data = **buffer;
+
+	(*buffer)++;
+	return data;
+}
+
+static char *ramtrace_read_string(char **buffer)
+{
+	int len = strlen(*buffer) + 1;
+
+	if (len > 1) {
+		char *s = kmalloc(len, GFP_KERNEL);
+
+		strncpy(s, *buffer, len);
+		*buffer = (*buffer) + len;
+		return s;
+	}
+	return NULL;
+
+}
+
+static struct list_head*
+ramtrace_read_bitmap_per_cpu(int n_bitmap, unsigned long long *bitmap,
+			     void *first_page)
+{
+	int j, k;
+	struct list_head *pages = kmalloc(sizeof(struct list_head), GFP_KERNEL);
+
+	INIT_LIST_HEAD(pages);
+	for (k = 0; k <  n_bitmap; k++) {
+		bitmap = (void *)(bitmap) + PAGE_SIZE * k;
+		for (j = 0; j < PAGE_SIZE/sizeof(long long); j++) {
+			struct ramtrace_pagelist *list_page;
+			unsigned long long k = bitmap[j];
+			int count = 0;
+			int nth = j * sizeof(k) * 8;
+
+			while (k) {
+				if (k & 1) {
+					list_page = kzalloc(sizeof(*list_page),
+							    GFP_KERNEL);
+					list_page->page = (first_page +
+						     (nth + count) * PAGE_SIZE);
+					list_add_tail(&list_page->list, pages);
+				}
+				count++;
+				k = k >> 1;
+			}
+
+		}
+	}
+	if (list_empty(pages))
+		return NULL;
+	return pages;
+}
+
+/* ramtrace_read_bitmap: Read bitmap pages.
+ *
+ * Read bitmap pages from previous boot and order the
+ * buffer_data_page as per the timestamp.
+ */
+static void
+ramtrace_read_bitmap(int n_cpu, int n_bitmap, struct list_head **per_cpu)
+{
+	int i;
+	void *first_bitmap = trace_ctx.vaddr + PAGE_SIZE;
+	void *base_addr = first_bitmap + (n_cpu * n_bitmap * PAGE_SIZE);
+	struct list_head *per_cpu_list;
+
+	for (i = 0; i < n_cpu; i++) {
+		void *bitmap_addr = first_bitmap + i * n_bitmap * PAGE_SIZE;
+
+		per_cpu_list = ramtrace_read_bitmap_per_cpu(n_bitmap,
+							bitmap_addr, base_addr);
+		if (per_cpu_list) {
+			ring_buffer_order_pages(per_cpu_list);
+			if (list_empty(per_cpu_list))
+				per_cpu[i] = NULL;
+			else
+				per_cpu[i] = per_cpu_list;
+		} else
+			per_cpu[i] = NULL;
+
+	}
+
+}
+
+static void ramtrace_read_pages(void)
+{
+	void *metapage = trace_ctx.vaddr;
+	const char current_kernel_version[] = UTS_RELEASE;
+
+
+	int n_cpu = ramtrace_read_int((int **)&metapage);
+	int trace_clock = ramtrace_read_int((int **)&metapage);
+	int n_bitmap = ramtrace_read_int((int **)&metapage);
+	char *kernel_version = ramtrace_read_string((char **)&metapage);
+	char *tracer = ramtrace_read_string((char **)&metapage);
+	struct tr_persistent_info *persist = NULL;
+
+	if (kernel_version && tracer) {
+		struct list_head **per_cpu_list;
+
+		/* If we have booted with a different version of OS, then
+		 * do not try to read from persistent store
+		 */
+		if (strcmp(kernel_version, current_kernel_version)) {
+			pr_err("Booted with a different version of OS. "
+				"The trace in PSTORE pertains to kernel "
+				"version %s.\n", kernel_version);
+			goto out;
+		}
+		per_cpu_list = kmalloc_array(n_cpu,
+				sizeof(struct list_head *), GFP_KERNEL);
+		ramtrace_read_bitmap(n_cpu, n_bitmap, per_cpu_list);
+		persist = kzalloc(sizeof(*persist), GFP_KERNEL);
+
+		persist->tracer_name = tracer;
+		persist->trace_clock = trace_clock;
+		persist->nr_cpus = n_cpu;
+		persist->data_pages = per_cpu_list;
+	}
+out:
+	trace_ctx.persist_info = persist;
+}
 static int ramtrace_init_mem(struct ramtrace_context *ctx)
 {
 
-- 
2.7.4

