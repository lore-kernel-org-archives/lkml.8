Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D92BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA5620637
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgBKMtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgBKMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:54 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux6-0007Y8-Ue; Tue, 11 Feb 2020 13:47:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 95AE41C2018;
        Tue, 11 Feb 2020 13:47:44 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:44 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Output LBR TOS information correctly
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200127165355.27495-3-kan.liang@linux.intel.com>
References: <20200127165355.27495-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158142526434.411.7289261225986269552.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     db278b90c326ce5895be09b6171f5ff3df1e3cca
Gitweb:        https://git.kernel.org/tip/db278b90c326ce5895be09b6171f5ff3df1e3cca
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 27 Jan 2020 08:53:55 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:23:49 +01:00

perf/x86/intel: Output LBR TOS information correctly

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200127165355.27495-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/lbr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7639e20..65113b1 100644
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
