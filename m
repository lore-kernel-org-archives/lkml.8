Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7A72073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgFQIhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:37:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:60716 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgFQIhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:37:47 -0400
IronPort-SDR: xvqsJemtidT4ijCv0Ym3OasdSyqBYzqTMrtp5awa6KIkRWIoHD0FpR92AxzkEWrTbOPGsqKUBt
 t4/SDlQoj/VA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 01:37:46 -0700
IronPort-SDR: JoPdcwtzheymRhccxuLexPkEUr45lYVnNcluC6Q1QHA96zIQ8Y2YOEuLTCp0FEo+aGnW38ui8L
 sMBVdDfKWpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="450162490"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2020 01:37:46 -0700
Received: from [10.249.225.191] (abudanko-mobl.ccr.corp.intel.com [10.249.225.191])
        by linux.intel.com (Postfix) with ESMTP id 9A99458026B;
        Wed, 17 Jun 2020 01:37:44 -0700 (PDT)
Subject: [PATCH v8 04/13] perf stat: factor out body of event handling loop
 for system wide
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Organization: Intel Corp.
Message-ID: <eeeff629-925a-530b-9803-f274337ae473@linux.intel.com>
Date:   Wed, 17 Jun 2020 11:37:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce process_timeout() and process_interval() functions that
factor out body of event handling loop for attach and system wide
monitoring use cases.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9be020e0098a..31f7ccf9537b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -475,6 +475,23 @@ static void process_interval(void)
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
+static bool process_timeout(int timeout, unsigned int interval, int *times)
+{
+	if (timeout)
+		return true;
+	return print_interval(interval, times);
+}
+
 static void enable_counters(void)
 {
 	if (stat_config.initial_delay)
@@ -611,6 +628,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity affinity;
 	int i, cpu;
 	bool second_pass = false;
+	bool stop = false;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -805,17 +823,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done) {
+		while (!done && !stop) {
 			nanosleep(&ts, NULL);
 			if (!is_target_alive(&target, evsel_list->core.threads))
 				break;
-			if (timeout)
-				break;
-			if (interval) {
-				process_interval();
-				if (interval_count && !(--times))
-					break;
-			}
+			stop = process_timeout(timeout, interval, &times);
 		}
 	}
 
-- 
2.24.1


