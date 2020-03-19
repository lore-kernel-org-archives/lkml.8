Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF7EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCSU25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:28:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:60493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSU2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:28:52 -0400
IronPort-SDR: S+3OueEU9MgLCNwg4fuxIor0huXr79Ka7HiCOv2mwCKP4Or4WlSbLybzbd1xAYNVDiYvRkO/Iu
 ebQg7aKFZkNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:28:52 -0700
IronPort-SDR: tnK6mLiprZ+AM6wYxbullBFNxJQaZbP3A9PI2Hx8ryF9f237BEJtGs+efEzFLOxACvg4O2Efd2
 VzKKasUJmhpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031224"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:28:51 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 05/17] perf machine: Remove the indent in resolve_lbr_callchain_sample
Date:   Thu, 19 Mar 2020 13:25:05 -0700
Message-Id: <20200319202517.23423-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The indent is unnecessary in resolve_lbr_callchain_sample.
Removing it will make the following patch simpler.

Current code path for resolve_lbr_callchain_sample()

        /* LBR only affects the user callchain */
        if (i != chain_nr) {
                body of the function
                ....
                return 1;
        }

        return 0;

With the patch,

        /* LBR only affects the user callchain */
        if (i == chain_nr)
                return 0;

        body of the function
        ...
        return 1;

No functional changes.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/machine.c | 123 +++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fd14f1489802..9021e5b6a2a9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2177,6 +2177,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	int chain_nr = min(max_stack, (int)chain->nr), i;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	u64 ip, branch_from = 0;
+	struct branch_stack *lbr_stack;
+	struct branch_entry *entries;
+	int lbr_nr, j, k;
+	bool branch;
+	struct branch_flags *flags;
+	int mix_chain_nr;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -2184,71 +2190,68 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	}
 
 	/* LBR only affects the user callchain */
-	if (i != chain_nr) {
-		struct branch_stack *lbr_stack = sample->branch_stack;
-		struct branch_entry *entries = perf_sample__branch_entries(sample);
-		int lbr_nr = lbr_stack->nr, j, k;
-		bool branch;
-		struct branch_flags *flags;
-		/*
-		 * LBR callstack can only get user call chain.
-		 * The mix_chain_nr is kernel call chain
-		 * number plus LBR user call chain number.
-		 * i is kernel call chain number,
-		 * 1 is PERF_CONTEXT_USER,
-		 * lbr_nr + 1 is the user call chain number.
-		 * For details, please refer to the comments
-		 * in callchain__printf
-		 */
-		int mix_chain_nr = i + 1 + lbr_nr + 1;
-
-		for (j = 0; j < mix_chain_nr; j++) {
-			int err;
-			branch = false;
-			flags = NULL;
+	if (i == chain_nr)
+		return 0;
 
-			if (callchain_param.order == ORDER_CALLEE) {
-				if (j < i + 1)
-					ip = chain->ips[j];
-				else if (j > i + 1) {
-					k = j - i - 2;
-					ip = entries[k].from;
-					branch = true;
-					flags = &entries[k].flags;
-				} else {
-					ip = entries[0].to;
-					branch = true;
-					flags = &entries[0].flags;
-					branch_from = entries[0].from;
-				}
+	lbr_stack = sample->branch_stack;
+	entries = perf_sample__branch_entries(sample);
+	lbr_nr = lbr_stack->nr;
+	/*
+	 * LBR callstack can only get user call chain.
+	 * The mix_chain_nr is kernel call chain
+	 * number plus LBR user call chain number.
+	 * i is kernel call chain number,
+	 * 1 is PERF_CONTEXT_USER,
+	 * lbr_nr + 1 is the user call chain number.
+	 * For details, please refer to the comments
+	 * in callchain__printf
+	 */
+	mix_chain_nr = i + 1 + lbr_nr + 1;
+
+	for (j = 0; j < mix_chain_nr; j++) {
+		int err;
+
+		branch = false;
+		flags = NULL;
+
+		if (callchain_param.order == ORDER_CALLEE) {
+			if (j < i + 1)
+				ip = chain->ips[j];
+			else if (j > i + 1) {
+				k = j - i - 2;
+				ip = entries[k].from;
+				branch = true;
+				flags = &entries[k].flags;
 			} else {
-				if (j < lbr_nr) {
-					k = lbr_nr - j - 1;
-					ip = entries[k].from;
-					branch = true;
-					flags = &entries[k].flags;
-				}
-				else if (j > lbr_nr)
-					ip = chain->ips[i + 1 - (j - lbr_nr)];
-				else {
-					ip = entries[0].to;
-					branch = true;
-					flags = &entries[0].flags;
-					branch_from = entries[0].from;
-				}
+				ip = entries[0].to;
+				branch = true;
+				flags = &entries[0].flags;
+				branch_from = entries[0].from;
+			}
+		} else {
+			if (j < lbr_nr) {
+				k = lbr_nr - j - 1;
+				ip = entries[k].from;
+				branch = true;
+				flags = &entries[k].flags;
+			} else if (j > lbr_nr)
+				ip = chain->ips[i + 1 - (j - lbr_nr)];
+			else {
+				ip = entries[0].to;
+				branch = true;
+				flags = &entries[0].flags;
+				branch_from = entries[0].from;
 			}
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				return (err < 0) ? err : 0;
 		}
-		return 1;
-	}
 
-	return 0;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       branch, flags, NULL,
+				       branch_from);
+		if (err)
+			return (err < 0) ? err : 0;
+	}
+	return 1;
 }
 
 static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
-- 
2.17.1

