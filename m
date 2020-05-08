Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E59C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E78524970
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgEHNJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730484AbgEHNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47DC05BD09;
        Fri,  8 May 2020 06:05:19 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gj-0007XG-AD; Fri, 08 May 2020 15:05:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 14A1A1C04CD;
        Fri,  8 May 2020 15:04:57 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:56 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf intel-pt: Update documentation about itrace G
 and L options
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429150751.12570-9-adrian.hunter@intel.com>
References: <20200429150751.12570-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158894309698.8414.1804138023783833053.tip-bot2@tip-bot2>
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

Commit-ID:     43358d9dfb250842383cddad816a7538548a5070
Gitweb:        https://git.kernel.org/tip/43358d9dfb250842383cddad816a7538548a5070
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 29 Apr 2020 18:07:50 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf intel-pt: Update documentation about itrace G and L options

Provide a little more information about the new G and L options,
particularly the issue with large PEBs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/itrace.txt        |  4 ++-
 tools/perf/Documentation/perf-intel-pt.txt | 35 +++++++++++++++++++++-
 2 files changed, 39 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 0326050..2714847 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -33,6 +33,10 @@
 	Also the number of last branch entries (default 64, max. 1024) for
 	instructions or transactions events can be specified.
 
+	Similar to options g and l, size may also be specified for options G and L.
+	On x86, note that G and L work poorly when data has been recorded with
+	large PEBS. Refer linkperf:perf-intel-pt[1] man page for details.
+
 	It is also possible to skip events generated (instructions, branches, transactions,
 	ptwrite, power) at the beginning. This is useful to ignore initialization code.
 
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 456fdcb..782eb8a 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -821,7 +821,9 @@ The letters are:
 	e	synthesize tracing error events
 	d	create a debug log
 	g	synthesize a call chain (use with i or x)
+	G	synthesize a call chain on existing event records
 	l	synthesize last branch entries (use with i or x)
+	L	synthesize last branch entries on existing event records
 	s	skip initial number of events
 
 "Instructions" events look like they were recorded by "perf record -e
@@ -912,6 +914,39 @@ transactions events can be specified. e.g.
 Note that last branch entries are cleared for each sample, so there is no overlap
 from one sample to the next.
 
+The G and L options are designed in particular for sample mode, and work much
+like g and l but add call chain and branch stack to the other selected events
+instead of synthesized events. For example, to record branch-misses events for
+'ls' and then add a call chain derived from the Intel PT trace:
+
+	perf record --aux-sample -e '{intel_pt//u,branch-misses:u}' -- ls
+	perf report --itrace=Ge
+
+Although in fact G is a default for perf report, so that is the same as just:
+
+	perf report
+
+One caveat with the G and L options is that they work poorly with "Large PEBS".
+Large PEBS means PEBS records will be accumulated by hardware and the written
+into the event buffer in one go.  That reduces interrupts, but can give very
+late timestamps.  Because the Intel PT trace is synchronized by timestamps,
+the PEBS events do not match the trace.  Currently, Large PEBS is used only in
+certain circumstances:
+	- hardware supports it
+	- PEBS is used
+	- event period is specified, instead of frequency
+	- the sample type is limited to the following flags:
+		PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_ADDR |
+		PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID |
+		PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER |
+		PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR |
+		PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER |
+		PERF_SAMPLE_PERIOD (and sometimes) | PERF_SAMPLE_TIME
+Because Intel PT sample mode uses a different sample type to the list above,
+Large PEBS is not used with Intel PT sample mode. To avoid Large PEBS in other
+cases, avoid specifying the event period i.e. avoid the 'perf record' -c option,
+--count option, or 'period' config term.
+
 To disable trace decoding entirely, use the option --no-itrace.
 
 It is also possible to skip events generated (instructions, branches, transactions)
