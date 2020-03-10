Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D112C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C1B24695
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583839028;
	bh=j1G0rDcGBYGZpyC/f4KJDCMnb0hSEfIHSr6dRwUluIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G50qyqP+cTCRWYEDvcDYdNYnNSFomeyV7FtyGFX0ssB6XT8R3Z2mb6aHg8H43FMLc
	 82VP8jM7kP687dcRVKECaeCnxKooxvJ/2kXxWqgEZoWLHvL3GjIaDfUaB7QRFkDWMi
	 eLjQXrsN9+YHJ00AE/bhOfDTS/jrBRPYBxQTD0vI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgCJLRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgCJLRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:17:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D5E024693;
        Tue, 10 Mar 2020 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583839023;
        bh=j1G0rDcGBYGZpyC/f4KJDCMnb0hSEfIHSr6dRwUluIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPDEWSBg4r6WLSv+7YrlN7KiQg0DMrtAQOiMg1O1KPVWvvhvZ1ZhnrC84wz16L7cj
         Y05IIFZjkbvxlyl8YRTdD9yYgWnC2S8Lc2KYbWMLhhLs+2G+NihvzqV9Usin4J/43A
         M8BJwQgoWRh962XcJYW9p2ipF6mGUYdKcrFU4h6M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/19] perf block-info: Fix wrong block address comparison in block_info__cmp()
Date:   Tue, 10 Mar 2020 08:15:48 -0300
Message-Id: <20200310111551.25160-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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
index fbbb6d640dad..5b4214656e29 100644
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
2.21.1

