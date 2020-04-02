Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE9C2074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbgDBOQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:16:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:63065 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgDBOQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:16:35 -0400
IronPort-SDR: d1MsRC7ROMMmQJka7buFkcKVWUiWVL6IUtNhZkg6lhz5+iuTLBnVr7I16lUaHv5NEoYrY3HqLc
 SNt4tTcSVW8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 07:16:34 -0700
IronPort-SDR: QcElm/xU0iQf6/kgR9+sI9A2AgJBz8gJNYz7V87X917hU05Gdrnq3q+KPSUOZN+RE00WJBaZ9k
 AK9lAkFpJhzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="450945000"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2020 07:16:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf script: Simplify auxiliary event printing functions
Date:   Thu,  2 Apr 2020 17:15:48 +0300
Message-Id: <20200402141548.21283-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the print functions for the following perf script
options:

	--show-task-events
	--show-namespace-events
	--show-cgroup-events
	--show-mmap-events
	--show-switch-events
	--show-lost-events
	--show-bpf-events

Example:
	# perf record --switch-events -a -e cycles -c 10000 sleep 1
 Before:
	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-before.txt
 After:
	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-after.txt
	# diff -s out-before.txt out-after.txt
	Files out-before.txt and out-after.tx are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 304 ++++++++----------------------------
 1 file changed, 66 insertions(+), 238 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 186ebf827fa1..348fec9743a4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2040,7 +2040,7 @@ static int cleanup_scripting(void)
 
 static bool filter_cpu(struct perf_sample *sample)
 {
-	if (cpu_list)
+	if (cpu_list && sample->cpu != (u32)-1)
 		return !test_bit(sample->cpu, cpu_bitmap);
 	return false;
 }
@@ -2138,41 +2138,59 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	return err;
 }
 
-static int process_comm_event(struct perf_tool *tool,
-			      union perf_event *event,
-			      struct perf_sample *sample,
-			      struct machine *machine)
+static int print_event_with_time(struct perf_tool *tool,
+				 union perf_event *event,
+				 struct perf_sample *sample,
+				 struct machine *machine,
+				 pid_t pid, pid_t tid, u64 timestamp)
 {
-	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-	int ret = -1;
+	struct thread *thread = NULL;
 
-	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing COMM event, skipping it.\n");
-		return -1;
+	if (evsel && !evsel->core.attr.sample_id_all) {
+		sample->cpu = 0;
+		sample->time = timestamp;
+		sample->pid = pid;
+		sample->tid = tid;
 	}
 
-	if (perf_event__process_comm(tool, event, sample, machine) < 0)
-		goto out;
+	if (filter_cpu(sample))
+		return 0;
 
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->comm.tid;
-		sample->pid = event->comm.pid;
-	}
-	if (!filter_cpu(sample)) {
+	if (tid != -1)
+		thread = machine__findnew_thread(machine, pid, tid);
+
+	if (thread && evsel) {
 		perf_sample__fprintf_start(sample, thread, evsel,
-				   PERF_RECORD_COMM, stdout);
-		perf_event__fprintf(event, stdout);
+					   event->header.type, stdout);
 	}
-	ret = 0;
-out:
+
+	perf_event__fprintf(event, stdout);
+
 	thread__put(thread);
-	return ret;
+
+	return 0;
+}
+
+static int print_event(struct perf_tool *tool, union perf_event *event,
+		       struct perf_sample *sample, struct machine *machine,
+		       pid_t pid, pid_t tid)
+{
+	return print_event_with_time(tool, event, sample, machine, pid, tid, 0);
+}
+
+static int process_comm_event(struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct machine *machine)
+{
+	if (perf_event__process_comm(tool, event, sample, machine) < 0)
+		return -1;
+
+	return print_event(tool, event, sample, machine, event->comm.pid,
+			   event->comm.tid);
 }
 
 static int process_namespaces_event(struct perf_tool *tool,
@@ -2180,37 +2198,11 @@ static int process_namespaces_event(struct perf_tool *tool,
 				    struct perf_sample *sample,
 				    struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-	int ret = -1;
-
-	thread = machine__findnew_thread(machine, event->namespaces.pid,
-					 event->namespaces.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing NAMESPACES event, skipping it.\n");
-		return -1;
-	}
-
 	if (perf_event__process_namespaces(tool, event, sample, machine) < 0)
-		goto out;
+		return -1;
 
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->namespaces.tid;
-		sample->pid = event->namespaces.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_NAMESPACES, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	ret = 0;
-out:
-	thread__put(thread);
-	return ret;
+	return print_event(tool, event, sample, machine, event->namespaces.pid,
+			   event->namespaces.tid);
 }
 
 static int process_cgroup_event(struct perf_tool *tool,
@@ -2218,34 +2210,11 @@ static int process_cgroup_event(struct perf_tool *tool,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-	int ret = -1;
-
-	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
-	if (thread == NULL) {
-		pr_debug("problem processing CGROUP event, skipping it.\n");
-		return -1;
-	}
-
 	if (perf_event__process_cgroup(tool, event, sample, machine) < 0)
-		goto out;
+		return -1;
 
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_CGROUP, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	ret = 0;
-out:
-	thread__put(thread);
-	return ret;
+	return print_event(tool, event, sample, machine, sample->pid,
+			    sample->tid);
 }
 
 static int process_fork_event(struct perf_tool *tool,
@@ -2253,69 +2222,24 @@ static int process_fork_event(struct perf_tool *tool,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
 	if (perf_event__process_fork(tool, event, sample, machine) < 0)
 		return -1;
 
-	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing FORK event, skipping it.\n");
-		return -1;
-	}
-
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = event->fork.time;
-		sample->tid = event->fork.tid;
-		sample->pid = event->fork.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_FORK, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-
-	return 0;
+	return print_event_with_time(tool, event, sample, machine,
+				     event->fork.pid, event->fork.tid,
+				     event->fork.time);
 }
 static int process_exit_event(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
-	int err = 0;
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
-	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing EXIT event, skipping it.\n");
+	/* Print before 'exit' deletes anything */
+	if (print_event_with_time(tool, event, sample, machine, event->fork.pid,
+				  event->fork.tid, event->fork.time))
 		return -1;
-	}
-
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->fork.tid;
-		sample->pid = event->fork.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_EXIT, stdout);
-		perf_event__fprintf(event, stdout);
-	}
 
