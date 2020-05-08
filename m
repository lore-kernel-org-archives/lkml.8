Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7481AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B6D20720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEHKs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:48:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:56777 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgEHKs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:48:59 -0400
IronPort-SDR: KAqyA6kog8WIAJhTwaD+DIFyYmcRokL8ShHHW83FJS9VJAGkQKuzF3T45TXqEuykthhwZMTFgk
 4ozXvmbxTPIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 03:48:58 -0700
IronPort-SDR: vOZctJD+MvzPeadWFeiC7VDz5/esk/5AmGf5AidpU+0RJqYgwkEqSzbM5PVw9w862Ep8vfwsqF
 BA40o/xxSO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="435643290"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2020 03:48:55 -0700
Received: from [10.249.224.104] (abudanko-mobl.ccr.corp.intel.com [10.249.224.104])
        by linux.intel.com (Postfix) with ESMTP id 4FDA1580709;
        Fri,  8 May 2020 03:48:53 -0700 (PDT)
Subject: [PATCH v3 3/9] perf stat: factor out event handling loop into a
 function
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0b63e751-5c45-3311-d930-15f1ebe72601@linux.intel.com>
Organization: Intel Corp.
Message-ID: <dc6b64d2-dcdf-a3de-a181-ea6294945c5e@linux.intel.com>
Date:   Fri, 8 May 2020 13:48:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0b63e751-5c45-3311-d930-15f1ebe72601@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out event handling loop into handle_events() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 85 +++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e0c1ad23c768..9775b0905146 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -371,6 +371,16 @@ static void process_interval(void)
 	print_counters(&rs, 0, NULL);
 }
 
+static bool print_interval_and_stop(struct perf_stat_config *config, int *times)
+{
+	if (config->interval) {
+		process_interval();
+		if (interval_count && !(--(*times)))
+			return true;
+	}
+	return false;
+}
+
 static void enable_counters(void)
 {
 	if (stat_config.initial_delay)
@@ -436,6 +446,42 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
+static int handle_events(pid_t pid, struct perf_stat_config *config)
+{
+	pid_t child = 0;
+	bool res, stop = false;
+	struct timespec time_to_sleep;
+	int sleep_time, status = 0, times = config->times;
+
+	if (config->interval)
+		sleep_time = config->interval;
+	else if (config->timeout)
+		sleep_time = config->timeout;
+	else
+		sleep_time = 1000;
+
+	time_to_sleep.tv_sec  = sleep_time / MSEC_PER_SEC;
+	time_to_sleep.tv_nsec = (sleep_time % MSEC_PER_SEC) * NSEC_PER_MSEC;
+
+	do {
+		if (pid != -1)
+			child = waitpid(pid, &status, WNOHANG);
+		if (child || stop || done)
+			break;
+		nanosleep(&time_to_sleep, NULL);
+		if (pid == -1)
+			stop = !is_target_alive(&target, evsel_list->core.threads);
+		if (config->timeout) {
+			stop = !stop ? true : stop;
+		} else {
+			res = print_interval_and_stop(config, &times);
+			stop = !stop ? res : stop;
+		}
+	} while (1);
+
+	return status;
+}
+
 enum counter_recovery {
 	COUNTER_SKIP,
 	COUNTER_RETRY,
@@ -494,12 +540,10 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
-	int times = stat_config.times;
 	int timeout = stat_config.timeout;
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct evsel *counter;
-	struct timespec ts;
 	size_t l;
 	int status = 0;
 	const bool forks = (argc > 0);
@@ -508,17 +552,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
@@ -675,16 +708,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		perf_evlist__start_workload(evsel_list);
 		enable_counters();
 
-		if (interval || timeout) {
-			while (!waitpid(child_pid, &status, WNOHANG)) {
-				nanosleep(&ts, NULL);
-				if (timeout)
-					break;
-				process_interval();
-				if (interval_count && !(--times))
-					break;
-			}
-		}
+		if (interval || timeout)
+			handle_events(child_pid, &stat_config);
+
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -701,18 +727,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done) {
-			nanosleep(&ts, NULL);
-			if (!is_target_alive(&target, evsel_list->core.threads))
-				break;
-			if (timeout)
-				break;
-			if (interval) {
-				process_interval();
-				if (interval_count && !(--times))
-					break;
-			}
-		}
+		handle_events(-1, &stat_config);
 	}
 
 	disable_counters();
-- 
2.24.1

