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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F738C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF5D20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT4o2lYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgGHQsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbgGHQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:48:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A354C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:48:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j20so4535005pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ub138swfr2oCacU7jol4ByzNM0/jOrTciohyH/GxRrg=;
        b=QT4o2lYuYI9sNpET+E6XYwEjCSoz2gl+R5PxneARblL0/a+HWBuqx1y5GNQjc+gg7p
         6449p6UUQCi6tgE1Y4mMt1nfXJ2Dh5tIH7VHBuHqPbkRSuv1na+mFVIihxKmW+vKPyky
         5Xh5w7u5EZ7mTh5FurhRlQNnLhMPQJ3NMb7zGE+h53EmGV3IyOMwndufitRsEtPo6olF
         eWFAvYW8gWX6IwNoWSOxY89PMW8LK5cLlqCPtq7xNUJAbf4y54SkTPnacstjE/4Wy3Yd
         EZqgAg5ictvkKAfj+bQfv4xU+0+wyDN3Na667jQc6sPAY2hISLaNphnhh2KjMKV2asmP
         p26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ub138swfr2oCacU7jol4ByzNM0/jOrTciohyH/GxRrg=;
        b=b06J+e4Ml1jorojfadxrZCKmk7hBXdoEatP/8n8260DgGKwKGAreerbgzlncs6OHMJ
         1zYKrXLZgaWC43qTmWYwlJ3ABvTpsXgy4c8SMcdc2QtNMhngSBD/Js/qnvPC1fdnNJcz
         9xgav3F2KUKxxNU9lgpn1K1JD5xg/EaU96OXEPyBxpoLbKs1Pc2RxJWz+rcuh81Ir8vV
         1Qh74YpGHYGMbkGlqt+FR4m+b9W4QZeJs7THY12g18+zLgTgtbiclh3kBDnGyriS2JDl
         woLR2spulMo0Liy1ExnaXr2ga4x3BZJRbGUWEjeK9R/CSsZrh5QqRXNp9BMRSNmeezgc
         zxkA==
X-Gm-Message-State: AOAM530Qn9PkGJdXm1tC8tswEp+w2t24lnIGq1A5EoaD/3JbnYvSOW6M
        Z0vxGrOKYn49EoRENGn81Us=
X-Google-Smtp-Source: ABdhPJwv2ZPprirbVjZ1R4yo8YZ3+Bm513yp1cHSJO8h0FJQiYqLUbwHp2A7gwy5nUb7OGzFz6Hwpg==
X-Received: by 2002:a63:531e:: with SMTP id h30mr48451272pgb.165.1594226887806;
        Wed, 08 Jul 2020 09:48:07 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:48:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 12/17] perf ftrace: add support for trace option funcgraph-irqs
Date:   Thu,  9 Jul 2020 00:46:00 +0800
Message-Id: <20200708164605.31245-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-opts noirqs' to filter out functions executed
in irq context.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: option name '--nofuncgraph-irqs' -> '--graph-noirqs'.
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 2165a75f1da1..5cc1f83795f5 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -109,6 +109,7 @@ OPTIONS
 --graph-opts::
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
+	  noirqs       - Ignore functions that happen inside interrupt.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 57d04d0e1178..330dac9ffe3d 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -44,6 +44,7 @@ struct perf_ftrace {
 	bool			inherit;
 	int			func_stack_trace;
 	int			graph_nosleep_time;
+	int			graph_noirqs;
 };
 
 struct filter_entry {
@@ -203,6 +204,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
+	write_tracing_option_file("funcgraph-irqs", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -395,6 +397,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_noirqs)
+		return 0;
+
+	if (write_tracing_option_file("funcgraph-irqs", "0") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -479,6 +492,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_funcgraph_irqs(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-irqs\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -669,6 +687,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
+		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = NULL, }
 	};
 
@@ -725,7 +744,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time",
+		     "graph tracer options, available options: nosleep-time,noirqs",
 		     parse_graph_tracer_opts),
 	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
 		     "ms to wait before starting tracing after program start"),
-- 
2.25.1

