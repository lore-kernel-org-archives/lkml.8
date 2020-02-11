Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFAEC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DD324683
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgBKMt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45988 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgBKMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux7-0007YB-9f; Tue, 11 Feb 2020 13:47:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E168B1C2017;
        Tue, 11 Feb 2020 13:47:44 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:44 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add new branch sample type for HW index
 of raw branch records
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200127165355.27495-2-kan.liang@linux.intel.com>
References: <20200127165355.27495-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158142526469.411.17102678591362898511.tip-bot2@tip-bot2>
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

Commit-ID:     bbfd5e4fab63703375eafaf241a0c696024a59e1
Gitweb:        https://git.kernel.org/tip/bbfd5e4fab63703375eafaf241a0c696024a59e1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 27 Jan 2020 08:53:54 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:23:49 +01:00

perf/core: Add new branch sample type for HW index of raw branch records

The low level index is the index in the underlying hardware buffer of
the most recently captured taken branch which is always saved in
branch_entries[0]. It is very useful for reconstructing the call stack.
For example, in Intel LBR call stack mode, the depth of reconstructed
LBR call stack limits to the number of LBR registers. With the low level
index information, perf tool may stitch the stacks of two samples. The
reconstructed LBR call stack can break the HW limitation.

Add a new branch sample type to retrieve low level index of raw branch
records. The low level index is between -1 (unknown) and max depth which
can be retrieved in /sys/devices/cpu/caps/branches.

Only when the new branch sample type is set, the low level index
information is dumped into the PERF_SAMPLE_BRANCH_STACK output.
Perf tool should check the attr.branch_sample_type, and apply the
corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
Otherwise, some user case may be broken. For example, users may parse a
perf.data, which include the new branch sample type, with an old version
perf tool (without the check). Users probably get incorrect information
without any warning.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200127165355.27495-2-kan.liang@linux.intel.com
---
 arch/powerpc/perf/core-book3s.c |  1 +
 arch/x86/events/intel/lbr.c     |  3 +++
 include/linux/perf_event.h      | 12 ++++++++++++
 include/uapi/linux/perf_event.h |  8 +++++++-
 kernel/events/core.c            | 10 ++++++++++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 3086055..3dcfecf 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -518,6 +518,7 @@ static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *
 		}
 	}
 	cpuhw->bhrb_stack.nr = u_index;
+	cpuhw->bhrb_stack.hw_idx = -1ULL;
 	return;
 }
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 534c766..7639e20 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -585,6 +585,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 		cpuc->lbr_entries[i].reserved	= 0;
 	}
 	cpuc->lbr_stack.nr = i;
+	cpuc->lbr_stack.hw_idx = -1ULL;
 }
 
 /*
@@ -680,6 +681,7 @@ static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
+	cpuc->lbr_stack.hw_idx = -1ULL;
 }
 
 void intel_pmu_lbr_read(void)
@@ -1120,6 +1122,7 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 	int i;
 
 	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
+	cpuc->lbr_stack.hw_idx = -1ULL;
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		u64 info = lbr->lbr[i].info;
 		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 547773f..68e21e8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -93,14 +93,26 @@ struct perf_raw_record {
 /*
  * branch stack layout:
  *  nr: number of taken branches stored in entries[]
+ *  hw_idx: The low level index of raw branch records
+ *          for the most recent branch.
+ *          -1ULL means invalid/unknown.
  *
  * Note that nr can vary from sample to sample
  * branches (to, from) are stored from most recent
  * to least recent, i.e., entries[0] contains the most
  * recent branch.
+ * The entries[] is an abstraction of raw branch records,
+ * which may not be stored in age order in HW, e.g. Intel LBR.
+ * The hw_idx is to expose the low level index of raw
+ * branch record for the most recent branch aka entries[0].
+ * The hw_idx index is between -1 (unknown) and max depth,
+ * which can be retrieved in /sys/devices/cpu/caps/branches.
+ * For the architectures whose raw branch records are
+ * already stored in age order, the hw_idx should be 0.
  */
 struct perf_branch_stack {
 	__u64				nr;
+	__u64				hw_idx;
 	struct perf_branch_entry	entries[0];
 };
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 377d794..397cfd6 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -181,6 +181,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
 
+	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -208,6 +210,8 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
 		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -853,7 +857,9 @@ enum perf_event_type {
 	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
 	 *
 	 *	{ u64                   nr;
-	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
+	 *	  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
+	 *        { u64 from, to, flags } lbr[nr];
+	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 * 	{ u64			abi; # enum perf_sample_regs_abi
 	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e453589..3f1f77d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6555,6 +6555,11 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
+static inline bool perf_sample_save_hw_index(struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
+}
+
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -6643,6 +6648,8 @@ void perf_output_sample(struct perf_output_handle *handle,
 			     * sizeof(struct perf_branch_entry);
 
 			perf_output_put(handle, data->br_stack->nr);
+			if (perf_sample_save_hw_index(event))
+				perf_output_put(handle, data->br_stack->hw_idx);
 			perf_output_copy(handle, data->br_stack->entries, size);
 		} else {
 			/*
@@ -6836,6 +6843,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		int size = sizeof(u64); /* nr */
 		if (data->br_stack) {
+			if (perf_sample_save_hw_index(event))
+				size += sizeof(u64);
+
 			size += data->br_stack->nr
 			      * sizeof(struct perf_branch_entry);
 		}
