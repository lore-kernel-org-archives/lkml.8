Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB6BC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7FB2072F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDEUPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:15:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgDEUPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:15:20 -0400
IronPort-SDR: PXZ8KCEteAetootYes+dYhlB86PExdcB5lC41vGYrtipyhgERwWooGRsd9wNflPaJru/KitBrp
 lUhHDQBA535g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 13:15:18 -0700
IronPort-SDR: dBXRgQldgR9pIeoVjT6ODwhazChjNxVoS965VypPWhsbDT9oV6mAAgxjkaM2IPcMmWUGs4Tg7N
 96U3GT0TYfTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329688521"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 13:15:15 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V6 15/15] perf script: Show text poke address symbol
Date:   Sun,  5 Apr 2020 23:13:27 +0300
Message-Id: <20200405201327.7332-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
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
index e934bf46269d..f06470e8f07b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2168,7 +2168,7 @@ static int print_event_with_time(struct perf_tool *tool,
 					   event->header.type, stdout);
 	}
 
-	perf_event__fprintf(event, stdout);
+	perf_event__fprintf(machine, event, stdout);
 
 	thread__put(thread);
 
@@ -2303,7 +2303,7 @@ process_finished_round_event(struct perf_tool *tool __maybe_unused,
 			     struct ordered_events *oe __maybe_unused)
 
 {
-	perf_event__fprintf(event, stdout);
+	perf_event__fprintf(NULL, event, stdout);
 	return 0;
 }
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 2195fc205e72..a187a70b4a98 100644
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
index cdaf58734254..e151df9b28d7 100644
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
index 470a3b413869..902f85ded944 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -230,7 +230,7 @@ static void intel_pt_log_event(union perf_event *event)
 	if (!intel_pt_enable_logging || !f)
 		return;
 
-	perf_event__fprintf(event, f);
+	perf_event__fprintf(NULL, event, f);
 }
 
 static void intel_pt_dump_sample(struct perf_session *session,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8447334ac056..4c023667a073 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -809,7 +809,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
 	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 
 	if (dump_trace)
-		perf_event__fprintf_text_poke(event, stdout);
+		perf_event__fprintf_text_poke(machine, event, stdout);
 
 	if (!event->text_poke.new_len)
 		return 0;
-- 
2.17.1

