Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA85C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D22207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgEFS21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:28:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:65275 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbgEFS20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:28:26 -0400
IronPort-SDR: QutpkligQ3gaieQiEvZN+jzYC0bdaeR/gdenjb3oJlxsApGhj4HqQ+nHZYmpDDE32FvtidHNZi
 dbAEbWnwwLNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:28:26 -0700
IronPort-SDR: qllKGC5FxV8u4PU8uN8GyTOHn2W++2qlXT+hhSmqQzzvK3dwW0+VEHvdSUsptlQM5jWUHL7jY0
 P4HFIeOIzmEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="284711675"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 06 May 2020 11:28:25 -0700
Received: from [10.249.228.227] (abudanko-mobl.ccr.corp.intel.com [10.249.228.227])
        by linux.intel.com (Postfix) with ESMTP id B214A580679;
        Wed,  6 May 2020 11:28:23 -0700 (PDT)
Subject: [PATCH v2 08/11] perf record: extend -D,--delay option with -1 value
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <44e55197-2328-3f86-1855-ad27ac4294c2@linux.intel.com>
Date:   Wed, 6 May 2020 21:28:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Extend -D,--delay option with -1 to start collection
with events disabled to be enbled later by enable
command provided via control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 12 ++++++++----
 tools/perf/builtin-trace.c  |  2 +-
 tools/perf/util/record.h    |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e4efdbf1a81e..8a14e68b86ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1704,8 +1704,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	if (opts->initial_delay) {
-		usleep(opts->initial_delay * USEC_PER_MSEC);
-		evlist__enable(rec->evlist);
+		pr_info(PERF_EVLIST__DISABLED_MSG);
+		if (opts->initial_delay > 0) {
+			usleep(opts->initial_delay * USEC_PER_MSEC);
+			evlist__enable(rec->evlist);
+			pr_info(PERF_EVLIST__ENABLED_MSG);
+		}
 	}
 
 	trigger_ready(&auxtrace_snapshot_trigger);
@@ -2413,8 +2417,8 @@ static struct option __record_options[] = {
 	OPT_CALLBACK('G', "cgroup", &record.evlist, "name",
 		     "monitor event in cgroup name only",
 		     parse_cgroups),
-	OPT_UINTEGER('D', "delay", &record.opts.initial_delay,
-		  "ms to wait before starting measurement after program start"),
+	OPT_INTEGER('D', "delay", &record.opts.initial_delay,
+		  "ms to wait before starting measurement after program start (-1: start with events disabled )"),
 	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
 	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
 		   "user to profile"),
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a46efb907bd4..63f69a927f3c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4773,7 +4773,7 @@ int cmd_trace(int argc, const char **argv)
 			"per thread proc mmap processing timeout in ms"),
 	OPT_CALLBACK('G', "cgroup", &trace, "name", "monitor event in cgroup name only",
 		     trace__parse_cgroups),
-	OPT_UINTEGER('D', "delay", &trace.opts.initial_delay,
+	OPT_INTEGER('D', "delay", &trace.opts.initial_delay,
 		     "ms to wait before starting measurement after program "
 		     "start"),
 	OPTS_EVSWITCH(&trace.evswitch),
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 923565c3b155..96a73bbd8cd4 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -60,7 +60,7 @@ struct record_opts {
 	const char    *auxtrace_snapshot_opts;
 	const char    *auxtrace_sample_opts;
 	bool	      sample_transaction;
-	unsigned      initial_delay;
+	int	      initial_delay;
 	bool	      use_clockid;
 	clockid_t     clockid;
 	u64	      clockid_res_ns;
-- 
2.24.1


