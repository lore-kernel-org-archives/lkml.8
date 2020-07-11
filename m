Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCE4C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166202076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZBskFKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgGKMnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGKMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2FCC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so3778164pgf.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPDdQLvTOE2rq+0aChRTrKWJk9zNAk+PpV2D0pKiyBY=;
        b=NZBskFKkn300fPkha8xVWU+2VyfWCqTZRe/OnamWZZpNJkIfDijqokK8pzKUu73NuC
         qQ2ZfjuXKgUGBmzyEfWMJmCWRLUqWdUPAa8NMDl/6L+LbnpOorx90A5JAulFEWnuq6R/
         zgvQAeBjcLDHyqiaeqdg5cHQY/d+/0Ns01mdbRiIBCsglZ0KKCYzJjSw+44QyIAGDaZ7
         m0XbSZIVk0XOq+zipzpOe+IvoyxyO7EMBMCcOi/a5775HrWgxEknW3XYV/ptQOifX8ZN
         2zPmtZMekAyJWEQZbL5suOZ33xUrb67oiMejEI+bktiWf7WLqGvf72qJXAZIYPR4ZNuW
         XkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPDdQLvTOE2rq+0aChRTrKWJk9zNAk+PpV2D0pKiyBY=;
        b=JvtChdRHCkV8zvPd/DlM7lkab+v8L3eR680nNjV2ARWVGmo0v8H0ZkRD0F/weOfWaC
         jnHafhyi+Oyz81Ykbg0vqZ1WTN7LkPcNYrIBaW4axGnl5jC++cQUdCPJzZOvteQmi3ly
         9oDB9MeSWLIhpZnkHUbgVAPr7OE5lwfggFssbmg5aUL1jzKO2DSqXvEvgL2QSw4B5hcL
         gitReFL8vZAFHsSz8c5qsLaGXRPGTKk3Lsu6bbUIDUhuOAf8cZeBhIFc+FjWqdaI1aJj
         qH03FlGIn8lK+E1hyiNt1RJ8cMsVfvS6Uq+9doHpM/c3Z1BjuzeERCSReXqDhQOGi2Qh
         x03g==
X-Gm-Message-State: AOAM533D7pbQ9oeOtwQjC2ynw0fbOuMUtMJ0ZlEt1+uhRExLZ2S+gVOU
        F5a1+J+YPNS2LR6HXyi3JjI=
X-Google-Smtp-Source: ABdhPJw/wDUqOnCWJX/59d5EOVGg7VUxg9cyUcUiF1FW1L9SToONJO4Mgc0QEudymeXxj9/gXHwywA==
X-Received: by 2002:a63:525a:: with SMTP id s26mr60575220pgl.155.1594471410811;
        Sat, 11 Jul 2020 05:43:30 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 13/17] perf ftrace: add option 'verbose' to show more info for graph tracer
Date:   Sat, 11 Jul 2020 20:40:31 +0800
Message-Id: <20200711124035.6513-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want ftrace display more and longer information about
the trace.

$ sudo perf ftrace -G
 2)   0.979 us    |  mutex_unlock();
 2)   1.540 us    |  __fsnotify_parent();
 2)   0.433 us    |  fsnotify();

$ sudo perf ftrace -G --graph-opts verbose
14160.770883 |   0)  <...>-47814   |  .... |   1.289 us    |  mutex_unlock();
14160.770886 |   0)  <...>-47814   |  .... |   1.624 us    |  __fsnotify_parent();
14160.770887 |   0)  <...>-47814   |  .... |   0.636 us    |  fsnotify();
14160.770888 |   0)  <...>-47814   |  .... |   0.328 us    |  __sb_end_write();
14160.770888 |   0)  <...>-47814   |  d... |   0.430 us    |  fpregs_assert_state_consistent();
14160.770889 |   0)  <...>-47814   |  d... |               |  do_syscall_64() {
14160.770889 |   0)  <...>-47814   |  .... |               |    __x64_sys_close() {

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 29 +++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index e6e9564d6c2e..0dd5ef4f9c65 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -107,6 +107,7 @@ OPTIONS
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
+	  verbose      - Show process names, PIDs, timestamps, etc.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index a5906258c413..d169d6329454 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -45,6 +45,7 @@ struct perf_ftrace {
 	int			func_irq_info;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_verbose;
 };
 
 struct filter_entry {
@@ -205,6 +206,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-proc", "0");
+	write_tracing_option_file("funcgraph-abstime", "0");
+	write_tracing_option_file("latency-format", "0");
 	write_tracing_option_file("irq-info", "0");
 }
 
@@ -420,6 +424,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_verbose)
+		return 0;
+
+	if (write_tracing_option_file("funcgraph-proc", "1") < 0)
+		return -1;
+
+	if (write_tracing_option_file("funcgraph-abstime", "1") < 0)
+		return -1;
+
+	if (write_tracing_option_file("latency-format", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -514,6 +535,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_funcgraph_verbose(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -696,6 +722,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = NULL, }
 	};
 
@@ -752,7 +779,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time,noirqs",
+		     "graph tracer options, available options: nosleep-time,noirqs,verbose",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
-- 
2.25.1

