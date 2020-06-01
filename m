Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3279FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16CB020734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFAQDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:03:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:34094 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAQDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:03:46 -0400
IronPort-SDR: VZPKFlxCgZCt/MgQI9eJOVArcrZZhT54CNJ9WS7pS69oRHgjKShXoeb96iXMD9jRw8GkegCwFy
 moThLOxc0nVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 09:03:46 -0700
IronPort-SDR: cGNBhd627MW2KIMElLtJq+P83f7wP6u3I9h3M8aF41HptgagiToCHaovjTZhIFKmvWh1rti5Rf
 BXS7+GE1EkYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="470370661"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2020 09:03:46 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id B5EE2580646;
        Mon,  1 Jun 2020 09:03:43 -0700 (PDT)
Subject: [PATCH v5 11/13] perf record: extend -D,--delay option with -1 value
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
Message-ID: <eabfe83d-3123-6080-a331-c195b65d1387@linux.intel.com>
Date:   Mon, 1 Jun 2020 19:03:42 +0300
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


Extend -D,--delay option with -1 to start collection
with events disabled to be enbled later by enable
command provided via control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  5 +++--
 tools/perf/builtin-record.c              | 12 ++++++++----
 tools/perf/builtin-trace.c               |  2 +-
 tools/perf/util/record.h                 |  2 +-
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index fa8a5fcd27ab..a84376605805 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -407,8 +407,9 @@ if combined with -a or -C options.
 
 -D::
 --delay=::
-After starting the program, wait msecs before measuring. This is useful to
-filter out the startup phase of the program, which is often very different.
+After starting the program, wait msecs before measuring (-1: start with events
+disabled). This is useful to filter out the startup phase of the program, which
+is often very different.
 
 -I::
 --intr-regs::
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e108d90ae2ed..d0b29a1070a0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1749,8 +1749,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	if (opts->initial_delay) {
-		usleep(opts->initial_delay * USEC_PER_MSEC);
-		evlist__enable(rec->evlist);
+		pr_info(EVLIST_DISABLED_MSG);
+		if (opts->initial_delay > 0) {
+			usleep(opts->initial_delay * USEC_PER_MSEC);
+			evlist__enable(rec->evlist);
+			pr_info(EVLIST_ENABLED_MSG);
+		}
 	}
 
 	trigger_ready(&auxtrace_snapshot_trigger);
@@ -2462,8 +2466,8 @@ static struct option __record_options[] = {
 	OPT_CALLBACK('G', "cgroup", &record.evlist, "name",
 		     "monitor event in cgroup name only",
 		     parse_cgroups),
-	OPT_UINTEGER('D', "delay", &record.opts.initial_delay,
-		  "ms to wait before starting measurement after program start"),
+	OPT_INTEGER('D', "delay", &record.opts.initial_delay,
+		  "ms to wait before starting measurement after program start (-1: start with events disabled)"),
 	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
 	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
 		   "user to profile"),
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4cbb64edc998..290149b1b3b5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4813,7 +4813,7 @@ int cmd_trace(int argc, const char **argv)
 			"per thread proc mmap processing timeout in ms"),
 	OPT_CALLBACK('G', "cgroup", &trace, "name", "monitor event in cgroup name only",
 		     trace__parse_cgroups),
-	OPT_UINTEGER('D', "delay", &trace.opts.initial_delay,
+	OPT_INTEGER('D', "delay", &trace.opts.initial_delay,
 		     "ms to wait before starting measurement after program "
 		     "start"),
 	OPTS_EVSWITCH(&trace.evswitch),
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 39d1de4b2a36..da138dcb4d34 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -61,7 +61,7 @@ struct record_opts {
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


