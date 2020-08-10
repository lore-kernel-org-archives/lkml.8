Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A2EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6120C20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHJV16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:27:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:25837 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgHJV1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:55 -0400
IronPort-SDR: l5sLP4M6UYTcqWzf05M+GU9oi06FUYj8IpFOR0EP2eoUxoPLHyk9q92o6AXWCQsUp1T+3ItGpH
 WH1K055m6Gig==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665980"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:55 -0700
IronPort-SDR: WRyRwwWHrKAmgoW6cJscmgAp47dJHrx6a2bXGKCmOjz2VU9gpuVg566Uk09dSpy/BbYqB0IKp+
 hgHrgt1MVyqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196832"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:54 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: [PATCH V6 14/16] perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Mon, 10 Aug 2020 14:24:34 -0700
Message-Id: <20200810212436.8026-15-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Display sampled code page sizes when PERF_SAMPLE_CODE_PAGE_SIZE was set.

For example,
perf script --fields comm,event,ip,code_page_size
            dtlb mem-loads:uP:            445777 4K
            dtlb mem-loads:uP:            40f724 4K
            dtlb mem-loads:uP:            474926 4K
            dtlb mem-loads:uP:            401075 4K
            dtlb mem-loads:uP:            401095 4K
            dtlb mem-loads:uP:            401095 4K
            dtlb mem-loads:uP:            4010cc 4K
            dtlb mem-loads:uP:            440b6f 4K

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 13 +++++++++++--
 tools/perf/util/session.c                |  3 +++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 27a49f2e6cb7..fd7ec6cb971c 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -118,7 +118,7 @@ OPTIONS
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
 	srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
 	brstackinsn, brstackoff, callindent, insn, insnlen, synth, phys_addr,
-	metric, misc, srccode, ipc, data_page_size.
+	metric, misc, srccode, ipc, data_page_size, code_page_size.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69773025cc58..e6341216e6f7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -116,6 +116,7 @@ enum perf_output_field {
 	PERF_OUTPUT_SRCCODE	    = 1ULL << 30,
 	PERF_OUTPUT_IPC             = 1ULL << 31,
 	PERF_OUTPUT_DATA_PAGE_SIZE  = 1ULL << 32,
+	PERF_OUTPUT_CODE_PAGE_SIZE  = 1ULL << 33,
 };
 
 struct output_option {
@@ -155,6 +156,7 @@ struct output_option {
 	{.str = "srccode", .field = PERF_OUTPUT_SRCCODE},
 	{.str = "ipc", .field = PERF_OUTPUT_IPC},
 	{.str = "data_page_size", .field = PERF_OUTPUT_DATA_PAGE_SIZE},
+	{.str = "code_page_size", .field = PERF_OUTPUT_CODE_PAGE_SIZE},
 };
 
 enum {
@@ -228,7 +230,7 @@ static struct {
 			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
 			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
 			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
-			      PERF_OUTPUT_DATA_PAGE_SIZE,
+			      PERF_OUTPUT_DATA_PAGE_SIZE | PERF_OUTPUT_CODE_PAGE_SIZE,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -481,6 +483,10 @@ static int perf_evsel__check_attr(struct evsel *evsel, struct perf_session *sess
 	    evsel__check_stype(evsel, PERF_SAMPLE_DATA_PAGE_SIZE, "DATA_PAGE_SIZE", PERF_OUTPUT_DATA_PAGE_SIZE))
 		return -EINVAL;
 
+	if (PRINT_FIELD(CODE_PAGE_SIZE) &&
+	    evsel__check_stype(evsel, PERF_SAMPLE_CODE_PAGE_SIZE, "CODE_PAGE_SIZE", PERF_OUTPUT_CODE_PAGE_SIZE))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1953,6 +1959,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(DATA_PAGE_SIZE))
 		fprintf(fp, " %s", get_page_size_name(sample->data_page_size, str));
 
+	if (PRINT_FIELD(CODE_PAGE_SIZE))
+		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
+
 	perf_sample__fprintf_ipc(sample, attr, fp);
 
 	fprintf(fp, "\n");
@@ -3436,7 +3445,7 @@ int cmd_script(int argc, const char **argv)
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
 		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,"
-		     "data_page_size",
+		     "data_page_size,code_page_size",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f810b07d10d2..83d4680044a2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1286,6 +1286,9 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		printf(" .. data page size: %s\n", get_page_size_name(sample->data_page_size, str));
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		printf(" .. code page size: %s\n", get_page_size_name(sample->code_page_size, str));
+
 	if (sample_type & PERF_SAMPLE_TRANSACTION)
 		printf("... transaction: %" PRIx64 "\n", sample->transaction);
 
-- 
2.17.1

