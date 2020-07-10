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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58468C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF9E207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD436mmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgGJNpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgGJNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995CC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so2276300plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lpjq8ZIMCIw2kgGCZR7QJmknygRvu3BXPrSbtHBr5+4=;
        b=pD436mmiYqVtBjRXzBV0KF1Re5Hj1/MJT03RG9PNpem5R8xMeQjl1wh3kJcEyo4lBk
         HWgWNI4gKR3nJuvjAftQTep0kmjHPyBDJnYf6HKc8jD9gigPN9uw0bHnjlvnFpbyX8Eh
         tCjJSKvRzjXFbtgkMoLzLcsz4mwqpGeyJMJz+KxmsPkZwkdQ0xJLp0K2WAKxo0VVovOm
         H1IVh4i2CaGje3yT1nhAThyt2uYktuU3EcgQziRWZ9SJr1oiZEL2qj3UVRdizXKRiPND
         NCZTl3fFv3BCJIN6zhUmSKsmWrhU2IFTpYkCUlRZ1JX6bcNAxIK3UzlDRVRX30ncZ+cC
         9mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lpjq8ZIMCIw2kgGCZR7QJmknygRvu3BXPrSbtHBr5+4=;
        b=lTNwlRet0nQQCo67ieCDpI6kP09wTA9vPREwB8sWwk/Z81Mw8WbLQ9MqG/IsktKH06
         H/eGj71QFR/kbtO+MlhJ/yC25RR+npAbIx2hq+jcekaS21XSexc6gX93/gtwRbz6JuZu
         ZGbN63SDcVkngdzd8aFstIheQMoRzNBpXuTvuZCE1jmLp5+PRA1CZPzFMsRnBIs6lQRZ
         XZgYJJfd2X6KOhIpVqeTb63QvGC7lnRtYuDJd7yWwtCUNhj/bzU7xqVG+A1gTqA9vPKN
         wRCuSXrA1tA6kTwOuif0fuIcSae439hn1hiJpvEqHD3Hkxg4igsnNxezQWRUGb4zDpq8
         ra8g==
X-Gm-Message-State: AOAM531rd6GKAs2Pxl3ngFBh22rEYJJaGslv9bTJ8vDP9rEiO8EADWmk
        0d5qJI5BcYNjBqldXa5Trx4=
X-Google-Smtp-Source: ABdhPJyOX3aF0G5GdzZrMqL9hggUYIZwkCsVAf9m1hSXpKUDEwGGNrPMtNlznXYWw78RngeR6vW2dg==
X-Received: by 2002:a17:90a:780f:: with SMTP id w15mr5715171pjk.235.1594388695142;
        Fri, 10 Jul 2020 06:44:55 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:44:54 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 10/17] perf ftrace: add support for trace option sleep-time
Date:   Fri, 10 Jul 2020 21:43:15 +0800
Message-Id: <20200710134322.15400-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
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

