Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED93BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5B6207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A/E6TJEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgERKIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:08:38 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:25119 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERKIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589796517; x=1621332517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yPGtxjnGdW9tLlgPI8w/Gq/33o5dSn7TJ6/TV2fK720=;
  b=A/E6TJEMWMGmF0yZfEc5a7xvn6zESgWAq10i8zahYyuEWcvG76rTs5Qh
   VaVLNTKerLrrmyW5c+NO9kmRuJsjmNnJCL+dUQfV2yrYT7KhWuxBEhMSi
   yVPWKOrH6LuYFE94xlqSkSgAU27V47mdsfArNCTX87fcYgtqCpX39tMRe
   w=;
IronPort-SDR: 5ybwXePamaaNKjYs3jc+6/JdHC5xMZSgaJeYxvlug3F2w1zuuCRna2V1aw7lz/vzEMn1h5RZuc
 aC16CY87MdNA==
X-IronPort-AV: E=Sophos;i="5.73,406,1583193600"; 
   d="scan'208";a="30703487"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 18 May 2020 10:08:37 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 1F19714181E;
        Mon, 18 May 2020 10:08:24 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 18 May 2020 10:08:24 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 18 May 2020 10:08:08 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 09/16] mm/damon: Implement access pattern recording
Date:   Mon, 18 May 2020 12:00:11 +0200
Message-ID: <20200518100018.2293-10-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518100018.2293-1-sjpark@amazon.com>
References: <20200518100018.2293-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D04UWA003.ant.amazon.com (10.43.160.212) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements the recording feature of DAMON. If this feature
is enabled, DAMON writes the monitored access patterns in its binary
format into a file which specified by the user. This is already able to
be implemented by each user using the callbacks.  However, as the
recording is expected to be used widely, this commit implements the
feature in the DAMON, for more convenience and efficiency.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |   7 +++
 mm/damon.c            | 131 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 264569b21502..bc46ea00e9a1 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -50,6 +50,11 @@ struct damon_ctx {
 	struct timespec64 last_aggregation;
 	struct timespec64 last_regions_update;
 
+	unsigned char *rbuf;
+	unsigned int rbuf_len;
+	unsigned int rbuf_offset;
+	char *rfile_path;
+
 	struct task_struct *kdamond;
 	bool kdamond_stop;
 	struct mutex kdamond_lock;
@@ -65,6 +70,8 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
+int damon_set_recording(struct damon_ctx *ctx,
+				unsigned int rbuf_len, char *rfile_path);
 int damon_start(struct damon_ctx *ctx);
 int damon_stop(struct damon_ctx *ctx);
 
diff --git a/mm/damon.c b/mm/damon.c
index 498160b5e086..ddd78843f79a 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -44,6 +44,9 @@
 #define damon_for_each_task_safe(t, next, ctx) \
 	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
 
+#define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
+#define MAX_RFILE_PATH_LEN	256
+
 /* Get a random number in [l, r) */
 #define damon_rand(l, r) (l + prandom_u32() % (r - l))
 
@@ -565,16 +568,80 @@ static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
 }
 
 /*
- * Reset the aggregated monitoring results
+ * Flush the content in the result buffer to the result file
+ */
+static void damon_flush_rbuffer(struct damon_ctx *ctx)
+{
+	ssize_t sz;
+	loff_t pos = 0;
+	struct file *rfile;
+
+	rfile = filp_open(ctx->rfile_path, O_CREAT | O_RDWR | O_APPEND, 0644);
+	if (IS_ERR(rfile)) {
+		pr_err("Cannot open the result file %s\n",
+				ctx->rfile_path);
+		return;
+	}
+
+	while (ctx->rbuf_offset) {
+		sz = kernel_write(rfile, ctx->rbuf, ctx->rbuf_offset, &pos);
+		if (sz < 0)
+			break;
+		ctx->rbuf_offset -= sz;
+	}
+	filp_close(rfile, NULL);
+}
+
+/*
+ * Write a data into the result buffer
+ */
+static void damon_write_rbuf(struct damon_ctx *ctx, void *data, ssize_t size)
+{
+	if (!ctx->rbuf_len || !ctx->rbuf)
+		return;
+	if (ctx->rbuf_offset + size > ctx->rbuf_len)
+		damon_flush_rbuffer(ctx);
+
+	memcpy(&ctx->rbuf[ctx->rbuf_offset], data, size);
+	ctx->rbuf_offset += size;
+}
+
+/*
+ * Flush the aggregated monitoring results to the result buffer
+ *
+ * Stores current tracking results to the result buffer and reset 'nr_accesses'
+ * of each region.  The format for the result buffer is as below:
+ *
+ *   <time> <number of tasks> <array of task infos>
+ *
+ *   task info: <pid> <number of regions> <array of region infos>
+ *   region info: <start address> <end address> <nr_accesses>
  */
 static void kdamond_reset_aggregated(struct damon_ctx *c)
 {
 	struct damon_task *t;
-	struct damon_region *r;
+	struct timespec64 now;
+	unsigned int nr;
+
+	ktime_get_coarse_ts64(&now);
+
+	damon_write_rbuf(c, &now, sizeof(struct timespec64));
+	nr = nr_damon_tasks(c);
+	damon_write_rbuf(c, &nr, sizeof(nr));
 
 	damon_for_each_task(t, c) {
-		damon_for_each_region(r, t)
+		struct damon_region *r;
+
+		damon_write_rbuf(c, &t->pid, sizeof(t->pid));
+		nr = nr_damon_regions(t);
+		damon_write_rbuf(c, &nr, sizeof(nr));
+		damon_for_each_region(r, t) {
+			damon_write_rbuf(c, &r->vm_start, sizeof(r->vm_start));
+			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
+			damon_write_rbuf(c, &r->nr_accesses,
+					sizeof(r->nr_accesses));
 			r->nr_accesses = 0;
+		}
 	}
 }
 
