Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9C0C54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A17206CD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPaDdxzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgDUAa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726294AbgDUAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:30:26 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676E5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:30:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id v6so2816841pgh.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Xi5M6qHP3ND0Z/UBJ6rtgvFQC8TVWZYy1Ggc5ZNgU+w=;
        b=RPaDdxzvAdp7tlM9YXteZK1gqsoaw5TEZ1g9yrSBwkIqONQrU/9LEHSFAqr/eD8EEe
         8dKlfr9f2YhPiTruVWHY8qfnisMHRe8NlKMK2QNXiAy1QPdJLQ31mZ+sJpsHYe9znRjO
         cY5Sh0eS1Bq6FpqcspSP8sKy7BZHiDJCQZGdvsPwkChijGi6vSAkJEaqUXjhqshhX9Sh
         fGvokTfF6lGq35evZ7ZT9NbV3v660FrCdZAaOEQY7WkMgXZhnsK6mb+5tGGowqGRY0Pu
         RyzOVY3Mufv4BuM7NqjeG9OwNvggSPIRaLis/9qwd5hMqh8/MNaA4e7eN8EVE+D3rbju
         huig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Xi5M6qHP3ND0Z/UBJ6rtgvFQC8TVWZYy1Ggc5ZNgU+w=;
        b=o9I24Q6o8N5+IoxaD0c56kzCD1cvinic9drl34fugWlSl+x1AS17esQKY+CSJNeOQ3
         t14kViqd5gnwhVjxM5BPQnbVk5ejRhhnRIRN9CXMdaStjWLlhBN8w4gXTZeilCp9hepM
         tdIsnYk20v4PcDVzXsfoDkCjWEm/Egi411s3sDIHQO5K5WKZx50F5KLpWYaZrw0hMAjr
         7poFIe1mJHm1wQ05zSrHXnqDwsqMLhOCHrNJMRGXwPzwhnJlxzv19/JMK7C5rRrAXBBS
         +uthK9WRgMKsOr/x714feBbj7z/aG2R+80/mwsfBcOEATHVnT/HQP2HQquLJ4hh8M/Le
         SQsQ==
X-Gm-Message-State: AGi0PuaY+BYh37iLWGXeRPe/w1oc4dJCDkGqnJ4DKgHSOybTzsRKAt/1
        dwMCKH3nuq8yZfVVBMj3gu9ncp53tV6c
X-Google-Smtp-Source: APiQypLylDqcbF9/yP0rtAvO/D027YYA2r5XoecsQQYvaA8sUy5vi4pFA4J6SNjksKUYNIcquX2p1AK1HTnD
X-Received: by 2002:a17:90a:d504:: with SMTP id t4mr2390923pju.123.1587429025588;
 Mon, 20 Apr 2020 17:30:25 -0700 (PDT)
Date:   Mon, 20 Apr 2020 17:30:20 -0700
Message-Id: <20200421003020.37611-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v2] perf/record: add num-synthesize-threads option
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

To control degree of parallelism of the synthesize_mmap() code which
is scanning /proc/PID/task/PID/maps and can be time consuming.
Mimic perf top way of handling the option.
If not specified will default to 1 thread, i.e. default behavior before
this option.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt |  4 +++
 tools/perf/builtin-record.c              | 34 ++++++++++++++++++++++--
 tools/perf/util/record.h                 |  1 +
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b3f3b3f1c161..6e8b4649307c 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -596,6 +596,10 @@ Make a copy of /proc/kcore and place it into a directory with the perf data file
 Limit the sample data max size, <size> is expected to be a number with
 appended unit character - B/K/M/G
 
+--num-thread-synthesize::
+	The number of threads to run when synthesizing events for existing processes.
+	By default, the number of threads equals 1.
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe904..2e8011f179f2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -43,6 +43,7 @@
 #include "util/time-utils.h"
 #include "util/units.h"
 #include "util/bpf-event.h"
+#include "util/util.h"
 #include "asm/bug.h"
 #include "perf.h"
 
@@ -50,6 +51,7 @@
 #include <inttypes.h>
 #include <locale.h>
 #include <poll.h>
+#include <pthread.h>
 #include <unistd.h>
 #include <sched.h>
 #include <signal.h>
@@ -503,6 +505,20 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, NULL, event, event->header.size);
 }
 
+static int process_locked_synthesized_event(struct perf_tool *tool,
+				     union perf_event *event,
+				     struct perf_sample *sample __maybe_unused,
+				     struct machine *machine __maybe_unused)
+{
+	static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
+	int ret;
+
+	pthread_mutex_lock(&synth_lock);
+	ret = process_synthesized_event(tool, event, sample, machine);
+	pthread_mutex_unlock(&synth_lock);
+	return ret;
+}
+
 static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
@@ -1288,6 +1304,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	struct perf_tool *tool = &rec->tool;
 	int fd = perf_data__fd(data);
 	int err = 0;
+	event_op f = process_synthesized_event;
 
 	if (rec->opts.tail_synthesize != tail)
 		return 0;
@@ -1402,9 +1419,18 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err < 0)
 		pr_warning("Couldn't synthesize cgroup events.\n");
 
+	if (rec->opts.nr_threads_synthesize > 1) {
+		perf_set_multithreaded();
+		f = process_locked_synthesized_event;
+	}
+
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
-					    process_synthesized_event, opts->sample_address,
-					    1);
+					    f, opts->sample_address,
+					    rec->opts.nr_threads_synthesize);
+
+	if (rec->opts.nr_threads_synthesize > 1)
+		perf_set_singlethreaded();
+
 out:
 	return err;
 }
@@ -2232,6 +2258,7 @@ static struct record record = {
 			.default_per_cpu = true,
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
+		.nr_threads_synthesize = 1,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -2421,6 +2448,9 @@ static struct option __record_options[] = {
 #endif
 	OPT_CALLBACK(0, "max-size", &record.output_max_size,
 		     "size", "Limit the maximum size of the output file", parse_output_max_size),
+	OPT_UINTEGER(0, "num-thread-synthesize",
+		     &record.opts.nr_threads_synthesize,
+		     "number of threads to run for event synthesis"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 24316458be20..923565c3b155 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -68,6 +68,7 @@ struct record_opts {
 	int	      affinity;
 	int	      mmap_flush;
 	unsigned int  comp_level;
+	unsigned int  nr_threads_synthesize;
 };
 
 extern const char * const *record_usage;
-- 
2.26.1.301.g55bc3eb7cb9-goog

