Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465EAC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFBD21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDVMSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728686AbgDVMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4028C03C1A8;
        Wed, 22 Apr 2020 05:17:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJo-0007nb-9Y; Wed, 22 Apr 2020 14:17:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E9AC11C02FC;
        Wed, 22 Apr 2020 14:17:23 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:23 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: Add an option to synthesize
 callchains for regular events
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-9-adrian.hunter@intel.com>
References: <20200401101613.6201-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784355.28353.8738282978125640759.tip-bot2@tip-bot2>
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

Commit-ID:     1c5c25b3fdbd7035f6d53a1a99b5afd577ce13e1
Gitweb:        https://git.kernel.org/tip/1c5c25b3fdbd7035f6d53a1a99b5afd577ce13e1
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:05 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:15 -03:00

perf auxtrace: Add an option to synthesize callchains for regular events

Currently, callchains can be synthesized only for synthesized events. Add
an itrace option to synthesize callchains for regular events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/builtin-report.c         | 3 ++-
 tools/perf/builtin-script.c         | 2 +-
 tools/perf/util/auxtrace.c          | 6 +++++-
 tools/perf/util/auxtrace.h          | 2 ++
 tools/perf/util/s390-cpumsf.c       | 2 +-
 6 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 82ff7da..671e154 100644
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
index 26d8fc2..c0cebd5 100644
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
index 8bf3ba2..06b511c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3537,7 +3537,7 @@ int cmd_script(int argc, const char **argv)
 		return -1;
 	}
 
-	if (itrace_synth_opts.callchain &&
+	if ((itrace_synth_opts.callchain || itrace_synth_opts.add_callchain) &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b60bae8..809a09e 100644
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
index db65aae..dd8a4ff 100644
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
index d7779e4..38a9428 100644
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