@@ -837,6 +904,14 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
+static void kdamond_write_record_header(struct damon_ctx *ctx)
+{
+	int recfmt_ver = 1;
+
+	damon_write_rbuf(ctx, "damon_recfmt_ver", 16);
+	damon_write_rbuf(ctx, &recfmt_ver, sizeof(recfmt_ver));
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -849,6 +924,9 @@ static int kdamond_fn(void *data)
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
 	kdamond_init_regions(ctx);
+
+	kdamond_write_record_header(ctx);
+
 	while (!kdamond_need_stop(ctx)) {
 		kdamond_prepare_access_checks(ctx);
 		if (ctx->sample_cb)
@@ -869,6 +947,7 @@ static int kdamond_fn(void *data)
 		if (kdamond_need_update_regions(ctx))
 			kdamond_update_regions(ctx);
 	}
+	damon_flush_rbuffer(ctx);
 	damon_for_each_task(t, ctx) {
 		damon_for_each_region_safe(r, next, t)
 			damon_destroy_region(r);
@@ -971,6 +1050,52 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids)
 	return 0;
 }
 
+/**
+ * damon_set_recording() - Set attributes for the recording.
+ * @ctx:	target kdamond context
+ * @rbuf_len:	length of the result buffer
+ * @rfile_path:	path to the monitor result files
+ *
+ * Setting 'rbuf_len' 0 disables recording.
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_recording(struct damon_ctx *ctx,
+			unsigned int rbuf_len, char *rfile_path)
+{
+	size_t rfile_path_len;
+
+	if (rbuf_len > MAX_RECORD_BUFFER_LEN) {
+		pr_err("too long (>%d) result buffer length\n",
+				MAX_RECORD_BUFFER_LEN);
+		return -EINVAL;
+	}
+	rfile_path_len = strnlen(rfile_path, MAX_RFILE_PATH_LEN);
+	if (rfile_path_len >= MAX_RFILE_PATH_LEN) {
+		pr_err("too long (>%d) result file path %s\n",
+				MAX_RFILE_PATH_LEN, rfile_path);
+		return -EINVAL;
+	}
+	ctx->rbuf_len = rbuf_len;
+	kfree(ctx->rbuf);
+	kfree(ctx->rfile_path);
+	ctx->rfile_path = NULL;
+	if (!rbuf_len) {
+		ctx->rbuf = NULL;
+	} else {
+		ctx->rbuf = kvmalloc(rbuf_len, GFP_KERNEL);
+		if (!ctx->rbuf)
+			return -ENOMEM;
+	}
+	ctx->rfile_path = kmalloc(rfile_path_len + 1, GFP_KERNEL);
+	if (!ctx->rfile_path)
+		return -ENOMEM;
+	strncpy(ctx->rfile_path, rfile_path, rfile_path_len + 1);
+	return 0;
+}
+
 /**
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
-- 
2.17.1

