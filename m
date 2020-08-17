Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB339C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E202067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vs3TlsI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgHQKz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:55:59 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:64585 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgHQKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597661747; x=1629197747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bmWnwAXrM5B/2idwlELxFNge5bIOUgMNKTV5WW7s4g8=;
  b=vs3TlsI+fSC0mo4VHk7F+4skRTUeUKcD2ENQt56E+mMmJ6OxUwUHunRH
   XlLZcTMGE/THA0PQY623mMYzGxXkanJWTEnFO7R240FyXxXf6hC/b5uwj
   5WVyr52mGt3rF7vMXANlZPKCmGO++VIBE8FkygsnmhVyV6Gc7LAC6cedp
   A=;
X-IronPort-AV: E=Sophos;i="5.76,322,1592870400"; 
   d="scan'208";a="48093096"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 17 Aug 2020 10:55:46 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 0DF7DA169E;
        Mon, 17 Aug 2020 10:55:34 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:55:34 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.192) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:55:15 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 09/15] mm/damon: Implement a debugfs interface
Date:   Mon, 17 Aug 2020 12:51:31 +0200
Message-ID: <20200817105137.19296-10-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817105137.19296-1-sjpark@amazon.com>
References: <20200817105137.19296-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D02UWC004.ant.amazon.com (10.43.162.236) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements a debugfs interface for DAMON.  It works for the
virtual address spaces monitoring.

DAMON exports four files, ``attrs``, ``target_ids``, ``record``, and
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

Target IDs
----------

Some types of address spaces supports multiple monitoring target.  For
example, the virtual memory address spaces monitoring can have multiple
processes as the monitoring targets.  Users can set the targets by
writing relevant id values of the targets to, and get the ids of the
current targets by reading from the ``target_ids`` file.  In case of the
virtual address spaces monitoring, the values should be pids of the
monitoring target processes.  For example, below commands set processes
having pids 42 and 4242 as the monitoring targets and check it again::

    # cd <debugfs>/damon
    # echo 42 4242 > target_ids
    # cat target_ids
    42 4242

Note that setting the target ids doesn't start the monitoring.

Record
------

DAMON supports direct monitoring result record feature.  The recorded
results are first written to a buffer and flushed to a file in batch.
Users can set the size of the buffer and the path to the result file by
reading from and writing to the ``record`` file.  For example, below
commands set the buffer to be 4 KiB and the result to be saved in
'/damon.data'.

    # cd <debugfs>/damon
    # echo 4096 /damon.data > record
    # cat record
    4096 /damon.data

Turning On/Off
--------------

Setting the files as described above doesn't incur effect unless you
explicitly start the monitoring.  You can start, stop, and check the
current status of the monitoring by writing to and reading from the
``monitor_on`` file.  Writing ``on`` to the file starts the monitoring
of the targets with the attributes.  Writing ``off`` to the file stops
those.  DAMON also stops if every targets are invalidated (in case of
the virtual memory monitoring, target processes are invalidated when
terminated).  Below example commands turn on, off, and check the status
of DAMON::

    # cd <debugfs>/damon
    # echo on > monitor_on
    # echo off > monitor_on
    # cat monitor_on
    off

Please note that you cannot write to the above-mentioned debugfs files
while the monitoring is turned on.  If you write to the files while
DAMON is running, an error code such as ``-EBUSY`` will be returned.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 mm/damon.c | 391 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 390 insertions(+), 1 deletion(-)

diff --git a/mm/damon.c b/mm/damon.c
index e52e107c90fd..92159aaf8b07 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -15,12 +15,14 @@
  * - Functions for the target validity check and cleanup
  * - Functions for DAMON core logics and features
  * - Functions for the DAMON programming interface
+ * - Functions for the DAMON debugfs interface
  * - Functions for the initialization
  */
 
 #define pr_fmt(fmt) "damon: " fmt
 
 #include <linux/damon.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/mm.h>
