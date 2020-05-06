Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB14C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247A22145D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778810;
	bh=VUqJGWfnZIEcj7uXe3qha10yBeFTZsKI9VaYHJPuTfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q3l8Bqi3uZYZBWs0vCNiEy1qELQsTMF1XWqjml53435lbOulgWXNGaLa3uTfePH5I
	 BwH9ACt47GoZXYE1LyDQ7hs0pgeMQgeTAI9rtzrU1HxBXrwoCkGyWzmadPZRJ2vQjL
	 1Hh+Czxro/VZukBwFUPJZVC6863+HzEqMmro7/f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgEFP0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbgEFP0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323E621775;
        Wed,  6 May 2020 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778805;
        bh=VUqJGWfnZIEcj7uXe3qha10yBeFTZsKI9VaYHJPuTfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4+grWfobDwxYa2oVYG4PgwF1JbppcJqQ/Z8/NJjyoEMWMsYmcWm4erUpYOiT+enV
         DJm4G/XCxawBCj5OXyzDrKdPlYeOmIVE3HJDdcUQxzT0Jmdu/CIkRzMKuaB3R0N8nH
         CJ93mTKDK7mp3puXZEYjcuj4x+3CpPMPEF8/U+IQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 70/91] perf evsel: Rename perf_evsel__parse_sample*() to evsel__parse_sample*()
Date:   Wed,  6 May 2020 12:22:13 -0300
Message-Id: <20200506152234.21977-71-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As these are 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 6 ++----
 tools/perf/builtin-inject.c                  | 2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  | 2 +-
 tools/perf/tests/sample-parsing.c            | 4 ++--
 tools/perf/util/evlist.c                     | 4 ++--
 tools/perf/util/evsel.c                      | 9 ++++-----
 tools/perf/util/evsel.h                      | 9 ++++-----
 tools/perf/util/python.c                     | 2 +-
 8 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 909ead08a6f6..026d32ed078e 100644
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
index 842e940523b7..aad007bfb581 100644
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
index 6d026e8a7fa6..1dc2897d2df9 100644
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
index ab964db855ac..a0bdaf390ac8 100644
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
index 404542b69543..0a0b760d6948 100644
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
index a11d1359ba81..b63d9eebe42f 100644
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
index a87de95a66c8..4b5a411c403c 100644
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
index 67810d31f88d..75a9b1d62bba 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1044,7 +1044,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 		pevent->evsel = evsel;
 
-		err = perf_evsel__parse_sample(evsel, event, &pevent->sample);
+		err = evsel__parse_sample(evsel, event, &pevent->sample);
 
 		/* Consume the even only after we parsed it out. */
 		perf_mmap__consume(&md->core);
-- 
2.21.1

