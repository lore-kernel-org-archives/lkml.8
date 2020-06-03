Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501CFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAD9206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vcepx1yB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFCHQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:16:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:62996 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgFCHQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591168560; x=1622704560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ep+MdSv8eQP3ckds5U0F+W6+o9V8F3cfwHm67gssntY=;
  b=Vcepx1yBDHSEF9Nra5pbbvgxUKETwg24H3ZmGkkXQh2sN8gcTZ6FiR01
   yhOVQcXp9poIuUIEgjOa1i4pvxNMuLvoJz036nQP9TcOvio9txvmvRLj3
   L2w/pufkDfVId00j/DPtDQkoRw0v/fj/GySVfksdlowtWtJoq7+ULQPQD
   c=;
IronPort-SDR: KjSI6WhbtiAd87PusXIS49PaAJPWCoIBu+1+a9ZWxF2V5uyIbiF9K6dnsnVCVzKw13MB4P3Q8M
 t/xJORm2aYzg==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="48089333"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 03 Jun 2020 07:15:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 8BB75A21DB;
        Wed,  3 Jun 2020 07:15:44 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 07:15:43 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 07:15:27 +0000
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
Subject: [RFC v10 5/8] mm/damon/schemes: Implement statistics feature
Date:   Wed, 3 Jun 2020 09:11:35 +0200
Message-ID: <20200603071138.8152-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603071138.8152-1-sjpark@amazon.com>
References: <20200603071138.8152-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D10UWB003.ant.amazon.com (10.43.161.106) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
index 842a01e80c6e..e77256cf30dd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -64,6 +64,7 @@ struct damon_task {
  * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
  * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
+ * @DAMOS_STAT:		Do nothing but count the stat.
  * @DAMOS_ACTION_LEN:	Number of supported actions.
  */
 enum damos_action {
@@ -72,6 +73,7 @@ enum damos_action {
 	DAMOS_PAGEOUT,
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
+	DAMOS_STAT,		/* Do nothing but only record the stat */
 	DAMOS_ACTION_LEN,
 };
 
@@ -84,6 +86,8 @@ enum damos_action {
  * @min_age_region:	Minimum age of target regions.
  * @max_age_region:	Maximum age of target regions.
  * @action:		&damo_action to be applied to the target regions.
+ * @stat_count:		Total number of regions that this scheme is applied.
+ * @stat_sz:		Total size of regions that this scheme is applied.
  * @list:		List head for siblings.
  *
  * For each aggregation interval, DAMON applies @action to monitoring target
@@ -98,6 +102,8 @@ struct damos {
 	unsigned int min_age_region;
 	unsigned int max_age_region;
 	enum damos_action action;
+	unsigned long stat_count;
+	unsigned long stat_sz;
 	struct list_head list;
 };
 
diff --git a/mm/damon.c b/mm/damon.c
index 909599e6e5bc..ea6a8b6886b8 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -191,6 +191,8 @@ static struct damos *damon_new_scheme(
 	scheme->min_age_region = min_age_region;
 	scheme->max_age_region = max_age_region;
 	scheme->action = action;
+	scheme->stat_count = 0;
+	scheme->stat_sz = 0;
 	INIT_LIST_HEAD(&scheme->list);
 
 	return scheme;
@@ -771,6 +773,8 @@ static int damos_do_action(struct damon_task *task, struct damon_region *r,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_STAT:
+		return 0;
 	default:
 		pr_warn("Wrong action %d\n", action);
 		return -EINVAL;
@@ -798,8 +802,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_task *t,
 				(s->max_age_region &&
 				 s->max_age_region < r->age))
 			continue;
+		s->stat_count++;
+		s->stat_sz += sz;
 		damos_do_action(t, r, s->action);
-		r->age = 0;
+		if (s->action != DAMOS_STAT)
+			r->age = 0;
 	}
 }
 
@@ -1384,11 +1391,11 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = snprintf(&buf[written], len - written,
-				"%u %u %u %u %u %u %d\n",
+				"%u %u %u %u %u %u %d %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
-				s->action);
+				s->action, s->stat_count, s->stat_sz);
 		if (!rc)
 			return -ENOMEM;
 
-- 
2.17.1

