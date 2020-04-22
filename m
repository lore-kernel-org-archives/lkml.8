Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3D0C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A252098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgDVMUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728765AbgDVMRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641A0C03C1AA;
        Wed, 22 Apr 2020 05:17:42 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJt-0007yg-SG; Wed, 22 Apr 2020 14:17:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 79DAB1C0823;
        Wed, 22 Apr 2020 14:17:31 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:31 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf script: Simplify auxiliary event printing functions
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402141548.21283-1-adrian.hunter@intel.com>
References: <20200402141548.21283-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755785108.28353.16455054125421171925.tip-bot2@tip-bot2>
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

Commit-ID:     1a2725f3ee5571cf07966f467b73a9941bcbacb8
Gitweb:        https://git.kernel.org/tip/1a2725f3ee5571cf07966f467b73a9941bcbacb8
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 Apr 2020 17:15:48 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:12 -03:00

perf script: Simplify auxiliary event printing functions

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
	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events > out-before.txt
 After:
	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events > out-after.txt
	# diff -s out-before.txt out-after.txt
	Files out-before.txt and out-after.tx are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200402141548.21283-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 304 +++++++----------------------------
 1 file changed, 66 insertions(+), 238 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1f57a7e..8bf3ba2 100644
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
