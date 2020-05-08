Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E71C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C71F249DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgEHNFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730480AbgEHNFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7847AC05BD43;
        Fri,  8 May 2020 06:05:18 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gf-0007Xm-Pn; Fri, 08 May 2020 15:05:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BE5511C0853;
        Fri,  8 May 2020 15:04:58 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:58 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: Add option to synthesize branch stack
 for regular events
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429150751.12570-5-adrian.hunter@intel.com>
References: <20200429150751.12570-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158894309864.8414.18276494350093192357.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ec90e42ce5142c4ed2a0061fe23bd4495428c52b
Gitweb:        https://git.kernel.org/tip/ec90e42ce5142c4ed2a0061fe23bd4495428c52b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 29 Apr 2020 18:07:46 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf auxtrace: Add option to synthesize branch stack for regular events

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
index 671e154..0326050 100644
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
index 7e124a7..7c4403c 100644
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
index 7da1342..0eea667 100644
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
@@ -1393,7 +1394,7 @@ repeat:
 		goto error;
 	}
 
-	if (itrace_synth_opts.last_branch)
+	if (itrace_synth_opts.last_branch || itrace_synth_opts.add_last_branch)
 		has_br_stack = true;
 
 	if (has_br_stack && branch_call_mode)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ac6e099..83ea7ca 100644
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
index dd8a4ff..0220a2e 100644
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
index 38a9428..f886199 100644
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
