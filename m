Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF282087D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbgEYOTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:19:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:48211 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgEYOTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:19:49 -0400
IronPort-SDR: XHTztFJml496+MdIkc430Hyy2GYvwF8k6FrViQVf0a25v5n1csyVYHoFQZuB6HAV+dvTWmxWwI
 vxy0EO3mZ1OQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:19:49 -0700
IronPort-SDR: CDyUaMXxaWdaoaXwvAUmcEJOdkNOFl35LFEjII4cTB0HTc/MwxK0P4RHg0CDh9gpoixvKIZ32D
 2W82sWzLw3uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="256233900"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2020 07:19:48 -0700
Received: from [10.249.227.191] (abudanko-mobl.ccr.corp.intel.com [10.249.227.191])
        by linux.intel.com (Postfix) with ESMTP id 7420F580101;
        Mon, 25 May 2020 07:19:46 -0700 (PDT)
Subject: [PATCH v4 04/10] perf stat: factor out event handling loop into a
 function
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5f42c6c5-c301-accd-928e-4304fb1c15d0@linux.intel.com>
Date:   Mon, 25 May 2020 17:19:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out event handling loop into dispatch_events() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 93 ++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c43ba6080691..ef2682a87491 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -421,6 +421,24 @@ static void process_interval(void)
 	print_counters(&rs, 0, NULL);
 }
 
+static bool print_interval(unsigned int interval, int *times)
+{
+	if (interval) {
+		process_interval();
+		if (interval_count && !(--(*times)))
+			return true;
+	}
+	return false;
+}
+
+static bool process_timeout(bool timeout, unsigned int interval, int *times)
+{
+	if (timeout)
+		return true;
+	else
+		return print_interval(interval, times);
+}
+
 static void enable_counters(void)
 {
 	if (stat_config.initial_delay)
@@ -486,6 +504,42 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
+static int dispatch_events(pid_t pid, struct perf_stat_config *config)
+{
+	pid_t child = 0;
+	bool stop = false;
+	struct timespec time_to_sleep;
+	int sleep_time, status = 0;
+	int times = config->times;
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
+		if (pid != -1) {
+			child = waitpid(pid, &status, WNOHANG);
+		} else {
+			if (!stop)
+				stop = !is_target_alive(&target, evsel_list->core.threads);
+		}
+
+		if (child || stop || done)
+			break;
+
+		nanosleep(&time_to_sleep, NULL);
+		stop = process_timeout(config->timeout, config->interval, &times);
+	} while (1);
+
+	return status;
+}
+
 enum counter_recovery {
 	COUNTER_SKIP,
 	COUNTER_RETRY,
@@ -544,12 +598,10 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
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
@@ -558,17 +610,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
@@ -725,16 +766,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
+			dispatch_events(child_pid, &stat_config);
+
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -751,18 +785,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
+		dispatch_events(-1, &stat_config);
 	}
 
 	disable_counters();
-- 
2.24.1

