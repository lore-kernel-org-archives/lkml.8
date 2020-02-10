Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE0AC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCD020863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D3x5Iqdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgBJPKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:10:30 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:23946 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBJPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581347429; x=1612883429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hNmJvif+++9bpJXH4ocwEtBZOpr7pyJLf5AMSJbMCdE=;
  b=D3x5IqdjGAt9Brz77sHFDY6my8u7ZvhVyDVRbBohNth0gHW8i2gsU6Ub
   m7OjHpXokW1O+Iv2lsHufiQ41HNNql1H+P0DrNtz/SOF8P5a42K1FU5bP
   cCrGGPNgzirs5ZHB73XqCZs+HRGsQ28uh53Ra8j35756Playsl8HQ+YG/
   M=;
IronPort-SDR: qTd2qINutpDE+kMds/NxaKsqI4nJ7UiYNe6hAjUULg5OUjUeS8uDqzZ+uxjF29ZEvhhhomImD6
 nNPXqRC2rB7Q==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="16476134"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Feb 2020 15:10:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 60AEDA0666;
        Mon, 10 Feb 2020 15:10:24 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 15:10:23 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.69) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 15:10:12 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/3] mm/damon/rules: Implement a debugfs interface
Date:   Mon, 10 Feb 2020 16:09:21 +0100
Message-ID: <20200210150921.32482-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210150921.32482-1-sjpark@amazon.com>
References: <20200210150921.32482-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.69]
X-ClientProxiedBy: EX13D17UWB002.ant.amazon.com (10.43.161.141) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements a debugfs interface for the DAMON's access
pattern based memory management rules.  It is supposed to be used by
administrators and privileged user space programs.  Users read and
update the rules using ``<debugfs>/damon/rules`` file.  The format is::

    <min/max size> <min/max access frequency> <min/max duration> <hint>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 2 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 5d33b5d6504b..efb85bdf9400 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -195,6 +195,29 @@ static void damon_destroy_task(struct damon_task *t)
 	damon_free_task(t);
 }
 
