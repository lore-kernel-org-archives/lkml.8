Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F038D206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="OHaUKbGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHJNe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:34:28 -0400
Received: from smtp1.axis.com ([195.60.68.17]:2977 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgHJNe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2535; q=dns/txt; s=axis-central1;
  t=1597066465; x=1628602465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jyiBG+7AxYWs1fq5Ne7NZgRbcmmsQfSp3ovATn+TQUg=;
  b=OHaUKbGGccMxDB0lYNItxMumpeHSLTK98lag/BqKMPh6SfjoKm5Sqqpw
   zRyFgIhsLhm91AUAHmmIktL/jARlI52oOqXg/08m+7RVjabjAqVDD//YU
   H2NQROY2Nn831i5GRCbzAywT6Q+1y4sqEZ/xDKuYS4rAW9WtwIhO0n935
   u1Nw8NF+cTwUP0/F4h2LG8Orr/oiB3+rhgtmCMw73xLd+YHinvv2eMmmk
   PLdUOTL1rSrtQCttBbmcHiJltOLB4OBuTTPVqWbJje6ofv6zL+3nkufkP
   Py3IMvc6qc4BMQ7KxNrAUh7pi4K+6lVDnBddfCwrkvuZkBHWRpDg0dbqg
   g==;
IronPort-SDR: IZbcggZ2K74SXZeXsM6xN/FVSB/v1r84WnVKG3tsM1528CCkt53pq+bRQMeDwbopwcPpM6WxFK
 x9w5pq6cO0qbraRIHP/Ztkn1C+05OCpnec+ZRO8ZxqF/imDlXcxEU9AdxISEmFdARx26r2RxYX
 bg7gO9GeucDVPO1N5OnZbZWTz+YX9bishi6J4pFyw/oX+jPSGQEFk7F6rdHSJVrkg5W9LTQa/V
 P7cCXNXovbuaU2sMLGSenFq6L48qJd8Jvnzsx59Ucdg/I5VW7+AUHkqD5zQaqx8FJLaDWuufVq
 RhM=
X-IronPort-AV: E=Sophos;i="5.75,457,1589234400"; 
   d="scan'208";a="11653402"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] perf bench mem: Always memset source before memcpy
Date:   Mon, 10 Aug 2020 15:34:04 +0200
Message-ID: <20200810133404.30829-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For memcpy, the source pages are memset to zero only when --cycles is
used.  This leads to wildly different results with or without --cycles,
since all sources pages are likely to be mapped to the same zero page
without explicit writes.

Before this fix:

$ export cmd="./perf stat -e LLC-loads -- ./perf bench \
  mem memcpy -s 1024MB -l 100 -f default"
$ $cmd

         2,935,826      LLC-loads
       3.821677452 seconds time elapsed

$ $cmd --cycles

       217,533,436      LLC-loads
       8.616725985 seconds time elapsed

After this fix:

$ $cmd

       214,459,686      LLC-loads
       8.674301124 seconds time elapsed

$ $cmd --cycles

       214,758,651      LLC-loads
       8.644480006 seconds time elapsed

Fixes: 47b5757bac03c3387c ("perf bench mem: Move boilerplate memory allocation to the infrastructure")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 tools/perf/bench/mem-functions.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 9235b76501be..19d45c377ac1 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -223,12 +223,8 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	return 0;
 }
 
-static u64 do_memcpy_cycles(const struct function *r, size_t size, void *src, void *dst)
+static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
 {
-	u64 cycle_start = 0ULL, cycle_end = 0ULL;
-	memcpy_t fn = r->fn.memcpy;
-	int i;
-
 	/* Make sure to always prefault zero pages even if MMAP_THRESH is crossed: */
 	memset(src, 0, size);
 
@@ -237,6 +233,15 @@ static u64 do_memcpy_cycles(const struct function *r, size_t size, void *src, vo
 	 * to not measure page fault overhead:
 	 */
 	fn(dst, src, size);
+}
+
+static u64 do_memcpy_cycles(const struct function *r, size_t size, void *src, void *dst)
+{
+	u64 cycle_start = 0ULL, cycle_end = 0ULL;
+	memcpy_t fn = r->fn.memcpy;
+	int i;
+
+	memcpy_prefault(fn, size, src, dst);
 
 	cycle_start = get_cycles();
 	for (i = 0; i < nr_loops; ++i)
@@ -252,11 +257,7 @@ static double do_memcpy_gettimeofday(const struct function *r, size_t size, void
 	memcpy_t fn = r->fn.memcpy;
 	int i;
 
-	/*
-	 * We prefault the freshly allocated memory range here,
-	 * to not measure page fault overhead:
-	 */
-	fn(dst, src, size);
+	memcpy_prefault(fn, size, src, dst);
 
 	BUG_ON(gettimeofday(&tv_start, NULL));
 	for (i = 0; i < nr_loops; ++i)
-- 
2.25.1

