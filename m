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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5849DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29491206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/aO8FC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgGHQs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbgGHQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:48:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7DC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:48:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc15so2268102pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTvWHNSnBehB9sglmJ129ws7d9bBoJ6ram4esEfWsG4=;
        b=i/aO8FC2PGdpNIR5x/wzkjU9aEs/jqBAVgjyyN50O0mci6ApXEQVvByeeHSmTJYfNi
         cnHH74vCb0K/hL+f38RfWAcwGkqVnkcbF6f9+IiAztjqt4aXmcO0zObNcYVKoy+pYkPU
         S1SbA6XDNPEl1rPIBGaIF6EX8aztnkGIiI5iIv69XipNRuA3JxJrCJtpERY45dlW5b35
         xqNPKNytDBzEy3B0bJIOeRjfV3ZDw5I0KcTqg96mJCyPukbtkLQ8cZnMnf03zg9O2Uaj
         HRGcZHvEQ+bI59Nmvi+lzVY2oDRp3iWWXsF9EyaE7+MUCkxyTW3G+kKKSS4o0qFJWo9j
         REQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTvWHNSnBehB9sglmJ129ws7d9bBoJ6ram4esEfWsG4=;
        b=KWj/9vi+GDrrN8uk21jGgYgyT0CELzQx84yABN7oXkulK5iEtZrzI2TDo6UxrwdHiC
         iL73+dhYMojdlL3Fx0mlI77jH5z+fVI1l2Kz/MQdIYju/Swj4FvV+cuzUjs1qSURWARj
         00+CpIGW1mzLp6mbxSZ8SGm2g6wru7nM8zUJb2D5vP0oO17tuD/LuJzOzT0U7LT7Xrjk
         i6+e2PV+QBSRyQ5c2pknYDid1B5ZcklaehRHVE5Vjj48xhw/O6oolF81uNSGtV5JlpEu
         u54ozfZ/KgMt6qA3BBx2w13+Kiha06BP83qt3d/Z2rt5sn3AIkibhGWzkA6HRkQaQXFx
         ZKfQ==
X-Gm-Message-State: AOAM531iCDt1mnkdbrITC1xxcZAfX/rUskHrVTM6YJFLLaiI6MkwcBCD
        IwZoZRQQcAJxOrfX4y70WtQ=
X-Google-Smtp-Source: ABdhPJyIgChmA5aso2YMHonjdjMmWNaZ5SKn+fmmyMlwgj/JtOQqqX0lqykrIfqDyWrW14blw6VlQg==
X-Received: by 2002:a17:902:d685:: with SMTP id v5mr41612794ply.117.1594226907708;
        Wed, 08 Jul 2020 09:48:27 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:48:27 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 15/17] perf ftrace: add support for trace option tracing_thresh
Date:   Thu,  9 Jul 2020 00:46:03 +0800
Message-Id: <20200708164605.31245-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-opts thresh' to setup trace duration
threshold for funcgraph tracer.

$ sudo ./perf ftrace -G --graph-opts thresh=100
 3) ! 184.060 us  |    } /* schedule */
 3) ! 185.600 us  |  } /* exit_to_usermode_loop */
 2) ! 225.989 us  |    } /* schedule_idle */
 2) # 4140.051 us |  } /* do_idle */

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 26 +++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index e88ed3865c8b..bcb1504892ef 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -112,6 +112,7 @@ OPTIONS
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
 	  verbose      - Show process names, PIDs, timestamps, etc.
+	  thresh=<n>   - Setup trace duration threshold in microseconds.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 8c537bc6adbb..21d6d6791dc3 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -47,6 +47,7 @@ struct perf_ftrace {
 	int			graph_nosleep_time;
 	int			graph_noirqs;
 	int			graph_verbose;
+	int			graph_thresh;
 };
 
 struct filter_entry {
@@ -230,6 +231,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	if (write_tracing_file("max_graph_depth", "0") < 0)
 		return -1;
 
+	if (write_tracing_file("tracing_thresh", "0") < 0)
+		return -1;
+
 	reset_tracing_filters();
 	reset_tracing_options(ftrace);
 	return 0;
@@ -442,6 +446,20 @@ static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_thresh(struct perf_ftrace *ftrace)
+{
+	int ret;
+
+	if (ftrace->graph_thresh == 0)
+		return 0;
+
+	ret = write_tracing_file_int("tracing_thresh", ftrace->graph_thresh);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -541,6 +559,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_thresh(ftrace) < 0) {
+		pr_err("failed to set tracing thresh\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -734,6 +757,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
+		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = NULL, }
 	};
 
@@ -790,7 +814,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time,noirqs,verbose",
+		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>",
 		     parse_graph_tracer_opts),
 	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
 		     "ms to wait before starting tracing after program start"),
-- 
2.25.1