@@ -70,6 +72,22 @@
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 
+/* A monitoring context for debugfs interface users. */
+static struct damon_ctx damon_user_ctx = {
+	.sample_interval = 5 * 1000,
+	.aggr_interval = 100 * 1000,
+	.regions_update_interval = 1000 * 1000,
+	.min_nr_regions = 10,
+	.max_nr_regions = 1000,
+
+	.init_target_regions = kdamond_init_vm_regions,
+	.update_target_regions = kdamond_update_vm_regions,
+	.prepare_access_checks = kdamond_prepare_vm_access_checks,
+	.check_accesses = kdamond_check_vm_accesses,
+	.target_valid = kdamond_vm_target_valid,
+	.cleanup = kdamond_vm_cleanup,
+};
+
 /*
  * Construct a damon_region struct
  *
@@ -1367,13 +1385,384 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 	return 0;
 }
 
+/*
+ * Functions for the DAMON debugfs interface
+ */
+
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
+/*
+ * Returns non-empty string on success, negarive error code otherwise.
+ */
+static char *user_input_str(const char __user *buf, size_t count, loff_t *ppos)
+{
+	char *kbuf;
+	ssize_t ret;
+
+	/* We do not accept continuous write */
+	if (*ppos)
+		return ERR_PTR(-EINVAL);
+
+	kbuf = kmalloc(count + 1, GFP_KERNEL);
+	if (!kbuf)
+		return ERR_PTR(-ENOMEM);
+
+	ret = simple_write_to_buffer(kbuf, count + 1, ppos, buf, count);
+	if (ret != count) {
+		kfree(kbuf);
+		return ERR_PTR(-EIO);
+	}
+	kbuf[ret] = '\0';
+
+	return kbuf;
+}
+
+static ssize_t debugfs_monitor_on_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	ssize_t ret = count;
+	char *kbuf;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/* Remove white space */
+	if (sscanf(kbuf, "%s", kbuf) != 1)
+		return -EINVAL;
+	if (!strncmp(kbuf, "on", count))
+		err = damon_start(ctx, 1);
+	else if (!strncmp(kbuf, "off", count))
+		err = damon_stop(ctx, 1);
+	else
+		return -EINVAL;
+
+	if (err)
+		ret = err;
+	return ret;
+}
+
+#define targetid_is_pid(ctx)	\
+	(ctx->target_valid == kdamond_vm_target_valid)
+
+static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
+{
+	struct damon_target *t;
+	unsigned long id;
+	int written = 0;
+	int rc;
+
+	damon_for_each_target(t, ctx) {
+		id = t->id;
+		if (targetid_is_pid(ctx))
+			/* Show pid numbers to debugfs users */
+			id = (unsigned long)pid_vnr((struct pid *)id);
+
+		rc = snprintf(&buf[written], len - written, "%lu ", id);
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
+static ssize_t debugfs_target_ids_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	ssize_t len;
+	char ids_buf[320];
+
+	mutex_lock(&ctx->kdamond_lock);
+	len = sprint_target_ids(ctx, ids_buf, 320);
+	mutex_unlock(&ctx->kdamond_lock);
+	if (len < 0)
+		return len;
+
+	return simple_read_from_buffer(buf, count, ppos, ids_buf, len);
+}
+
+/*
+ * Converts a string into an array of unsigned long integers
+ *
+ * Returns an array of unsigned long integers if the conversion success, or
+ * NULL otherwise.
+ */
+static unsigned long *str_to_target_ids(const char *str, ssize_t len,
+					ssize_t *nr_ids)
+{
+	unsigned long *ids;
+	const int max_nr_ids = 32;
+	unsigned long id;
+	int pos = 0, parsed, ret;
+
+	*nr_ids = 0;
+	ids = kmalloc_array(max_nr_ids, sizeof(id), GFP_KERNEL);
+	if (!ids)
+		return NULL;
+	while (*nr_ids < max_nr_ids && pos < len) {
+		ret = sscanf(&str[pos], "%lu%n", &id, &parsed);
+		pos += parsed;
+		if (ret != 1)
+			break;
+		ids[*nr_ids] = id;
+		*nr_ids += 1;
+	}
+
+	return ids;
+}
+
+static ssize_t debugfs_target_ids_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char *kbuf;
+	unsigned long *targets;
+	ssize_t nr_targets;
+	ssize_t ret = count;
+	int i;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	targets = str_to_target_ids(kbuf, ret, &nr_targets);
+	if (!targets) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (targetid_is_pid(ctx)) {
+		for (i = 0; i < nr_targets; i++)
+			targets[i] = (unsigned long)find_get_pid(
+					(int)targets[i]);
+	}
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret = -EINVAL;
+		goto unlock_out;
+	}
+
+	err = damon_set_targets(ctx, targets, nr_targets);
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
+	mutex_lock(&ctx->kdamond_lock);
+	ret = snprintf(record_buf, ARRAY_SIZE(record_buf), "%u %s\n",
+			ctx->rbuf_len, ctx->rfile_path);
+	mutex_unlock(&ctx->kdamond_lock);
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
+	ssize_t ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
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
+static ssize_t debugfs_attrs_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char kbuf[128];
+	int ret;
+
+	mutex_lock(&ctx->kdamond_lock);
+	ret = snprintf(kbuf, ARRAY_SIZE(kbuf), "%lu %lu %lu %lu %lu\n",
+			ctx->sample_interval, ctx->aggr_interval,
+			ctx->regions_update_interval, ctx->min_nr_regions,
+			ctx->max_nr_regions);
+	mutex_unlock(&ctx->kdamond_lock);
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
+	ssize_t ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
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
+static const struct file_operations target_ids_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_target_ids_read,
+	.write = debugfs_target_ids_write,
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
+		"target_ids", "monitor_on"};
+	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
+		&target_ids_fops, &monitor_on_fops};
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
+	INIT_LIST_HEAD(&ctx->targets_list);
+
+	return 0;
+}
+
 /*
  * Functions for the initialization
  */
 
 static int __init damon_init(void)
 {
-	return 0;
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
 }
 
 module_init(damon_init);
-- 
2.17.1

