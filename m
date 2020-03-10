Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD00C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AF124691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583838984;
	bh=nTOUwNuPvB9t/C+sYs3EvVxrB9+MpX5GBSTL8dH8SUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hj7FRl0bZ9pZriT9IKZcIXDI0LnFPYxxSzYks9e8GBvpkL5n9UPMZtx+hApKYYOR9
	 TXXNYHPBGWAy3384btivyRJQgBX2CHOJd/Dy68AkQRezg6HRGFmlSpfpOC9omEk0wY
	 a4oX1M2gXt9Mntzamnh7ozSdTCD2a+RIDReEwHRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCJLQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCJLQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:16:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471AE2468F;
        Tue, 10 Mar 2020 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583838977;
        bh=nTOUwNuPvB9t/C+sYs3EvVxrB9+MpX5GBSTL8dH8SUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIhzy0kIU0lQ7euDdgsdhqQyR4wWhezVOy/o/blyFns3HPMvyfuESrzA9qmlzMFon
         tN/2kbECwvmTDPbifOa/K5lTNzj6seV183qibA/Eu7fVCLMtjUAPxTXoFK2m5lpO4G
         2cKeV2oLULOfR2eJBic2/Ja2JqQWXZm1JzEfhnEU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/19] libperf: Add counting example
Date:   Tue, 10 Mar 2020 08:15:37 -0300
Message-Id: <20200310111551.25160-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

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
 .../perf/Documentation/examples/counting.c    | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 tools/lib/perf/Documentation/examples/counting.c

diff --git a/tools/lib/perf/Documentation/examples/counting.c b/tools/lib/perf/Documentation/examples/counting.c
new file mode 100644
index 000000000000..6085693571ef
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
-- 
2.21.1

