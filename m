Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D0C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5182074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6n93bz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGRGuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgGRGuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:50:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F0C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so6329709pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCBLcrGRp+pdOgjKOYl4FCLc+/ip6fXMEGxXzBrd2Vs=;
        b=E6n93bz7Mfb80jUUsM4uUkQ05cAwsGYXNJzrS/UPJInbyVW+ox7Kr1HSfQrqO2MLAi
         Pz0HwNHWNeXk3DUvj/UFCNS5X53KfUFfNvgamxK9MzEfehVXBx2fbm33I431XgVinpB0
         urV+PRDvqy3jAhjHpZPZ73NvlRMM7FofjRWxTah45Nw34lPUsQ7gUzNfnhD6HUZlMg05
         yf5QTf1fU4g6kfNzrnmkvA2Qxib6PYpI8jCspuBn0dF5K2/8nWPxMlXh7ZMLZJFMe4eb
         khpPITDIfBoRobb3IPKdel7iTeMzM5FzQ+JtEuFp5n5hPQYVHG1w1M4yyj4i+1PeQOuc
         j6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCBLcrGRp+pdOgjKOYl4FCLc+/ip6fXMEGxXzBrd2Vs=;
        b=mqWCZszddCLMQxg+UXe02LFze99gSqedRyPQoH24c1WUAcZWMD1MwHk1iHm8icSfJ3
         ku3t5s1rLW34XAMdi6B+bQYYhrg7DahNESdpDcXJdN1y7+1tLnCFvnX9CsDVCLpcjZAQ
         7iZ+ZRxIr3Nhs4fJQnKFXOstm3ZzWJdAbE04ao3q7j3v6+ZSx/0d8vDwJyzSug7y9oSZ
         G9Uox43ihneQKKQ1z1faoTCvV8XHbXGh3xtESnxXMnUOyMEF7nCYf2WT0fJj1erK4V+t
         A9wcHa3mSpF8lGtOfZQf00q9uPGp9zop17RS7cTFo2afiWdoX+eyJBzTuRDzHiuPKPu+
         ODFA==
X-Gm-Message-State: AOAM531OPR3OzMFiCr1AsqImkYJNs7hlsInHH7f8a7HixVb+p4TfdUo6
        1rl8oOhHYRGXMTEGeo1wTvA=
X-Google-Smtp-Source: ABdhPJxxg3LXw+u5ik7P/8aXDN+JfjA0AXjgvamh/7ZGdub0JSs0+wxkMPuwn0R8X66UAiJfxOyu9A==
X-Received: by 2002:a17:90a:1a83:: with SMTP id p3mr12406717pjp.113.1595055006155;
        Fri, 17 Jul 2020 23:50:06 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:50:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 11/18] perf ftrace: add support for tracing option 'irq-info'
Date:   Sat, 18 Jul 2020 14:48:19 +0800
Message-Id: <20200718064826.9865-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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
index 21d3b444587a..3ab1fe040994 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -77,6 +77,7 @@ OPTIONS
 --func-opts::
 	List of options allowed to set:
 	  call-graph - Display kernel stack trace for function tracer.
+	  irq-info   - Display irq context info for function tracer.
 
 -G::
 --graph-funcs=::
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6402df3984c0..95d87c5966ad 100644
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
@@ -207,6 +208,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("irq-info", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -294,6 +296,17 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
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
@@ -469,6 +482,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -659,6 +677,7 @@ static int parse_func_tracer_opts(const struct option *opt,
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option func_tracer_opts[] = {
 		{ .name = "call-graph",	.value_ptr = &ftrace->func_stack_trace },
+		{ .name = "irq-info",	.value_ptr = &ftrace->func_irq_info },
 		{ .name = NULL, }
 	};
 
@@ -724,7 +743,7 @@ int cmd_ftrace(int argc, const char **argv)
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

