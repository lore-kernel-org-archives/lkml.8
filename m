Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C32C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7703B206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IBUXDxxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgFPOJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:09:39 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:42923 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgFPOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592316578; x=1623852578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=G533LDoQFtDJQXbDr2JCFEh7st24m9XNZEbhqU5i7lY=;
  b=IBUXDxxzSsgXD47NlhkoWeLgY2iL8mHc/1F55fn/0K3HBcgaUR33rjf9
   ZGYY8R1U13VqcddX2IW/ZlWmCE7bxY5bVoLs1eaT+d3dPmrKg2QXKvih8
   7fhANtoqA3mRHcWWrDdKpuDMq3nUiDpKT6maZ+F9RNNmNIv26wlQp4x0C
   I=;
IronPort-SDR: 5hEuOIt3Xl5wZ2R1Zv2Na55KGYpZAeFzaIccrI6bHjmD4TFK+LeD0vvElF6h9X7usYS4RfG7qj
 QPFU6TyLu80w==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="36496769"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Jun 2020 14:09:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 185B5C05FF;
        Tue, 16 Jun 2020 14:09:31 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:09:30 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:08:58 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v4 1/8] mm/damon/debugfs: Allow users to set initial monitoring target regions
Date:   Tue, 16 Jun 2020 16:08:06 +0200
Message-ID: <20200616140813.17863-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616140813.17863-1-sjpark@amazon.com>
References: <20200616140813.17863-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D01UWB004.ant.amazon.com (10.43.161.157) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Some users would want to monitor only a part of the entire virtual
memory address space.  The '->init_target_regions' callback is therefore
provided, but only programming interface can use it.

For the reason, this commit introduces a new debugfs file,
'init_region'.  Users can specify which initial monitoring target
address regions they want by writing special input to the file.  The
input should describe each region in each line in below form:

    <pid> <start address> <end address>

This commit also makes the default '->init_target_regions' callback,
'kdamon_init_vm_regions()' to do nothing if the user has set the initial
target regions already.

Note that the regions will be updated to cover entire memory mapped
regions after 'regions update interval'.  If you want the regions to not
be updated after the initial setting, you could set the interval as a
very long time, say, a few decades.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 4 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 5862b60cdea9..ab115db1f20c 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1790,6 +1790,147 @@ static ssize_t debugfs_record_write(struct file *file,
 	return ret;
 }
 
+static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+	int written = 0;
+	int rc;
+
+	damon_for_each_task(t, c) {
+		damon_for_each_region(r, t) {
+			rc = snprintf(&buf[written], len - written,
+					"%d %lu %lu\n",
+					t->pid, r->ar.start, r->ar.end);
+			if (!rc)
+				return -ENOMEM;
+			written += rc;
+		}
+	}
+	return written;
+}
+
+static ssize_t debugfs_init_regions_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char *kbuf;
+	ssize_t len;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		mutex_unlock(&ctx->kdamond_lock);
+		return -EBUSY;
+	}
+
+	len = sprint_init_regions(ctx, kbuf, count);
+	mutex_unlock(&ctx->kdamond_lock);
+	if (len < 0)
+		goto out;
+	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+
+out:
+	kfree(kbuf);
+	return len;
+}
+
+static int add_init_region(struct damon_ctx *c,
+			 int pid, struct damon_addr_range *ar)
+{
+	struct damon_task *t;
+	struct damon_region *r, *prev;
+	int rc = -EINVAL;
+
+	if (ar->start >= ar->end)
+		return -EINVAL;
+
+	damon_for_each_task(t, c) {
+		if (t->pid == pid) {
+			r = damon_new_region(c, ar->start, ar->end);
+			if (!r)
+				return -ENOMEM;
+			damon_add_region(r, t);
+			if (nr_damon_regions(t) > 1) {
+				prev = damon_prev_region(r);
+				if (prev->ar.end > r->ar.start) {
+					damon_destroy_region(r);
+					return -EINVAL;
+				}
+			}
+			rc = 0;
+		}
+	}
+	return rc;
+}
+
+static int set_init_regions(struct damon_ctx *c, const char *str, ssize_t len)
+{
+	struct damon_task *t;
+	struct damon_region *r, *next;
+	int pos = 0, parsed, ret;
+	int pid;
+	struct damon_addr_range ar;
+	int err;
+
+	damon_for_each_task(t, c) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+
+	while (pos < len) {
+		ret = sscanf(&str[pos], "%d %lu %lu%n",
+				&pid, &ar.start, &ar.end, &parsed);
+		if (ret != 3)
+			break;
+		err = add_init_region(c, pid, &ar);
+		if (err)
+			goto fail;
+		pos += parsed;
+	}
+
+	return 0;
+
+fail:
+	damon_for_each_task(t, c) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+	return err;
+}
+
+static ssize_t debugfs_init_regions_write(struct file *file,
+					  const char __user *buf, size_t count,
+					  loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char *kbuf;
+	ssize_t ret = count;
+	int err;
+
+	kbuf = user_input_str(buf, count, ppos);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	err = set_init_regions(ctx, kbuf, ret);
+	if (err)
+		ret = err;
+
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+	kfree(kbuf);
+	return ret;
+}
+
 static ssize_t debugfs_attrs_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
@@ -1866,6 +2007,12 @@ static const struct file_operations record_fops = {
 	.write = debugfs_record_write,
 };
 
+static const struct file_operations init_regions_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_init_regions_read,
+	.write = debugfs_init_regions_write,
+};
+
 static const struct file_operations attrs_fops = {
 	.owner = THIS_MODULE,
 	.read = debugfs_attrs_read,
@@ -1876,10 +2023,11 @@ static struct dentry *debugfs_root;
 
 static int __init damon_debugfs_init(void)
 {
-	const char * const file_names[] = {"attrs", "record", "schemes",
-		"pids", "monitor_on"};
-	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
-		&schemes_fops, &pids_fops, &monitor_on_fops};
+	const char * const file_names[] = {"attrs", "init_regions", "record",
+		"schemes", "pids", "monitor_on"};
+	const struct file_operations *fops[] = {&attrs_fops,
+		&init_regions_fops, &record_fops, &schemes_fops, &pids_fops,
+		&monitor_on_fops};
 	int i;
 
 	debugfs_root = debugfs_create_dir("damon", NULL);
-- 
2.17.1

