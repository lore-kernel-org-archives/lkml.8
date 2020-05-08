Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA28C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFE6249C1
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgEHNFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729688AbgEHNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FAAC05BD43;
        Fri,  8 May 2020 06:04:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gQ-0007EK-U4; Fri, 08 May 2020 15:04:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F3F101C0821;
        Fri,  8 May 2020 15:04:46 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:46 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__parse_sample*() to
 evsel__parse_sample*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308693.8414.11484082792213872851.tip-bot2@tip-bot2>
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

Commit-ID:     6b6017a20650d908d7b5830cc991947991146a5f
Gitweb:        https://git.kernel.org/tip/6b6017a20650d908d7b5830cc991947991146a5f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 30 Apr 2020 11:03:49 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf evsel: Rename perf_evsel__parse_sample*() to evsel__parse_sample*()

As these are 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  6 ++----
 tools/perf/builtin-inject.c                  |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  2 +-
 tools/perf/tests/sample-parsing.c            |  4 ++--
 tools/perf/util/evlist.c                     |  4 ++--
 tools/perf/util/evsel.c                      |  9 ++++-----
 tools/perf/util/evsel.h                      |  9 ++++-----
 tools/perf/util/python.c                     |  2 +-
 8 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 909ead0..026d32e 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -130,13 +130,11 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 				goto next_event;
 
 			if (strcmp(event->comm.comm, comm1) == 0) {
-				CHECK__(perf_evsel__parse_sample(evsel, event,
-								 &sample));
+				CHECK__(evsel__parse_sample(evsel, event, &sample));
 				comm1_time = sample.time;
 			}
 			if (strcmp(event->comm.comm, comm2) == 0) {
-				CHECK__(perf_evsel__parse_sample(evsel, event,
-								 &sample));
+				CHECK__(evsel__parse_sample(evsel, event, &sample));
 				comm2_time = sample.time;
 			}
 next_event:
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 842e940..aad007b 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -546,7 +546,7 @@ static int perf_inject__sched_stat(struct perf_tool *tool,
 	return 0;
 found:
 	event_sw = &ent->event[0];
-	perf_evsel__parse_sample(evsel, event_sw, &sample_sw);
+	evsel__parse_sample(evsel, event_sw, &sample_sw);
 
 	sample_sw.period = sample->period;
 	sample_sw.time	 = sample->time;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 6d026e8..1dc2897 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -108,7 +108,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 					continue;
 				}
 
-				err = perf_evsel__parse_sample(evsel, event, &sample);
+				err = evsel__parse_sample(evsel, event, &sample);
 				if (err) {
 					pr_debug("Can't parse sample, err = %d\n", err);
 					goto out_delete_evlist;
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index ab964db..a0bdaf3 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -298,10 +298,10 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 
 	evsel.sample_size = __evsel__sample_size(sample_type);
 
-	err = perf_evsel__parse_sample(&evsel, event, &sample_out);
+	err = evsel__parse_sample(&evsel, event, &sample_out);
 	if (err) {
 		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
-			 "perf_evsel__parse_sample", sample_type, err);
+			 "evsel__parse_sample", sample_type, err);
 		goto out_free;
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 404542b..0a0b760 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1439,7 +1439,7 @@ int perf_evlist__parse_sample(struct evlist *evlist, union perf_event *event,
 
 	if (!evsel)
 		return -EFAULT;
-	return perf_evsel__parse_sample(evsel, event, sample);
+	return evsel__parse_sample(evsel, event, sample);
 }
 
 int perf_evlist__parse_sample_timestamp(struct evlist *evlist,
@@ -1450,7 +1450,7 @@ int perf_evlist__parse_sample_timestamp(struct evlist *evlist,
 
 	if (!evsel)
 		return -EFAULT;
-	return perf_evsel__parse_sample_timestamp(evsel, event, timestamp);
+	return evsel__parse_sample_timestamp(evsel, event, timestamp);
 }
 
 int perf_evlist__strerror_open(struct evlist *evlist,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a11d135..b63d9ee 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1964,8 +1964,8 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
 	return 0;
 }
 
-int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
-			     struct perf_sample *data)
+int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
+			struct perf_sample *data)
 {
 	u64 type = evsel->core.attr.sample_type;
 	bool swapped = evsel->needs_swap;
@@ -2267,9 +2267,8 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	return 0;
 }
 
-int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
-				       union perf_event *event,
-				       u64 *timestamp)
+int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
+				  u64 *timestamp)
 {
 	u64 type = evsel->core.attr.sample_type;
 	const __u64 *array;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a87de95..4b5a411 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -293,12 +293,11 @@ static inline int evsel__read_on_cpu_scaled(struct evsel *evsel, int cpu, int th
 	return __evsel__read_on_cpu(evsel, cpu, thread, true);
 }
 
-int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
-			     struct perf_sample *sample);
+int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
+			struct perf_sample *sample);
 
-int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
-				       union perf_event *event,
-				       u64 *timestamp);
+int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
+				  u64 *timestamp);
 
 static inline struct evsel *perf_evsel__next(struct evsel *evsel)
 {
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 67810d3..75a9b1d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1044,7 +1044,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 		pevent->evsel = evsel;
 
-		err = perf_evsel__parse_sample(evsel, event, &pevent->sample);
+		err = evsel__parse_sample(evsel, event, &pevent->sample);
 
 		/* Consume the even only after we parsed it out. */
 		perf_mmap__consume(&md->core);
