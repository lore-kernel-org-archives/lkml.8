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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E057C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B412076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqkKKqXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgGKMn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGKMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84925C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m16so2160941pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7KG5QWQXC0DT5Wy+0SYBLxbROhm08sns0ssVfXKln0=;
        b=pqkKKqXrvGeqWSbXdDi+np+6LrLadYN/AQwQdNcTBlKxkFeg4R4+HYC8CFAcjj7sXm
         YulTpzCUtOkXuMkcejnlXPRiTVpx6iq8lON5kfmaQFOpXIHYaOci//LrR+BaS2xPrHUH
         27dQ2W+NQV/YPo5+L4Hr0JgM0Iqa6u+oGIucXB6vlpTGOSyOwWU0D8pp5ekAg1RvgcoD
         WWnTOhIFpasZhJ9OepgWm8v1rAgADz5kP5F2IACS3V5UelKgd6DX6l/8u77VmNqtcjwX
         TBk/vjBzuu2B7/hr8UvJImJ4lmqO/hXu4vosH1M+brqWpvQ67ZQceFW+W3VCqovMAJ5n
         nMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7KG5QWQXC0DT5Wy+0SYBLxbROhm08sns0ssVfXKln0=;
        b=M8N5pNJEG328+shhqyEYRNPRLYTMef8MtALSvcl+IAU00M9yfs26ZpGfZx0eQRNDT9
         tapP+qjPUWHw/fdSurgGAE+XHTGToUtMYr/Kr1FqYtHGnMkVI9EaSXr9KxLqVrCvS6T6
         1dvlabYhAkH8SLEjwr7xpsn0bqBq4UzcF8VR5enX7m8BgJpojKHkMIat1OoJHQJEJFAP
         IGTTBCEti4vcINAwq1TVd7xqtPZoSif4+H72fixeGXKPOh6qEg3ydxnPPR1ZfqKyMFUw
         i/PQTPjpAdy90FZO1c6qm47S+Q9zWi9nZwQD3ABpdVPUhaOkf0ZYB2z3LpoCieSUWtco
         7khQ==
X-Gm-Message-State: AOAM530Iln1mkeax/4ywf6QvDTEu1akmMz+IA9mTQAt17GcMVCDeeO8n
        T6UJKBlQLkVNEw5JAUzG/DGH6OqS
X-Google-Smtp-Source: ABdhPJxOkdJ9o8yfjPyO625CHtYLYFxhKt1UVeBcmS9oRDo/SxvZnfHi+/XfeNoDbBuNdIb/7qa8wA==
X-Received: by 2002:a17:90b:3842:: with SMTP id nl2mr10286880pjb.111.1594471406141;
        Sat, 11 Jul 2020 05:43:26 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 12/17] perf ftrace: add support for tracing option 'irq-info'
Date:   Sat, 11 Jul 2020 20:40:30 +0800
Message-Id: <20200711124035.6513-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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
index 2e16e1e588d9..e6e9564d6c2e 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -81,6 +81,7 @@ OPTIONS
 --func-opts::
 	List of options allowed to set:
 	  call-graph - Display kernel stack trace for function tracer.
+	  irq-info   - Display irq context info for function tracer.
 
 -G::
 --graph-funcs=::
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 179c5da678e3..a5906258c413 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -42,6 +42,7 @@ struct perf_ftrace {
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	int			func_stack_trace;
+	int			func_irq_info;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
 };
@@ -204,6 +205,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("irq-info", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -291,6 +293,17 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
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
@@ -466,6 +479,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -656,6 +674,7 @@ static int parse_func_tracer_opts(const struct option *opt,
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option func_tracer_opts[] = {
 		{ .name = "call-graph",	.value_ptr = &ftrace->func_stack_trace },
+		{ .name = "irq-info",	.value_ptr = &ftrace->func_irq_info },
 		{ .name = NULL, }
 	};
 
@@ -723,7 +742,7 @@ int cmd_ftrace(int argc, const char **argv)
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

