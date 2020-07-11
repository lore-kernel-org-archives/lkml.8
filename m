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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AF3C433EA
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16609207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKdQ2bDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgGKMnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGKMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6863FC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so3368201plk.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lpjq8ZIMCIw2kgGCZR7QJmknygRvu3BXPrSbtHBr5+4=;
        b=SKdQ2bDAgEhYK7n4PnvOPqYvYIxnUoWURE3N9znXLpTjlMIhnxK9rONNQhRDElehy/
         66NIQ8Vj2VxXRKCihAQGFyJ64qQ03oNVz6ryPuvc+9r+ADC/8mBj/6LYNRHalS43O26A
         YVu1fFfpq+Smw6JH1QGxvrufN4KP4uF82GPfQuMS7vs7AU/OdTDEGatsMSbk64NRYFFj
         YCzTs6EV9EDiuO/PVC5lIssKy85jRizhwVGoZZSCMCswYKN5WjkXVUxcic/ICg1bcQv6
         iwm4fy01ZiD7r2l8tY7CmtMwsjYHhk9c3WekA24Nr9WjsPIPjaznmb2/YKf1VMD/8tXB
         +R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lpjq8ZIMCIw2kgGCZR7QJmknygRvu3BXPrSbtHBr5+4=;
        b=ozK+YxAHfDkp5eLQKV6aKWxd0TXH+fvZsWeT4K4Ga+IuV1NJ1+QL9ULBDMdLGKzDUH
         o1/r6wxAZpKqNMe4qbfKM1S7QUf5u3mG6VHoFQAjz3vjYxldlHc7BFmRs8QGdec5oOoP
         1mk1rmzWylxDOAqomEwz1ikijNuW/olcdwM8yBhJ6m2JJNfth7dCxXUpI1cTNVt58gwi
         M5ptyFoK/jsNzBhgU5bi3s9iseJZbYRWDl2JJsv7yLfFuBOu/qtclMfE3j07SvMrlk1C
         tGm1nA45AqF/9/g9NR2Y3a1cLy10uRgjvAzo9Q5rdJvILoki0wnruO65V6Le4F2loAH2
         usfg==
X-Gm-Message-State: AOAM532ZleRIGITey2dvfHtz2Cx4ugWH+TUFbYh1sLMhctkGyxj2TGse
        xLgckTmK05UoskayhXGkyy4=
X-Google-Smtp-Source: ABdhPJxCSAdPSkcn0pWOvDk53DdDYLIOfC5tMZbuuPRy3eNBKb7hF6ESRZ2XMeZbl2xAKoJd0EAgjQ==
X-Received: by 2002:a17:90a:80c3:: with SMTP id k3mr10518461pjw.102.1594471393014;
        Sat, 11 Jul 2020 05:43:13 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:12 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 10/17] perf ftrace: add support for trace option sleep-time
Date:   Sat, 11 Jul 2020 20:40:28 +0800
Message-Id: <20200711124035.6513-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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
index 676a30cb9b5a..760c2b78c305 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -102,6 +102,10 @@ OPTIONS
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
index 91611eef5deb..b4eda459ba78 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -42,6 +42,7 @@ struct perf_ftrace {
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	int			func_stack_trace;
+	int			graph_nosleep_time;
 };
 
 struct filter_entry {
@@ -200,6 +201,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
+	write_tracing_option_file("sleep-time", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -381,6 +383,17 @@ static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
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
@@ -460,6 +473,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -633,6 +651,26 @@ static int parse_func_tracer_opts(const struct option *opt,
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
@@ -675,6 +713,9 @@ int cmd_ftrace(int argc, const char **argv)
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

