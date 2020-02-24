Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340EAC35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F155F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582519119;
	bh=C8nmkqVWZ0uI/CFY2FODvJ85+9FdpHTKJQFmOaZxkd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P6TD8uLXfutiQ6JhClJeFw6E1QEOQK4E8hKYlh6lokgkSYNn6xl3OljQ50w1xCpT3
	 xyeP0cTgZBV8x4sGvV4nbHhvB6sGI26L9OCDgoZE7vAhuXnZlDMy9W/eXafcdOQLrS
	 aexxBm6OLCnDFXRxDYp86sIeypm+l4V4Vc7M9PzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgBXEih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44830 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgBXEid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so3511799plo.11;
        Sun, 23 Feb 2020 20:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bkf6Qs7ci8lu0oz3mgFCvqHY9Lyghcvow3vv5vNXGOI=;
        b=e3sQ7oPa4hfEtJJBUpwWOq+kdNSNlV0xpK8jm/eZ6A+V4LQtaQ1J70DDokig/mz7cQ
         oux8DruDbIiBqNNxmyy+yvkKdVGIFX7PtBWQS8tP7Fly5Sua8pR0EOi4aBm5DeILLEVc
         MCgJwk2v+6nmg7VdHUSdpnGWxB3Iw3457oD/R4TySDB/0O/KslA9oAxuFzBoTqJHzff0
         gMzsnCNZQJ5agC7M0QFwdHaUT6J5PNhOviCk9sBpwUMzLJrm7Nbf1IXHa6t1lj/bjnVB
         QlVp8ArDXCGiIHUZVhXuWNKpl2XK4MzTVDfoG8FmxdjhAddAQQQpH//u+8tSHguFqONa
         PDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Bkf6Qs7ci8lu0oz3mgFCvqHY9Lyghcvow3vv5vNXGOI=;
        b=IXqd6ptF9X+AeRw/5An05gu9G2xxLJA0bw00XLexq1ZVjx2m/os5LC4/cFlrA4HBT4
         zzSNux7CoSk+kMYuE9Xa5igydU/Z2/0BB6kaRxxU4bDLnPzqnuyvsrrtMIvWi15BklqG
         hVf9erf6R4Z9GelyaQ6NphkH5qf1vNrJj/zroO4AeMHuS4c6luw2pJjaYmITI+4PRijU
         UFTTzLZfmVgSaEwyMyjByVS/nqPASB8KMgN4YWsj/qZU8T8QF3NMcgBO+XaSg/CWp6oT
         XfaSeUtDdBVvrCgUuhNKN6YFZPwXhO2f8Uedmcy/YsrjqIJQcaXFQmZ63qmsVsBP26N0
         muGQ==
X-Gm-Message-State: APjAAAUood3MM7wPLWbYbQmd3ZQyfPacI5QShftJZPQjtZ/Mamwfz/d5
        PB+CFYs+jgmqeiUseViZ9tI=
X-Google-Smtp-Source: APXvYqws5Mva9l1z/d48Uc0o1rlaMrv58I/q+sLVJsC9NSx3wnPvxjNedOjPhaXtNFv4TkCcA6xPBQ==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr46769157plb.11.1582519112582;
        Sun, 23 Feb 2020 20:38:32 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:32 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 10/10] perf script: Add --show-cgroup-events option
Date:   Mon, 24 Feb 2020 13:37:49 +0900
Message-Id: <20200224043749.69466-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --show-cgroup-events option is to print CGROUP events in the
output like others.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  3 ++
 tools/perf/builtin-script.c              | 41 ++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b057e47b..3dd297600427 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -319,6 +319,9 @@ OPTIONS
 --show-bpf-events
 	Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT.
 
+--show-cgroup-events
+	Display cgroup events i.e. events of type PERF_RECORD_CGROUP.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e2406b291c1c..3db4afc29430 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1681,6 +1681,7 @@ struct perf_script {
 	bool			show_lost_events;
 	bool			show_round_events;
 	bool			show_bpf_events;
+	bool			show_cgroup_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct evswitch		evswitch;
@@ -2199,6 +2200,41 @@ static int process_namespaces_event(struct perf_tool *tool,
 	return ret;
 }
 
+static int process_cgroup_event(struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct thread *thread;
+	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	struct perf_session *session = script->session;
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	int ret = -1;
+
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (thread == NULL) {
+		pr_debug("problem processing CGROUP event, skipping it.\n");
+		return -1;
+	}
+
+	if (perf_event__process_cgroup(tool, event, sample, machine) < 0)
+		goto out;
+
+	if (!evsel->core.attr.sample_id_all) {
+		sample->cpu = 0;
+		sample->time = 0;
+	}
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_CGROUP, stdout);
+		perf_event__fprintf(event, stdout);
+	}
+	ret = 0;
+out:
+	thread__put(thread);
+	return ret;
+}
+
 static int process_fork_event(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
@@ -2538,6 +2574,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
+	if (script->show_cgroup_events)
+		script->tool.cgroup = process_cgroup_event;
 	if (script->show_lost_events)
 		script->tool.lost = process_lost_event;
 	if (script->show_round_events) {
@@ -3463,6 +3501,7 @@ int cmd_script(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.attr		 = process_attr,
@@ -3563,6 +3602,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-cgroup-events", &script.show_cgroup_events,
+		    "Show cgroup events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
 		    "Show lost events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
-- 
2.25.0.265.gbab2e86ba0-goog