-	if (perf_event__process_exit(tool, event, sample, machine) < 0)
-		err = -1;
-
-	thread__put(thread);
-	return err;
+	return perf_event__process_exit(tool, event, sample, machine);
 }
 
 static int process_mmap_event(struct perf_tool *tool,
@@ -2323,33 +2247,11 @@ static int process_mmap_event(struct perf_tool *tool,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
 	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
 		return -1;
 
-	thread = machine__findnew_thread(machine, event->mmap.pid, event->mmap.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing MMAP event, skipping it.\n");
-		return -1;
-	}
-
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->mmap.tid;
-		sample->pid = event->mmap.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_MMAP, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, event->mmap.pid,
+			   event->mmap.tid);
 }
 
 static int process_mmap2_event(struct perf_tool *tool,
@@ -2357,33 +2259,11 @@ static int process_mmap2_event(struct perf_tool *tool,
 			      struct perf_sample *sample,
 			      struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
 	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
 		return -1;
 
-	thread = machine__findnew_thread(machine, event->mmap2.pid, event->mmap2.tid);
-	if (thread == NULL) {
-		pr_debug("problem processing MMAP2 event, skipping it.\n");
-		return -1;
-	}
-
-	if (!evsel->core.attr.sample_id_all) {
-		sample->cpu = 0;
-		sample->time = 0;
-		sample->tid = event->mmap2.tid;
-		sample->pid = event->mmap2.pid;
-	}
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_MMAP2, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, event->mmap2.pid,
+			   event->mmap2.tid);
 }
 
 static int process_switch_event(struct perf_tool *tool,
@@ -2391,10 +2271,7 @@ static int process_switch_event(struct perf_tool *tool,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	struct thread *thread;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
@@ -2405,20 +2282,8 @@ static int process_switch_event(struct perf_tool *tool,
 	if (!script->show_switch_events)
 		return 0;
 
-	thread = machine__findnew_thread(machine, sample->pid,
-					 sample->tid);
-	if (thread == NULL) {
-		pr_debug("problem processing SWITCH event, skipping it.\n");
-		return -1;
-	}
-
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_SWITCH, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, sample->pid,
+			   sample->tid);
 }
 
 static int
@@ -2427,23 +2292,8 @@ process_lost_event(struct perf_tool *tool,
 		   struct perf_sample *sample,
 		   struct machine *machine)
 {
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-	struct thread *thread;
-
-	thread = machine__findnew_thread(machine, sample->pid,
-					 sample->tid);
-	if (thread == NULL)
-		return -1;
-
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   PERF_RECORD_LOST, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, sample->pid,
+			   sample->tid);
 }
 
 static int
@@ -2462,33 +2312,11 @@ process_bpf_events(struct perf_tool *tool __maybe_unused,
 		   struct perf_sample *sample,
 		   struct machine *machine)
 {
-	struct thread *thread;
-	struct perf_script *script = container_of(tool, struct perf_script, tool);
-	struct perf_session *session = script->session;
-	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
 	if (machine__process_ksymbol(machine, event, sample) < 0)
 		return -1;
 
-	if (!evsel->core.attr.sample_id_all) {
-		perf_event__fprintf(event, stdout);
-		return 0;
-	}
-
-	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
-	if (thread == NULL) {
-		pr_debug("problem processing MMAP event, skipping it.\n");
-		return -1;
-	}
-
-	if (!filter_cpu(sample)) {
-		perf_sample__fprintf_start(sample, thread, evsel,
-					   event->header.type, stdout);
-		perf_event__fprintf(event, stdout);
-	}
-
-	thread__put(thread);
-	return 0;
+	return print_event(tool, event, sample, machine, sample->pid,
+			   sample->tid);
 }
 
 static void sig_handler(int sig __maybe_unused)
-- 
2.17.1

