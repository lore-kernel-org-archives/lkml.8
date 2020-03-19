Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF8EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908B120CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgCSOMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:12:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbgCSOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvst-0002DB-RK; Thu, 19 Mar 2020 15:10:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3C6C41C22A9;
        Thu, 19 Mar 2020 15:10:50 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:49 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf block-info: Fix wrong block address comparison
 in block_info__cmp()
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200202141655.32053-2-yao.jin@linux.intel.com>
References: <20200202141655.32053-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158462704993.28353.6246503222087533009.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3e152aa984ff4f639f7d2daf1ad10d408c0a3332
Gitweb:        https://git.kernel.org/tip/3e152aa984ff4f639f7d2daf1ad10d408c0a3332
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Sun, 02 Feb 2020 22:16:52 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 09 Mar 2020 21:43:25 -03:00

perf block-info: Fix wrong block address comparison in block_info__cmp()

Commit 6041441870ab ("perf block: Cleanup and refactor block info
functions") introduces block_info__cmp(), which compares two blocks.

But the issues are:

1. It should return the strcmp cmp value only if it's not 0.

2. When symbol names are matched, we need to compare the addresses
   of blocks further. But it wrongly uses the symbol addresses for
   comparison.

3. If the syms are both NULL, we can't consider these two blocks are
   matched.

This patch fixes above 3 issues.

Fixes: 6041441870ab ("perf block: Cleanup and refactor block info functions")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200202141655.32053-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/block-info.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index fbbb6d6..5b42146 100644
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
