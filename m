Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907A3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7D720717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4JtMgPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGQOiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgGQOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:37:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE876C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:37:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so6448291pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5jlKEkgzpkLmb2vCNuFzmtt6H/DTwedr4QScCX86FM=;
        b=p4JtMgPOd47Z7dcaxUBx6PcGYLGRgrhS80tvwHp7xWiU2rSEAKWw2WhgEELFCobYOh
         EMrg1qlPatXXix1nrftmZQlFeiuhRIr9fP35ySkCMbl6Qila/Sit5OpEwcN4YxANV9xB
         FBtTtCxlIaq73x4ClHY/MKjZ1ZLZV/EXwcRpQeDsTycIOP2Xv8Dj7zXskmthz/BapOci
         sJKhwzXesZzpSBrAVb2FdRmASB8Znpdh2FcUzF6OldHSjaqEcYQaPzXHFfvU+PSQzL09
         2qoTXqMbWJE5YvIb8UiDBfIPhXgnsvBFiYU+dmoQk7E5IYFoydcQrX/4HXdT4DRgZKUd
         knCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5jlKEkgzpkLmb2vCNuFzmtt6H/DTwedr4QScCX86FM=;
        b=oxbdAvOURXURpL92AVlodNZ3VL/vxD4n65JrMJ2fDalAqRC7fBNc5aFA1wgH6HP7X8
         2fSOgjlpkfOLHRke4sNrgnuMDZAku51T8QZx3J3TYlxAOs8CFkRM4bzmGr1uB3M8zQop
         aGV2qkEWd5nPFtdAgZLudKB0giCFkvmmUapF1gH6weHvcxk98LoT0NX1aLcCmsx8ymJu
         U8tbIbvUWz56tCf9V0thoSIVT16MRILzXz4z164sEnupTBx37CjccEMng2xT/AouZicE
         EVHEJ1heWZWZ5DltTXx3fA8a5vrCbWN5691d1AIfaEUAvp/GPoGwvzW0yeOO/dA9Rgle
         1AJQ==
X-Gm-Message-State: AOAM533JGa2XmaX9Pwz+bpO2G+WgJwVb2o5iZoBuuSanoRk4lnxkUrMi
        aKXSx4ADgKWtjQFAWKwhuW8=
X-Google-Smtp-Source: ABdhPJyiyXOH3hu8V4ZGu3AsC76FVVr48ObzvXvCDc/q1AK90bRBrn5QkUX7WkuB9x4/Exp7hO6diw==
X-Received: by 2002:a17:902:fe11:: with SMTP id g17mr8234618plj.145.1594996679278;
        Fri, 17 Jul 2020 07:37:59 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:37:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 09/17] perf ftrace: add support for trace option sleep-time
Date:   Fri, 17 Jul 2020 22:36:20 +0800
Message-Id: <20200717143628.47721-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
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

