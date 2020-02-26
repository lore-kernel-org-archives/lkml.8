Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775AC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E2520714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBZOVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:21:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57963 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgBZOVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:21:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6xYE-00080S-75; Wed, 26 Feb 2020 15:20:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CCDFB1C2157;
        Wed, 26 Feb 2020 15:20:37 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:20:37 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf auxtrace: Add auxtrace_record__read_finish()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200217082300.6301-1-adrian.hunter@intel.com>
References: <20200217082300.6301-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158272683754.28353.12991573767087010344.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ad60ba0c2e6da6ff573c5ac57708fbc443bbb473
Gitweb:        https://git.kernel.org/tip/ad60ba0c2e6da6ff573c5ac57708fbc443bbb473
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 17 Feb 2020 10:23:00 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 18 Feb 2020 10:13:29 -03:00

perf auxtrace: Add auxtrace_record__read_finish()

All ->read_finish() implementations are doing the same thing. Add a
helper function so that they can share the same implementation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Wei Li <liwei391@huawei.com>
Link: http://lore.kernel.org/lkml/20200217082300.6301-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 21 ++-------------------
 tools/perf/arch/arm64/util/arm-spe.c | 20 ++------------------
 tools/perf/arch/x86/util/intel-bts.c | 20 ++------------------
 tools/perf/arch/x86/util/intel-pt.c  | 20 ++------------------
 tools/perf/util/auxtrace.c           | 22 +++++++++++++++++++++-
 tools/perf/util/auxtrace.h           |  6 ++++++
 6 files changed, 35 insertions(+), 74 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 60141c3..941f814 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -858,24 +858,6 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
 	free(ptr);
 }
 
-static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
-			if (evsel->disabled)
-				return 0;
-			return perf_evlist__enable_event_idx(ptr->evlist,
-							     evsel, idx);
-		}
-	}
-
-	return -EINVAL;
-}
-
 struct auxtrace_record *cs_etm_record_init(int *err)
 {
 	struct perf_pmu *cs_etm_pmu;
@@ -895,6 +877,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	}
 
 	ptr->cs_etm_pmu			= cs_etm_pmu;
+	ptr->itr.pmu			= cs_etm_pmu;
 	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
 	ptr->itr.recording_options	= cs_etm_recording_options;
 	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
@@ -904,7 +887,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	ptr->itr.snapshot_finish	= cs_etm_snapshot_finish;
 	ptr->itr.reference		= cs_etm_reference;
 	ptr->itr.free			= cs_etm_recording_free;
-	ptr->itr.read_finish		= cs_etm_read_finish;
+	ptr->itr.read_finish		= auxtrace_record__read_finish;
 
 	*err = 0;
 	return &ptr->itr;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1d993c2..8d6821d 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -158,23 +158,6 @@ static void arm_spe_recording_free(struct auxtrace_record *itr)
 	free(sper);
 }
 
