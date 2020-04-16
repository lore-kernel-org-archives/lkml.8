Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D35C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1B72076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExLcymzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391448AbgDPANj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733284AbgDPANH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:13:07 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A6C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:13:07 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k10so1519255plx.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VSuhz+enLDEoUe8o3p0Ply7OBrvYmFVYQ8Yt4+PCZjw=;
        b=ExLcymzbtB9kq61CDfHnbt/jG0yH7G8Ffm1tR+ZQ9J+dNcj33sP4aJNnNyc2bZBQ2Z
         xMjyITOfO9cjJ0/kyf+s4IT6bUloJGGEzTB0MdGqIgHw6xpgBIc8IUVQ6O2txa52CWBq
         994OQyQm5XFtE+6M9+ZEtC1sE46C4K7+lnN9LoNvmrCdqjkrMdIAB+OuI6008lRfq75+
         sScc9jwlDpPzZfCws39Y04smVqihR/LkURdQJQGD/Xws+vfmREKPkoYP4djQlTaqFwzp
         fdNyKX/H23KAAXREnJn8aTDXTLQKu6xlSOAf+Rm58FQ+EBBbQXK6fMRwJ1pwzGroMRlg
         4QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VSuhz+enLDEoUe8o3p0Ply7OBrvYmFVYQ8Yt4+PCZjw=;
        b=oZ9E6LMDBp81IwQWxmgJwqMotKDZlWFsX9fvtPuXmhqPWNCAXMhXQmOlenCIZ5Tmv1
         vU/zhK415aNxua7zOLlzqG3DcA1Emj7Hgb5RzkF7t5SubBII9vEpXekBGqBMRdAwT40F
         sVuBxUWWndnAUMqBt/Zj86mjTRy4p7vGnozymkL5YgtzZPBAgph66dXXx4xn2g63mU+q
         m28beWk7VmoJXA66T2UYNfqy5TkBpeWD+0/JtxxcA9p3oGC8+oEYMsj+sscNkaT4SftQ
         zVUkek8RasRnbwi3zssWoBL/hBL7xavyZQF3TYnw1VVmv/e8N+cNAXBvHMi7RMnKHQgA
         wZpw==
X-Gm-Message-State: AGi0Puag+hOJ2PXgwOftqqph7qFICSrRcbRwNDZ6hS1bJQcZuKIO33NN
        w1HthXyP8OQIj/O0Ni4tz+xzoarmQDB8
X-Google-Smtp-Source: APiQypLOVeuUMpLSIaXr0Ek5N6IEquPt7vV531GuJbYbQtTtJeDDPAXCy9U7xigL9h42WaNWly3PcOjUgcik
X-Received: by 2002:a17:90a:f418:: with SMTP id ch24mr1925485pjb.68.1586995987222;
 Wed, 15 Apr 2020 17:13:07 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:13:03 -0700
Message-Id: <20200416001303.96841-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] perf/record: add num-synthesize-threads option
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
 tools/perf/builtin-record.c              | 35 ++++++++++++++++++++++--
 tools/perf/util/record.h                 |  1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

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
index 1ab349abe904..2f97d0c32a75 100644
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
@@ -1288,6 +1304,8 @@ static int record__synthesize(struct record *rec, bool tail)
 	struct perf_tool *tool = &rec->tool;
 	int fd = perf_data__fd(data);
 	int err = 0;
+	int (*f)(struct perf_tool *, union perf_event *, struct perf_sample *,
+		struct machine *) = process_synthesized_event;
 
 	if (rec->opts.tail_synthesize != tail)
 		return 0;
@@ -1402,9 +1420,18 @@ static int record__synthesize(struct record *rec, bool tail)
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
@@ -2232,6 +2259,7 @@ static struct record record = {
 			.default_per_cpu = true,
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
+		.nr_threads_synthesize = 1,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -2421,6 +2449,9 @@ static struct option __record_options[] = {
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
2.26.0.110.g2183baf09c-goog

