Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1EC2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BCB217BA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIGEQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 00:16:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:58719 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgIGEQu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:16:50 -0400
IronPort-SDR: H0IizkYrG4wwzZz5P+1/BmFhai0mgyMd5CqeI41sGAL5E5aVcQ6BWgZ7++gTL5zsixFoj37Y9y
 j/5CIEU094+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157215553"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="157215553"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 21:16:50 -0700
IronPort-SDR: fgvdwIp22FPN+mMtxJZuyvd6eSgolQNCMVehJi2BM4rbmlFd1+L+IwjtHjpvQrLdsPV6FSwGSa
 OnyCCARZ23Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="406709927"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2020 21:16:48 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 3/7] perf util: Compare two streams
Date:   Mon,  7 Sep 2020 12:16:02 +0800
Message-Id: <20200907041606.14500-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907041606.14500-1-yao.jin@linux.intel.com>
References: <20200907041606.14500-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stream is the branch history which is aggregated by the branch
records from perf samples. Now we support the callchain as
stream.

If the callchain entries of one stream are fully matched with
the callchain entries of another stream, we think two streams
are matched.

For example,

   cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
   -----------------------                 -----------------------
             main div.c:39                           main div.c:39
             main div.c:44                           main div.c:44

Above two streams are matched (we don't consider the case that
source code is changed).

The matching logic is, compare the chain string first. If it's not
matched, fallback to dso address comparison.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v5:
   - Remove enum stream_type
   - Rebase to perf/core

 v4:
   - Remove original source line comparison code.

 tools/perf/util/callchain.c | 54 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 9a9b56ed3f0a..7cab271e656b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1599,3 +1599,57 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 	for (node = cursor->first; node != NULL; node = node->next)
 		map__zput(node->map);
 }
+
+static bool chain_match(struct callchain_list *base_chain,
+			struct callchain_list *pair_chain)
+{
+	enum match_result match;
+
+	match = match_chain_strings(base_chain->srcline,
+				    pair_chain->srcline);
+	if (match != MATCH_ERROR)
+		return match == MATCH_EQ;
+
+	match = match_chain_dso_addresses(base_chain->ms.map,
+					  base_chain->ip,
+					  pair_chain->ms.map,
+					  pair_chain->ip);
+
+	return match == MATCH_EQ;
+}
+
+bool callchain_cnode_matched(struct callchain_node *base_cnode,
+			     struct callchain_node *pair_cnode)
+{
+	struct callchain_list *base_chain, *pair_chain;
+	bool match = false;
+
+	pair_chain = list_first_entry(&pair_cnode->val,
+				      struct callchain_list,
+				      list);
+
+	list_for_each_entry(base_chain, &base_cnode->val, list) {
+		if (&pair_chain->list == &pair_cnode->val)
+			return false;
+
+		if (!base_chain->srcline || !pair_chain->srcline) {
+			pair_chain = list_next_entry(pair_chain, list);
+			continue;
+		}
+
+		match = chain_match(base_chain, pair_chain);
+		if (!match)
+			return false;
+
+		pair_chain = list_next_entry(pair_chain, list);
+	}
+
+	/*
+	 * Say chain1 is ABC, chain2 is ABCD, we consider they are
+	 * not fully matched.
+	 */
+	if (pair_chain && (&pair_chain->list != &pair_cnode->val))
+		return false;
+
+	return match;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 83398e5bbe4b..72134bed49d8 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -290,4 +290,7 @@ int callchain_branch_counts(struct callchain_root *root,
 			    u64 *branch_count, u64 *predicted_count,
 			    u64 *abort_count, u64 *cycles_count);
 
+bool callchain_cnode_matched(struct callchain_node *base_cnode,
+			     struct callchain_node *pair_cnode);
+
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.17.1

