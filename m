Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AE720674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QbBe2b8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgFBNHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:07:16 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:64000 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgFBNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591103227; x=1622639227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yXcscIx9TszwKz07XL6u8QTZrOQmEAxwAfn/hK3gC7Q=;
  b=QbBe2b8DUrb8rqOWWqimmXkRgO51MFymAKTPWrM0t3QgGf4gVE8QWZdT
   z8TPIj9jHci7Jb33rEQfAhSDa7+lBVO3f0vo/OB+JmDJ/AdEHh01ya7wY
   srrYXTUPJstFuY5dppplAv1ff9D6d+PZCSJ3HSnJuajBc/8aMmxouCEOD
   E=;
IronPort-SDR: nC8b8AKKge52pMvpsUJykAc+9zQDcLWR3+//e6ireo+hA5Mc/Wly7o4xepmNyM7G5T4aVjWAny
 RgoBNPGBedtA==
X-IronPort-AV: E=Sophos;i="5.73,464,1583193600"; 
   d="scan'208";a="49176524"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 02 Jun 2020 13:06:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 5A27FA2019;
        Tue,  2 Jun 2020 13:06:57 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 13:06:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.175) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 13:06:41 +0000
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
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 06/15] mm/damon: Implement callbacks
Date:   Tue, 2 Jun 2020 15:01:16 +0200
Message-ID: <20200602130125.20467-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602130125.20467-1-sjpark@amazon.com>
References: <20200602130125.20467-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.175]
X-ClientProxiedBy: EX13D29UWC002.ant.amazon.com (10.43.162.254) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements callbacks for DAMON.  Using this, DAMON users can
install their callbacks for each step of the access monitoring so that
they can do something interesting with the monitored access patterns
online.  For example, callbacks can report the monitored patterns to
users or do some access pattern based memory management such as
proactive reclamations or access pattern based THP promotions/demotions
decision makings.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/linux/damon.h | 13 +++++++++++++
 mm/damon.c            |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5afcb2bb7f77..12536d9d2f74 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -80,6 +80,15 @@ struct damon_task {
  * @kdamond_lock.  Accesses to other fields must be protected by themselves.
  *
  * @tasks_list:		Head of monitoring target tasks (&damon_task) list.
+ *
+ * @sample_cb:			Called for each sampling interval.
+ * @aggregate_cb:		Called for each aggregation interval.
+ *
+ * @sample_cb and @aggregate_cb are called from @kdamond for each of the
+ * sampling intervals and aggregation intervals, respectively.  Therefore,
+ * users can safely access to the monitoring results via @tasks_list without
+ * additional protection of @kdamond_lock.  For the reason, users are
+ * recommended to use these callback for the accesses to the results.
  */
 struct damon_ctx {
 	unsigned long sample_interval;
@@ -96,6 +105,10 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct list_head tasks_list;	/* 'damon_task' objects */
+
+	/* callbacks */
+	void (*sample_cb)(struct damon_ctx *context);
+	void (*aggregate_cb)(struct damon_ctx *context);
 };
 
 int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
diff --git a/mm/damon.c b/mm/damon.c
index de5ed38ac05c..42ce9df47f8b 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -850,6 +850,8 @@ static int kdamond_fn(void *data)
 	kdamond_init_regions(ctx);
 	while (!kdamond_need_stop(ctx)) {
 		kdamond_prepare_access_checks(ctx);
+		if (ctx->sample_cb)
+			ctx->sample_cb(ctx);
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
@@ -857,6 +859,8 @@ static int kdamond_fn(void *data)
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
+			if (ctx->aggregate_cb)
+				ctx->aggregate_cb(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
-- 
2.17.1

