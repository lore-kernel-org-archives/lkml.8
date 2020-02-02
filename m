Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5574C3524A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9117D20643
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBBORY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 09:17:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:6184 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgBBORY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 09:17:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 06:17:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,394,1574150400"; 
   d="scan'208";a="253811057"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2020 06:17:22 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 1/4] perf util: Fix wrong block address comparison in block_info__cmp
Date:   Sun,  2 Feb 2020 22:16:52 +0800
Message-Id: <20200202141655.32053-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202141655.32053-1-yao.jin@linux.intel.com>
References: <20200202141655.32053-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6041441870ab ("perf block: Cleanup and refactor block info
functions") introduces a function block_info__cmp, which compares
two blocks.

But the issues are:

1. It should return the strcmp cmp value only if it's not 0.

2. When symbol names are matched, we need to compare the addresses
   of blocks further. But it wrongly uses the symbol addresses for
   comparison.

3. If the syms are both NULL, we can't consider these two blocks are
   matched.

This patch fixes above 3 issues.

Fixes: 6041441870ab ("perf block: Cleanup and refactor block info
functions")

 v6:
 ---
 New in this patch set.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/block-info.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index c4b030bf6ec2..4ed5bce945ad 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -74,30 +74,21 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 
 	if (!bi_l->sym || !bi_r->sym) {
 		if (!bi_l->sym && !bi_r->sym)
-			return 0;
+			return -1;
 		else if (!bi_l->sym)
 			return -1;
 		else
 			return 1;
 	}
 
-	if (bi_l->sym == bi_r->sym) {
-		if (bi_l->start == bi_r->start) {
-			if (bi_l->end == bi_r->end)
-				return 0;
-			else
-				return (int64_t)(bi_r->end - bi_l->end);
-		} else
-			return (int64_t)(bi_r->start - bi_l->start);
-	} else {
-		cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
+	cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
+	if (cmp)
 		return cmp;
-	}
 
-	if (bi_l->sym->start != bi_r->sym->start)
-		return (int64_t)(bi_r->sym->start - bi_l->sym->start);
+	if (bi_l->start != bi_r->start)
+		return (int64_t)(bi_r->start - bi_l->start);
 
-	return (int64_t)(bi_r->sym->end - bi_l->sym->end);
+	return (int64_t)(bi_r->end - bi_l->end);
 }
 
 static void init_block_info(struct block_info *bi, struct symbol *sym,
-- 
2.17.1

