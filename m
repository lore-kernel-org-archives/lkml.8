Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDE122BF3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h2DxzTnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgHEHBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:01:21 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:52358 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEHBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596610870; x=1628146870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mwawrc3ImgMxu1QbgNqUEbXzt7eWdu4Q7HXyzxKaC9A=;
  b=h2DxzTnJJsqx40Se8wzu2y0QlL7itQRaaaegx7w3DWyOCzjXej9pDq9Y
   PkZV5LVoVFHHts6lHLBwTihhqJG9ZPuU3C4aI0IAPLYlXU4wQZQ/yxqu/
   BqtLG54ofIPQ2gn8qfTOZXVcUjGCHDvqxUv+WomD2nk7kpCi4INWn+FJx
   Y=;
IronPort-SDR: T225ob9dGGhATU4y/EpKQDwNuoKyMWQTf8BqLKPcjA8HaR6nfQqSKHz7SrO2YRz6X7+K70SWDk
 MJ8ubFHLJZdg==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="46228671"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Aug 2020 07:01:03 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id B4548A2305;
        Wed,  5 Aug 2020 07:00:51 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:00:50 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:00:34 +0000
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
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v6 01/10] mm/damon/debugfs: Allow users to set initial monitoring target regions
Date:   Wed, 5 Aug 2020 08:59:42 +0200
Message-ID: <20200805065951.18221-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805065951.18221-1-sjpark@amazon.com>
References: <20200805065951.18221-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
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
index d25aeccf7939..b2507bae6c57 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1928,6 +1928,147 @@ static ssize_t debugfs_record_write(struct file *file,
 	return ret;
 }
 
+static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	int written = 0;
+	int rc;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			rc = snprintf(&buf[written], len - written,
+					"%lu %lu %lu\n",
+					t->id, r->ar.start, r->ar.end);
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
+			 unsigned long target_id, struct damon_addr_range *ar)
+{
+	struct damon_target *t;
+	struct damon_region *r, *prev;
+	int rc = -EINVAL;
+
+	if (ar->start >= ar->end)
+		return -EINVAL;
+
+	damon_for_each_target(t, c) {
+		if (t->id == target_id) {
+			r = damon_new_region(ar->start, ar->end);
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
+	struct damon_target *t;
+	struct damon_region *r, *next;
+	int pos = 0, parsed, ret;
+	unsigned long target_id;
+	struct damon_addr_range ar;
+	int err;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+
+	while (pos < len) {
+		ret = sscanf(&str[pos], "%lu %lu %lu%n",
+				&target_id, &ar.start, &ar.end, &parsed);
+		if (ret != 3)
+			break;
+		err = add_init_region(c, target_id, &ar);
+		if (err)
+			goto fail;
+		pos += parsed;
+	}
+
+	return 0;
+
+fail:
+	damon_for_each_target(t, c) {
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
@@ -2004,6 +2145,12 @@ static const struct file_operations record_fops = {
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
@@ -2014,10 +2161,11 @@ static struct dentry *debugfs_root;
 
 static int __init damon_debugfs_init(void)
 {
-	const char * const file_names[] = {"attrs", "record", "schemes",
-		"target_ids", "monitor_on"};
-	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
-		&schemes_fops, &target_ids_fops, &monitor_on_fops};
+	const char * const file_names[] = {"attrs", "init_regions", "record",
+		"schemes", "target_ids", "monitor_on"};
+	const struct file_operations *fops[] = {&attrs_fops,
+		&init_regions_fops, &record_fops, &schemes_fops,
+		&target_ids_fops, &monitor_on_fops};
 	int i;
 
 	debugfs_root = debugfs_create_dir("damon", NULL);
-- 
2.17.1

