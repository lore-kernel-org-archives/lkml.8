Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B91C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C7220770
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RkCqnvFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCRLee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:34:34 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:34063 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCRLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584531271; x=1616067271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KbVtoUsMfgegI6zAE5OoPlXkLfKM6/Q/WWrXihSckPY=;
  b=RkCqnvFaL3JpwRCXLnWkTOkouvm3AKamWdTBOvrlCA7k02T6mtcb97EV
   8ZlKStV50YxX6BEo1SOEU5wHkzx2X8lB4Bao0VodvZMLexxQTdYRmx6tY
   3U7oE38nCjFBYpBNMsYvLQS4yfVgPDkFvvB2YxJ4H6WIk5tgu/N2Tjl/D
   Q=;
IronPort-SDR: gNWk/EGh2+eBsV2sELRfw/U0caViPhAaEMXjBiCK/hUb8nbhOBHTudUdrCRVfqoyYogmGZl9ee
 l2ztH0zD89ng==
X-IronPort-AV: E=Sophos;i="5.70,567,1574121600"; 
   d="scan'208";a="23004182"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Mar 2020 11:34:19 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id A926BA2DBE;
        Wed, 18 Mar 2020 11:34:09 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Mar 2020 11:34:08 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.235) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Mar 2020 11:33:52 +0000
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
Subject: [PATCH v7 09/15] mm/damon: Add debugfs interface
Date:   Wed, 18 Mar 2020 12:27:16 +0100
Message-ID: <20200318112722.30143-10-sjpark@amazon.com>
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

This commit adds a debugfs interface for DAMON.

DAMON exports four files, ``attrs``, ``pids``, ``record``, and
``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.

Attributes
----------

Users can read and write the ``sampling interval``, ``aggregation
interval``, ``regions update interval``, and min/max number of
monitoring target regions by reading from and writing to the ``attrs``
file.  For example, below commands set those values to 5 ms, 100 ms,
1,000 ms, 10, 1000 and check it again::

    # cd <debugfs>/damon
    # echo 5000 100000 1000000 10 1000 > attrs
    # cat attrs
    5000 100000 1000000 10 1000

Target PIDs
-----------

Users can read and write the pids of current monitoring target processes
by reading from and writing to the ``pids`` file.  For example, below
commands set processes having pids 42 and 4242 as the processes to be
monitored and check it again::

    # cd <debugfs>/damon
    # echo 42 4242 > pids
    # cat pids
    42 4242

Note that setting the pids doesn't starts the monitoring.

Record
------

DAMON support direct monitoring result record feature.  The recorded
results are first written to a buffer and flushed to a file in batch.
Users can set the size of the buffer and the path to the result file by
reading from and writing to the ``record`` file.  For example, below
commands set the buffer to be 4 KiB and the result to be saved in
'/damon.data'.

    # cd <debugfs>/damon
    # echo 4096 /damon.data > pids
    # cat record
    4096 /damon.data

Turning On/Off
--------------

You can check current status, start and stop the monitoring by reading
from and writing to the ``monitor_on`` file.  Writing ``on`` to the file
starts DAMON to monitor the target processes with the attributes.
Writing ``off`` to the file stops DAMON.  DAMON also stops if every
target processes is be terminated.  Below example commands turn on, off,
and check status of DAMON::

    # cd <debugfs>/damon
    # echo on > monitor_on
    # echo off > monitor_on
    # cat monitor_on
    off

Please note that you cannot write to the ``attrs`` and ``pids`` files
while the monitoring is turned on.  If you write to the files while
DAMON is running, ``-EINVAL`` will be returned.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 354 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 352 insertions(+), 2 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 59d49b0990cf..b77e537e2ffe 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "damon: " fmt
 
 #include <linux/damon.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/mm.h>
@@ -46,6 +47,15 @@
 /* Get a random number in [l, r) */
 #define damon_rand(ctx, l, r) (l + prandom_u32_state(&ctx->rndseed) % (r - l))
 
