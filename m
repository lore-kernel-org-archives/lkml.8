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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD421C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95824206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il16yw7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgGHQr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgGHQr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:47:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD62AC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:47:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so7840835ple.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q0kVvXo0D1/ovBf7Rlh80j9YhzxIZArwTGmIoqgm70k=;
        b=il16yw7YGh+ANowSrJbFgwyeA0QwXPdWBvSWJ0bF+3sdh8GxCySpSkMrFNlubn4hcA
         ioG2PEHoDMtwrissXnazUepOfr2mTI5WydP6haHGmfpf2ZXffBtcQS0VU6NFJSexCUaq
         kw7t7Is7mXYN1KRm3SjnYB5/2fguo93LRyVzFJmFm/81CHQQiRC3J8asFtzitXcdDd8u
         q0YkJXCFrEzYvKiCCcau1oKmkbWaP+wtaJ8KHB0pNaVO5HH7vri7jOJjozJoytJQiCKl
         XmhqR5Ni7i4z1nEnLeN0z5ciTBL/ftgPgDtocyqIbqtZWFAUGAirj1fvDRw3z1+HIa6Q
         x5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0kVvXo0D1/ovBf7Rlh80j9YhzxIZArwTGmIoqgm70k=;
        b=rYI2h70ynSyxAteyG7gvOizaEWWM5GvEE7iPeyqjfCvHDyzR73Dku/H34Hr0bkE6gQ
         xXWUVpCAQWQAPdhEF72D0jfANT5fa+XAJ09ooH6Xd7Bd5TCh5DNpP6XEgaFQntXxm2Me
         PhfSowQx4F0sOSEb/5B1j9r5mliuyZ2HvU07GdcaOiRk9Nvm+oJvNC6LKD72JAg69OIX
         ofoDMBI/OggfFarVJtSC+lv0fzdaT3idTfRuAeuv4fgAHC1UZkXDWF/b1aVJXaiGpLFh
         iBzcsgt6IKv9uaPg7bv7q5PEDsWyzsmvAtQT0/sY7SwdH1rHHTWMt1cpmjj9O6fYM838
         PDrw==
X-Gm-Message-State: AOAM531sFlwLtMaZ6BOS0EjZNpZRJs9JvWtewl/54yxbv8qGH9ymwgss
        hei+4d8CMjfz8zJXKIiTtt7h6+8vxyI=
X-Google-Smtp-Source: ABdhPJxfisNGBFOeOtcLPyYbjzYqkKr+tGtIeLDaHFV8kK87uO4lA1oS2W1w4DBiovgAUtu5e/bNUg==
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr10661203pjs.136.1594226876480;
        Wed, 08 Jul 2020 09:47:56 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:47:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 10/17] perf ftrace: add support for tracing option 'func_stack_trace'
Date:   Thu,  9 Jul 2020 00:45:58 +0800
Message-Id: <20200708164605.31245-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
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
index 27381c0dafe7..eba0e85aa308 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -82,6 +82,10 @@ OPTIONS
 	(or glob patterns).  It will be passed to 'set_ftrace_notrace'
 	in tracefs.
 
+--func-opts::
+	List of options allowed to set:
+	  call-graph - Display kernel stack trace for function tracer.
+
 -G::
 --graph-funcs=::
 	Set graph filter on the given function (or a glob pattern).
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index ab1435c2cd0e..095471593d68 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -27,6 +27,7 @@
 #include "util/cap.h"
 #include "util/config.h"
 #include "util/units.h"
+#include "util/util.h"
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -41,6 +42,7 @@ struct perf_ftrace {
 	unsigned		initial_delay;
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
+	int			func_stack_trace;
 };
 
 struct filter_entry {
@@ -198,6 +200,7 @@ static void reset_tracing_filters(void);
 static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
+	write_tracing_option_file("func_stack_trace", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -274,6 +277,17 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
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
@@ -422,6 +436,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -605,6 +624,26 @@ static int parse_buffer_size(const struct option *opt,
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
 int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
@@ -637,6 +676,9 @@ int cmd_ftrace(int argc, const char **argv)
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

