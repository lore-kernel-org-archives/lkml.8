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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE10C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA65221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYO7r25B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHHCjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD7C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id x7so1673252qvi.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOAF8R7pkfmGmqrz35rVdWEvq0FEmyVSxeYF6yZIxVY=;
        b=pYO7r25BQaIdiBHfry5YW81hFTRTAw5rWdeYxzU2AlHnM2TGrrM96x/sS5YYx5hkzS
         xIyRyjiGkLa0efX55qB+7+WWF9k1zB8y1XIHh1VqYbGBmL73RjobUpgA/RUkqe+UfyoY
         9pHLvnWzpRTPu6I6rdxw/1f1JsK6Y8sySjmYX6Aa1EcTWL/iWg+C5OUCHHMyMaG4Zb7+
         /IyzlKTDzQdZosX9GpcSEykWd3oRUatRZXFdIo36Ig48DEElPPoFyijpSmYvFq6gs+w6
         CBRPIjfqPakKTLVNwiuSedBozyFlWO4Ee14x80EeU3bmiytq/jTS9bTUlcsHLVSTQAOs
         ATtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOAF8R7pkfmGmqrz35rVdWEvq0FEmyVSxeYF6yZIxVY=;
        b=EzbQc1Zid7IrWkPjgpajLL72iVvjUSquUyvdlBowyMYktJE93BM2DbnqlawHWpxhQ+
         h8Nr0sYtRc/k3DQ1E8mis26Nr75YCC1dZvQ3a56VSBQJhMni3Pw0V+TBPMM2cTgwtBnI
         16lgiNBeduAQHQxHxyc+ZcELe4Vtwj1QeD5mpjiCLEE1hUERvNZkXpQKGf9FR4J/r5eF
         UNeyrgPKXsjo3uL9Z33Rw5Sa8tOiWsnEC3nnRCfogFqlGXi/3C5e+XOwztatnYBpfVs9
         GZxsZvrLn37ol1FcUH8t6nNuImwqOCOnXujJzcn4JO1V4HkN0lXZIDMDhexcgYKeRe2R
         mnMA==
X-Gm-Message-State: AOAM533206RmZOjgqPgDtuZ1Vyv/rECnirD/xQVv25lpJ0pjot5z6r8i
        HH+7y+A5IUUhEyTQHIBKGwA=
X-Google-Smtp-Source: ABdhPJyFijWuqYhTDjogD8T+X6haInX9d6vJmO2H0jwPlUXLs3ppM72bfblvxLIS7wTPTe3fGAckYA==
X-Received: by 2002:a0c:99c8:: with SMTP id y8mr17542227qve.57.1596854358383;
        Fri, 07 Aug 2020 19:39:18 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:17 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 08/18] perf ftrace: add support for tracing option 'func_stack_trace'
Date:   Sat,  8 Aug 2020 10:31:31 +0800
Message-Id: <20200808023141.14227-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to display call trace for function tracer. To do this,
just specify a '--func-opts call-graph' option.

$ sudo perf ftrace -T vfs_read --func-opts call-graph
 iio-sensor-prox-855   [003]   6168.369657: vfs_read <-ksys_read
 iio-sensor-prox-855   [003]   6168.369677: <stack trace>
 => vfs_read
 => ksys_read
 => __x64_sys_read
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
 ...

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: switch to uniform option --func-opts.
v2: option name '-s' -> '--func-call-graph'
---
 tools/perf/Documentation/perf-ftrace.txt |  4 +++
 tools/perf/builtin-ftrace.c              | 42 ++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index c46d0a09b38c..8f08ad0992c2 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -76,6 +76,10 @@ OPTIONS
 	specify multiple functions (or glob patterns).  It will be
 	passed to 'set_ftrace_notrace' in tracefs.
 
+--func-opts::
+	List of options allowed to set:
+	  call-graph - Display kernel stack trace for function tracer.
+
 -G::
 --graph-funcs=::
 	Select function_graph tracer and set graph filter on the given
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 07b81d0c1658..469b89748c42 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -27,6 +27,7 @@
 #include "util/cap.h"
 #include "util/config.h"
 #include "util/units.h"
+#include "util/parse-sublevel-options.h"
 
 #define DEFAULT_TRACER  "function_graph"
 
@@ -42,6 +43,7 @@ struct perf_ftrace {
 	int			graph_depth;
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
+	int			func_stack_trace;
 };
 
 struct filter_entry {
@@ -202,6 +204,7 @@ static void reset_tracing_filters(void);
 static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
+	write_tracing_option_file("func_stack_trace", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -278,6 +281,17 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
 	return set_tracing_cpumask(cpumap);
 }
 
+static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->func_stack_trace)
+		return 0;
+
+	if (write_tracing_option_file("func_stack_trace", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void)
 {
 	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
@@ -426,6 +440,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_func_stack_trace(ftrace) < 0) {
+		pr_err("failed to set tracing option func_stack_trace\n");
+		goto out_reset;
+	}
+
 	if (set_tracing_filters(ftrace) < 0) {
 		pr_err("failed to set tracing filters\n");
 		goto out_reset;
@@ -598,6 +617,26 @@ static int parse_buffer_size(const struct option *opt,
 	return -1;
 }
 
+static int parse_func_tracer_opts(const struct option *opt,
+				  const char *str, int unset)
+{
+	int ret;
+	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
+	struct sublevel_option func_tracer_opts[] = {
+		{ .name = "call-graph",	.value_ptr = &ftrace->func_stack_trace },
+		{ .name = NULL, }
+	};
+
+	if (unset)
+		return 0;
+
+	ret = perf_parse_sublevel_options(str, func_tracer_opts);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void select_tracer(struct perf_ftrace *ftrace)
 {
 	bool graph = !list_empty(&ftrace->graph_funcs) ||
@@ -645,6 +684,9 @@ int cmd_ftrace(int argc, const char **argv)
 		     parse_filter_func),
 	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
 		     "do not trace given functions", parse_filter_func),
+	OPT_CALLBACK(0, "func-opts", &ftrace, "options",
+		     "function tracer options, available options: call-graph",
+		     parse_func_tracer_opts),
 	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
 		     "trace given functions using function_graph tracer",
 		     parse_filter_func),
-- 
2.25.1

