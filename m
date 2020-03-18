Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0167FC5ACD9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29B92077A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p3saGtPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCRLdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:33:44 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55731 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCRLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584531225; x=1616067225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=s0AfyZ6CiQ6AzJS05n/GM916ac2WmoGpXpoaffAKTPY=;
  b=p3saGtPpSuoKmxTvO2FY2vQN4+/PEK2FPefK6Isvl6by1wbVpSuNkGSL
   M+BRY0DiwW4yJ8WToUOdseEwRCL1aedhYjbtDp26Pve7WyVMMv+pTxTH9
   UcHpK877UyKeT5cZnHvudOnKE6OKWzbpivORQVfvW0f2DinqZDqPb+bFG
   s=;
IronPort-SDR: ODNl+8upXqZPtYW0Y6p5MvnEOupndjxY/OoQ+9dHBo6dRPKg+lr3MHLx3F8aevk1QFZqwDrqGv
 WT5HT4ca0wAQ==
X-IronPort-AV: E=Sophos;i="5.70,567,1574121600"; 
   d="scan'208";a="22002595"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 18 Mar 2020 11:33:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id BA158A26C4;
        Wed, 18 Mar 2020 11:33:33 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Mar 2020 11:33:32 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.235) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Mar 2020 11:33:14 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 08/15] mm/damon: Implement access pattern recording
Date:   Wed, 18 Mar 2020 12:27:15 +0100
Message-ID: <20200318112722.30143-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318112722.30143-1-sjpark@amazon.com>
References: <20200318112722.30143-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.235]
X-ClientProxiedBy: EX13D28UWC001.ant.amazon.com (10.43.162.166) To
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
 mm/damon.c            | 120 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cad3ee3d78db..47fb0ec03030 100644
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
 	struct mutex kdamond_lock;
 
@@ -66,6 +71,8 @@ int damon_set_pids(struct damon_ctx *ctx, unsigned long *pids, ssize_t nr_pids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
+int damon_set_recording(struct damon_ctx *ctx,
+				unsigned int rbuf_len, char *rfile_path);
 int damon_start(struct damon_ctx *ctx);
 int damon_stop(struct damon_ctx *ctx);
 
diff --git a/mm/damon.c b/mm/damon.c
index 2e8af1ce4389..59d49b0990cf 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -41,6 +41,8 @@
 #define damon_for_each_task_safe(ctx, t, next) \
 	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
 
+#define MAX_RFILE_PATH_LEN	256
+
 /* Get a random number in [l, r) */
 #define damon_rand(ctx, l, r) (l + prandom_u32_state(&ctx->rndseed) % (r - l))
 
@@ -523,16 +525,81 @@ static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
 }
 
 /*
- * Reset the aggregated monitoring results
+ * Flush the content in the result buffer to the result file
+ */
+static void damon_flush_rbuffer(struct damon_ctx *ctx)
+{
+	ssize_t sz;
+	loff_t pos;
+	struct file *rfile;
+
+	while (ctx->rbuf_offset) {
+		pos = 0;
+		rfile = filp_open(ctx->rfile_path, O_CREAT | O_RDWR | O_APPEND,
+				0644);
+		if (IS_ERR(rfile)) {
+			pr_err("Cannot open the result file %s\n",
+					ctx->rfile_path);
+			return;
+		}
+
+		sz = kernel_write(rfile, ctx->rbuf, ctx->rbuf_offset, &pos);
+		filp_close(rfile, NULL);
+
+		ctx->rbuf_offset -= sz;
+	}
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
+ * of each regions.  The format for the result buffer is as below:
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
 
 	damon_for_each_task(c, t) {
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
 
@@ -803,6 +870,7 @@ static int kdamond_fn(void *data)
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 	}
+	damon_flush_rbuffer(ctx);
 	damon_for_each_task(ctx, t) {
 		damon_for_each_region_safe(r, next, t)
 			damon_destroy_region(r);
@@ -910,6 +978,52 @@ int damon_set_pids(struct damon_ctx *ctx, unsigned long *pids, ssize_t nr_pids)
 	return 0;
 }
 
+/*
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
+				unsigned int rbuf_len, char *rfile_path)
+{
+	size_t rfile_path_len;
+
+	if (rbuf_len > 4 * 1024 * 1024) {
+		pr_err("too long (>%d) result buffer length\n",
+				4 * 1024 * 1024);
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
 /*
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
-- 
2.17.1