+/* A monitoring context for debugfs interface users. */
+static struct damon_ctx damon_user_ctx = {
+	.sample_interval = 5 * 1000,
+	.aggr_interval = 100 * 1000,
+	.regions_update_interval = 1000 * 1000,
+	.min_nr_regions = 10,
+	.max_nr_regions = 1000,
+};
+
 /*
  * Construct a damon_region struct
  *
@@ -1062,14 +1072,354 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 	return 0;
 }
 
-static int __init damon_init(void)
+static ssize_t debugfs_monitor_on_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char monitor_on_buf[5];
+	bool monitor_on;
+	int len;
+
+	monitor_on = damon_kdamond_running(ctx);
+	len = snprintf(monitor_on_buf, 5, monitor_on ? "on\n" : "off\n");
+
+	return simple_read_from_buffer(buf, count, ppos, monitor_on_buf, len);
+}
+
+static ssize_t debugfs_monitor_on_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	ssize_t ret;
+	char cmdbuf[5];
+	int err;
+
+	ret = simple_write_to_buffer(cmdbuf, 5, ppos, buf, count);
+	if (ret < 0)
+		return ret;
+
+	if (sscanf(cmdbuf, "%s", cmdbuf) != 1)
+		return -EINVAL;
+	if (!strncmp(cmdbuf, "on", 5))
+		err = damon_start(ctx);
+	else if (!strncmp(cmdbuf, "off", 5))
+		err = damon_stop(ctx);
+	else
+		return -EINVAL;
+
+	if (err)
+		ret = err;
+	return ret;
+}
+
+static ssize_t damon_sprint_pids(struct damon_ctx *ctx, char *buf, ssize_t len)
+{
+	struct damon_task *t;
+	int written = 0;
+	int rc;
+
+	damon_for_each_task(ctx, t) {
+		rc = snprintf(&buf[written], len - written, "%lu ", t->pid);
+		if (!rc)
+			return -ENOMEM;
+		written += rc;
+	}
+	if (written)
+		written -= 1;
+	written += snprintf(&buf[written], len - written, "\n");
+	return written;
+}
+
+static ssize_t debugfs_pids_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	ssize_t len;
+	char pids_buf[320];
+
+	len = damon_sprint_pids(ctx, pids_buf, 320);
+	if (len < 0)
+		return len;
+
+	return simple_read_from_buffer(buf, count, ppos, pids_buf, len);
+}
+
+/*
+ * Converts a string into an array of unsigned long integers
+ *
+ * Returns an array of unsigned long integers if the conversion success, or
+ * NULL otherwise.
+ */
+static unsigned long *str_to_pids(const char *str, ssize_t len,
+				ssize_t *nr_pids)
+{
+	unsigned long *pids;
+	const int max_nr_pids = 32;
+	unsigned long pid;
+	int pos = 0, parsed, ret;
+
+	*nr_pids = 0;
+	pids = kmalloc_array(max_nr_pids, sizeof(pid), GFP_KERNEL);
+	if (!pids)
+		return NULL;
+	while (*nr_pids < max_nr_pids && pos < len) {
+		ret = sscanf(&str[pos], "%lu%n", &pid, &parsed);
+		pos += parsed;
+		if (ret != 1)
+			break;
+		pids[*nr_pids] = pid;
+		*nr_pids += 1;
+	}
+	if (*nr_pids == 0) {
+		kfree(pids);
+		pids = NULL;
+	}
+
+	return pids;
+}
+
+static ssize_t debugfs_pids_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
 {
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char *kbuf;
+	unsigned long *targets;
+	ssize_t nr_targets;
+	ssize_t ret;
+	int err;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(kbuf, count, ppos, buf, count);
+	if (ret < 0)
+		goto out;
+
+	targets = str_to_pids(kbuf, ret, &nr_targets);
+	if (!targets) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret= -EINVAL;
+		goto unlock_out;
+	}
+
+	err = damon_set_pids(ctx, targets, nr_targets);
+	if (err)
+		ret = err;
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+	kfree(targets);
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+static ssize_t debugfs_record_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char record_buf[20 + MAX_RFILE_PATH_LEN];
+	int ret;
+
+	ret = snprintf(record_buf, ARRAY_SIZE(record_buf), "%u %s\n",
+			ctx->rbuf_len, ctx->rfile_path);
+	return simple_read_from_buffer(buf, count, ppos, record_buf, ret);
+}
+
+static ssize_t debugfs_record_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char *kbuf;
+	unsigned int rbuf_len;
+	char rfile_path[MAX_RFILE_PATH_LEN];
+	ssize_t ret;
+	int err;
+
+	kbuf = kmalloc(count + 1, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+	kbuf[count] = '\0';
+
+	ret = simple_write_to_buffer(kbuf, count, ppos, buf, count);
+	if (ret < 0)
+		goto out;
+	if (sscanf(kbuf, "%u %s",
+				&rbuf_len, rfile_path) != 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	err = damon_set_recording(ctx, rbuf_len, rfile_path);
+	if (err)
+		ret = err;
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+
+static ssize_t debugfs_attrs_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char kbuf[128];
+	int ret;
+
+	ret = snprintf(kbuf, ARRAY_SIZE(kbuf), "%lu %lu %lu %lu %lu\n",
+			ctx->sample_interval, ctx->aggr_interval,
+			ctx->regions_update_interval, ctx->min_nr_regions,
+			ctx->max_nr_regions);
+
+	return simple_read_from_buffer(buf, count, ppos, kbuf, ret);
+}
+
+static ssize_t debugfs_attrs_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	unsigned long s, a, r, minr, maxr;
+	char *kbuf;
+	ssize_t ret;
+	int err;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(kbuf, count, ppos, buf, count);
+	if (ret < 0)
+		goto out;
+
+	if (sscanf(kbuf, "%lu %lu %lu %lu %lu",
+				&s, &a, &r, &minr, &maxr) != 5) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	err = damon_set_attrs(ctx, s, a, r, minr, maxr);
+	if (err)
+		ret = err;
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+static const struct file_operations monitor_on_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_monitor_on_read,
+	.write = debugfs_monitor_on_write,
+};
+
+static const struct file_operations pids_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_pids_read,
+	.write = debugfs_pids_write,
+};
+
+static const struct file_operations record_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_record_read,
+	.write = debugfs_record_write,
+};
+
+static const struct file_operations attrs_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_attrs_read,
+	.write = debugfs_attrs_write,
+};
+
+static struct dentry *debugfs_root;
+
+static int __init damon_debugfs_init(void)
+{
+	const char * const file_names[] = {"attrs", "record",
+		"pids", "monitor_on"};
+	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
+		&pids_fops, &monitor_on_fops};
+	int i;
+
+	debugfs_root = debugfs_create_dir("damon", NULL);
+	if (!debugfs_root) {
+		pr_err("failed to create the debugfs dir\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
+		if (!debugfs_create_file(file_names[i], 0600, debugfs_root,
+					NULL, fops[i])) {
+			pr_err("failed to create %s file\n", file_names[i]);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static int __init damon_init_user_ctx(void)
+{
+	int rc;
+
+	struct damon_ctx *ctx = &damon_user_ctx;
+
+	ktime_get_coarse_ts64(&ctx->last_aggregation);
+	ctx->last_regions_update = ctx->last_aggregation;
+
+	rc = damon_set_recording(ctx, 1024 * 1024, "/damon.data");
+	if (rc)
+		return rc;
+
+	mutex_init(&ctx->kdamond_lock);
+
+	prandom_seed_state(&ctx->rndseed, 42);
+	INIT_LIST_HEAD(&ctx->tasks_list);
+
 	return 0;
 }
 
+static int __init damon_init(void)
+{
+	int rc;
+
+	rc = damon_init_user_ctx();
+	if (rc)
+		return rc;
+
+	rc = damon_debugfs_init();
+	if (rc)
+		pr_err("%s: debugfs init failed\n", __func__);
+
+	return rc;
+}
+
 static void __exit damon_exit(void)
 {
-	return;
+	damon_stop(&damon_user_ctx);
+	debugfs_remove_recursive(debugfs_root);
+
+	kfree(damon_user_ctx.rbuf);
+	kfree(damon_user_ctx.rfile_path);
 }
 
 module_init(damon_init);
-- 
2.17.1

