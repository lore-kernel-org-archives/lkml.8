Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA9FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E40420835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgE0SDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:03:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:31564 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgE0SDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:03:23 -0400
IronPort-SDR: NAzBuRSK0b3F13gBb5LWlFsHWKqjqFP5Rhnp6MArYJ9fOXr4cjbjZlvhhNu79jjrn5q1jET5Bw
 OSfKMcq8HWBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 11:03:22 -0700
IronPort-SDR: zOzprujK1m7EQvx35bqerN8Q1Xorg5edMghLJEuR85os/fmxxky0tlOX5J6o/5v2dNNbDj0jaI
 Ir492gQENQrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="266925675"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2020 11:03:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf script: Fix --call-trace for Intel PT
Date:   Wed, 27 May 2020 21:02:50 +0300
Message-Id: <20200527180250.16723-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make process_attr() respect -F-ip, noting also that the condition in
process_attr() (callchain_param.record_mode != CALLCHAIN_NONE) is always
true so test the sample type directly.

Example:

  Before:

    $ perf record -e intel_pt//u uname
    Linux
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.033 MB perf.data ]
    $ perf script --call-trace | head -5
           uname 30992 [006] 41758.313696574:  cbr: 42 freq: 4219 MHz (156%)                    0 [unknown] ([unknown]                                         )
           uname 30992 [006] 41758.313696907: _start                               7f71792c4100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )
           uname 30992 [006] 41758.313699574:     _dl_start                        7f71792c4103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )
           uname 30992 [006] 41758.313699907:     _dl_start                        7f71792c4e18 _dl_start+0x28 (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )
           uname 30992 [006] 41758.313701574:     _dl_start                        7f71792c5128 _dl_start+0x338 (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )

  After:

    $ perf script --call-trace | head -5
           uname 30992 [006] 41758.313696574:  cbr: 42 freq: 4219 MHz (156%)
           uname 30992 [006] 41758.313696907: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )      _start
           uname 30992 [006] 41758.313699574: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
           uname 30992 [006] 41758.313699907: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
           uname 30992 [006] 41758.313701574: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: f288e8e1aa4f ("perf script: Enable IP fields for callchains")
---
 tools/perf/builtin-script.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5bdd1a393399..3249ead2deef 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -167,6 +167,7 @@ static struct {
 	u64 fields;
 	u64 invalid_fields;
 	u64 user_set_fields;
+	u64 user_unset_fields;
 } output[OUTPUT_TYPE_MAX] = {
 
 	[PERF_TYPE_HARDWARE] = {
@@ -2132,10 +2133,18 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	sample_type = perf_evlist__combined_sample_type(evlist);
 	callchain_param_setup(sample_type);
 
-	/* Enable fields for callchain entries, if it got enabled. */
-	if (callchain_param.record_mode != CALLCHAIN_NONE) {
-		output[output_type(evsel->core.attr.type)].fields |= PERF_OUTPUT_IP |
-								     PERF_OUTPUT_SYM;
+	/* Enable fields for callchain entries */
+	if (symbol_conf.use_callchain &&
+	    (sample_type & PERF_SAMPLE_CALLCHAIN ||
+	     sample_type & PERF_SAMPLE_BRANCH_STACK ||
+	     (sample_type & PERF_SAMPLE_REGS_USER &&
+	      sample_type & PERF_SAMPLE_STACK_USER))) {
+		int type = output_type(evsel->core.attr.type);
+
+		if (!(output[type].user_unset_fields & PERF_OUTPUT_IP))
+			output[type].fields |= PERF_OUTPUT_IP;
+		if (!(output[type].user_unset_fields & PERF_OUTPUT_SYM))
+			output[type].fields |= PERF_OUTPUT_SYM;
 	}
 	set_print_ip_opts(&evsel->core.attr);
 	return 0;
@@ -2704,9 +2713,11 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 					if (change == REMOVE) {
 						output[j].fields &= ~all_output_options[i].field;
 						output[j].user_set_fields &= ~all_output_options[i].field;
+						output[j].user_unset_fields |= all_output_options[i].field;
 					} else {
 						output[j].fields |= all_output_options[i].field;
 						output[j].user_set_fields |= all_output_options[i].field;
+						output[j].user_unset_fields &= ~all_output_options[i].field;
 					}
 					output[j].user_set = true;
 					output[j].wildcard_set = true;
-- 
2.17.1

