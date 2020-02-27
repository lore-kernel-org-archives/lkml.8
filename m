Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8697EC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45324670
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgB0EkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:40:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:33102 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgB0EkS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:40:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 20:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="261310567"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 26 Feb 2020 20:40:15 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 3/3] perf report: Support hotkey 'a' on address for annotation
Date:   Thu, 27 Feb 2020 12:39:39 +0800
Message-Id: <20200227043939.4403-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227043939.4403-1-yao.jin@linux.intel.com>
References: <20200227043939.4403-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have supported the annotation functionality
even without symbols.

For this patch, it supports the hotkey 'a' on address in report
view. Note that, for branch mode, we only support the annotation
for "branch to" address.

 v5:
 ---
 New patch in v5.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/ui/browsers/hists.c | 47 ++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 2f07680559c4..7f9a8fd24e5c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3061,21 +3061,46 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 				continue;
 			}
 
-			if (browser->selection == NULL ||
-			    browser->selection->sym == NULL ||
-			    browser->selection->map->dso->annotate_warned)
+			if (!browser->selection ||
+			    !browser->selection->map ||
+			    !browser->selection->map->dso ||
+			    browser->selection->map->dso->annotate_warned) {
 				continue;
+			}
 
-			if (symbol__annotation(browser->selection->sym)->src == NULL) {
-				ui_browser__warning(&browser->b, delay_secs * 2,
-						    "No samples for the \"%s\" symbol.\n\n"
-						    "Probably appeared just in a callchain",
-						    browser->selection->sym->name);
-				continue;
+			if (!browser->selection->sym) {
+				if (!browser->he_selection)
+					continue;
+
+				if (sort__mode == SORT_MODE__BRANCH) {
+					bi = browser->he_selection->branch_info;
+					if (!bi || !bi->to.ms.map)
+						continue;
+
+					actions->ms.sym = new_annotate_sym(bi->to.al_addr,
+									   bi->to.ms.map);
+					actions->ms.map = bi->to.ms.map;
+				} else {
+					actions->ms.sym = new_annotate_sym(browser->he_selection->ip,
+									   browser->selection->map);
+					actions->ms.map = browser->selection->map;
+				}
+
+				if (!actions->ms.sym)
+					continue;
+			} else {
+				if (symbol__annotation(browser->selection->sym)->src == NULL) {
+					ui_browser__warning(&browser->b, delay_secs * 2,
+						"No samples for the \"%s\" symbol.\n\n"
+						"Probably appeared just in a callchain",
+						browser->selection->sym->name);
+					continue;
+				}
+
+				actions->ms.map = browser->selection->map;
+				actions->ms.sym = browser->selection->sym;
 			}
 
-			actions->ms.map = browser->selection->map;
-			actions->ms.sym = browser->selection->sym;
 			do_annotate(browser, actions);
 			continue;
 		case 'P':
-- 
2.17.1

