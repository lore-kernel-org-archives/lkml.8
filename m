Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F039DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B0520734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFAQC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:02:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:51420 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFAQC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:02:27 -0400
IronPort-SDR: kmZrGz3F3xg3ZrHLyfOb31Wb+tVSSd5y7vnxBxitFt7TesIGC4HKEY8g8FWyY4A2PZlL3j5ou2
 JHYYivwyCMng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 09:02:26 -0700
IronPort-SDR: CXfXPbkQpfUGG0JOiAj9OzZw9kuXPkyZ/boG4eL6gI9ZQ75vKRM0YqnzGmcNTxKxxPW071cbBT
 YftGqYuBYPLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="256818326"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2020 09:02:25 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id A3BC8580646;
        Mon,  1 Jun 2020 09:02:23 -0700 (PDT)
Subject: [PATCH v5 09/13] perf stat: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Organization: Intel Corp.
Message-ID: <732e7374-3080-8c8f-eab2-855a2974d695@linux.intel.com>
Date:   Mon, 1 Jun 2020 19:02:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement handling of 'enable' and 'disable' control commands
coming from control file descriptor. process_evlist() functions
checks for events on static fd and makes required operations.
If poll event splits initiated timeout interval then the reminder
is calculated and waited in the following poll() syscall.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 69 +++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d0ddaa5fac96..7fb08454b343 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -439,6 +439,31 @@ static bool process_timeout(bool timeout, unsigned int interval, int *times)
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
@@ -514,10 +539,21 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
-static int dispatch_events(pid_t pid, bool timeout, int interval, int *times, struct timespec *ts)
+static int dispatch_events(pid_t pid, bool timeout, int interval, int *times)
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
 		if (pid != -1)
@@ -528,9 +564,18 @@ static int dispatch_events(pid_t pid, bool timeout, int interval, int *times, st
 		if (done || stop || child)
 			break;
 
-		nanosleep(ts, NULL);
-		stop = process_timeout(timeout, interval, times);
-	}
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
+	} while (1);
 
 	return status;
 }
@@ -598,7 +643,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct evsel *counter;
-	struct timespec ts;
 	size_t l;
 	int status = 0;
 	const bool forks = (argc > 0);
@@ -607,17 +651,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
@@ -775,7 +808,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 
 		if (interval || timeout)
-			status = dispatch_events(child_pid, timeout, interval, &times, &ts);
+			status = dispatch_events(child_pid, timeout, interval, &times);
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -792,7 +825,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		dispatch_events(-1, timeout, interval, &times, &ts);
+		dispatch_events(-1, timeout, interval, &times);
 	}
 
 	disable_counters();
-- 
2.24.1

