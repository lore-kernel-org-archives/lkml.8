Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A5C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079982072F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgDEUPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:15:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgDEUPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:15:16 -0400
IronPort-SDR: voZa227GW8y0gMGFNU4NNg/vT2LZMNhZquSQS+MVuSqsJAO3sqwOG5Wf2Na7JlzPaJKSfeu0TX
 vvGGnIY0AhdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 13:15:14 -0700
IronPort-SDR: 9ZpTMo41sj7frxYVp7HlfTKruhr3L84Z3z9XY43x8pwKPSUF4SOYA4gwdbxzXf1gR53mPfQOq4
 nUAbQ231/MbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329688515"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 13:15:11 -0700
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
Subject: [PATCH V6 14/15] perf script: Add option --show-text-poke-events
Date:   Sun,  5 Apr 2020 23:13:26 +0300
Message-Id: <20200405201327.7332-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistent with other new events, add an option to perf script to display
text poke events and ksymbol events. Both text poke events and ksymbol
events are displayed because some text pokes (e.g. ftrace trampolines) have
corresponding ksymbol events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-script.txt |  4 ++++
 tools/perf/builtin-script.c              | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 99a9853a11ba..8fe507d69f95 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -322,6 +322,10 @@ OPTIONS
 --show-cgroup-events
 	Display cgroup events i.e. events of type PERF_RECORD_CGROUP.
 
+--show-text-poke-events
+	Display text poke events i.e. events of type PERF_RECORD_TEXT_POKE and
+	PERF_RECORD_KSYMBOL.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 348fec9743a4..e934bf46269d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1695,6 +1695,7 @@ struct perf_script {
 	bool			show_round_events;
 	bool			show_bpf_events;
 	bool			show_cgroup_events;
+	bool			show_text_poke_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct evswitch		evswitch;
@@ -2319,6 +2320,18 @@ process_bpf_events(struct perf_tool *tool __maybe_unused,
 			   sample->tid);
 }
 
+static int process_text_poke_events(struct perf_tool *tool,
+				    union perf_event *event,
+				    struct perf_sample *sample,
+				    struct machine *machine)
+{
+	if (perf_event__process_text_poke(tool, event, sample, machine) < 0)
+		return -1;
+
+	return print_event(tool, event, sample, machine, sample->pid,
+			   sample->tid);
+}
+
 static void sig_handler(int sig __maybe_unused)
 {
 	session_done = 1;
@@ -2427,6 +2440,10 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.ksymbol = process_bpf_events;
 		script->tool.bpf     = process_bpf_events;
 	}
+	if (script->show_text_poke_events) {
+		script->tool.ksymbol   = process_bpf_events;
+		script->tool.text_poke = process_text_poke_events;
+	}
 
 	if (perf_script__setup_per_event_dump(script)) {
 		pr_err("Couldn't create the per event dump files\n");
@@ -3452,6 +3469,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show round events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-bpf-events", &script.show_bpf_events,
 		    "Show bpf related events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-text-poke-events", &script.show_text_poke_events,
+		    "Show text poke related events (if recorded)"),
 	OPT_BOOLEAN('\0', "per-event-dump", &script.per_event_dump,
 		    "Dump trace output to files named by the monitored events"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
-- 
2.17.1

