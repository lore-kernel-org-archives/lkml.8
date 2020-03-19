Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B913EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBCE20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgCSOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:11:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32875 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgCSOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvt5-0002Kd-87; Thu, 19 Mar 2020 15:11:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BEB101C22B2;
        Thu, 19 Mar 2020 15:10:54 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:54 -0000
From:   "tip-bot2 for Michael Petlan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add counting example
Cc:     Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158462705444.28353.17324137810375912960.tip-bot2@tip-bot2>
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

Commit-ID:     76ce02651dabee19df018097db4485800e05e177
Gitweb:        https://git.kernel.org/tip/76ce02651dabee19df018097db4485800e05e177
Author:        Michael Petlan <mpetlan@redhat.com>
AuthorDate:    Thu, 27 Feb 2020 20:44:24 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 04 Mar 2020 10:34:10 -03:00

libperf: Add counting example

Current libperf man pages mention file counting.c "coming with libperf package",
however, the file is missing. Add the file then.

Fixes: 81de3bf37a8b ("libperf: Add man pages")
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
LPU-Reference: 20200227194424.28210-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/Documentation/examples/counting.c | 83 +++++++++++++++-
 1 file changed, 83 insertions(+)
 create mode 100644 tools/lib/perf/Documentation/examples/counting.c

diff --git a/tools/lib/perf/Documentation/examples/counting.c b/tools/lib/perf/Documentation/examples/counting.c
new file mode 100644
index 0000000..6085693
--- /dev/null
+++ b/tools/lib/perf/Documentation/examples/counting.c
@@ -0,0 +1,83 @@
+#include <linux/perf_event.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/mmap.h>
+#include <perf/core.h>
+#include <perf/event.h>
+#include <stdio.h>
+#include <unistd.h>
+
+static int libperf_print(enum libperf_print_level level,
+                         const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+int main(int argc, char **argv)
+{
+	int count = 100000, err = 0;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_thread_map *threads;
+	struct perf_counts_values counts;
+
+	struct perf_event_attr attr1 = {
+		.type        = PERF_TYPE_SOFTWARE,
+		.config      = PERF_COUNT_SW_CPU_CLOCK,
+		.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING,
+		.disabled    = 1,
+	};
+	struct perf_event_attr attr2 = {
+		.type        = PERF_TYPE_SOFTWARE,
+		.config      = PERF_COUNT_SW_TASK_CLOCK,
+		.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING,
+		.disabled    = 1,
+	};
+
+	libperf_init(libperf_print);
+	threads = perf_thread_map__new_dummy();
+	if (!threads) {
+		fprintf(stderr, "failed to create threads\n");
+		return -1;
+	}
+	perf_thread_map__set_pid(threads, 0, 0);
+	evlist = perf_evlist__new();
+	if (!evlist) {
+		fprintf(stderr, "failed to create evlist\n");
+		goto out_threads;
+	}
+	evsel = perf_evsel__new(&attr1);
+	if (!evsel) {
+		fprintf(stderr, "failed to create evsel1\n");
+		goto out_evlist;
+	}
+	perf_evlist__add(evlist, evsel);
+	evsel = perf_evsel__new(&attr2);
+	if (!evsel) {
+		fprintf(stderr, "failed to create evsel2\n");
+		goto out_evlist;
+	}
+	perf_evlist__add(evlist, evsel);
+	perf_evlist__set_maps(evlist, NULL, threads);
+	err = perf_evlist__open(evlist);
+	if (err) {
+		fprintf(stderr, "failed to open evsel\n");
+		goto out_evlist;
+	}
+	perf_evlist__enable(evlist);
+	while (count--);
+	perf_evlist__disable(evlist);
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts);
+		fprintf(stdout, "count %llu, enabled %llu, run %llu\n",
+				counts.val, counts.ena, counts.run);
+	}
+	perf_evlist__close(evlist);
+out_evlist:
+	perf_evlist__delete(evlist);
+out_threads:
+	perf_thread_map__put(threads);
+	return err;
+}
