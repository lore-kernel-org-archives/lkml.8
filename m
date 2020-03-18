Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF06C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C016C20774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SlpBCYgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCRLcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:32:55 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:42483 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCRLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584531174; x=1616067174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IIweUbJ6ywSxmEcEsqVWoNZ/WqTFK20tUG13PKDxXU8=;
  b=SlpBCYgOcuiVX8O+xraTgbBjl8ei7tsivi8p6D047Zp5yP6uYJyYGGPx
   +IhlVEtIcd3bDXVmtvrH5iwOFpZll7+Mf7eKHa+nSqgnlkn8jgaa9fxpZ
   myAY+duIJzAr09FGNQFJCmrcQAKfKgmhhLBYzAm8rURdn+A4BM2ID59r9
   E=;
IronPort-SDR: ETsYFwWCXdqiKtV6jfvVJ1un7t8wySL4whgPWQh+9JbcrMmEtsPTXOPvBfEhrozL4akLUT1+Cz
 xz06oDSJsiKw==
X-IronPort-AV: E=Sophos;i="5.70,567,1574121600"; 
   d="scan'208";a="33271215"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 Mar 2020 11:32:51 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 428FFA0333;
        Wed, 18 Mar 2020 11:32:40 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Mar 2020 11:32:40 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.235) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Mar 2020 11:32:26 +0000
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
Subject: [PATCH v7 07/15] mm/damon: Implement callbacks
Date:   Wed, 18 Mar 2020 12:27:14 +0100
Message-ID: <20200318112722.30143-8-sjpark@amazon.com>
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
index 535337529d20..2e8af1ce4389 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -787,9 +787,13 @@ static int kdamond_fn(void *data)
 			}
 			mmput(mm);
 		}
+		if (ctx->sample_cb)
+			ctx->sample_cb(ctx);
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
+			if (ctx->aggregate_cb)
+				ctx->aggregate_cb(ctx);
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
-- 
2.17.1

