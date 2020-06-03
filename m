Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7012C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9970A20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgFCP7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:59:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:12497 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgFCP7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:59:25 -0400
IronPort-SDR: i3vfUlXtvhQnbdcwPV582iZy4yKVz8Mk5xzeLEeOmzxg20Z+E98pCilOrSr8GSRxUfcR7eLJeG
 ZWJS0weudP4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:59:24 -0700
IronPort-SDR: 2ttDapdPHY1+eFySzZmvMzVd6jSsg6UKZ8ObGr7PwmLrWwWwJTuYSLlWymt8lOWHZEZW21FSbV
 16VCLY+rbvHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="347808022"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 03 Jun 2020 08:59:24 -0700
Received: from [10.249.225.188] (abudanko-mobl.ccr.corp.intel.com [10.249.225.188])
        by linux.intel.com (Postfix) with ESMTP id 0696A5800E3;
        Wed,  3 Jun 2020 08:59:21 -0700 (PDT)
Subject: [PATCH v7 09/13] perf stat: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Organization: Intel Corp.
Message-ID: <67630441-400e-0045-c4f9-ef8e486a6559@linux.intel.com>
Date:   Wed, 3 Jun 2020 18:59:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement handling of 'enable' and 'disable' control commands
coming from control file descriptor. process_evlist() function
checks for events on static fds and makes required operations.
If poll event splits initiated timeout interval then the reminder
is calculated and still waited in the following poll() syscall.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 67 +++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f88d5ee55022..cc56d71a3ed5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -492,6 +492,31 @@ static bool process_timeout(int timeout, unsigned int interval, int *times)
 	return print_interval(interval, times);
 }
 
+static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
+{
+	bool stop = false;
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
+
+	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
+		switch (cmd) {
+		case EVLIST_CTL_CMD_ENABLE:
+			pr_info(EVLIST_ENABLED_MSG);
+			stop = print_interval(interval, times);
+			break;
+		case EVLIST_CTL_CMD_DISABLE:
+			stop = print_interval(interval, times);
+			pr_info(EVLIST_DISABLED_MSG);
+			break;
+		case EVLIST_CTL_CMD_ACK:
+		case EVLIST_CTL_CMD_UNSUPPORTED:
+		default:
+			break;
+		}
+	}
+
+	return stop;
+}
+
 static void enable_counters(void)
 {
 	if (stat_config.initial_delay < 0) {
@@ -567,10 +592,21 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
-static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
+static int dispatch_events(bool forks, int timeout, int interval, int *times)
 {
 	bool stop = false;
 	int child = 0, status = 0;
+	int time_to_sleep, sleep_time;
+	struct timespec time_start, time_stop, time_diff;
+
+	if (interval)
+		sleep_time = interval;
+	else if (timeout)
+		sleep_time = timeout;
+	else
+		sleep_time = 1000;
+
+	time_to_sleep = sleep_time;
 
 	while (1) {
 		if (forks)
@@ -581,8 +617,17 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times, st
 		if (done || stop || child)
 			break;
 
-		nanosleep(ts, NULL);
-		stop = process_timeout(timeout, interval, times);
+		clock_gettime(CLOCK_MONOTONIC, &time_start);
+		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
+			stop = process_timeout(timeout, interval, times);
+			time_to_sleep = sleep_time;
+		} else { /* fd revent */
+			stop = process_evlist(evsel_list, interval, times);
+			clock_gettime(CLOCK_MONOTONIC, &time_stop);
+			diff_timespec(&time_diff, &time_stop, &time_start);
+			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
+					time_diff.tv_nsec / NSEC_PER_MSEC;
+		}
 	}
 
 	return status;
@@ -651,7 +696,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct evsel *counter;
-	struct timespec ts;
 	size_t l;
 	int status = 0;
 	const bool forks = (argc > 0);
@@ -660,17 +704,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
@@ -828,7 +861,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 
 		if (interval || timeout)
-			status = dispatch_events(forks, timeout, interval, &times, &ts);
+			status = dispatch_events(forks, timeout, interval, &times);
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -845,7 +878,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		dispatch_events(forks, timeout, interval, &times, &ts);
+		dispatch_events(forks, timeout, interval, &times);
 	}
 
 	disable_counters();
-- 
2.24.1


