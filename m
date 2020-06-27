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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D3DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D717B2158C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZhISPqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgF0Nil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF0Nii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B43C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f6so2086850pjq.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yU6gt4VEMD8sdwbXjlPOd/0aIjuAkcKiJZIXO4mnnmI=;
        b=DZhISPqLfic1EPi/eiDN2pEicUiE0mFwQdWxtIXDrTNMvmuBKQzOGyB97PH3j+YHw/
         88CJkdzvNcgoxVTN2vEhwI5YtzYW6NWmZav1I1ULhNhBVkD6F/Ks5yV8tzsHsF2VJ3cm
         qZGJ5Cga2mwB4bz3sLbe1iFDJzlByoixLKGwLQDPFjgWiHGi2XyDRPfhLPCz+8k3TfMM
         8Ykn4ucsJZ62TLtkMSKI//YUjFi7erGyYN11VBBecXjKSt5s8J76pB+bhuWZBHIkpBP/
         qm2ZZjgeXsr90k9F8SCo7D3W/o0z5IR0p2F6EuunQTaBY5BO1etgDLzlod8V9F+2Mp9N
         B9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yU6gt4VEMD8sdwbXjlPOd/0aIjuAkcKiJZIXO4mnnmI=;
        b=CANYclCRRyxAScnFEOOl6qO7tBDfjb9oZk/jlWqZO8Dc7D1cQagi4R5hDIV8PacWne
         llMwKodN6GCStAR+zVSABHdKv4+IXTwutpikowwYvs4Pe8rncPqCPxnhr/D9rW1NhqWP
         OOFYzRjQ/3nakuEyunvKDiXAGCHtpQvFp6of665PEBPwOqRYaHkLtrWlQOsDrcZF8Uba
         c1KaOqpzKHut+CNlLpbLwV9Q6FTMHWSMCTj3x+ldAWM/yRHxdqjwJt4Wmil22LbJ9AiN
         X4QApHPuxoO7Hzg7I8cEV95TnodLltqYOgydHnIAZchJTiCrscRoM0zrjuMtgL1oa2/0
         jNDg==
X-Gm-Message-State: AOAM530yFY3sbDpPRGJFIV/3TS1X5W3mrt1uR0wzJJZbyUPiLMR846/D
        hXLnh5xSISMuCwnz1cOcPwk=
X-Google-Smtp-Source: ABdhPJxRF2+mILeVidcMn93qt/TQmJoO0tFiykCXhn6f2G12aRsT0jYzFnN5nGz0Sfr6UW3xS6liPg==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4mr6503522plo.315.1593265117938;
        Sat, 27 Jun 2020 06:38:37 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 12/15] perf ftrace: add support for tracing option 'irq-info'
Date:   Sat, 27 Jun 2020 21:36:51 +0800
Message-Id: <20200627133654.64863-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to display irq context info for function tracer. To do
this, just specify a '--func-irq-info' option.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  3 +++
 tools/perf/builtin-ftrace.c              | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index b616e05d5156..3c9eb044b7eb 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -84,6 +84,9 @@ OPTIONS
 --func-call-graph::
 	Display kernel stack trace for function tracer.
 
+--func-irq-info::
+	Display irq context info for function tracer.
+
 -G::
 --graph-funcs=::
 	Set graph filter on the given function (or a glob pattern).
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 876c8e800425..0a1e481b66a0 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -42,6 +42,7 @@ struct perf_ftrace {
 	unsigned		buffer_size_kb;
 	bool			inherit;
 	bool			func_stack_trace;
+	bool			func_irq_info;
 	bool			graph_nosleep_time;
 	bool			graph_noirqs;
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
@@ -465,6 +478,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -661,6 +679,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "do not trace given functions", parse_filter_func),
 	OPT_BOOLEAN(0, "func-call-graph", &ftrace.func_stack_trace,
 		    "show kernel stack trace for function tracer"),
+	OPT_BOOLEAN(0, "func-irq-info", &ftrace.func_irq_info,
+		    "display irq info for function tracer"),
 	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
 			     "trace given functions using function_graph tracer",
 			     parse_filter_func, "*"),
-- 
2.25.1

