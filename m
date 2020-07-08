Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4F3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03072078A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGHHxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:53:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:5120 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgGHHxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:53:39 -0400
IronPort-SDR: THSBLJitPuVevQm+abohRZ7IYnti03kEz99Rl3sX76I73pGa6W0nG2TCYKkjKxogeP1aFwnM+z
 428/2Uy9S7wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145256828"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="145256828"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:53:36 -0700
IronPort-SDR: BHuRMyDbqn95aW6eQUPBQJHbbknuhAZJZIEdLEpuEstApn+pJHBHVw6g72QzoeP/HFl2fuKPkR
 ud+//N1QmpmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358031104"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 00:53:36 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id 7839C5807FC;
        Wed,  8 Jul 2020 00:53:34 -0700 (PDT)
Subject: [PATCH v10 11/15] perf stat: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5f078e5f-471e-583c-30ea-9aa77d492c13@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:53:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement handling of 'enable' and 'disable' control commands coming
from control file descriptor. If poll event splits initiated timeout
interval then the reminder is calculated and still waited in the
following evlist__poll() call.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 83 ++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9d5c503e698f..5280a45af5dc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -560,9 +560,61 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
-static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
+static void process_evlist(struct evlist *evlist, unsigned int interval)
+{
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
+
+	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
+		switch (cmd) {
+		case EVLIST_CTL_CMD_ENABLE:
+			pr_info(EVLIST_ENABLED_MSG);
+			if (interval)
+				process_interval();
+			break;
+		case EVLIST_CTL_CMD_DISABLE:
+			if (interval)
+				process_interval();
+			pr_info(EVLIST_DISABLED_MSG);
+			break;
+		case EVLIST_CTL_CMD_ACK:
+		case EVLIST_CTL_CMD_UNSUPPORTED:
+		default:
+			break;
+		}
+	}
+}
+
+static void compute_tts(struct timespec *time_start, struct timespec *time_stop,
+			int *time_to_sleep)
+{
+	int tts = *time_to_sleep;
+	struct timespec time_diff;
+
+	diff_timespec(&time_diff, time_stop, time_start);
+
+	tts -= time_diff.tv_sec * MSEC_PER_SEC +
+	       time_diff.tv_nsec / NSEC_PER_MSEC;
+
+	if (tts < 0)
+		tts = 0;
+
+	*time_to_sleep = tts;
+}
+
+static int dispatch_events(bool forks, int timeout, int interval, int *times)
 {
 	int child_exited = 0, status = 0;
+	int time_to_sleep, sleep_time;
+	struct timespec time_start, time_stop;
+
+	if (interval)
+		sleep_time = interval;
+	else if (timeout)
+		sleep_time = timeout;
+	else
+		sleep_time = 1000;
+
+	time_to_sleep = sleep_time;
 
 	while (!done) {
 		if (forks)
@@ -573,9 +625,16 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times, st
 		if (child_exited)
 			break;
 
-		nanosleep(ts, NULL);
-		if (timeout || handle_interval(interval, times))
-			break;
+		clock_gettime(CLOCK_MONOTONIC, &time_start);
+		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
+			if (timeout || handle_interval(interval, times))
+				break;
+			time_to_sleep = sleep_time;
+		} else { /* fd revent */
+			process_evlist(evsel_list, interval);
+			clock_gettime(CLOCK_MONOTONIC, &time_stop);
+			compute_tts(&time_start, &time_stop, &time_to_sleep);
+		}
 	}
 
 	return status;
@@ -644,7 +703,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct evsel *counter;
-	struct timespec ts;
 	size_t l;
 	int status = 0;
 	const bool forks = (argc > 0);
@@ -653,17 +711,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int i, cpu;
 	bool second_pass = false;
 
-	if (interval) {
-		ts.tv_sec  = interval / USEC_PER_MSEC;
-		ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
-	} else if (timeout) {
-		ts.tv_sec  = timeout / USEC_PER_MSEC;
-		ts.tv_nsec = (timeout % USEC_PER_MSEC) * NSEC_PER_MSEC;
-	} else {
-		ts.tv_sec  = 1;
-		ts.tv_nsec = 0;
-	}
-
 	if (forks) {
 		if (perf_evlist__prepare_workload(evsel_list, &target, argv, is_pipe,
 						  workload_exec_failed_signal) < 0) {
@@ -821,7 +868,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 
 		if (interval || timeout)
-			status = dispatch_events(forks, timeout, interval, &times, &ts);
+			status = dispatch_events(forks, timeout, interval, &times);
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -838,7 +885,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		status = dispatch_events(forks, timeout, interval, &times, &ts);
+		status = dispatch_events(forks, timeout, interval, &times);
 	}
 
 	disable_counters();
-- 
2.24.1


