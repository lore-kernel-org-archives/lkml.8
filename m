Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0898924125
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA0RJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:09:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:48043 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0RJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:09:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 08:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,370,1574150400"; 
   d="scan'208";a="308813167"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2020 08:54:58 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, eranian@google.com, acme@redhat.com,
        mingo@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 2/2] perf/x86/intel: Output LBR TOS information
Date:   Mon, 27 Jan 2020 08:53:55 -0800
Message-Id: <20200127165355.27495-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127165355.27495-1-kan.liang@linux.intel.com>
References: <20200127165355.27495-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For Intel LBR, the LBR Top-of-Stack (TOS) information is the HW index of
raw branch record for the most recent branch.

For non-adaptive PEBS and non-PEBS, the TOS information can be directly
retrieved from TOS MSR read in intel_pmu_lbr_read().

For adaptive PEBS, the LBR information stored in PEBS record doesn't
include the TOS information. For single PEBS, TOS can be directly read
from MSR, because the PMI is triggered immediately after PEBS is
written. TOS MSR is still unchanged.
For large PEBS, TOS MSR has stale value. Set -1ULL to indicate that the
TOS information is not available.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7639e2097101..65113b16804a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -585,7 +585,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 		cpuc->lbr_entries[i].reserved	= 0;
 	}
 	cpuc->lbr_stack.nr = i;
-	cpuc->lbr_stack.hw_idx = -1ULL;
+	cpuc->lbr_stack.hw_idx = tos;
 }
 
 /*
@@ -681,7 +681,7 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
-	cpuc->lbr_stack.hw_idx = -1ULL;
+	cpuc->lbr_stack.hw_idx = tos;
 }
 
 void intel_pmu_lbr_read(void)
@@ -1122,7 +1122,13 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 	int i;
 
 	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
-	cpuc->lbr_stack.hw_idx = -1ULL;
+
+	/* Cannot get TOS for large PEBS */
+	if (cpuc->n_pebs == cpuc->n_large_pebs)
+		cpuc->lbr_stack.hw_idx = -1ULL;
+	else
+		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
+
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		u64 info = lbr->lbr[i].info;
 		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
-- 
2.17.1

