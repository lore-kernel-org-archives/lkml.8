Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62BC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CAA22204
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YNMWEFRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgDFNOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:14:41 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:18057 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgDFNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586178879; x=1617714879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xjZkneBUveUkovP0qf4dvlI7qTPmP9m2LFnwSnSWkCg=;
  b=YNMWEFRbwNPMaX8w+Jm3cwNdqF6CluaWU/UoYv67/DDTJ4fXoCDSb+40
   ypp2IcvhQnH3bS/qGY3BWsOwKfOLi4tYqZxmiqfWYXDZCtnN4rpoTOiWz
   RE09RX8LBlRlW+WOw7zGeWW3h1KL6K2Nb4eg8XPDoJWL4c1THN1DuqCkC
   Y=;
IronPort-SDR: 7exDCaXD0/dqwecCJlkZBrNslf25aZLciAE5ha0qyGQ1BnfldCehPJMIzITBKBd453YqICXWYp
 G5hZBWAfy/+w==
X-IronPort-AV: E=Sophos;i="5.72,351,1580774400"; 
   d="scan'208";a="24290807"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 06 Apr 2020 13:14:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 7C32EA24B6;
        Mon,  6 Apr 2020 13:14:15 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 13:14:14 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 13:14:00 +0000
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
Subject: [PATCH v8 07/15] mm/damon: Implement callbacks
Date:   Mon, 6 Apr 2020 15:09:30 +0200
Message-ID: <20200406130938.14066-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406130938.14066-1-sjpark@amazon.com>
References: <20200406130938.14066-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D11UWB003.ant.amazon.com (10.43.161.206) To
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
index 64e327400749..cad3ee3d78db 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -56,6 +56,10 @@ struct damon_ctx {
 	struct rnd_state rndseed;
 
 	struct list_head tasks_list;	/* 'damon_task' objects */
+
+	/* callbacks */
+	void (*sample_cb)(struct damon_ctx *context);
+	void (*aggregate_cb)(struct damon_ctx *context);
 };
 
 int damon_set_pids(struct damon_ctx *ctx, unsigned long *pids, ssize_t nr_pids);
diff --git a/mm/damon.c b/mm/damon.c
index acbcd702ef0c..608787e88118 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -821,6 +821,8 @@ static int kdamond_fn(void *data)
 	kdamond_init_regions(ctx);
 	while (!kdamond_need_stop(ctx)) {
 		kdamond_prepare_access_checks(ctx);
+		if (ctx->sample_cb)
+			ctx->sample_cb(ctx);
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 
@@ -828,6 +830,8 @@ static int kdamond_fn(void *data)
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
+			if (ctx->aggregate_cb)
+				ctx->aggregate_cb(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
-- 
2.17.1

