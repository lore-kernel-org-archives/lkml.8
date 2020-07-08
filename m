Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01968207F9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEdzZ3Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgGHQsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbgGHQsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:48:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC2EC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:48:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so18411217plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYZ44erC//O5NgDxZQDY3YbDYA2m4mu+vUUINjHyycI=;
        b=eEdzZ3Qq2MBAqxJeFuWLW/2OtaJBvtUT4haJZhAhbOKfRRZqDbfyq/ywCAv8aiyMjJ
         MobMvtLv8RcWk5hbwemzueVJbjxIHoiutdcbBcUzrE40jVytzOyHdECN8+4wpV5XCLkn
         9Sfqf8vjzS0U0zpmMtTpRcwXvtlq5q+2DJxk8hSMTb3in2OCB/B64NSeR+QQlNrelmyN
         jQCCXZ5depMwpBm/iQ1TahxC6v/Q3Ipm1IQp1dZ3hy/qvkO2eAcykoiaBeTpu+bQjcOQ
         nMMb5q7b3ltFF1C7gvVCWgna6xXy1eYmKN1RNKOOL2qhlYoHDvJWIM4ZYtjZD0khEHiM
         x0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYZ44erC//O5NgDxZQDY3YbDYA2m4mu+vUUINjHyycI=;
        b=jKiKAbjeOXP1SkYvRrr/AxjMIKlqwTBccGxUY5JiBgojBST7VWRjJr969i7+7B/Jn0
         D3XBtu3whyykvksvGw+Un+gyJMpxARMInenqYRHpNPeoELfuFMZ9754WRVqBMZqyftrm
         dDwbVCAlPrpLGmRmg3IEWjfzYLcyWufVx7HSJ2EDGRrLWG/0O87FrTRtf18fOSynqz8q
         uMQsswdfCZWp57a2KTQxVJINxC0lqZiZnqNDUlT2iqPAuoWPnf4bQ4wb+cR8/p56I3DA
         +gtMyqsajJkDGFKlGZMSPJI1iiKyGX9cTtOTS/TXWRyFhhrlRu+qLas2D7Ltt6ebW3uP
         chjQ==
X-Gm-Message-State: AOAM533dPDZC7a8v6EJLG2x8q3R0HVFmr1SCSJCStvutnh/ENIP2Fq03
        40LAZaosM3J+KgWbJrqlKLM=
X-Google-Smtp-Source: ABdhPJxnePiLsgcHRGc1cQHD5hqPDd41ULuiOJcu9Obpe3kqzvRynbg8o8V142disu9/9NtBQ5sCKw==
X-Received: by 2002:a17:902:446:: with SMTP id 64mr6674136ple.157.1594226894152;
        Wed, 08 Jul 2020 09:48:14 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:48:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 13/17] perf ftrace: add support for tracing option 'irq-info'
Date:   Thu,  9 Jul 2020 00:46:01 +0800
Message-Id: <20200708164605.31245-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
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
index 5cc1f83795f5..b157566e54a2 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -85,6 +85,7 @@ OPTIONS
 --func-opts::
 	List of options allowed to set:
 	  call-graph - Display kernel stack trace for function tracer.
+	  irq-info   - Display irq context info for function tracer.
 
 -G::
 --graph-funcs=::
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 330dac9ffe3d..a750ee78db4f 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -43,6 +43,7 @@ struct perf_ftrace {
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	int			func_stack_trace;
+	int			func_irq_info;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
 };
@@ -205,6 +206,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("irq-info", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -292,6 +294,17 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
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
@@ -467,6 +480,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -667,6 +685,7 @@ static int parse_func_tracer_opts(const struct option *opt,
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option func_tracer_opts[] = {
 		{ .name = "call-graph",	.value_ptr = &ftrace->func_stack_trace },
+		{ .name = "irq-info",	.value_ptr = &ftrace->func_irq_info },
 		{ .name = NULL, }
 	};
 
@@ -734,7 +753,7 @@ int cmd_ftrace(int argc, const char **argv)
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

