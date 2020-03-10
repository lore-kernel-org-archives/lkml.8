Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9372CC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692F4246B2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCJHEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:04:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:5965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgCJHD6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:03:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524664"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:03:54 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 10/14] perf util: Enable block source line comparison
Date:   Tue, 10 Mar 2020 15:02:41 +0800
Message-Id: <20200310070245.16314-11-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310070245.16314-1-yao.jin@linux.intel.com>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we only supported address comparison, but it was not good
for the case that address might be changed if source code was updated.

This patch enables for the source line comparison.

1. If all of the source lines in a block are not changed (or only
   moved some offsets as a whole), we think the block is not changed.

2. If we can aware any source line in this block is changed,
   we think this block is changed.

3. If 1 and 2 are both not matched, fallback to address comparison.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/block-info.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 2ad9e2dd7f77..3aa564151d84 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -93,11 +93,12 @@ struct block_info *block_info__new(void)
 }
 
 int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right,
-			  struct srclist *src_list __maybe_unused)
+			  struct srclist *src_list)
 {
 	struct block_info *bi_l = left->block_info;
 	struct block_info *bi_r = right->block_info;
 	int cmp;
+	bool changed;
 
 	if (!bi_l->sym || !bi_r->sym) {
 		if (!bi_l->sym && !bi_r->sym)
@@ -112,6 +113,27 @@ int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right,
 	if (cmp)
 		return cmp;
 
+	if (src_list && bi_l->line && bi_r->line) {
+		if (block_same_srcfiles(bi_l->line, bi_r->line) &&
+		    bi_l->line->start_rel) {
+
+			if (block_srclist_matched(src_list,
+						  bi_l->line->start_rel,
+						  bi_l->line->start_nr,
+						  bi_l->line->end_nr,
+						  bi_r->line->start_nr,
+						  bi_r->line->end_nr,
+						  &changed)) {
+				bi_l->srcline_matched = true;
+				return 0;
+			} else if (changed) {
+				bi_l->block_changed = true;
+				return 0;
+			} else
+				return -1;
+		}
+	}
+
 	if (bi_l->start != bi_r->start)
 		return (int64_t)(bi_r->start - bi_l->start);
 
-- 
2.17.1

