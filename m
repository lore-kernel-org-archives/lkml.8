Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41519C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181122071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbgEYOVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:21:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:1393 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgEYOVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:21:20 -0400
IronPort-SDR: Ho4BCFvLN8RebHh8Fb8PMyMtRTAUWzJA1ZWKdGu13Snb8JQHxzi0daWbnigTY7KeYx7+aM+sHi
 1XloRxEgYKyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:21:19 -0700
IronPort-SDR: te3/EHRADyWGPH+xTSkNXEWXi1yblOPNgjpeuSRwTOR9wxHwOSQhyw31u5hHXZ50nRhMCX7F8C
 1MFLbHR/RlTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="256234130"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2020 07:21:19 -0700
Received: from [10.249.227.191] (abudanko-mobl.ccr.corp.intel.com [10.249.227.191])
        by linux.intel.com (Postfix) with ESMTP id 18C7258056A;
        Mon, 25 May 2020 07:21:16 -0700 (PDT)
Subject: [PATCH v4 06/10] perf stat: implement control commands handling
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
Message-ID: <51635bc5-4396-0b87-4150-bc272754af9c@linux.intel.com>
Date:   Mon, 25 May 2020 17:21:15 +0300
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


Implement handling of 'enable' and 'disable' control commands
coming from control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 45 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 70b48a279b75..c06c2b701a15 100644
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
@@ -518,8 +543,8 @@ static int dispatch_events(pid_t pid, struct perf_stat_config *config)
 {
 	pid_t child = 0;
 	bool stop = false;
-	struct timespec time_to_sleep;
-	int sleep_time, status = 0;
+	int time_to_sleep, sleep_time, status = 0;
+	struct timespec time_start, time_stop, time_diff;
 	int times = config->times;
 
 	if (config->interval)
@@ -529,8 +554,7 @@ static int dispatch_events(pid_t pid, struct perf_stat_config *config)
 	else
 		sleep_time = 1000;
 
-	time_to_sleep.tv_sec  = sleep_time / MSEC_PER_SEC;
-	time_to_sleep.tv_nsec = (sleep_time % MSEC_PER_SEC) * NSEC_PER_MSEC;
+	time_to_sleep = sleep_time;
 
 	do {
 		if (pid != -1) {
@@ -543,8 +567,17 @@ static int dispatch_events(pid_t pid, struct perf_stat_config *config)
 		if (child || stop || done)
 			break;
 
-		nanosleep(&time_to_sleep, NULL);
-		stop = process_timeout(config->timeout, config->interval, &times);
+		clock_gettime(CLOCK_MONOTONIC, &time_start);
+		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
+			stop = process_timeout(config->timeout, config->interval, &times);
+			time_to_sleep = sleep_time;
+		} else { /* fd revent */
+			stop = process_evlist(evsel_list, config->interval, &times);
+			clock_gettime(CLOCK_MONOTONIC, &time_stop);
+			diff_timespec(&time_diff, &time_stop, &time_start);
+			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
+					time_diff.tv_nsec / NSEC_PER_MSEC;
+		}
 	} while (1);
 
 	return status;
-- 
2.24.1

