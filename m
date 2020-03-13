Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8DCC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8E92074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCMNqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:46:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:8268 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgCMNqi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:46:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 06:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="236960287"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2020 06:46:35 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf report: Fix no branch type statistics report issue
Date:   Fri, 13 Mar 2020 21:46:07 +0800
Message-Id: <20200313134607.12873-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we could get the report of branch type statistics.

For example,

perf record -j any,save_type ...
perf report --stdio

  #
  # Branch Statistics:
  #
  COND_FWD:  40.6%
  COND_BWD:   4.1%
  CROSS_4K:  24.7%
  CROSS_2M:  12.3%
      COND:  44.7%
    UNCOND:   0.0%
       IND:   6.1%
      CALL:  24.5%
       RET:  24.7%

But now for the recent perf, it can't report the branch type statistics.

It's a regression issue caused by commit 40c39e304641
("perf report: Fix a no annotate browser displayed issue"),
which only counts the branch type statistics for browser mode.

This patch moves the branch_type_count() outside of ui__has_annotation()
checking, then branch type statistics can work for stdio mode.

Fixes: 40c39e304641 ("perf report: Fix a no annotate browser displayed issue")

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index d7c905f7520f..5f4045df76f4 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -186,24 +186,23 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 {
 	struct hist_entry *he = iter->he;
 	struct report *rep = arg;
-	struct branch_info *bi;
+	struct branch_info *bi = he->branch_info;
 	struct perf_sample *sample = iter->sample;
 	struct evsel *evsel = iter->evsel;
 	int err;
 
+	branch_type_count(&rep->brtype_stat, &bi->flags,
+			  bi->from.addr, bi->to.addr);
+
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 	if (err)
 		goto out;
 
 	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
 
-	branch_type_count(&rep->brtype_stat, &bi->flags,
-			  bi->from.addr, bi->to.addr);
-
 out:
 	return err;
 }
-- 
2.17.1

