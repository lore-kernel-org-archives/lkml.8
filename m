Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BDBC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5777620663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCSU3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:29:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:60500 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgCSU2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:28:55 -0400
IronPort-SDR: 8qIyUmmj7Fq0MRup88lV2CTXMsV1TCsHIeoEDSTx31SIFENAjCjq56BronYbXYoDPSvpzTfsCQ
 21s/hrHTv/dA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:28:55 -0700
IronPort-SDR: /A1IS8WAVw+EWIpApRsu6gXLytM0L0izf4E4rwNAOCoEzlqMDjuF1kWuZF0pCk+Q9FNRqlY1Ee
 6fDDJ0rfhQYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031245"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:28:55 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 08/17] perf machine: Factor out lbr_callchain_add_lbr_ip()
Date:   Thu, 19 Mar 2020 13:25:08 -0700
Message-Id: <20200319202517.23423-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Both caller and callee needs to add ip from LBR to callchain.
Factor out lbr_callchain_add_lbr_ip() to improve code readability.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/machine.c | 143 +++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 70 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ef26f28eacea..f1661dd3ca69 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2193,6 +2193,74 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	return 0;
 }
 
+static int lbr_callchain_add_lbr_ip(struct thread *thread,
+				    struct callchain_cursor *cursor,
+				    struct perf_sample *sample,
+				    struct symbol **parent,
+				    struct addr_location *root_al,
+				    u64 *branch_from,
+				    bool callee)
+{
+	struct branch_stack *lbr_stack = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	int lbr_nr = lbr_stack->nr;
+	struct branch_flags *flags;
+	int err, i;
+	u64 ip;
+
+	if (callee) {
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		flags = &entries[0].flags;
+		*branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL,
+				       *branch_from);
+		if (err)
+			return err;
+
+		/* Add LBR ip from entries.from one by one. */
+		for (i = 0; i < lbr_nr; i++) {
+			ip = entries[i].from;
+			flags = &entries[i].flags;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL,
+					       *branch_from);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+
+	/* Add LBR ip from entries.from one by one. */
+	for (i = lbr_nr - 1; i >= 0; i--) {
+		ip = entries[i].from;
+		flags = &entries[i].flags;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL,
+				       *branch_from);
+		if (err)
+			return err;
+	}
+
+	/* Add LBR ip from first entries.to */
+	ip = entries[0].to;
+	flags = &entries[0].flags;
+	*branch_from = entries[0].from;
+	err = add_callchain_ip(thread, cursor, parent,
+			       root_al, &cpumode, ip,
+			       true, flags, NULL,
+			       *branch_from);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2209,14 +2277,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 {
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
-	u8 cpumode = PERF_RECORD_MISC_USER;
-	u64 ip, branch_from = 0;
-	struct branch_stack *lbr_stack;
-	struct branch_entry *entries;
-	int lbr_nr, j, k;
-	bool branch;
-	struct branch_flags *flags;
-	int mix_chain_nr;
+	u64 branch_from = 0;
 	int err;
 
 	for (i = 0; i < chain_nr; i++) {
@@ -2228,21 +2289,6 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	if (i == chain_nr)
 		return 0;
 
-	lbr_stack = sample->branch_stack;
-	entries = perf_sample__branch_entries(sample);
-	lbr_nr = lbr_stack->nr;
-	/*
-	 * LBR callstack can only get user call chain.
-	 * The mix_chain_nr is kernel call chain
-	 * number plus LBR user call chain number.
-	 * i is kernel call chain number,
-	 * 1 is PERF_CONTEXT_USER,
-	 * lbr_nr + 1 is the user call chain number.
-	 * For details, please refer to the comments
-	 * in callchain__printf
-	 */
-	mix_chain_nr = i + 1 + lbr_nr + 1;
-
 	if (callchain_param.order == ORDER_CALLEE) {
 		/* Add kernel ip */
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
@@ -2251,57 +2297,14 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 		if (err)
 			goto error;
 
-		/* Add LBR ip from first entries.to */
-		ip = entries[0].to;
-		branch = true;
-		flags = &entries[0].flags;
-		branch_from = entries[0].from;
-		err = add_callchain_ip(thread, cursor, parent,
-				       root_al, &cpumode, ip,
-				       branch, flags, NULL,
-				       branch_from);
+		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
+					       root_al, &branch_from, true);
 		if (err)
 			goto error;
 
-		/* Add LBR ip from entries.from one by one. */
-		for (j = i + 2; j < mix_chain_nr; j++) {
-			k = j - i - 2;
-			ip = entries[k].from;
-			branch = true;
-			flags = &entries[k].flags;
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
 	} else {
-		/* Add LBR ip from entries.from one by one. */
-		for (j = 0; j < lbr_nr; j++) {
-			k = lbr_nr - j - 1;
-			ip = entries[k].from;
-			branch = true;
-			flags = &entries[k].flags;
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				goto error;
-		}
-
-		/* Add LBR ip from first entries.to */
-		ip = entries[0].to;
-		branch = true;
-		flags = &entries[0].flags;
-		branch_from = entries[0].from;
-		err = add_callchain_ip(thread, cursor, parent,
-				       root_al, &cpumode, ip,
-				       branch, flags, NULL,
-				       branch_from);
+		err = lbr_callchain_add_lbr_ip(thread, cursor, sample, parent,
+					       root_al, &branch_from, false);
 		if (err)
 			goto error;
 
-- 
2.17.1

