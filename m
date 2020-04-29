Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57950C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE7C21973
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgD2PHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:07:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:48798 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgD2PHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:43 -0400
IronPort-SDR: mDOM8UBE0HkS/wgq8FEvvaIQHmYqXQkEd6AOLrpM/XawUHjFGXBxmEtb9fCzF6ViUlc2+LTlfH
 cq38ejcu30Kg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:43 -0700
IronPort-SDR: gwH4HLAf4wSHQFLXuB/8JdqYU/AuACZznt1kNp6/qVdl9NBLJOfSmUhnttM83zE6V/lIo8HtNu
 vliR1+diZh3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227458"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] perf intel-pt: Update documentation about itrace G and L options
Date:   Wed, 29 Apr 2020 18:07:50 +0300
Message-Id: <20200429150751.12570-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a little more information about the new G and L options,
particularly the issue with large PEBs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt        |  4 +++
 tools/perf/Documentation/perf-intel-pt.txt | 35 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 0326050beebd..271484754fee 100644
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
index 456fdcbf26ac..782eb8a65caf 100644
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
-- 
2.17.1