-static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct arm_spe_recording *sper =
-			container_of(itr, struct arm_spe_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(sper->evlist, evsel) {
-		if (evsel->core.attr.type == sper->arm_spe_pmu->type) {
-			if (evsel->disabled)
-				return 0;
-			return perf_evlist__enable_event_idx(sper->evlist,
-							     evsel, idx);
-		}
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *arm_spe_recording_init(int *err,
 					       struct perf_pmu *arm_spe_pmu)
 {
@@ -192,12 +175,13 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	}
 
 	sper->arm_spe_pmu = arm_spe_pmu;
+	sper->itr.pmu = arm_spe_pmu;
 	sper->itr.recording_options = arm_spe_recording_options;
 	sper->itr.info_priv_size = arm_spe_info_priv_size;
 	sper->itr.info_fill = arm_spe_info_fill;
 	sper->itr.free = arm_spe_recording_free;
 	sper->itr.reference = arm_spe_reference;
-	sper->itr.read_finish = arm_spe_read_finish;
+	sper->itr.read_finish = auxtrace_record__read_finish;
 	sper->itr.alignment = 0;
 
 	*err = 0;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 39e3631..26cee10 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -413,23 +413,6 @@ out_err:
 	return err;
 }
 
-static int intel_bts_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct intel_bts_recording *btsr =
-			container_of(itr, struct intel_bts_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(btsr->evlist, evsel) {
-		if (evsel->core.attr.type == btsr->intel_bts_pmu->type) {
-			if (evsel->disabled)
-				return 0;
-			return perf_evlist__enable_event_idx(btsr->evlist,
-							     evsel, idx);
-		}
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *intel_bts_recording_init(int *err)
 {
 	struct perf_pmu *intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
@@ -450,6 +433,7 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
 	}
 
 	btsr->intel_bts_pmu = intel_bts_pmu;
+	btsr->itr.pmu = intel_bts_pmu;
 	btsr->itr.recording_options = intel_bts_recording_options;
 	btsr->itr.info_priv_size = intel_bts_info_priv_size;
 	btsr->itr.info_fill = intel_bts_info_fill;
@@ -459,7 +443,7 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
 	btsr->itr.find_snapshot = intel_bts_find_snapshot;
 	btsr->itr.parse_snapshot_options = intel_bts_parse_snapshot_options;
 	btsr->itr.reference = intel_bts_reference;
-	btsr->itr.read_finish = intel_bts_read_finish;
+	btsr->itr.read_finish = auxtrace_record__read_finish;
 	btsr->itr.alignment = sizeof(struct branch);
 	return &btsr->itr;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index be07d68..7eea4fd 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1166,23 +1166,6 @@ static u64 intel_pt_reference(struct auxtrace_record *itr __maybe_unused)
 	return rdtsc();
 }
 
-static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct intel_pt_recording *ptr =
-			container_of(itr, struct intel_pt_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
-			if (evsel->disabled)
-				return 0;
-			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
-							     idx);
-		}
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *intel_pt_recording_init(int *err)
 {
 	struct perf_pmu *intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
@@ -1203,6 +1186,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	}
 
 	ptr->intel_pt_pmu = intel_pt_pmu;
+	ptr->itr.pmu = intel_pt_pmu;
 	ptr->itr.recording_options = intel_pt_recording_options;
 	ptr->itr.info_priv_size = intel_pt_info_priv_size;
 	ptr->itr.info_fill = intel_pt_info_fill;
@@ -1212,7 +1196,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	ptr->itr.find_snapshot = intel_pt_find_snapshot;
 	ptr->itr.parse_snapshot_options = intel_pt_parse_snapshot_options;
 	ptr->itr.reference = intel_pt_reference;
-	ptr->itr.read_finish = intel_pt_read_finish;
+	ptr->itr.read_finish = auxtrace_record__read_finish;
 	/*
 	 * Decoding starts at a PSB packet. Minimum PSB period is 2K so 4K
 	 * should give at least 1 PSB per sample.
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index eb087e7..3571ce7 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -629,8 +629,10 @@ int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts)
 {
-	if (itr)
+	if (itr) {
+		itr->evlist = evlist;
 		return itr->recording_options(itr, evlist, opts);
+	}
 	return 0;
 }
 
@@ -664,6 +666,24 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 	return -EINVAL;
 }
 
+int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
+{
+	struct evsel *evsel;
+
+	if (!itr->evlist || !itr->pmu)
+		return -EINVAL;
+
+	evlist__for_each_entry(itr->evlist, evsel) {
+		if (evsel->core.attr.type == itr->pmu->type) {
+			if (evsel->disabled)
+				return 0;
+			return perf_evlist__enable_event_idx(itr->evlist, evsel,
+							     idx);
+		}
+	}
+	return -EINVAL;
+}
+
 /*
  * Event record size is 16-bit which results in a maximum size of about 64KiB.
  * Allow about 4KiB for the rest of the sample record, to give a maximum
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 749d72c..e58ef16 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -29,6 +29,7 @@ struct record_opts;
 struct perf_record_auxtrace_error;
 struct perf_record_auxtrace_info;
 struct events_stats;
+struct perf_pmu;
 
 enum auxtrace_error_type {
        PERF_AUXTRACE_ERROR_ITRACE  = 1,
@@ -322,6 +323,8 @@ struct auxtrace_mmap_params {
  * @read_finish: called after reading from an auxtrace mmap
  * @alignment: alignment (if any) for AUX area data
  * @default_aux_sample_size: default sample size for --aux sample option
+ * @pmu: associated pmu
+ * @evlist: selected events list
  */
 struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
@@ -346,6 +349,8 @@ struct auxtrace_record {
 	int (*read_finish)(struct auxtrace_record *itr, int idx);
 	unsigned int alignment;
 	unsigned int default_aux_sample_size;
+	struct perf_pmu *pmu;
+	struct evlist *evlist;
 };
 
 /**
@@ -537,6 +542,7 @@ int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
 				   struct auxtrace_mmap *mm,
 				   unsigned char *data, u64 *head, u64 *old);
 u64 auxtrace_record__reference(struct auxtrace_record *itr);
+int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx);
 
 int auxtrace_index__auxtrace_event(struct list_head *head, union perf_event *event,
 				   off_t file_offset);
