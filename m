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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2302DC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC36207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYBcMk35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIBUBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBUB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:01:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00DC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:01:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f142so871624qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mw5fsjCKEi+9JjHAjgqb+NR1m500PQED3nnDZnS2XVY=;
        b=JYBcMk35IQgEdnRIJ+bkm/MpNr5/ZZVgt0cbxzs7e/OR2RPfOLO/IDo8SjrJN0xEBC
         MdXU5TWsPrP9pqN9Zgugewz8aRXi5/9+7j3m1oc7I0xw0mp2rz4rgx/YeJsqxr+4zD/Y
         LEkkOw9OUzj3uydTAi6tDlQZnWaxi2QFT8Er1dQEC04KD69nSK2GNL7L3cobMWIHV8Sy
         OnBLkNKQs4KwRTdNtNQ3WXgG5W9T2Up/fpkOHPE3KaA4yGWD/PjJhMBcBkhAOk6h8jIw
         ppiKbUOFUxdSTi1kwk6skN1hKoS5wVgh76nlP4WP9cwoOTsv9QkyTgl4BA2cZ0w9o4yr
         0sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mw5fsjCKEi+9JjHAjgqb+NR1m500PQED3nnDZnS2XVY=;
        b=YJEgG84eDC+XelrmiU04hk3Ua6g6mwAV/EC6zbMZ0z1UVbp4jymYMNPz1paaHHgbvr
         iiDq5tX2zuXDD29sIlpn9ML9Rdmq1PlUHrCOv2KpkmDFhhX5BRH7j4IrXBlmAP66H+R7
         U+/707CCVhJPZpSyvNHCd4bot8040Hquw5llhCwQROr6myilF3dzBKohzYH0e5Z+dnQJ
         o3Bws+IZkhJ5DRB7Ux352fyXZKfBdnCUHehja9w1kPzc95ABpbsg+ZTXTunYomjYnRDr
         /8vzoTmstXWb5+ayKU1DSTTAYdZzCxNt+7PXGeX0Xgqea8TcYkQ1HGvgU/I3jDXND5bS
         2aiQ==
X-Gm-Message-State: AOAM532M2QZ3k0uxSzD6X1rIgFhxua8dibps4rP8WSWQO9Y+IPBjJhNM
        7DHOdF7bLwLWI41ftTIKKuk=
X-Google-Smtp-Source: ABdhPJxYc/oGpgTnNsWvud/DA1DIi8hl71W8hYofgkkP2MrN8qPw21pz8LT6ALFlutVt/Y3xz+WqxA==
X-Received: by 2002:a37:a443:: with SMTP id n64mr8573241qke.288.1599076883384;
        Wed, 02 Sep 2020 13:01:23 -0700 (PDT)
Received: from ubuntu (69-220-158-6.lightspeed.rlghnc.sbcglobal.net. [69.220.158.6])
        by smtp.gmail.com with ESMTPSA id g4sm347552qth.30.2020.09.02.13.01.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2020 13:01:22 -0700 (PDT)
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
Subject: [RFC PATCH 2/7] pstore: Support a new backend, ramtrace
Date:   Wed,  2 Sep 2020 13:00:17 -0700
Message-Id: <e4fd9eb693a7959721cf83a6b2ad882f99c98de2.1599072725.git.nachukannan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ramtrace provides persistent RAM storage for trace, so they can be
recovered after a reboot. This is a child-node of "/reserved-memory",
and is named "ramtrace" after the backend.

ramtrace supports allocation and deallocation of page-sized memory
This functionality is used by ring buffer in trace when the user switches to
persistent storage. The ring buffer writes directly to the persistent RAM and doesn't use
the write API provided by pstore. For these reasons, a new backend is
needed.

Required properties:

- compatible: must be "ramtrace"

- reg: region of memory that is preserved between reboots

Also, can be enabled on kernel command line as,
ramtrace.mem_address=0x100000000 ramtrace.mem_size=0x7ffffff

Signed-off-by: Nachammai Karuppiah <nachukannan@gmail.com>
---
 drivers/of/platform.c    |   1 +
 fs/pstore/Makefile       |   2 +
 fs/pstore/ramtrace.c     | 346 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore.h   |   3 +
 include/linux/ramtrace.h |  15 ++
 5 files changed, 367 insertions(+)
 create mode 100644 fs/pstore/ramtrace.c
 create mode 100644 include/linux/ramtrace.h

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 071f04d..1a11f54 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -511,6 +511,7 @@ static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,rmtfs-mem" },
 	{ .compatible = "qcom,cmd-db" },
 	{ .compatible = "ramoops" },
