Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B202C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D2A2158C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmuOdgte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgF0Nip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF0Nio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136AC061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d194so2890077pga.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=et8yAY5LUk1Ej9lJlx0XYVYoU+X3e2V+U02/1KqejXE=;
        b=OmuOdgteJ7H1+DK0n9AWTELrb4Ddnp0XVrQtm+7hnI/cU6SxyCZZV5loLvl2OPBVQ+
         tz+u+yyaRx4nY2T55ZJgvx/d1Kjk8BTBIZ+7r3XNQGbnWFPjs3Hw1nrwwHIj3BEwZVKp
         V6s9pcNlyvuAVlSbBZqVwnrb1/QR2nWJkPCZydDSXG095yiyA4ZJDYEeDfn1KUGvra10
         oA7JBnU9g5ouSPs8KlxphrQgi7XQekYl7ohYICM4rrfXcbL6rKga+j8WD2PtLYi3L1LO
         K07ijV2iYUlwz6fFiLOyHtGqAw8ndIUcT6lE7zEvb/ONkXQCeMDqfU75axTxHkaWoDYa
         Tmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et8yAY5LUk1Ej9lJlx0XYVYoU+X3e2V+U02/1KqejXE=;
        b=LXyTd0Ixc1dd/85rlZalXyVqJiydNHgb18iHzSZlyQas6JKDsU3pj6W02KW/zSyXVR
         Tl9rf6/ebRx14VmFc+T+Ixh093uh9YrzNHo6AygkBSTaKzEAd6b8qTd8cLkDbtXhG7Os
         GtOi6fc2XCueioGgvQC41IJmfYxqKjcXPzaNg5pbDUTC2iFg/E7JIJimdGEaE6On5r0O
         cWyhN/Rm+QLwE9LwACSJgi8bm+4TTi6D4CkeYUMdMgdeIx1QUBv1q3oY6W58wyYLlOeA
         v1ivjClRa0BzLhUQGtHUjg0cKce84dqKYETd4bWkiilSoShKqr3T4sY/5ZyXfR6SQ4xX
         AksQ==
X-Gm-Message-State: AOAM530vMUwF8LobbxNEN3XrlrvKkzgNA8RWlswhJon8vWpRBzp1U1oG
        XNspI/CIt5guMLq1MXmAS7k=
X-Google-Smtp-Source: ABdhPJwhqIfWj9KsFqPX+89oXzv4CTapCVOW2vWRYKfY6LIk52CuourZFmBrYbmcE+rdMGl708pdFg==
X-Received: by 2002:aa7:8433:: with SMTP id q19mr6913590pfn.55.1593265123413;
        Sat, 27 Jun 2020 06:38:43 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:42 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 13/15] perf ftrace: add option '--graph-verbose' to show more info for graph tracer
Date:   Sat, 27 Jun 2020 21:36:52 +0800
Message-Id: <20200627133654.64863-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want ftrace display more and longer information about the trace.

$ sudo perf ftrace -G
 2)   0.979 us    |  mutex_unlock();
 2)   1.540 us    |  __fsnotify_parent();
 2)   0.433 us    |  fsnotify();

$ sudo perf ftrace -G --graph-verbose
14160.770883 |   0)  <...>-47814   |  .... |   1.289 us    |  mutex_unlock();
14160.770886 |   0)  <...>-47814   |  .... |   1.624 us    |  __fsnotify_parent();
14160.770887 |   0)  <...>-47814   |  .... |   0.636 us    |  fsnotify();
14160.770888 |   0)  <...>-47814   |  .... |   0.328 us    |  __sb_end_write();
14160.770888 |   0)  <...>-47814   |  d... |   0.430 us    |  fpregs_assert_state_consistent();
14160.770889 |   0)  <...>-47814   |  d... |               |  do_syscall_64() {
14160.770889 |   0)  <...>-47814   |  .... |               |    __x64_sys_close() {

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  3 +++
 tools/perf/builtin-ftrace.c              | 28 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 3c9eb044b7eb..cc770fc0a1e8 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -113,6 +113,9 @@ OPTIONS
 --graph-noirqs::
 	Ignore functions that happen inside interrupt for function_graph tracer.
 
+--graph-verbose::
+	Show process names, PIDs, timestamps for function_graph tracer.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-trace[1]
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 0a1e481b66a0..e037fe7abd47 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -45,6 +45,7 @@ struct perf_ftrace {
 	bool			func_irq_info;
 	bool			graph_nosleep_time;
 	bool			graph_noirqs;
+	bool			graph_verbose;
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
 
@@ -419,6 +423,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
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
@@ -513,6 +534,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -698,6 +724,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "measure on-CPU time only for function_graph tracer"),
 	OPT_BOOLEAN(0, "graph-noirqs", &ftrace.graph_noirqs,
 		    "ignore functions that happen inside interrupt for function_graph tracer"),
+	OPT_BOOLEAN(0, "graph-verbose", &ftrace.graph_verbose,
+		    "show process names, PIDs, timestamps for function_graph tracer"),
 	OPT_END()
 	};
 
-- 
2.25.1

