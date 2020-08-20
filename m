Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C7BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68BF20885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgHTVZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:25:30 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:55178 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726976AbgHTVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:25:30 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 22191749-1500050 
        for multiple; Thu, 20 Aug 2020 22:25:03 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] perf tools: Use %zd for size_t printf formats on 32b
Date:   Thu, 20 Aug 2020 22:25:01 +0100
Message-Id: <20200820212501.24421-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of trivial fixes for using %zd for size_t.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/util/session.c | 2 +-
 tools/perf/util/zstd.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ffbc9d35a383..7a5f03764702 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -87,7 +87,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 		session->decomp_last = decomp;
 	}
 
-	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
+	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
 
 	return 0;
 }
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index d2202392ffdb..48dd2b018c47 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -99,7 +99,7 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 	while (input.pos < input.size) {
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
-			pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
+			pr_err("failed to decompress (B): %zd -> %zd, dst_size %zd : %s\n",
 			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
 			break;
 		}
-- 
2.20.1

