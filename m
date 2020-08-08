Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B21C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF46122CF8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkHcArsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHHCji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6680DC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so3522431qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EbyEsk7nlJHntsOEMlFsah0Ii+ve+07Y76zgwo3ks28=;
        b=WkHcArskJti7RPa+RSbl7S70yvObwi/inTmOTfVHN+nFeZwOHKSi5DER6W8mdBdIOT
         okljRL9sDJQwf/izjI8etRFPFGa4LSY483KuHFe/THr5NFToxv0JUXGBZl+EqhB5jTA6
         yXmhTkR/ZLf+ps3ZlDYQkt7yy4dKQcG5pS76jebs8o+Bi33n+CFBDkYDQm8WiO5Y9PV4
         oaWqqKOr1DQaNPvuPcbIApnmXe65/n9YM7IN33E7fUmaPieIdAKUyGiuMiQn7pPl/2t3
         E5P4/+GjykdCi64ShYgnyc7JL5e2Vq7PA8fP7SgZKUdOMapgtxa2v3iEIoBgqSNv1rBe
         LIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EbyEsk7nlJHntsOEMlFsah0Ii+ve+07Y76zgwo3ks28=;
        b=hT8Zz+k5YYO5abYwptA/5LV33F66fgyi9iZaUfqQ2PDBokVprRuu2PI5+Dfn9xcplL
         bSg8KDB6ZVxWGx5LtlcJx3yMMBUhDOihC2SBm2yQ5tclz7mlX9GGNPLcpvPMl2s/odb4
         wz/59E7HEGDVTiycI/UKaXpEZqUvUVbU85ylMoML7oJXcQKAysCnmhM2FAei4pYZb2/S
         0wVs1zgeDmt5Mv9LwVg1U024BG+H7iSJrIta+60XObEryMFc0g/FAZgCYEiFWwBUJt9x
         5VxeNuDYMInKKd7hxxvMXDyT0wROsJ4DSAcoDxdLPTZv4CVntZrO/j54Enub3YLhC3K/
         EMVA==
X-Gm-Message-State: AOAM531EJH+HdLNY4zOqPOKiHGmq00xGkNRwf4xCCVFmlS1OLdppCK6Q
        d01lctzxk7I9zRL2Fy8Yzc4=
X-Google-Smtp-Source: ABdhPJzLTU8hgrtA8VwMFjCyEPohPU9DGMtTrqkwO6Ai8lt5XCGAKsFJvTp1gSzWtBtfJJ3Jg0vmCA==
X-Received: by 2002:a37:62cc:: with SMTP id w195mr17097619qkb.33.1596854376660;
        Fri, 07 Aug 2020 19:39:36 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 11/18] perf ftrace: add support for tracing option 'irq-info'
Date:   Sat,  8 Aug 2020 10:31:34 +0800
Message-Id: <20200808023141.14227-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to display irq context info for function tracer. To do
this, just specify a '--func-opts irq-info' option.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index fca55ac55ff3..37ea3ea97922 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -79,6 +79,7 @@ OPTIONS
 --func-opts::
 	List of options allowed to set:
 	  call-graph - Display kernel stack trace for function tracer.
+	  irq-info   - Display irq context info for function tracer.
 
 -G::
 --graph-funcs=::
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b4c821be4fb5..d1241febe143 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -44,6 +44,7 @@ struct perf_ftrace {
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	int			func_stack_trace;
+	int			func_irq_info;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
 };
@@ -209,6 +210,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("irq-info", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -296,6 +298,17 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_func_irqinfo(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->func_irq_info)
+		return 0;
+
+	if (write_tracing_option_file("irq-info", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void)
 {
 	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
@@ -471,6 +484,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_func_irqinfo(ftrace) < 0) {
+		pr_err("failed to set tracing option irq-info\n");
+		goto out_reset;
+	}
+
 	if (set_tracing_filters(ftrace) < 0) {
 		pr_err("failed to set tracing filters\n");
 		goto out_reset;
@@ -660,6 +678,7 @@ static int parse_func_tracer_opts(const struct option *opt,
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option func_tracer_opts[] = {
 		{ .name = "call-graph",	.value_ptr = &ftrace->func_stack_trace },
+		{ .name = "irq-info",	.value_ptr = &ftrace->func_irq_info },
 		{ .name = NULL, }
 	};
 
@@ -742,7 +761,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
 		     "do not trace given functions", parse_filter_func),
 	OPT_CALLBACK(0, "func-opts", &ftrace, "options",
-		     "function tracer options, available options: call-graph",
+		     "function tracer options, available options: call-graph,irq-info",
 		     parse_func_tracer_opts),
 	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
 		     "trace given functions using function_graph tracer",
-- 
2.25.1

