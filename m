Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD2C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3E820714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgC0Isg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:48:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:42151 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgC0Isf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:48:35 -0400
IronPort-SDR: VMxiPTVE0FYOz1mfzrQkSDfZjvobEae8K+765Fd8xjC75pXcS9Rt3B6fH9VUmk+7Pk2UZV1Kn2
 4M4M+O8KBPWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:48:35 -0700
IronPort-SDR: K+58miVoRPl3HmfQgSyaeUJ9aus+DB4yYbw6u/D3nENxGtXJ2IHBlHs34f0ByjQ0kTXhpB/nNj
 UQ4ucUob6SQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="241235517"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2020 01:48:35 -0700
Received: from [10.249.36.56] (abudanko-mobl.ccr.corp.intel.com [10.249.36.56])
        by linux.intel.com (Postfix) with ESMTP id D5C735803E3;
        Fri, 27 Mar 2020 01:48:32 -0700 (PDT)
Subject: [PATCH v1 4/8] perf stat: implement resume and pause control commands
 handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <20afb83b-efc4-6cba-6512-eebbb4e0707a@linux.intel.com>
Date:   Fri, 27 Mar 2020 11:48:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement handle_events() function to handle multiple events
coming from different sources during the measurement in various
modes. Events can come from workload being monitored, signals can
asynchronously arrive, control file descriptors can deliver resume
and pause commands from external processes.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 110 +++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0a1b79fd3f48..58a1b2ff90f7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -373,6 +373,16 @@ static void process_interval(void)
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
 	if (stat_config.initial_delay < 0) {
@@ -448,6 +458,66 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
+static int handle_events(pid_t pid, struct perf_stat_config *config)
+{
+	pid_t child = 0;
+	bool res, stop = false;
+	int sleep_time, time_to_sleep, status = 0, times = config->times;
+	enum evlist_ctl_cmd cmd = CTL_CMD_UNSUPPORTED;
+	struct timespec time_start, time_stop, time_diff;
+
+	if (config->interval)
+		sleep_time = config->interval;
+	else if (config->timeout)
+		sleep_time = config->timeout;
+	else
+		sleep_time = 1000;
+
+	time_to_sleep = sleep_time;
+
+	do {
+		if (pid != -1)
+			child = wait4(pid, &status, WNOHANG, &(config->ru_data));
+		if (child || stop || done)
+			break;
+		clock_gettime(CLOCK_MONOTONIC, &time_start);
+		if (evlist__poll(evsel_list, time_to_sleep) > 0) { /* fd revent */
+			if (perf_evlist__ctlfd_process(evsel_list, &cmd) > 0) {
+				switch (cmd) {
+				case CTL_CMD_RESUME:
+					pr_info(PERF_EVLIST__RESUMED_MSG);
+					stop = print_interval_and_stop(config, &times);
+					break;
+				case CTL_CMD_PAUSE:
+					stop = print_interval_and_stop(config, &times);
+					pr_info(PERF_EVLIST__PAUSED_MSG);
+					break;
+				case CTL_CMD_ACK:
+				case CTL_CMD_UNSUPPORTED:
+				default:
+					break;
+				}
+			}
+			clock_gettime(CLOCK_MONOTONIC, &time_stop);
+			diff_timespec(&time_diff, &time_stop, &time_start);
+			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
+					 time_diff.tv_nsec / NSEC_PER_MSEC;
+		} else { /* poll timeout or EINTR */
+			if (pid == -1)
+				stop = !is_target_alive(&target, evsel_list->core.threads);
+			if (config->timeout) {
+				stop = !stop ? true : stop;
+			} else {
+				res = print_interval_and_stop(config, &times);
+				stop = !stop ? res : stop;
+			}
+			time_to_sleep = sleep_time;
+		}
+	} while (1);
+
+	return status;
+}
+
 enum counter_recovery {
 	COUNTER_SKIP,
 	COUNTER_RETRY,
@@ -507,12 +577,10 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
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
@@ -521,17 +589,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
@@ -688,18 +745,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
-		if (child_pid != -1)
+		if (stat_config.ctl_fd == -1 && !interval && !timeout)
 			wait4(child_pid, &status, 0, &stat_config.ru_data);
+		else
+			status = handle_events(child_pid, &stat_config);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
@@ -711,18 +760,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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


