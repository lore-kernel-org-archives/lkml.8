Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA8C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AB120661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgELMUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:20:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:43213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgELMUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:20:08 -0400
IronPort-SDR: 26yi1cLsae6vM5iC5VkAgjDLmfpZC7Z5BKFJbWMJ9XRzoYW4AJhKHXREeD/3O6+AacpdQs0Bj6
 TejxHJqhrxSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:20:08 -0700
IronPort-SDR: nV29K/9smC22w0bcsOXU3i2paQjJSqxj/JGBbgEzkWhRSbgkOeeVw4fsBJiSAv9gz9Bmif2qPr
 6EO70Mbhu8Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879462"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:20:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 15/15] perf script: Show text poke address symbol
Date:   Tue, 12 May 2020 15:19:22 +0300
Message-Id: <20200512121922.8997-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is generally more useful to show the symbol with an address. In this
case, the print function requires the 'machine' which means changing
callers to provide it as a parameter. It is optional because most events
do not need it and the callers that matter can provide it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c    |  4 ++--
 tools/perf/tests/perf-record.c |  4 ++--
 tools/perf/util/event.c        | 23 ++++++++++++++++++-----
 tools/perf/util/event.h        |  6 ++++--
 tools/perf/util/intel-pt.c     |  2 +-
 tools/perf/util/machine.c      |  2 +-
 6 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 35ed8f69ed6a..5bdd1a393399 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2170,7 +2170,7 @@ static int print_event_with_time(struct perf_tool *tool,
 					   event->header.type, stdout);
 	}
 
-	perf_event__fprintf(event, stdout);
+	perf_event__fprintf(machine, event, stdout);
 
 	thread__put(thread);
 
@@ -2305,7 +2305,7 @@ process_finished_round_event(struct perf_tool *tool __maybe_unused,
 			     struct ordered_events *oe __maybe_unused)
 
 {
-	perf_event__fprintf(event, stdout);
+	perf_event__fprintf(NULL, event, stdout);
 	return 0;
 }
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 83adfd846ccd..ff6febf15269 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -185,14 +185,14 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 				err = perf_evlist__parse_sample(evlist, event, &sample);
 				if (err < 0) {
 					if (verbose > 0)
-						perf_event__fprintf(event, stderr);
+						perf_event__fprintf(NULL, event, stderr);
 					pr_debug("Couldn't parse sample\n");
 					goto out_delete_evlist;
 				}
 
 				if (verbose > 0) {
 					pr_info("%" PRIu64" %d ", sample.time, sample.cpu);
-					perf_event__fprintf(event, stderr);
+					perf_event__fprintf(NULL, event, stderr);
 				}
 
 				if (prev_time > sample.time) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index dde2f0147713..4b60cd57ad62 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -440,14 +440,26 @@ static int text_poke_printer(enum binary_printer_ops op, unsigned int val,
 	}
 }
 
-size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp)
+size_t perf_event__fprintf_text_poke(struct machine *machine,
+				     union perf_event *event, FILE *fp)
 {
 	struct perf_record_text_poke_event *tp = &event->text_poke;
 	size_t ret;
 	bool old;
 
-	ret = fprintf(fp, " %" PRI_lx64 " old len %u new len %u\n",
-		      tp->addr, tp->old_len, tp->new_len);
+	ret = fprintf(fp, " %" PRI_lx64 " ", tp->addr);
+	if (machine) {
+		struct addr_location al;
+
+		al.map = maps__find(&machine->kmaps, tp->addr);
+		if (al.map && map__load(al.map) >= 0) {
+			al.addr = al.map->map_ip(al.map, tp->addr);
+			al.sym = map__find_symbol(al.map, al.addr);
+			if (al.sym)
+				ret += symbol__fprintf_symname_offs(al.sym, &al, fp);
+		}
+	}
+	ret += fprintf(fp, " old len %u new len %u\n", tp->old_len, tp->new_len);
 	old = true;
 	ret += binary__fprintf(tp->bytes, tp->old_len, 16, text_poke_printer,
 			       &old, fp);
@@ -457,7 +469,8 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp)
 	return ret;
 }
 
-size_t perf_event__fprintf(union perf_event *event, FILE *fp)
+size_t perf_event__fprintf(struct machine *machine, union perf_event *event,
+			   FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
 			     perf_event__name(event->header.type));
@@ -502,7 +515,7 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 		ret += perf_event__fprintf_bpf(event, fp);
 		break;
 	case PERF_RECORD_TEXT_POKE:
-		ret += perf_event__fprintf_text_poke(event, fp);
+		ret += perf_event__fprintf_text_poke(machine, event, fp);
 		break;
 	default:
 		ret += fprintf(fp, "\n");
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index dbbba6dea51d..611c8e5ad9d9 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -389,8 +389,10 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
-size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp);
-size_t perf_event__fprintf(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_text_poke(struct machine *machine,
+				     union perf_event *event, FILE *fp);
+size_t perf_event__fprintf(struct machine *machine, union perf_event *event,
+			   FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
 				 const char *symbol_name, u64 *addr);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index e2e199a58222..4c6bb45d8200 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -236,7 +236,7 @@ static void intel_pt_log_event(union perf_event *event)
 	if (!intel_pt_enable_logging || !f)
 		return;
 
-	perf_event__fprintf(event, f);
+	perf_event__fprintf(NULL, event, f);
 }
 
 static void intel_pt_dump_sample(struct perf_session *session,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9120d7dc274f..5f52b579b3fe 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -821,7 +821,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 
 	if (dump_trace)
-		perf_event__fprintf_text_poke(event, stdout);
+		perf_event__fprintf_text_poke(machine, event, stdout);
 
 	if (!event->text_poke.new_len)
 		return 0;
-- 
2.17.1