+static struct damon_rule *damon_new_rule(
+		unsigned int min_sz_region, unsigned int max_sz_region,
+		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
+		unsigned int min_age_region, unsigned int max_age_region,
+		enum damon_action action)
+{
+	struct damon_rule *ret;
+
+	ret = kmalloc(sizeof(struct damon_rule), GFP_KERNEL);
+	if (!ret)
+		return NULL;
+	ret->min_sz_region = min_sz_region;
+	ret->max_sz_region = max_sz_region;
+	ret->min_nr_accesses = min_nr_accesses;
+	ret->max_nr_accesses = max_nr_accesses;
+	ret->min_age_region = min_age_region;
+	ret->max_age_region = max_age_region;
+	ret->action = action;
+	INIT_LIST_HEAD(&ret->list);
+
+	return ret;
+}
+
 static void damon_add_rule(struct damon_ctx *ctx, struct damon_rule *r)
 {
 	list_add_tail(&r->list, &ctx->rules_list);
@@ -1266,6 +1289,130 @@ static ssize_t debugfs_monitor_on_write(struct file *file,
 	return ret;
 }
 
+static ssize_t damon_sprint_rules(struct damon_ctx *c, char *buf, ssize_t len)
+{
+	char *cursor = buf;
+	struct damon_rule *r;
+	int ret;
+
+	damon_for_each_rule(c, r) {
+		ret = snprintf(cursor, len, "%u %u %u %u %u %u %d\n",
+				r->min_sz_region, r->max_sz_region,
+				r->min_nr_accesses, r->max_nr_accesses,
+				r->min_age_region, r->max_age_region,
+				r->action);
+		cursor += ret;
+	}
+	return cursor - buf;
+}
+
+static ssize_t debugfs_rules_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	ssize_t len;
+	char *rules_buf;
+
+	rules_buf = kmalloc(sizeof(char) * 1024, GFP_KERNEL);
+
+	len = damon_sprint_rules(ctx, rules_buf, 1024);
+	len = simple_read_from_buffer(buf, count, ppos, rules_buf, len);
+
+	kfree(rules_buf);
+	return len;
+}
+
+static void damon_free_rules(struct damon_rule **rules, ssize_t nr_rules)
+{
+	ssize_t i;
+
+	for (i = 0; i < nr_rules; i++)
+		kfree(rules[i]);
+	kfree(rules);
+}
+
+/*
+ * Converts a string into an array of struct damon_rule pointers
+ *
+ * Returns an array of struct damon_rule pointers that converted, or NULL
+ * otherwise.
+ */
+static struct damon_rule **str_to_rules(const char *str, ssize_t len,
+				ssize_t *nr_rules)
+{
+	struct damon_rule *rule, **rules;
+	int pos = 0, parsed, ret;
+	unsigned int min_sz, max_sz, min_nr_a, max_nr_a, min_age, max_age;
+	int action;
+
+	rules = kmalloc_array(256, sizeof(struct damon_rule *), GFP_KERNEL);
+	if (!rules)
+		return NULL;
+
+	*nr_rules = 0;
+	while (pos < len && *nr_rules < 256) {
+		ret = sscanf(&str[pos], "%u %u %u %u %u %u %d%n",
+				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
+				&min_age, &max_age, &action, &parsed);
+		pos += parsed;
+		if (ret != 7)
+			break;
+		if (action >= DAMON_ACTION_LEN) {
+			pr_err("wrong action %d\n", action);
+			goto error;
+		}
+
+		rule = damon_new_rule(min_sz, max_sz, min_nr_a, max_nr_a,
+				min_age, max_age, action);
+		if (!rule)
+			goto error;
+
+		rules[*nr_rules] = rule;
+		*nr_rules += 1;
+	}
+	return rules;
+error:
+	damon_free_rules(rules, *nr_rules);
+	return NULL;
+}
+
+static ssize_t debugfs_rules_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char *rules_buf;
+	struct damon_rule **rules;
+	ssize_t nr_rules, ret;
+
+	rules_buf = kmalloc(sizeof(char) * 1024, GFP_KERNEL);
+	ret = simple_write_to_buffer(rules_buf, 1024, ppos, buf, count);
+	if (ret < 0) {
+		kfree(rules_buf);
+		return ret;
+	}
+
+	rules = str_to_rules(rules_buf, ret, &nr_rules);
+	if (!rules)
+		return -EINVAL;
+
+	spin_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond)
+		goto monitor_running;
+
+	damon_set_rules(ctx, rules, nr_rules);
+	spin_unlock(&ctx->kdamond_lock);
+	kfree(rules_buf);
+	return ret;
+
+monitor_running:
+	spin_unlock(&ctx->kdamond_lock);
+	pr_err("%s: kdamond is running. Turn it off first.\n", __func__);
+	ret = -EINVAL;
+	damon_free_rules(rules, nr_rules);
+	kfree(rules_buf);
+	return ret;
+}
+
 static ssize_t damon_sprint_pids(struct damon_ctx *ctx, char *buf, ssize_t len)
 {
 	char *cursor = buf;
@@ -1468,6 +1615,12 @@ static const struct file_operations pids_fops = {
 	.write = debugfs_pids_write,
 };
 
+static const struct file_operations rules_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_rules_read,
+	.write = debugfs_rules_write,
+};
+
 static const struct file_operations record_fops = {
 	.owner = THIS_MODULE,
 	.read = debugfs_record_read,
@@ -1484,10 +1637,10 @@ static struct dentry *debugfs_root;
 
 static int __init debugfs_init(void)
 {
-	const char * const file_names[] = {"attrs", "record",
+	const char * const file_names[] = {"attrs", "record", "rules",
 		"pids", "monitor_on"};
 	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
-		&pids_fops, &monitor_on_fops};
+		&rules_fops, &pids_fops, &monitor_on_fops};
 	int i;
 
 	debugfs_root = debugfs_create_dir("damon", NULL);
-- 
2.17.1

