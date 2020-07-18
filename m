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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E76EC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2E72074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzJQdEEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgGRGtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgGRGtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:49:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4EC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cv18so4663680pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5jlKEkgzpkLmb2vCNuFzmtt6H/DTwedr4QScCX86FM=;
        b=pzJQdEEb0F29JsHLnbPO5EMCRxBxjpJGtf8scMEBl9B1OI3mQCVQwxaFP2kJZE/6Nj
         F7roxOC6LbFpP1km36kUf4wHvNkPGwd5ET4QVXEphrUQklxd3jpzWh/P41KORj69mLhh
         NREWxtEkjSaAjn1FhJ/ThyPl+MJV6FKi4rbkSvGmKcNqoJ+vceonkfzuX3LuPMUEWjhY
         ioT6unvCp3GssU3LQY1zX2PR3jXKozrs5gRQmPHK68K021aV6QSBYIPCS5awN4DOJSGt
         KNDsSl8J3VOQ5KhdRKk89F/ubu1R3KlyS+nzim2elYY65Z56QcuYDd49TlFCjw/1Deoe
         TjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5jlKEkgzpkLmb2vCNuFzmtt6H/DTwedr4QScCX86FM=;
        b=hdwvI1dC8ggxnzkHcL+UHToB+kKuC8rtZYfeHaLUUGflBU1ypCGlz5i+vvgPF/JH3a
         oMnohQli+AS9sirDH+ffzoY2Kri43TpP7p8yU4ud6wq2egRtVnobUF2M7FpiPUpRec7R
         TGCKVZO83SXxbLfw51BnF5qdFdxoaUe/ZZRGKe/h0UI8YcAfhpaZMdnULOun0yRWpuW4
         Ig0tTGd2P+HmRCmUPFcqhDskGnwn72eGVug0XJKpq2HtccP2EDvfP6bu3oDBPtP/8lwb
         Y+ohW4fvSWNQ+VEKDmSz7m7c4LCvWPoEYFGgTMWP0Jaglza8AqVbc2dSjsmC/D+xFk4B
         YvWg==
X-Gm-Message-State: AOAM532A+Vi/sl6zw0O0E/DUO0Nz2xurBW5+2xKBBqbMlYpkayJuvIpE
        h3XSjPF23lbPozTpQyo4PnA=
X-Google-Smtp-Source: ABdhPJw2MOAR/T2iOnCJwVlr5oeRdd1Qyc+rg/zNG9GlPa1X6geJ8BW6n/soe7+PidFlOpi0NZ2zNg==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr10454849pls.244.1595054985218;
        Fri, 17 Jul 2020 23:49:45 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:49:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 09/18] perf ftrace: add support for trace option sleep-time
Date:   Sat, 18 Jul 2020 14:48:17 +0800
Message-Id: <20200718064826.9865-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-opts nosleep-time' which allow us
only to measure on-CPU time. This option is function_graph tracer
only.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: switch to uniform option --graph-opts.
v2: option name '--nosleep-time' -> '--graph-nosleep-time'.
---
 tools/perf/Documentation/perf-ftrace.txt |  4 +++
 tools/perf/builtin-ftrace.c              | 41 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 5a5069306141..2968a34239a4 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -98,6 +98,10 @@ OPTIONS
 --graph-depth=::
 	Set max depth for function graph tracer to follow
 
+--graph-opts::
+	List of options allowed to set:
+	  nosleep-time - Measure on-CPU time only for function_graph tracer.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-trace[1]
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index e7c8697294f0..835f810985f0 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -42,6 +42,7 @@ struct perf_ftrace {
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	int			func_stack_trace;
+	int			graph_nosleep_time;
 };
 
 struct filter_entry {
@@ -203,6 +204,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
+	write_tracing_option_file("sleep-time", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -384,6 +386,17 @@ static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_nosleep_time)
+		return 0;
+
+	if (write_tracing_option_file("sleep-time", "0") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -463,6 +476,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_sleep_time(ftrace) < 0) {
+		pr_err("failed to set tracing option sleep-time\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -636,6 +654,26 @@ static int parse_func_tracer_opts(const struct option *opt,
 	return 0;
 }
 
+static int parse_graph_tracer_opts(const struct option *opt,
+				  const char *str, int unset)
+{
+	int ret;
+	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
+	struct sublevel_option graph_tracer_opts[] = {
+		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
+		{ .name = NULL, }
+	};
+
+	if (unset)
+		return 0;
+
+	ret = perf_parse_sublevel_options(str, graph_tracer_opts);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
@@ -676,6 +714,9 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
+	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
+		     "graph tracer options, available options: nosleep-time",
+		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
-- 
2.25.1

