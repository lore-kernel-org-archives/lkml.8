Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E95C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B327D20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oH4vGHZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgC3LxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:53:18 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:9859 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgC3LxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585569198; x=1617105198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tsdeA8JBYq03cXIHW3dIrgYjdCdto2VIoJkbBcORfYc=;
  b=oH4vGHZLcIUyTp6RpntxKfiYRRfelIM5DHTTyIhIlaMbp13MjWfTo13G
   bqYL+egnI/jYXJhDi6/fAIbQTL46otWQ77DDkjykw7aQCntpYyr2bTPjI
   +4SOmnGHx+nfquo+823lLpZuq6V0krTV5dqPSgwwrLB85aM9B1vnNDkLY
   g=;
IronPort-SDR: TZdZKsPaztKdXSdsSGBHlsK6Wb7LN1pHmtJm7AsgYc8ICDv83iVdmFcRoAxzBQBwJTwcFxdujw
 r04x/HLY+66g==
X-IronPort-AV: E=Sophos;i="5.72,324,1580774400"; 
   d="scan'208";a="25842589"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 30 Mar 2020 11:53:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id F2B5F2412D8;
        Mon, 30 Mar 2020 11:53:01 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 30 Mar 2020 11:53:01 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.134) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 30 Mar 2020 11:52:47 +0000
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
        <rostedt@goodmis.org>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v5 4/7] mm/damon/schemes: Implement a debugfs interface
Date:   Mon, 30 Mar 2020 13:50:39 +0200
Message-ID: <20200330115042.17431-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330115042.17431-1-sjpark@amazon.com>
References: <20200330115042.17431-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D37UWC003.ant.amazon.com (10.43.162.183) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements a debugfs interface for the data access
monitoring oriented memory management schemes.  It is supposed to be
used by administrators and/or privileged user space programs.  Users can
read and update the rules using ``<debugfs>/damon/schemes`` file.  The
format is::

    <min/max size> <min/max access frequency> <min/max age> <action>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 933d484451d1..1f4d7e345f4c 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -181,6 +181,29 @@ static void damon_destroy_task(struct damon_task *t)
 	damon_free_task(t);
 }
 
