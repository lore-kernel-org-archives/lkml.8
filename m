Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C88BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E7620672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgGHHwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:52:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:7504 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgGHHwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:52:33 -0400
IronPort-SDR: B5sB9e6B2ZryaOtmiamDm8xA0UKZA6Y4UvMYLPb6feOviZezkmToOI0i6mI5qfHM//A/xTaY9r
 YlD9JYr3QOyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="146824742"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="146824742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:52:31 -0700
IronPort-SDR: PJTHRv1C00VQiPOHbM3BNfja4AH8KikS1rFp0wuJNmBOAZZz7wXAWOAOXrequPGqb/5V2AFhGj
 AqZoKieiQq3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358030767"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 00:52:31 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id 47F8A5807FC;
        Wed,  8 Jul 2020 00:52:29 -0700 (PDT)
Subject: [PATCH v10 09/15] perf stat: factor out event handling loop into
 dispatch_events()
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
Message-ID: <ef57a962-8e9f-4627-8b24-0198b8bd2117@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:52:28 +0300
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


Consolidate event dispatching loops for fork, attach and system
wide monitoring use cases into common dispatch_events() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 91f31518948e..a5a0f4841003 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -550,6 +550,27 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
+static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
+{
+	int child_exited = 0, status = 0;
+
+	while (!done) {
+		if (forks)
+			child_exited = waitpid(child_pid, &status, WNOHANG);
+		else
+			child_exited = !is_target_alive(&target, evsel_list->core.threads) ? 1 : 0;
+
+		if (child_exited)
+			break;
+
+		nanosleep(ts, NULL);
+		if (timeout || handle_interval(interval, times))
+			break;
+	}
+
+	return status;
+}
+
 enum counter_recovery {
 	COUNTER_SKIP,
 	COUNTER_RETRY,
@@ -789,13 +810,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		perf_evlist__start_workload(evsel_list);
 		enable_counters();
 
-		if (interval || timeout) {
-			while (!waitpid(child_pid, &status, WNOHANG)) {
-				nanosleep(&ts, NULL);
-				if (timeout || handle_interval(interval, &times))
-					break;
-			}
-		}
+		if (interval || timeout)
+			status = dispatch_events(forks, timeout, interval, &times, &ts);
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -812,11 +828,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done && is_target_alive(&target, evsel_list->core.threads)) {
-			nanosleep(&ts, NULL);
-			if (timeout || handle_interval(interval, &times))
-				break;
-		}
+		status = dispatch_events(forks, timeout, interval, &times, &ts);
 	}
 
 	disable_counters();
-- 
2.24.1


