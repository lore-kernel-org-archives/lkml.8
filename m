Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30749C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176EB20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:52:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:50093 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgEHKwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:52:37 -0400
IronPort-SDR: m1H68JHJwnnofi/oUaLbz0d3cckaCGfUvrdrT6v+ddGHvNvmEc4Mlxj7FTZmDnJ+2CmilZThNl
 QgnAfl415+4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 03:52:36 -0700
IronPort-SDR: ObOJZ19eeZy9bJRrEM7Sg0KUjMCttS96bzVvMl1qIJCIJmxH39wyunFa9I+lt1xlz1s/6qeqhY
 BvEHN0y5oOKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="296047744"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2020 03:52:36 -0700
Received: from [10.249.224.104] (abudanko-mobl.ccr.corp.intel.com [10.249.224.104])
        by linux.intel.com (Postfix) with ESMTP id 7D36F5805B4;
        Fri,  8 May 2020 03:52:34 -0700 (PDT)
Subject: [PATCH v3 7/9] perf record: extend -D,--delay option with -1 value
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
Message-ID: <117f0c6b-7e65-dc85-f4c3-87e773e463ec@linux.intel.com>
Date:   Fri, 8 May 2020 13:52:33 +0300
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
index 561ef55743e2..c2c4ce7ccee2 100644
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
index e4efdbf1a81e..44fba34bc5aa 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1704,8 +1704,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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