+static struct damos *damon_new_scheme(
+		unsigned int min_sz_region, unsigned int max_sz_region,
+		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
+		unsigned int min_age_region, unsigned int max_age_region,
+		enum damos_action action)
+{
+	struct damos *scheme;
+
+	scheme = kmalloc(sizeof(*scheme), GFP_KERNEL);
+	if (!scheme)
+		return NULL;
+	scheme->min_sz_region = min_sz_region;
+	scheme->max_sz_region = max_sz_region;
+	scheme->min_nr_accesses = min_nr_accesses;
+	scheme->max_nr_accesses = max_nr_accesses;
+	scheme->min_age_region = min_age_region;
+	scheme->max_age_region = max_age_region;
+	scheme->action = action;
+	INIT_LIST_HEAD(&scheme->list);
+
+	return scheme;
+}
+
 static void damon_add_scheme(struct damon_ctx *ctx, struct damos *s)
 {
 	list_add_tail(&s->list, &ctx->schemes_list);
@@ -1362,6 +1385,147 @@ static ssize_t debugfs_monitor_on_write(struct file *file,
 	return ret;
 }
 
+static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
+{
+	struct damos *s;
+	int written = 0;
+	int rc;
+
+	damon_for_each_schemes(c, s) {
+		rc = snprintf(&buf[written], len - written,
+				"%u %u %u %u %u %u %d\n",
+				s->min_sz_region, s->max_sz_region,
+				s->min_nr_accesses, s->max_nr_accesses,
+				s->min_age_region, s->max_age_region,
+				s->action);
+		if (!rc)
+			return -ENOMEM;
+
+		written += rc;
+	}
+	return written;
+}
+
+static ssize_t debugfs_schemes_read(struct file *file, char __user *buf,
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
+	len = sprint_schemes(ctx, kbuf, count);
+	if (len < 0)
+		goto out;
+	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+
+out:
+	kfree(kbuf);
+	return len;
+}
+
+static void free_schemes_arr(struct damos **schemes, ssize_t nr_schemes)
+{
+	ssize_t i;
+
+	for (i = 0; i < nr_schemes; i++)
+		kfree(schemes[i]);
+	kfree(schemes);
+}
+
+/*
+ * Converts a string into an array of struct damos pointers
+ *
+ * Returns an array of struct damos pointers that converted if the conversion
+ * success, or NULL otherwise.
+ */
+static struct damos **str_to_schemes(const char *str, ssize_t len,
+				ssize_t *nr_schemes)
+{
+	struct damos *scheme, **schemes;
+	const int max_nr_schemes = 256;
+	int pos = 0, parsed, ret;
+	unsigned int min_sz, max_sz, min_nr_a, max_nr_a, min_age, max_age;
+	int action;
+
+	schemes = kmalloc_array(max_nr_schemes, sizeof(scheme),
+			GFP_KERNEL);
+	if (!schemes)
+		return NULL;
+
+	*nr_schemes = 0;
+	while (pos < len && *nr_schemes < max_nr_schemes) {
+		ret = sscanf(&str[pos], "%u %u %u %u %u %u %d%n",
+				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
+				&min_age, &max_age, &action, &parsed);
+		if (ret != 7)
+			break;
+		if (action >= DAMOS_ACTION_LEN) {
+			pr_err("wrong action %d\n", action);
+			goto fail;
+		}
+
+		pos += parsed;
+		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
+				min_age, max_age, action);
+		if (!scheme)
+			goto fail;
+
+		schemes[*nr_schemes] = scheme;
+		*nr_schemes += 1;
+	}
+	if (!*nr_schemes)
+		goto fail;
+	return schemes;
+fail:
+	free_schemes_arr(schemes, *nr_schemes);
+	return NULL;
+}
+
+static ssize_t debugfs_schemes_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	char *kbuf;
+	struct damos **schemes;
+	ssize_t nr_schemes = 0, ret;
+	int err;
+
+	if (*ppos)
+		return -EINVAL;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(kbuf, count, ppos, buf, count);
+	if (ret < 0)
+		goto out;
+
+	schemes = str_to_schemes(kbuf, ret, &nr_schemes);
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	err = damon_set_schemes(ctx, schemes, nr_schemes);
+	if (err)
+		ret = err;
+	else
+		nr_schemes = 0;
+unlock_out:
+	mutex_unlock(&ctx->kdamond_lock);
+	free_schemes_arr(schemes, nr_schemes);
+out:
+	kfree(kbuf);
+	return ret;
+}
+
 static ssize_t damon_sprint_pids(struct damon_ctx *ctx, char *buf, ssize_t len)
 {
 	struct damon_task *t;
@@ -1588,6 +1752,12 @@ static const struct file_operations pids_fops = {
 	.write = debugfs_pids_write,
 };
 
+static const struct file_operations schemes_fops = {
+	.owner = THIS_MODULE,
+	.read = debugfs_schemes_read,
+	.write = debugfs_schemes_write,
+};
+
 static const struct file_operations record_fops = {
 	.owner = THIS_MODULE,
 	.read = debugfs_record_read,
@@ -1604,10 +1774,10 @@ static struct dentry *debugfs_root;
 
 static int __init damon_debugfs_init(void)
 {
-	const char * const file_names[] = {"attrs", "record",
+	const char * const file_names[] = {"attrs", "record", "schemes",
 		"pids", "monitor_on"};
 	const struct file_operations *fops[] = {&attrs_fops, &record_fops,
-		&pids_fops, &monitor_on_fops};
+		&schemes_fops, &pids_fops, &monitor_on_fops};
 	int i;
 
 	debugfs_root = debugfs_create_dir("damon", NULL);
-- 
2.17.1

