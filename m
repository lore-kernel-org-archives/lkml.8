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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A66BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117412158C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQAFJhnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgF0NiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF0NiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB040C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so1051437pjw.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0kR7PLuVW+8hDOGilpyP2dfMp7eGXDRIgpIqjORDuA=;
        b=SQAFJhnjCOyVG+zUdqyMm7esXb/F47fkzBvEhA9KwSCVqbRuQ+yTUBKTO+0X2rYBMN
         RQXCOnAfnGs5kHIKN/1AUBuokJ2SBZeAFB9dDLYZ3HH00ijiBgKHU3uyoi8JHSWV68Di
         RUFZnqh265VbNXwP/J79KO9hzFYWwNRVQY30GTI4+/rBv8rgKw/NVO6ZT0efiRZwU/x5
         xQuKGqFjlabhbPQ4drdx1A7WKil07771RIWBa37BH9eqiYXg/mdcKhuLaB2VWmudPK6M
         GL1ENllG213uUzTFMPIMHOnI2afpZ6ZPBe9ts3L/TSa58p9E0vblbEpuMamWCl00ceu9
         ufQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0kR7PLuVW+8hDOGilpyP2dfMp7eGXDRIgpIqjORDuA=;
        b=XI6Ztv7zkf7p2Y6DgXA67p4GbUkzyz4DHmg6mZ5ZvMYioD0CEQWdJPdCdxOQQglaXr
         ht7VhTW/EnirCd0pheE7eDefjOFMIWcHYd2t5Fqa7SwrA4FAk6xSyhsxZ8WEFyjLbSFB
         0T3SkeHYp5xaba25QTXYIIlv7OW/8ccJ+ofpuc6d5G+dphyZ25NQ95YRrVHWy+N+06gy
         TCgJ9B+NMFYohE+YtC4xFMxc8dqD2b/m5O3LSEqXGmmJjhVO+IsE3bsBeRFW3OOLeK6f
         Dot2RbdaQXymR+7kfOHTguf/Ka5WmfvDXtKtkfvka7kN5ivcxo7rdKcEBVTGdzvvqkX6
         KnqQ==
X-Gm-Message-State: AOAM532PxleH4om6TnAxeTEa4WZ27UHyNJdIqAj5P6l8MQwYbTAZrGHs
        VdMvc5yYt6xyjag00aeFlqQ=
X-Google-Smtp-Source: ABdhPJxaiMq09ByQkOjkR9IvN95NbS+9fEspTvRBIrxHyZ7UCoF93rS96cN+CX7bcAoVIh8tVA5Tug==
X-Received: by 2002:a17:90b:e89:: with SMTP id fv9mr8410891pjb.131.1593265102509;
        Sat, 27 Jun 2020 06:38:22 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:21 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 09/15] perf ftrace: add support for tracing option 'func_stack_trace'
Date:   Sat, 27 Jun 2020 21:36:48 +0800
Message-Id: <20200627133654.64863-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to display call trace for function tracer. To do this,
just specify a '--func-call-graph' option.

$ sudo perf ftrace -T vfs_read --func-call-graph
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
v2: option name '-s' -> '--func-call-graph'
---
 tools/perf/Documentation/perf-ftrace.txt |  3 +++
 tools/perf/builtin-ftrace.c              | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 66876e79cc24..94cdb2ebdf34 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -81,6 +81,9 @@ OPTIONS
 	(or glob patterns).  It will be passed to 'set_ftrace_notrace'
 	in tracefs.
 
+--func-call-graph::
+	Display kernel stack trace for function tracer.
+
 -G::
 --graph-funcs=::
 	Set graph filter on the given function (or a glob pattern).
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b2651b9bd6d0..bbfa7973b4fa 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -41,6 +41,7 @@ struct perf_ftrace {
 	unsigned		initial_delay;
 	unsigned		buffer_size_kb;
 	bool			inherit;
+	bool			func_stack_trace;
 };
 
 struct filter_entry {
@@ -198,6 +199,7 @@ static void reset_tracing_filters(void);
 static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
+	write_tracing_option_file("func_stack_trace", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -274,6 +276,17 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
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
@@ -421,6 +434,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -605,6 +623,8 @@ int cmd_ftrace(int argc, const char **argv)
 			     parse_filter_func, "*"),
 	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
 		     "do not trace given functions", parse_filter_func),
+	OPT_BOOLEAN(0, "func-call-graph", &ftrace.func_stack_trace,
+		    "show kernel stack trace for function tracer"),
 	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
 			     "trace given functions using function_graph tracer",
 			     parse_filter_func, "*"),
-- 
2.25.1

