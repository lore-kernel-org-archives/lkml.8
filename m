Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D24C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E39424969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgEHNGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730502AbgEHNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10F6C05BD43;
        Fri,  8 May 2020 06:05:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h4-0007tn-Ed; Fri, 08 May 2020 15:05:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CC9251C0857;
        Fri,  8 May 2020 15:05:12 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:12 -0000
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Add num-synthesize-threads option
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Jones <tonyj@suse.de>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200422155038.9380-1-irogers@google.com>
References: <20200422155038.9380-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158894311277.8414.1121482637436259181.tip-bot2@tip-bot2>
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

Commit-ID:     d99c22eabee45f40ca44b877a1adde028f14b6b4
Gitweb:        https://git.kernel.org/tip/d99c22eabee45f40ca44b877a1adde028f14b6b4
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 22 Apr 2020 08:50:38 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 23 Apr 2020 11:10:41 -03:00

perf record: Add num-synthesize-threads option

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
 tools/perf/Documentation/perf-record.txt |  4 +++-
 tools/perf/builtin-record.c              | 34 +++++++++++++++++++++--
 tools/perf/util/record.h                 |  1 +-
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b3f3b3f..6e8b464 100644
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
index 1ab349a..2e8011f 100644
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
index 2431645..923565c 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -68,6 +68,7 @@ struct record_opts {
 	int	      affinity;
 	int	      mmap_flush;
 	unsigned int  comp_level;
+	unsigned int  nr_threads_synthesize;
 };
 
 extern const char * const *record_usage;
