Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47E4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888672077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgDAKRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:34151 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732226AbgDAKRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:49 -0400
IronPort-SDR: YLrfEumNpouf0tf9u8xz1eKMAuWVk63OzrLnlEwrHDt/mA7qiktm+/qD+u0hDDHMzp+pXD9ptT
 LBU058ZRuG3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:47 -0700
IronPort-SDR: DGYCJ/gbsAgYA3Mo2l41iwmT6bMuQt9B5A7iKrLg6ViDdQDu/OyI1ksGrJUrouJZkddiYXOjrT
 sVuJT+X7o11Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925534"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:47 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/16] perf auxtrace: Add an option to synthesize callchains for regular events
Date:   Wed,  1 Apr 2020 13:16:05 +0300
Message-Id: <20200401101613.6201-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, callchains can be synthesized only for synthesized events. Add
an itrace option to synthesize callchains for regular events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/builtin-report.c         | 3 ++-
 tools/perf/builtin-script.c         | 2 +-
 tools/perf/util/auxtrace.c          | 6 +++++-
 tools/perf/util/auxtrace.h          | 2 ++
 tools/perf/util/s390-cpumsf.c       | 2 +-
 6 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 82ff7dad40c2..671e154ede03 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -10,6 +10,7 @@
 		e	synthesize error events
 		d	create a debug log
 		g	synthesize a call chain (use with i or x)
+		G	synthesize a call chain on existing event records
 		l	synthesize last branch entries (use with i or x)
 		s       skip initial number of events
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 26d8fc27e427..c0cebd53ecf9 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -339,6 +339,7 @@ static int report__setup_sample_type(struct report *rep)
 	bool is_pipe = perf_data__is_pipe(session->data);
 
 	if (session->itrace_synth_opts->callchain ||
+	    session->itrace_synth_opts->add_callchain ||
 	    (!is_pipe &&
 	     perf_header__has_feat(&session->header, HEADER_AUXTRACE) &&
 	     !session->itrace_synth_opts->set))
@@ -1332,7 +1333,7 @@ int cmd_report(int argc, const char **argv)
 	if (symbol_conf.cumulate_callchain && !callchain_param.order_set)
 		callchain_param.order = ORDER_CALLER;
 
-	if (itrace_synth_opts.callchain &&
+	if ((itrace_synth_opts.callchain || itrace_synth_opts.add_callchain) &&
 	    (int)itrace_synth_opts.callchain_sz > report.max_stack)
 		report.max_stack = itrace_synth_opts.callchain_sz;
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 186ebf827fa1..a0dc118e987b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3709,7 +3709,7 @@ int cmd_script(int argc, const char **argv)
 		return -1;
 	}
 
-	if (itrace_synth_opts.callchain &&
+	if ((itrace_synth_opts.callchain || itrace_synth_opts.add_callchain) &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b60bae8e395c..809a09e75c55 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1462,8 +1462,12 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			synth_opts->branches = true;
 			synth_opts->returns = true;
 			break;
+		case 'G':
 		case 'g':
-			synth_opts->callchain = true;
+			if (p[-1] == 'G')
+				synth_opts->add_callchain = true;
+			else
+				synth_opts->callchain = true;
 			synth_opts->callchain_sz =
 					PERF_ITRACE_DEFAULT_CALLCHAIN_SZ;
 			while (*p == ' ' || *p == ',')
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index db65aae5c2ea..dd8a4ff8209e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -74,6 +74,7 @@ enum itrace_period_type {
  * @calls: limit branch samples to calls (can be combined with @returns)
  * @returns: limit branch samples to returns (can be combined with @calls)
  * @callchain: add callchain to 'instructions' events
+ * @add_callchain: add callchain to existing event records
  * @thread_stack: feed branches to the thread_stack
  * @last_branch: add branch context to 'instruction' events
  * @callchain_sz: maximum callchain size
@@ -101,6 +102,7 @@ struct itrace_synth_opts {
 	bool			calls;
 	bool			returns;
 	bool			callchain;
+	bool			add_callchain;
 	bool			thread_stack;
 	bool			last_branch;
 	unsigned int		callchain_sz;
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index d7779e48652f..38a942881d1a 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1079,7 +1079,7 @@ static bool check_auxtrace_itrace(struct itrace_synth_opts *itops)
 		itops->pwr_events || itops->errors ||
 		itops->dont_decode || itops->calls || itops->returns ||
 		itops->callchain || itops->thread_stack ||
-		itops->last_branch;
+		itops->last_branch || itops->add_callchain;
 	if (!ison)
 		return true;
 	pr_err("Unsupported --itrace options specified\n");
-- 
2.17.1

