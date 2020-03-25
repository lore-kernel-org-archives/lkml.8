Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27765C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CA520775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140379;
	bh=DPiVu0t8sMc0c3QIhOtlhQ/w+i9viQKaMJRH4mgeN2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IR+K5V11ZMTePJxVm2HSBbaHpA0hwcefgQUX2hV/PONRuiw2J2FGEEoQh1RzNS4Fp
	 89nMwCG8ptt+tX5BxlereXLNqj4YSxDn0Dtqq1KE0orKUF1qm658V2j8wUDh4OR5FA
	 uHjRaDhBD9v1gbuLCkc85EIKIYe0kK+/UR8lT7kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgCYMqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:46:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39731 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCYMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:46:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id m1so762233pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpM0lmi5cvBD21brmsnNLQXs+vFEHjg1A/hdVqoEFN8=;
        b=T5XW1n1SVYU1iF4/QiBF/6I6dDOziS3mR9WhDoPF+bfmYddX1+/0Y5bp2EYI+A5Ohc
         wt/QitYVgI5kxQA3Dw3Ueeiz7nfj819oXFNK/JYdLUWaEdzRxFLMzY3JjdK2cGImR+fs
         +6bwwdT51hlgiHR85OyrY7CFDS628ly90bCnDl+AZi9+laWAMi1M1JU6Lu9cttoYbbmd
         YTZFhJLZPf0ZfwdOcEKzZiL+fVCo3YpoyvcsyZ7JNdk1egrd7m/xfVn1TIhWW9ckG6FO
         NwXYMzb5p68HZlb79aeQQR2UlTVjtvUHDffYC9h7yICYsu97YmIaLbpJlEczFt2J6mr+
         +wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WpM0lmi5cvBD21brmsnNLQXs+vFEHjg1A/hdVqoEFN8=;
        b=TDTNXtWWFkqiipzPTIX2RsvS4Owp9GqxugubzJYuNPGrhn/qAsJIMHBSFB5U8uFwfo
         g8zZF1jaVcFQLHC57m4vqZdZRw8mAMdZexw+u8V/0XUBzbYo3XdhVTOneFJ/JAO6BZow
         91qYy8V/Zyrgxye8m+zy2t/8mQlOu0U5foJ3cCwJiDnAuWu8rLcvlSEZ6SVY2jgCpA75
         eolj0F+hnZJOGbJ5LCXrpyYsFAVYi9m5UFDr4k51Y2iVkE+5cyhYrYrFO4li65SQ9mOp
         py8JrXMEQ1XL6z3U8uT7wmtAuo/96CsqLTcf56/lhP/oR8tlkQLJvoN5+74dq23M64Hb
         5ufQ==
X-Gm-Message-State: ANhLgQ22WlYCukt+Ln0MgllLVKaN/SxzIjkyvGWqzugrrheN8177zK7S
        slQRx2BUSev3725t5mgrVlM=
X-Google-Smtp-Source: ADFU+vv5r7s2fgJnpHVOJsnaMlkeoKfTaZUBYZoIxfYsCfRS5gZ0BE8ampM2w4/W8bRghUF54bbItw==
X-Received: by 2002:a17:90a:cb87:: with SMTP id a7mr3552742pju.114.1585140373192;
        Wed, 25 Mar 2020 05:46:13 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:46:12 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 9/9] perf script: Add --show-cgroup-events option
Date:   Wed, 25 Mar 2020 21:45:36 +0900
Message-Id: <20200325124536.2800725-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
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
index db6a36aac47e..515ff9f6af30 100644
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
index 656b347f6dd8..6cc2d1da6ece 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1685,6 +1685,7 @@ struct perf_script {
 	bool			show_lost_events;
 	bool			show_round_events;
 	bool			show_bpf_events;
+	bool			show_cgroup_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct evswitch		evswitch;
@@ -2203,6 +2204,41 @@ static int process_namespaces_event(struct perf_tool *tool,
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
@@ -2542,6 +2578,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
+	if (script->show_cgroup_events)
+		script->tool.cgroup = process_cgroup_event;
 	if (script->show_lost_events)
 		script->tool.lost = process_lost_event;
 	if (script->show_round_events) {
@@ -3467,6 +3505,7 @@ int cmd_script(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.attr		 = process_attr,
@@ -3567,6 +3606,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-cgroup-events", &script.show_cgroup_events,
+		    "Show cgroup events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
 		    "Show lost events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
-- 
2.25.1.696.g5e7596f4ac-goog

