Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02AC2073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KeotNUt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGGJky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:40:54 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:15499 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594114853; x=1625650853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NihY3ViitGJtQEPksogWk5DoMQ/1XBiWu08W85dI/4o=;
  b=KeotNUt/eluDVbvqgDv/jGyPwrIPP5J024jIe1ST7zrB1ysV4K6Tweog
   fNV8VWz0INI4CwLfHe582HJ1ZPwwyNCjnFtLZSHG02Cxq3nERA1R6ydfY
   XeUSRUVg9qzsFO0JeYGEytXcnykQjAYNsw98dB7WbQDNawkNt9MTWkSJP
   Q=;
IronPort-SDR: X1lixmzdn1vPYBST3ApDjhtRWNutxjj1YUDQDULXpucZy5C8+yD93mwu+FQk2xR/iDRb0uTYNU
 WWPzcpHJdvaw==
X-IronPort-AV: E=Sophos;i="5.75,323,1589241600"; 
   d="scan'208";a="49677446"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Jul 2020 09:40:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 7AC17A1D4E;
        Tue,  7 Jul 2020 09:40:31 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 09:40:30 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 09:40:14 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v13 5/8] mm/damon/schemes: Implement statistics feature
Date:   Tue, 7 Jul 2020 11:38:02 +0200
Message-ID: <20200707093805.4775-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707093805.4775-1-sjpark@amazon.com>
References: <20200707093805.4775-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D36UWA002.ant.amazon.com (10.43.160.24) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

To tune the DAMON-based operation schemes, knowing how many and how
large regions are affected by each of the schemes will be helful.  Those
stats could be used for not only the tuning, but also monitoring of the
working set size and the number of regions, if the scheme does not
change the program behavior too much.

For the reason, this commit implements the statistics for the schemes.
The total number and size of the regions that each scheme is applied are
exported to users via '->stat_count' and '->stat_sz' of 'struct damos'.
Admins can also check the number by reading 'schemes' debugfs file.  The
last two integers now represents the stats.  To allow collecting the
stats without changing the program behavior, this commit also adds new
scheme action, 'DAMOS_STAT'.  Note that 'DAMOS_STAT' is not only making
no memory operation actions, but also does not reset the age of regions.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  6 ++++++
 mm/damon.c            | 13 ++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 76e6ea2f97a7..f176a2b6e67c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -73,6 +73,7 @@ struct damon_task {
  * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
+ * @DAMOS_STAT:		Do nothing but count the stat.
  * @DAMOS_ACTION_LEN:	Number of supported actions.
  */
 enum damos_action {
@@ -81,6 +82,7 @@ enum damos_action {
 	DAMOS_PAGEOUT,
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
+	DAMOS_STAT,		/* Do nothing but only record the stat */
 	DAMOS_ACTION_LEN,
 };
 
@@ -93,6 +95,8 @@ enum damos_action {
  * @min_age_region:	Minimum age of target regions.
  * @max_age_region:	Maximum age of target regions.
  * @action:		&damo_action to be applied to the target regions.
+ * @stat_count:		Total number of regions that this scheme is applied.
+ * @stat_sz:		Total size of regions that this scheme is applied.
  * @list:		List head for siblings.
  *
  * For each aggregation interval, DAMON applies @action to monitoring target
@@ -107,6 +111,8 @@ struct damos {
 	unsigned int min_age_region;
 	unsigned int max_age_region;
 	enum damos_action action;
+	unsigned long stat_count;
+	unsigned long stat_sz;
 	struct list_head list;
 };
 
diff --git a/mm/damon.c b/mm/damon.c
index 28b1e119e521..937b6bccb7b8 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -212,6 +212,8 @@ static struct damos *damon_new_scheme(
 	scheme->min_age_region = min_age_region;
 	scheme->max_age_region = max_age_region;
 	scheme->action = action;
+	scheme->stat_count = 0;
+	scheme->stat_sz = 0;
 	INIT_LIST_HEAD(&scheme->list);
 
 	return scheme;
@@ -927,6 +929,8 @@ static int damos_do_action(struct damon_task *task, struct damon_region *r,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_STAT:
+		return 0;
 	default:
 		pr_warn("Wrong action %d\n", action);
 		return -EINVAL;
@@ -950,8 +954,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_task *t,
 			continue;
 		if (r->age < s->min_age_region || s->max_age_region < r->age)
 			continue;
+		s->stat_count++;
+		s->stat_sz += sz;
 		damos_do_action(t, r, s->action);
-		r->age = 0;
+		if (s->action != DAMOS_STAT)
+			r->age = 0;
 	}
 }
 
@@ -1508,11 +1515,11 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = snprintf(&buf[written], len - written,
-				"%lu %lu %u %u %u %u %d\n",
+				"%lu %lu %u %u %u %u %d %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
-				s->action);
+				s->action, s->stat_count, s->stat_sz);
 		if (!rc)
 			return -ENOMEM;
 
-- 
2.17.1