+	{ .compatile = "ramtrace" },
 	{}
 };
 
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index c270467..4cee2f0 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -18,3 +18,5 @@ obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
 
 pstore_blk-objs += blk.o
 obj-$(CONFIG_PSTORE_BLK)	+= pstore_blk.o
+
+obj-$(CONFIG_TRACE_EVENTS_TO_PSTORE) += ramtrace.o
diff --git a/fs/pstore/ramtrace.c b/fs/pstore/ramtrace.c
new file mode 100644
index 0000000..57f59e0
--- /dev/null
+++ b/fs/pstore/ramtrace.c
@@ -0,0 +1,346 @@
+#include <linux/ring_buffer.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/ramtrace.h>
+#include <generated/utsrelease.h>
+#include <linux/of.h>
+#include <linux/vmalloc.h>
+
+static unsigned long long mem_address;
+module_param_hw(mem_address, ullong, other, 0400);
+MODULE_PARM_DESC(mem_address,
+		"start of reserved RAM used to store trace data");
+
+static ulong mem_size;
+module_param(mem_size, ulong, 0400);
+MODULE_PARM_DESC(mem_size,
+		"size of reserved RAM used to store trace data");
+
+
+struct ramtrace_context {
+	phys_addr_t phys_addr;	/* Physical address of the persistent memory */
+	unsigned long size;     /* size of the persistent memory */
+	void *vaddr;	/* Virtual address of the first page i.e metadata page */
+	int *clock_id;  /* Pointer to clock id in metadata page */
+	char *tracer_name; /* Pointer to tracer name in metadata page. */
+	spinlock_t lock;
+	struct ramtrace_pagelist *freelist;	/* Linked list of free pages */
+	void **bitmap_pages;	/* Array of bitmap pages per CPU */
+	struct tr_persistent_info *persist_info;
+	struct pstore_info pstore;
+	void *base_address;     /* First page available for allocation */
+	int num_bitmap_per_cpu, cpu;
+	int pages_available;
+	int read_buffer_status;
+};
+
+static int ramtrace_pstore_open(struct pstore_info *psi);
+static ssize_t ramtrace_pstore_read(struct pstore_record *record);
+static int ramtrace_pstore_erase(struct pstore_record *record);
+
+static int ramtrace_pstore_write(struct pstore_record *record)
+{
+	return 0;
+}
+
+static void free_persist_info(void);
+
+static struct ramtrace_context trace_ctx = {
+	.size = 0,
+	.pstore = {
+		.owner	= THIS_MODULE,
+		.name	= "ramtrace",
+		.open	= ramtrace_pstore_open,
+		.read	= ramtrace_pstore_read,
+		.write	= ramtrace_pstore_write,
+		.erase	= ramtrace_pstore_erase,
+	},
+	.read_buffer_status = -1,
+};
+
+static int ramtrace_pstore_open(struct pstore_info *psi)
+{
+	/*
+	 * If there is any data to be read from previous boot, turn
+	 * read_buffer_status to 0, to indicate that data is available to be
+	 * read
+	 */
+	if (trace_ctx.persist_info)
+		trace_ctx.read_buffer_status = 0;
+	return 0;
+}
+
+static ssize_t ramtrace_pstore_read(struct pstore_record *record)
+{
+	if (trace_ctx.read_buffer_status)
+		return 0;
+
+	trace_ctx.read_buffer_status = 1;
+
+	record->time.tv_sec = 0;
+	record->time.tv_nsec = 0;
+	record->compressed = false;
+
+	/*
+	 * Set size as non-zero. This is a place holder value since pstore
+	 * doesn't accept zero-sized buffer. The actual buffer size is unknown.
+	 */
+	record->size = PAGE_SIZE;
+	record->id = 0;
+	record->type = PSTORE_TYPE_TRACE;
+	/*
+	 * Since the buffer used by trace isn't contigous, do not provide
+	 * pstore with a buffer. Instead, the data field in pstore_record
+	 * contains a pointer to pstore_trace_seq_ops structure which provides
+	 * the required interface to iterate through the ramtrace pages.
+	 */
+	record->buf = NULL;
+
+	return record->size;
+}
+
+static int ramtrace_pstore_erase(struct pstore_record *record)
+{
+	pstore_tracing_erase();
+	free_persist_info();
+}
+
+static struct platform_device *dummy;
+
+static int ramtrace_parse_dt(struct platform_device *pdev,
+			    struct ramtrace_platform_data *pdata)
+{
+	struct resource *res;
+
+
+	dev_dbg(&pdev->dev, "using Device Tree\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"failed to locate DT /reserved-memory resource\n");
+		return -EINVAL;
+	}
+
+	pdata->mem_size = resource_size(res);
+	pdata->mem_address = res->start;
+
+	return 0;
+}
+
+static int ramtrace_init_mem(struct ramtrace_context *ctx)
+{
+
+	struct page **pages;
+	unsigned int page_count;
+	pgprot_t prot;
+	unsigned int i;
+	struct ramtrace_pagelist *freelist;
+
+	page_count = DIV_ROUND_UP(ctx->size, PAGE_SIZE);
+
+	prot = pgprot_noncached(PAGE_KERNEL);
+
+	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
+	if (!pages) {
+		pr_err("%s: Failed to allocate array for %u pages\n",
+		       __func__, page_count);
+		return 0;
+	}
+	freelist = kzalloc(sizeof(struct ramtrace_pagelist), GFP_KERNEL);
+	INIT_LIST_HEAD(&freelist->list);
+	trace_ctx.freelist = freelist;
+	for (i = 0; i < page_count; i++) {
+		phys_addr_t addr = ctx->phys_addr + i * PAGE_SIZE;
+
+		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
+	}
+
+	ctx->vaddr = vmap(pages, page_count, VM_MAP, prot);
+
+	/* Initialize the freelist - free page pool.
+	 * Note - This doesn't initialize the page.
+	 */
+	for (i = 0; i < page_count; i++) {
+		struct ramtrace_pagelist *freelist_node;
+		void *addr = ctx->vaddr + i * PAGE_SIZE;
+
+		freelist_node = kmalloc(sizeof(*freelist_node), GFP_KERNEL);
+		freelist_node->page = addr;
+		list_add_tail(&freelist_node->list, &freelist->list);
+	}
+	spin_lock_init(&ctx->lock);
+
+	/* Read the data from previous boot, if any */
+	ramtrace_read_pages();
+	kfree(pages);
+	return 1;
+}
+
+static int ramtrace_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ramtrace_platform_data *pdata = dev->platform_data;
+	struct ramtrace_platform_data pdata_local;
+	struct ramtrace_context *cxt = &trace_ctx;
+	int err = -EINVAL;
+
+	/*
+	 * Only a single ramtrace area allowed at a time, so fail extra
+	 * probes.
+	 */
+	if (cxt->size) {
+		pr_err("already initialized\n");
+		goto fail_out;
+	}
+
+	if (dev_of_node(dev) && !pdata) {
+		pdata = &pdata_local;
+		memset(pdata, 0, sizeof(*pdata));
+
+		err = ramtrace_parse_dt(pdev, pdata);
+		if (err < 0)
+			goto fail_out;
+	}
+
+	/* Make sure we didn't get bogus platform data pointer. */
+	if (!pdata) {
+		pr_err("NULL platform data\n");
+		goto fail_out;
+	}
+
+	if (!pdata->mem_size) {
+		pr_err("The memory size must be non-zero\n");
+		goto fail_out;
+	}
+
+	cxt->size = pdata->mem_size;
+	cxt->phys_addr = pdata->mem_address;
+
+	err = ramtrace_init_mem(cxt);
+
+	/*
+	 * Update the module parameter variables as well so they are visible
+	 * through /sys/module/ramtrace/parameters/
+	 */
+	mem_size = pdata->mem_size;
+	mem_address = pdata->mem_address;
+
+	pr_info("using 0x%lx@0x%llx\n",
+		cxt->size, (unsigned long long)cxt->phys_addr);
+
+	/* Initialize struct pstore_info and register with pstore */
+	cxt->pstore.flags = PSTORE_FLAGS_TRACE;
+	cxt->pstore.data = &pstore_trace_seq_ops;
+	err = pstore_register(&cxt->pstore);
+	if (err) {
+		pr_err("registering with pstore failed\n");
+		goto fail_out;
+	}
+
+	return 0;
+
+fail_out:
+	return err;
+
+}
+
+static int ramtrace_remove(struct platform_device *pdev)
+{
+	struct ramtrace_context *cxt = &trace_ctx;
+	struct ramtrace_pagelist *freelist = cxt->freelist;
+
+	pstore_unregister(&cxt->pstore);
+
+	cxt->pstore.bufsize = 0;
+
+	pstore_tracing_erase();
+	free_persist_info();
+
+	if (!list_empty(&freelist->list)) {
+		struct ramtrace_pagelist *node, *tmp;
+
+		list_for_each_entry_safe(node, tmp, &freelist->list, list) {
+			list_del(&node->list);
+			kfree(node);
+		}
+	}
+	cxt->size = 0;
+	return 0;
+}
+
+static const struct of_device_id dt_match[] = {
+	{ .compatible = "ramtrace" },
+	{}
+};
+
+static struct platform_driver ramtrace_driver = {
+	.probe		= ramtrace_probe,
+	.remove		= ramtrace_remove,
+	.driver		= {
+		.name		= "ramtrace",
+		.of_match_table	= dt_match,
+	},
+};
+
+static inline void ramtrace_unregister_dummy(void)
+{
+	platform_device_unregister(dummy);
+	dummy = NULL;
+}
+
+static void __init ramtrace_register_dummy(void)
+{
+	struct ramtrace_platform_data pdata;
+
+	/*
+	 * Prepare a dummy platform data structure to carry the module
+	 * parameters. If mem_size isn't set, then there are no module
+	 * parameters, and we can skip this.
+	 */
+	if (!mem_size)
+		return;
+
+	pr_info("using module parameters\n");
+
+	memset(&pdata, 0, sizeof(pdata));
+	pdata.mem_size = mem_size;
+	pdata.mem_address = mem_address;
+
+
+	dummy = platform_device_register_data(NULL, "ramtrace", -1,
+			&pdata, sizeof(pdata));
+	if (IS_ERR(dummy)) {
+		pr_info("could not create platform device: %ld\n",
+			PTR_ERR(dummy));
+		dummy = NULL;
+		ramtrace_unregister_dummy();
+	}
+}
+
+static int __init ramtrace_init(void)
+{
+	int ret;
+
+	ramtrace_register_dummy();
+	ret = platform_driver_register(&ramtrace_driver);
+	if (ret != 0)
+		ramtrace_unregister_dummy();
+
+	return ret;
+}
+postcore_initcall(ramtrace_init);
+
+static void __exit ramtrace_exit(void)
+{
+	platform_driver_unregister(&ramtrace_driver);
+	ramtrace_unregister_dummy();
+}
+module_exit(ramtrace_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nachammai Karuppiah nachukannan@gmail.com");
+MODULE_DESCRIPTION("RAM trace buffer manager/driver");
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index eb93a54..20bae10 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -39,6 +39,8 @@ enum pstore_type_id {
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
 
+	PSTORE_TYPE_TRACE	= 9,
+
 	/* End of the list */
 	PSTORE_TYPE_MAX
 };
@@ -202,6 +204,7 @@ struct pstore_info {
 #define PSTORE_FLAGS_CONSOLE	BIT(1)
 #define PSTORE_FLAGS_FTRACE	BIT(2)
 #define PSTORE_FLAGS_PMSG	BIT(3)
+#define PSTORE_FLAGS_TRACE	BIT(4)
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
diff --git a/include/linux/ramtrace.h b/include/linux/ramtrace.h
new file mode 100644
index 0000000..faf459f
--- /dev/null
+++ b/include/linux/ramtrace.h
@@ -0,0 +1,15 @@
+#include <linux/list.h>
+#include <linux/trace.h>
+#include <linux/trace_events.h>
+#include <linux/pstore.h>
+
+/*
+ * Ramoops platform data
+ * @mem_size	memory size for ramtrace
+ * @mem_address	physical memory address to contain ramtrace
+ */
+
+struct ramtrace_platform_data {
+	unsigned long	mem_size;
+	phys_addr_t	mem_address;
+};
-- 
2.7.4

