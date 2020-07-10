Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEFDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF70207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZu9+pWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgGJNp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgGJNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:45:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B10C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:45:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls15so2644851pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7KG5QWQXC0DT5Wy+0SYBLxbROhm08sns0ssVfXKln0=;
        b=XZu9+pWQbTy60PSoHQBwjwbQMrb5r4JmvOsB9uKCfCWtvev3RcGAQV8lvPW3ltvX1E
         R5UcMS9cEg1j4lDqHhwSBPctGD6+ljgmsZZg7vQnJf+ASoMZlCKBAkl/vqg+zA1I2uRQ
         CKgN5yukxYU/RL7vL54n4pYNwOlVlL+Cgh8MoMlcLzUveSTAwKDBQZikNCf414IRQev6
         HPYQUQDPGCCNMFSlsscQB1S1zDfLoN1yVXsXaf0w9vA8tGTgQsXfuS2vPcror/QnM0VX
         aXo6S9llVhSQHFgnTaawneCqilaAJybBQfRsAdwity5LvMDMizJH6gDlQDhlupuAgYS7
         Z7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7KG5QWQXC0DT5Wy+0SYBLxbROhm08sns0ssVfXKln0=;
        b=FmLGO6CTlRhW7kxHxoWhAR9klcwYzKTPR+p5i3+mWQpZxfcHaTpqpje5EIk9M6XgY3
         xTCrABTC6vielaGfW4XKUfz64MAGSdjdGYGfYR2rR8BbkI4/ZwkUTFMLSb0aOGN3zG2F
         ClovXEx3algx1hinZ3GgECf9cJgRg0nQserqANueZz2o70KFFsWNd3WGTk7q6rWdvLBM
         L8jBwI1piA6Yf0oHp49Qgwvg7wsgovFDe7sYfYuB4OBZ8NXm6zWuZSjskpv2nybNDfVp
         8DKqKEGANTEpXwocv5bgRWBzsLAYBxgfh4qrufwNyM+AeCGDCsWtHbJDDqPUs0snF6dt
         9T/Q==
X-Gm-Message-State: AOAM5327tHhtWknBsnK6QSOlL7M85pMpj1FDqur71+mBFxHWp2HSyqzL
        C4MI/6Y8D/tf6/cd/lTR0bs=
X-Google-Smtp-Source: ABdhPJz6IiPHNSVd7i9nrd6Wo9FhX15AQTUgKDWGi6ePstv+AqsYEYYLey0QJ14cXLSvSRME/KMLlg==
X-Received: by 2002:a17:902:820a:: with SMTP id x10mr8288876pln.135.1594388710310;
        Fri, 10 Jul 2020 06:45:10 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:45:09 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 12/17] perf ftrace: add support for tracing option 'irq-info'
Date:   Fri, 10 Jul 2020 21:43:17 +0800
Message-Id: <20200710134322.15400-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
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

