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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A1AC433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6242076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8nosYbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgGKMnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0991C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so3758496pje.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qI2UxEq65Bm2hy2Ar9pHiCmTMt1XFcVBUAcKn4PHYsg=;
        b=Q8nosYbECXs8Q94XR2lcuaAt80U2DfCEcqfLreecfsQsgrk0z9ylWvBwcRDlifNGdu
         z9ccuQmddO/ZoW5La+UEYjqDMaPOMhPmd14c0lD7Um76coVVOQLhjXIQX7XGeJv+uzI5
         T8NJxPSD6Nv62eBGBP7WfRhUhZ2/uh663JfKSVC4UuF5jpCBMC8fM6uAVqmcXnUqmL41
         K6Ep6wrSe7AKZmUnS9ycIFHglNOpu/3w1Ce0zfQwLGEdsCbkQWmVzaLk12cdEiVXiVuw
         IPHNMR+bBjdPaWeLFDnkch7W4xgr3Yf+QdlovME27Je83lb4JEoM8336LX4mG8bzH1z+
         eEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qI2UxEq65Bm2hy2Ar9pHiCmTMt1XFcVBUAcKn4PHYsg=;
        b=fVOc4Klc7OAu6esHNP1ORi5HPieyW9CbGsH1b2bO1TkpuNzMfCKQ1qNX9AB3ij8rPi
         sw9Ikgn//L3ZZms9eGhLRDCOm+98E7HN1IZvnQIYxgNN9xwvjMKAGY3k6VcJsPbpazd0
         UlvFajxaWaFfcOJ0qPgbo2Q7+bL8GJzL5p6Y0AXmFZy0Ng5TI7s8Y2M0LO25EvSi5Z+u
         u3WBWKnL0JEHKWQ4lV6eYILzpvRUcss9brFr1WGoyWtzpfjhNrm9J0Fm37vmlJT2IiEC
         NT4wRpGtVSm4zheUsqGxByjCCf6ZLYSzN+GVJwmJWyADMnPOLeSZojbi7A8gJg+VH6yh
         Kvsg==
X-Gm-Message-State: AOAM532MyJDAgFMvliW5uMgXQO4wIkot19k2POL8x8/AXIUs0Et1QjH0
        vpNPbE3lUrf1tPR+kwChED8=
X-Google-Smtp-Source: ABdhPJxKbn7RsBWbwsT4O/L5PjXaMSIMF0+7a1VguWrhDNmkuulFzTOPDQOTY9JoR3rovbDIOCjw6w==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr55354600plr.92.1594471388409;
        Sat, 11 Jul 2020 05:43:08 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 09/17] perf ftrace: add support for tracing option 'func_stack_trace'
Date:   Sat, 11 Jul 2020 20:40:27 +0800
Message-Id: <20200711124035.6513-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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
index fd632bd9b2c1..676a30cb9b5a 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -78,6 +78,10 @@ OPTIONS
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
index 4efaa7b6a906..91611eef5deb 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -27,6 +27,7 @@
 #include "util/cap.h"
 #include "util/config.h"
 #include "util/units.h"
+#include "util/parse-sublevel-options.h"
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -40,6 +41,7 @@ struct perf_ftrace {
 	int			graph_depth;
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
+	int			func_stack_trace;
 };
 
 struct filter_entry {
@@ -197,6 +199,7 @@ static void reset_tracing_filters(void);
 static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
+	write_tracing_option_file("func_stack_trace", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -273,6 +276,17 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
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
@@ -421,6 +435,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -594,6 +613,26 @@ static int parse_buffer_size(const struct option *opt,
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
@@ -626,6 +665,9 @@ int cmd_ftrace(int argc, const char **argv)
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

