Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC428C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46A920661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgELMUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:20:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:43213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgELMUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:20:04 -0400
IronPort-SDR: ncOjIPukHrrJ+C6NCOWLCMNIVdnU8SU5jZzcPjzr0vFT6kFCT3z9th/k6JO/IaqV+EOjzzBKwq
 GUADhVpqFaTw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:20:04 -0700
IronPort-SDR: L3DdxBc6+DJULanXfzBVFfEJtwP0E0MusXsOPNTV+r2yzi8Umdf2sKFu4qteeiCFT8EjrmHfUk
 x7dXSRLDpbnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879437"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:20:00 -0700
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
Subject: [PATCH V7 14/15] perf script: Add option --show-text-poke-events
Date:   Tue, 12 May 2020 15:19:21 +0300
Message-Id: <20200512121922.8997-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
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
index 372dfd110e6d..4f712fb8f175 100644
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
index ecc8bd4c5e57..35ed8f69ed6a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1678,6 +1678,7 @@ struct perf_script {
 	bool			show_round_events;
 	bool			show_bpf_events;
 	bool			show_cgroup_events;
+	bool			show_text_poke_events;
 	bool			allocated;
 	bool			per_event_dump;
 	bool			stitch_lbr;
@@ -2321,6 +2322,18 @@ process_bpf_events(struct perf_tool *tool __maybe_unused,
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
@@ -2429,6 +2442,10 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.ksymbol = process_bpf_events;
 		script->tool.bpf     = process_bpf_events;
 	}
+	if (script->show_text_poke_events) {
+		script->tool.ksymbol   = process_bpf_events;
+		script->tool.text_poke = process_text_poke_events;
+	}
 
 	if (perf_script__setup_per_event_dump(script)) {
 		pr_err("Couldn't create the per event dump files\n");
@@ -3460,6 +3477,8 @@ int cmd_script(int argc, const char **argv)
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

