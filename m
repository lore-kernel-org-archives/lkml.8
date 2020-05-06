Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A284AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722E720936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778597;
	bh=hGqVc2n5n9GdKslcB1rWXutM97MIZOt9oy7q2MkEhDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tOxLdUk4gDbBey0COU2L89mxKYm28/KlqcSSs6HjB7+jjDq7g85xTpWJlymCk7jeN
	 JlKD01fyyybqvTP/oOtOUKuaEaPPCb1aiEyD12qUQKLhjXV5qsdgjNGBZxVL+wRQJ7
	 C363vJyhuWjrwYS1I3VPVKCroiAR5xvlzU4tebSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgEFPXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgEFPXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 423CA2192A;
        Wed,  6 May 2020 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778593;
        bh=hGqVc2n5n9GdKslcB1rWXutM97MIZOt9oy7q2MkEhDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzxhHcjHTpje77VADSd5PCgIqnXXCyYVTPEntBM6OQUWJaVvyr7o3pFtnNsAz7hEx
         cmBDtTi01TzWCgzZNMAI/EkN9aGtx9KBBXB8XhotvP/IR1erdE8vF/8EvR2bvh/DSp
         ANN5W9egWdMpW8Gv4HQzxftNb0PvovPg2GOytnd0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Jones <tonyj@suse.de>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/91] perf record: Add num-synthesize-threads option
Date:   Wed,  6 May 2020 12:21:11 -0300
Message-Id: <20200506152234.21977-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On a desktop computer the processing of /proc/PID/task/PID/maps isn't
slow enough to warrant parallel processing and the thread creation has
some cost - hence the default of 1. On a loaded server with
>100 cores it is possible to see synthesis times in the order of
seconds and in this case having the option is desirable.

As the processing is a synchronization point, it is legitimate to worry if
Amdahl's law will apply to this patch. Profiling with this patch in
place:
https://lore.kernel.org/lkml/20200415054050.31645-4-irogers@google.com/
shows:
...
      - 32.59% __perf_event__synthesize_threads
         - 32.54% __event__synthesize_thread
            + 22.13% perf_event__synthesize_mmap_events
            + 6.68% perf_event__get_comm_ids.constprop.0
            + 1.49% process_synthesized_event
            + 1.29% __GI___readdir64
            + 0.60% __opendir
...
That is the processing is 1.49% of execution time and there is plenty to
make parallel. This is shown in the benchmark in this patch:

https://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com/

  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
   Number of synthesis threads: 1
     Average synthesis took: 127729.000 usec (+- 3372.880 usec)
     Average num. events: 21548.600 (+- 0.306)
     Average time per event 5.927 usec
   Number of synthesis threads: 2
     Average synthesis took: 88863.500 usec (+- 385.168 usec)
     Average num. events: 21552.800 (+- 0.327)
     Average time per event 4.123 usec
   Number of synthesis threads: 3
     Average synthesis took: 83257.400 usec (+- 348.617 usec)
     Average num. events: 21553.200 (+- 0.327)
     Average time per event 3.863 usec
   Number of synthesis threads: 4
     Average synthesis took: 75093.000 usec (+- 422.978 usec)
     Average num. events: 21554.200 (+- 0.200)
     Average time per event 3.484 usec
   Number of synthesis threads: 5
     Average synthesis took: 64896.600 usec (+- 353.348 usec)
     Average num. events: 21558.000 (+- 0.000)
     Average time per event 3.010 usec
   Number of synthesis threads: 6
     Average synthesis took: 59210.200 usec (+- 342.890 usec)
     Average num. events: 21560.000 (+- 0.000)
     Average time per event 2.746 usec
   Number of synthesis threads: 7
     Average synthesis took: 54093.900 usec (+- 306.247 usec)
     Average num. events: 21562.000 (+- 0.000)
     Average time per event 2.509 usec
   Number of synthesis threads: 8
     Average synthesis took: 48938.700 usec (+- 341.732 usec)
     Average num. events: 21564.000 (+- 0.000)
     Average time per event 2.269 usec

Where average time per synthesized event goes from 5.927 usec with 1
thread to 2.269 usec with 8. This isn't a linear speed up as not all of
synthesize code has been made parallel. If the synthesis time was about
10 seconds then using 8 threads may bring this down to less than 4.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Jones <tonyj@suse.de>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Link: http://lore.kernel.org/lkml/20200422155038.9380-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.1

