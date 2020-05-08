Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BEDC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555F4208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgEHNLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729524AbgEHNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245BC05BD09;
        Fri,  8 May 2020 06:04:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gQ-0007Dr-7q; Fri, 08 May 2020 15:04:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9987A1C04DF;
        Fri,  8 May 2020 15:04:46 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:46 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__{prev,next}() to
 evsel__{prev,next}()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308658.8414.17173281322600957173.tip-bot2@tip-bot2>
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

Commit-ID:     e470daeaa36ad8058cb32616afb8c8d7cfba8456
Gitweb:        https://git.kernel.org/tip/e470daeaa36ad8058cb32616afb8c8d7cfba8456
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 30 Apr 2020 11:06:45 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf evsel: Rename perf_evsel__{prev,next}() to evsel__{prev,next}()

As those are 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/evsel-roundtrip-name.c |  2 +-
 tools/perf/tests/parse-events.c         | 52 ++++++++++++------------
 tools/perf/ui/browsers/hists.c          |  4 +-
 tools/perf/util/evsel.h                 |  4 +-
 tools/perf/util/sort.c                  |  2 +-
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index f143de1..61ecd8e 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -53,7 +53,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 					ret = -1;
 				}
 
-				evsel = perf_evsel__next(evsel);
+				evsel = evsel__next(evsel);
 			}
 		}
 	}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8d0c048..5b90ee3 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -468,7 +468,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 
 	/* syscalls:sys_enter_openat:k */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
@@ -479,7 +479,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 
 	/* 1:1:hp */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
@@ -501,7 +501,7 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "krava"));
 
 	/* cpu/config=2/u" */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
@@ -529,7 +529,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
 
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
 	/*
@@ -577,7 +577,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
 	/* cpu/pmu-event/u*/
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong exclude_user",
@@ -658,7 +658,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:upp */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -700,7 +700,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cache-references + :u modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_REFERENCES == evsel->core.attr.config);
@@ -715,7 +715,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:k */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -758,7 +758,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group1 cycles:kppp */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -775,7 +775,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group2 cycles + G modifier */
-	evsel = leader = perf_evsel__next(evsel);
+	evsel = leader = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -793,7 +793,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group2 1:3 + G modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 3 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
@@ -807,7 +807,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:u */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -849,7 +849,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:kp + p */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -892,7 +892,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions + G */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -907,7 +907,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:G */
-	evsel = leader = perf_evsel__next(evsel);
+	evsel = leader = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -924,7 +924,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:G */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -938,7 +938,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
 
 	/* cycles */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -977,7 +977,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:G + :H group modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1017,7 +1017,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :G group modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1057,7 +1057,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :u group modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1097,7 +1097,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :uG group modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1135,7 +1135,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* cache-misses - not sampling */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1149,7 +1149,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* branch-misses - not sampling */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
@@ -1188,7 +1188,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* branch-misses - not sampling */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
@@ -1234,14 +1234,14 @@ static int test__pinned_group(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
 
 	/* cache-misses - can not be pinned, but will go on with the leader */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
 	/* branch-misses - ditto */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 2936697..f98a118 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3512,13 +3512,13 @@ browse_hists:
 				if (pos->core.node.next == &evlist->core.entries)
 					pos = evlist__first(evlist);
 				else
-					pos = perf_evsel__next(pos);
+					pos = evsel__next(pos);
 				goto browse_hists;
 			case K_UNTAB:
 				if (pos->core.node.prev == &evlist->core.entries)
 					pos = evlist__last(evlist);
 				else
-					pos = perf_evsel__prev(pos);
+					pos = evsel__prev(pos);
 				goto browse_hists;
 			case K_SWITCH_INPUT_DATA:
 			case K_RELOAD:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4b5a411..a84a4f6 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -299,12 +299,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 				  u64 *timestamp);
 
-static inline struct evsel *perf_evsel__next(struct evsel *evsel)
+static inline struct evsel *evsel__next(struct evsel *evsel)
 {
 	return list_entry(evsel->core.node.next, struct evsel, core.node);
 }
 
-static inline struct evsel *perf_evsel__prev(struct evsel *evsel)
+static inline struct evsel *evsel__prev(struct evsel *evsel)
 {
 	return list_entry(evsel->core.node.prev, struct evsel, core.node);
 }
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index dc15ddc..dc23b34 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2354,7 +2354,7 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
 
 		evsel = evlist__first(evlist);
 		while (--nr > 0)
-			evsel = perf_evsel__next(evsel);
+			evsel = evsel__next(evsel);
 
 		return evsel;
 	}
