Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203FBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CDD2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgF2TGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:06:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:62620 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbgF2TGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:34 -0400
IronPort-SDR: FIGKWO91R3zr8k5X9AUH4xn6JFnFDqeYWRqHIwlD+n9oCePsMtFbXSHd+s1HxLMFWEvyTWOrRf
 d65IKmnryDug==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126075726"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="126075726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:20:38 -0700
IronPort-SDR: NDYKaM6CLSGEW0MTqi9U3mVb3TT9hfe/kst4wiBSW3tvGIgJ74WE04p8LkizDDC2fNYu4bstem
 M5i03pX40wDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="303001173"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2020 02:20:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] perf record: Fix duplicated sideband events with Intel PT system wide tracing
Date:   Mon, 29 Jun 2020 12:19:51 +0300
Message-Id: <20200629091955.17090-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629091955.17090-1-adrian.hunter@intel.com>
References: <20200629091955.17090-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0a892c1c9472 ("perf record: Add dummy event during system wide
synthesis") reveals an issue with Intel PT system wide tracing.
Specifically that Intel PT already adds a dummy tracking event, and it is
not the first event.  Adding another dummy tracking event causes duplicated
sideband events.  Fix by checking for an existing dummy tracking event
first.

Example showing duplicated switch events:

 Before:

   # perf record -a -e intel_pt//u uname
   Linux
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.895 MB perf.data ]
   # perf script --no-itrace --show-switch-events | head
            swapper     0 [007]  6390.516222: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    11/11
            swapper     0 [007]  6390.516222: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    11/11
          rcu_sched    11 [007]  6390.516223: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0
          rcu_sched    11 [007]  6390.516224: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0
          rcu_sched    11 [007]  6390.516227: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0
          rcu_sched    11 [007]  6390.516227: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0
            swapper     0 [007]  6390.516228: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    11/11
            swapper     0 [007]  6390.516228: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    11/11
            swapper     0 [002]  6390.516415: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:  5556/5559
            swapper     0 [002]  6390.516416: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:  5556/5559

 After:

   # perf record -a -e intel_pt//u uname
   Linux
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.868 MB perf.data ]
   #  perf script --no-itrace --show-switch-events | head
            swapper     0 [005]  6450.567013: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:  7179/7181
               perf  7181 [005]  6450.567014: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0
               perf  7181 [005]  6450.567028: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0
            swapper     0 [005]  6450.567029: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:  7179/7181
            swapper     0 [005]  6450.571699: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    11/11
          rcu_sched    11 [005]  6450.571700: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0
          rcu_sched    11 [005]  6450.571702: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0
            swapper     0 [005]  6450.571703: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    11/11
            swapper     0 [005]  6450.579703: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:    11/11
          rcu_sched    11 [005]  6450.579704: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 18 +++++++++---------
 tools/perf/util/evlist.c    | 12 ++++++++++++
 tools/perf/util/evlist.h    |  1 +
 tools/perf/util/evsel.c     |  8 +-------
 tools/perf/util/evsel.h     |  6 ++++++
 5 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e108d90ae2ed..a37e7910e9e9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -852,20 +852,20 @@ static int record__open(struct record *rec)
 	 * event synthesis.
 	 */
 	if (opts->initial_delay || target__has_cpu(&opts->target)) {
-		if (perf_evlist__add_dummy(evlist))
-			return -ENOMEM;
+		pos = perf_evlist__get_tracking_event(evlist);
+		if (!evsel__is_dummy_event(pos)) {
+			/* Set up dummy event. */
+			if (perf_evlist__add_dummy(evlist))
+				return -ENOMEM;
+			pos = evlist__last(evlist);
+			perf_evlist__set_tracking_event(evlist, pos);
+		}
 
-		/* Disable tracking of mmaps on lead event. */
-		pos = evlist__first(evlist);
-		pos->tracking = 0;
-		/* Set up dummy event. */
-		pos = evlist__last(evlist);
-		pos->tracking = 1;
 		/*
 		 * Enable the dummy event when the process is forked for
 		 * initial_delay, immediately for system wide.
 		 */
-		if (opts->initial_delay)
+		if (opts->initial_delay && !pos->immediate)
 			pos->core.attr.enable_on_exec = 1;
 		else
 			pos->immediate = 1;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 173b4f0e0e6e..ab48be4cf258 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1566,6 +1566,18 @@ void perf_evlist__to_front(struct evlist *evlist,
 	list_splice(&move, &evlist->core.entries);
 }
 
+struct evsel *perf_evlist__get_tracking_event(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->tracking)
+			return evsel;
+	}
+
+	return evlist__first(evlist);
+}
+
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel)
 {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b6f325dfb4d2..a8081dfc19cf 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -335,6 +335,7 @@ void perf_evlist__to_front(struct evlist *evlist,
 	evlist__cpu_iter_start(evlist);			\
 	perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
 
+struct evsel *perf_evlist__get_tracking_event(struct evlist *evlist);
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 96e5171dce41..a68ac3632ae6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -898,12 +898,6 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 	}
 }
 
-static bool is_dummy_event(struct evsel *evsel)
-{
-	return (evsel->core.attr.type == PERF_TYPE_SOFTWARE) &&
-	       (evsel->core.attr.config == PERF_COUNT_SW_DUMMY);
-}
-
 struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evsel_term_type type)
 {
 	struct evsel_config_term *term, *found_term = NULL;
@@ -1161,7 +1155,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 * The software event will trigger -EOPNOTSUPP error out,
 	 * if BRANCH_STACK bit is set.
 	 */
-	if (is_dummy_event(evsel))
+	if (evsel__is_dummy_event(evsel))
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0f963c2a88a5..35e3f6d66085 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -399,6 +399,12 @@ static inline bool evsel__has_br_stack(const struct evsel *evsel)
 	       evsel->synth_sample_type & PERF_SAMPLE_BRANCH_STACK;
 }
 
+static inline bool evsel__is_dummy_event(struct evsel *evsel)
+{
+	return (evsel->core.attr.type == PERF_TYPE_SOFTWARE) &&
+	       (evsel->core.attr.config == PERF_COUNT_SW_DUMMY);
+}
+
 struct perf_env *evsel__env(struct evsel *evsel);
 
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
-- 
2.17.1

