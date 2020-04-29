Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CECC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB2221974
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgD2PHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:07:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:48789 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2PHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:37 -0400
IronPort-SDR: WQBCy7x/ygT3JdbxFV72+c6fo3b18rVOjYWry9VDNLx5l0bU2LNfYz2a4gn2Gcw50hz0z72qUy
 nfVGDTNxvgwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:36 -0700
IronPort-SDR: u8G+BeMhcQOIgRNV9e61MHs89ge6svawnTxtrRIkWQEnCRME4SyAV133Fg48QdRxxL8J4UkpL7
 8pR50Gg6yFiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227413"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] perf auxtrace: Add option to synthesize branch stack for regular events
Date:   Wed, 29 Apr 2020 18:07:46 +0300
Message-Id: <20200429150751.12570-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an existing option to synthesize branch stacks for synthesized
events. Add a new option to synthesize branch stacks for regular events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/builtin-inject.c         | 3 ++-
 tools/perf/builtin-report.c         | 5 +++--
 tools/perf/util/auxtrace.c          | 6 +++++-
 tools/perf/util/auxtrace.h          | 2 ++
 tools/perf/util/s390-cpumsf.c       | 3 ++-
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 671e154ede03..0326050beebd 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -12,6 +12,7 @@
 		g	synthesize a call chain (use with i or x)
 		G	synthesize a call chain on existing event records
 		l	synthesize last branch entries (use with i or x)
+		L	synthesize last branch entries on existing event records
 		s       skip initial number of events
 
 	The default is all events i.e. the same as --itrace=ibxwpe,
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 7e124a7b8bfd..7c4403cf8dcb 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -684,7 +684,8 @@ static int __cmd_inject(struct perf_inject *inject)
 
 			perf_header__clear_feat(&session->header,
 						HEADER_AUXTRACE);
-			if (inject->itrace_synth_opts.last_branch)
+			if (inject->itrace_synth_opts.last_branch ||
+			    inject->itrace_synth_opts.add_last_branch)
 				perf_header__set_feat(&session->header,
 						      HEADER_BRANCH_STACK);
 			evsel = perf_evlist__id2evsel_strict(session->evlist,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0c32767b1c56..736a54f8e2fc 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -349,7 +349,8 @@ static int report__setup_sample_type(struct report *rep)
 	     !session->itrace_synth_opts->set))
 		sample_type |= PERF_SAMPLE_CALLCHAIN;
 
-	if (session->itrace_synth_opts->last_branch)
+	if (session->itrace_synth_opts->last_branch ||
+	    session->itrace_synth_opts->add_last_branch)
 		sample_type |= PERF_SAMPLE_BRANCH_STACK;
 
 	if (!is_pipe && !(sample_type & PERF_SAMPLE_CALLCHAIN)) {
@@ -1393,7 +1394,7 @@ int cmd_report(int argc, const char **argv)
 		goto error;
 	}
 
-	if (itrace_synth_opts.last_branch)
+	if (itrace_synth_opts.last_branch || itrace_synth_opts.add_last_branch)
 		has_br_stack = true;
 
 	if (has_br_stack && branch_call_mode)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 33ad33378a90..21d5eddda532 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1463,8 +1463,12 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 				synth_opts->callchain_sz = val;
 			}
 			break;
+		case 'L':
 		case 'l':
-			synth_opts->last_branch = true;
+			if (p[-1] == 'L')
+				synth_opts->add_last_branch = true;
+			else
+				synth_opts->last_branch = true;
 			synth_opts->last_branch_sz =
 					PERF_ITRACE_DEFAULT_LAST_BRANCH_SZ;
 			while (*p == ' ' || *p == ',')
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index dd8a4ff8209e..0220a2e86c16 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -77,6 +77,7 @@ enum itrace_period_type {
  * @add_callchain: add callchain to existing event records
  * @thread_stack: feed branches to the thread_stack
  * @last_branch: add branch context to 'instruction' events
+ * @add_last_branch: add branch context to existing event records
  * @callchain_sz: maximum callchain size
  * @last_branch_sz: branch context size
  * @period: 'instructions' events period
@@ -105,6 +106,7 @@ struct itrace_synth_opts {
 	bool			add_callchain;
 	bool			thread_stack;
 	bool			last_branch;
+	bool			add_last_branch;
 	unsigned int		callchain_sz;
 	unsigned int		last_branch_sz;
 	unsigned long long	period;
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 38a942881d1a..f8861998e5bd 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1079,7 +1079,8 @@ static bool check_auxtrace_itrace(struct itrace_synth_opts *itops)
 		itops->pwr_events || itops->errors ||
 		itops->dont_decode || itops->calls || itops->returns ||
 		itops->callchain || itops->thread_stack ||
-		itops->last_branch || itops->add_callchain;
+		itops->last_branch || itops->add_callchain ||
+		itops->add_last_branch;
 	if (!ison)
 		return true;
 	pr_err("Unsupported --itrace options specified\n");
-- 
2.17.1

