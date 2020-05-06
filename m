Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD41C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A56A20CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778721;
	bh=GGRIseQMktZJlY52mt7ANKHySNFZCqQzsSlXLeEJyME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DlZfNOUotGfXF+HQH8uBUkYi8DsHjU5Ij/ei4OVgHhpdu8J0gIOIuHFDUOzAm8g/G
	 KvMV1rHgUiX2PmCovRU5XKK5Xx4E5Qls2kaHRe7ZUuh0UjH8kmjM1Z5RKLoSuGiBGJ
	 d5xdy5HC4Hq2fCXrGKv/fUV3/m53iH/OIM1tQSss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgEFPZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgEFPZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1856221775;
        Wed,  6 May 2020 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778717;
        bh=GGRIseQMktZJlY52mt7ANKHySNFZCqQzsSlXLeEJyME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIEsaoedLY3WXFlfFU7twkbzDVuDrbo9RWaH0UMzSTNuPZ5+1EhzH2IUMHCCeTACG
         2YhCKGOmxbOizNrsSU82m6eOzKuwcxrMvc+iG44Lnm61Nzo4NYZaSHS0x9bHAzVLbN
         Vg5lwZw6ruDWuOyx4cJVdDJ6gpeiI6A9ECPChd+A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 42/91] perf auxtrace: Add option to synthesize branch stack for regular events
Date:   Wed,  6 May 2020 12:21:45 -0300
Message-Id: <20200506152234.21977-43-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

There is an existing option to synthesize branch stacks for synthesized
events. Add a new option to synthesize branch stacks for regular events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 7da1342a1f4e..0eea667bfb76 100644
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
index ac6e09965a78..83ea7ca24686 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1464,8 +1464,12 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
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
2.21.1

