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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B5DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F032B207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="texWblfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgGRGti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgGRGti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:49:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F51CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a23so4827903pfk.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uH9FmidZkMqeDhyoNde7P2iPFWOBXIbSIju5FSPIJ3w=;
        b=texWblfbzLM8EGDqzhgsEJVvCBZiHY7n9fxx7HSSd+rNlVQnAQIzFmzJgN40OWo3m/
         BleQ5ypIHkaIn/gYlMaHW9x/hEiRE1hRom/MW+kl6EhZSK03wWKokGNyKpPwQd1T0iH4
         ZL11ftTm9DEvz9b8k3EkU8nmWUWjfKAW2vKoNtFhOzAtG3JWz72zWxU3sq3bIGi4ac/b
         uO5ypjLweO3Y69Bfeq7pmJZonCdYKRg/Y+5DhB1+Pw/JQa2U7oc5fnBtS6htNA43cR+9
         5QMmHmivZKjYmOhjqSdgFoDqGykjwMD1gqQhEDN79LeNegf269CB3MCwCZ0NHsL8DwSD
         8bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uH9FmidZkMqeDhyoNde7P2iPFWOBXIbSIju5FSPIJ3w=;
        b=mDTDhy+/QPYbdD2FRLrRksdZM4amoxsGnIqxzYOIP7JRsN1DtEij4MTDxzkXCVFqOl
         yVZvP7K7wQ6n2B9jQQsjKz24fEjIoTRneFkitLg9bn5Z7uX9XBbvLBL7H3y+/3xxu3/1
         BWKHUFdQiVSBLf8GymdpXuyGDfYnw37tdAT/PpTO0d7bRqXf05xILVQ5g4O33UDSbXf4
         mDF4/bCmR23SpAHHBszmfLxM018NYAuHRRPDvxfqIgewFSde583xmKFPq0Lw+CZ1B6eN
         0MHWu9AF3+aGZkcHGGTMkV2TQksWazHsL/CthqVRH1ef2K1NM/QKEcAmRjMr8BsKpqHW
         1eiQ==
X-Gm-Message-State: AOAM533UsZxktMrUAYK3hoqKfQ8C4jGy5VaIHj9zagqKUdwqUuKbghay
        2+LmGokoW9u8ankrZxCSxTBGqhAvPIU=
X-Google-Smtp-Source: ABdhPJy5xng9yz5oL1qGdrYkSF8cMxJOzaXxGZE/+Cu80JwkWottNcXHsl6b6xuof0ZZGOnMjYQw3Q==
X-Received: by 2002:a63:3c16:: with SMTP id j22mr11827667pga.335.1595054977972;
        Fri, 17 Jul 2020 23:49:37 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:49:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 08/18] perf ftrace: add support for tracing option 'func_stack_trace'
Date:   Sat, 18 Jul 2020 14:48:16 +0800
Message-Id: <20200718064826.9865-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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
index 3eee073a7042..5a5069306141 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -74,6 +74,10 @@ OPTIONS
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
index 765ebd56e05f..e7c8697294f0 100644
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
@@ -200,6 +202,7 @@ static void reset_tracing_filters(void);
 static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
+	write_tracing_option_file("func_stack_trace", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -276,6 +279,17 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
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
@@ -424,6 +438,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -597,6 +616,26 @@ static int parse_buffer_size(const struct option *opt,
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
@@ -627,6 +666,9 @@ int cmd_ftrace(int argc, const char **argv)
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

