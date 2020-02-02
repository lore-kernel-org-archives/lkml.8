Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5517CC3524A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A91208C3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgBBORd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 09:17:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:6188 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgBBORa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 09:17:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 06:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,394,1574150400"; 
   d="scan'208";a="253811073"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2020 06:17:27 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 4/4] perf util: Support color ops to print block percents in color
Date:   Sun,  2 Feb 2020 22:16:55 +0800
Message-Id: <20200202141655.32053-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202141655.32053-1-yao.jin@linux.intel.com>
References: <20200202141655.32053-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice to print the block percents with colors.

This patch supports the 'Sampled Cycles%' and 'Avg Cycles%'
printed in colors.

For example,

perf record -b ...
perf report --total-cycles or perf report --total-cycles --stdio

percent > 5%, colored in red
percent > 0.5%, colored in green
percent < 0.5%, default color

 v3/v4/v5/v6:
 ------------
 No change

 v2:
 ---
 No functional change

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/block-info.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index e0e56f30e6a6..4268c0ffb77a 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -181,6 +181,17 @@ static int block_column_width(struct perf_hpp_fmt *fmt,
 	return block_fmt->width;
 }
 
+static int color_pct(struct perf_hpp *hpp, int width, double pct)
+{
+#ifdef HAVE_SLANG_SUPPORT
+	if (use_browser) {
+		return __hpp__slsmg_color_printf(hpp, "%*.2f%%",
+						 width - 1, pct);
+	}
+#endif
+	return hpp_color_scnprintf(hpp, "%*.2f%%", width - 1, pct);
+}
+
 static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
 					struct perf_hpp *hpp,
 					struct hist_entry *he)
@@ -188,14 +199,11 @@ static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
 	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
 	struct block_info *bi = he->block_info;
 	double ratio = 0.0;
-	char buf[16];
 
 	if (block_fmt->total_cycles)
 		ratio = (double)bi->cycles / (double)block_fmt->total_cycles;
 
-	sprintf(buf, "%.2f%%", 100.0 * ratio);
-
-	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
+	return color_pct(hpp, block_fmt->width, 100.0 * ratio);
 }
 
 static int64_t block_total_cycles_pct_sort(struct perf_hpp_fmt *fmt,
@@ -248,16 +256,13 @@ static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
 	struct block_info *bi = he->block_info;
 	double ratio = 0.0;
 	u64 avg;
-	char buf[16];
 
 	if (block_fmt->block_cycles && bi->num_aggr) {
 		avg = bi->cycles_aggr / bi->num_aggr;
 		ratio = (double)avg / (double)block_fmt->block_cycles;
 	}
 
-	sprintf(buf, "%.2f%%", 100.0 * ratio);
-
-	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
+	return color_pct(hpp, block_fmt->width, 100.0 * ratio);
 }
 
 static int block_avg_cycles_entry(struct perf_hpp_fmt *fmt,
@@ -344,7 +349,7 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
 
 	switch (idx) {
 	case PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT:
-		fmt->entry = block_total_cycles_pct_entry;
+		fmt->color = block_total_cycles_pct_entry;
 		fmt->cmp = block_info__cmp;
 		fmt->sort = block_total_cycles_pct_sort;
 		break;
@@ -352,7 +357,7 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
 		fmt->entry = block_cycles_lbr_entry;
 		break;
 	case PERF_HPP_REPORT__BLOCK_CYCLES_PCT:
-		fmt->entry = block_cycles_pct_entry;
+		fmt->color = block_cycles_pct_entry;
 		break;
 	case PERF_HPP_REPORT__BLOCK_AVG_CYCLES:
 		fmt->entry = block_avg_cycles_entry;
-- 
2.17.1

