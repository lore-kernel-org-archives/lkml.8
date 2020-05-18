Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3D120709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IkG273PP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgERKIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:08:16 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27888 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589796495; x=1621332495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5eUUH3KSzXPS1Zv1Jyq7nrLXWic8IpcbJpzSCJto0dg=;
  b=IkG273PPQ/L7u8pNWnMe336GL+deQ2g6qy+ul3HnSZX1Y0ZiAvxgGET/
   8121yikgyq2mnJWKWsOPSL6fGRCv80cTNY2W+okyaDrsCfFzGRZI8/0yV
   1uREaQFprmh9Y3f1wVly1uJXE5ZoGjxyoDnk9sHVd9vpKpxyp4BZuXzzO
   4=;
IronPort-SDR: /z+M2zXz80vZxZfTWk2X7x8rwHYuD2KLFg2/BM+8tTVxa34bH5V6NzDTtdRBX3g3LLJVHvSmgV
 zE7gmDm2yuiQ==
X-IronPort-AV: E=Sophos;i="5.73,406,1583193600"; 
   d="scan'208";a="45461777"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 May 2020 10:08:11 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 7F6A1A2072;
        Mon, 18 May 2020 10:07:58 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 18 May 2020 10:07:57 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 18 May 2020 10:07:42 +0000
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
Subject: [PATCH v12 08/16] mm/damon: Implement callbacks
Date:   Mon, 18 May 2020 12:00:10 +0200
Message-ID: <20200518100018.2293-9-sjpark@amazon.com>
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

This commit implements callbacks for DAMON.  Using this, DAMON users can
install their callbacks for each step of the access monitoring so that
they can do something interesting with the monitored access patterns
online.  For example, callbacks can report the monitored patterns to
users or do some access pattern based memory management such as
proactive reclamations or access pattern based THP promotions/demotions
decision makings.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 4 ++++
 mm/damon.c            | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 62b9f90ed87b..264569b21502 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -55,6 +55,10 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct list_head tasks_list;	/* 'damon_task' objects */
+
+	/* callbacks */
+	void (*sample_cb)(struct damon_ctx *context);
+	void (*aggregate_cb)(struct damon_ctx *context);
 };
 
 int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
diff --git a/mm/damon.c b/mm/damon.c
index 38a8a68b7beb..498160b5e086 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -851,6 +851,8 @@ static int kdamond_fn(void *data)
 	kdamond_init_regions(ctx);
 	while (!kdamond_need_stop(ctx)) {
 		kdamond_prepare_access_checks(ctx);
+		if (ctx->sample_cb)
+			ctx->sample_cb(ctx);
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
@@ -858,6 +860,8 @@ static int kdamond_fn(void *data)
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
+			if (ctx->aggregate_cb)
+				ctx->aggregate_cb(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
-- 
2.17.1

