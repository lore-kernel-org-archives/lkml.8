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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F055AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EA12074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR44F2uK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgGRGty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgGRGty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:49:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347EDC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so7479361pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPCZkzgvYsNx67LrNj9/kDqAKiM3/VI4Z3LHYpW0hPM=;
        b=DR44F2uKmgv5ogvECpWmfTDMqbd7LvU6cXos08L931agcf7gA+/HidpF0ezD/IxL8Q
         PBoZ3cdTnBp0QxyqexNhqdIwvCS3ABRJwOFwimjJzfbAKD65jcwUhUaeJ6GQO2iZszLY
         JOKTjOgS3PRF240lMRzLpAsISEfrAecNpV8HDPhnAqi+ExXYJgx2iMcYwoBb+eWJnC8d
         SvXLUQJFykK1dIE8wO6CpvN9JSMj9K6G4zcGZq/mmwyeTUDASAz64TxcwnWJrV3MBaFK
         HcZX41/Ay0D5BZwLlaWQ35gN3PbPs+BToTqlI3I3mLcRyJLDmn/nSeGDIPsybrJblD+C
         OBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPCZkzgvYsNx67LrNj9/kDqAKiM3/VI4Z3LHYpW0hPM=;
        b=nR8pTkyl0ej0Fr/lpgaBi1aSeqr4pWL4x8mBtmPpjZde544q61mqx47vDShf+7Jvwg
         fXVBH6/dD1GjBsVYojNC3iBZLZpLR2j4VQQvzOBMhmVXNOFIIiKBobQtZDJ2UJTOtdKs
         XpwnFFAm3XfGCMRuPQ5/FD37wVzVMUw8wAI8CUabK14m3g1EB6AkbdbiKKUAaygWEdpJ
         dL6QjthHTt/4gZgvOlLQMf2h7Z4aNNYAEiWGa8sFZ39oW61S1mRSwcrW9agUMShtuzot
         g6uFfZZyvRDgwQi8HkVy4X7k5wdWQj5G0yAWnY4Jox9iIfoewBOgGm76nsnlWYYj5qt0
         vOSw==
X-Gm-Message-State: AOAM5314ngxmaf6g8A7u3LafzUSK6IjEC3jv+1xzYpwEsssVwA+aPF5a
        bETZLiow/tMGQMTmF+yERa6jupSIBj8=
X-Google-Smtp-Source: ABdhPJw7XA9mA/IVpV9glz818W8UMdwYzLzcKzFJvRqp7oMUHuC+3F95LbPSZo183kIyWtaNKBOjkA==
X-Received: by 2002:a17:90a:3d0e:: with SMTP id h14mr865567pjc.184.1595054993768;
        Fri, 17 Jul 2020 23:49:53 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:49:53 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 10/18] perf ftrace: add support for trace option funcgraph-irqs
Date:   Sat, 18 Jul 2020 14:48:18 +0800
Message-Id: <20200718064826.9865-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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
index 2968a34239a4..21d3b444587a 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -101,6 +101,7 @@ OPTIONS
 --graph-opts::
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
+	  noirqs       - Ignore functions that happen inside interrupt.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 835f810985f0..6402df3984c0 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -43,6 +43,7 @@ struct perf_ftrace {
 	bool			inherit;
 	int			func_stack_trace;
 	int			graph_nosleep_time;
+	int			graph_noirqs;
 };
 
 struct filter_entry {
@@ -205,6 +206,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
+	write_tracing_option_file("funcgraph-irqs", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -397,6 +399,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
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
@@ -481,6 +494,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -661,6 +679,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
+		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = NULL, }
 	};
 
@@ -715,7 +734,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time",
+		     "graph tracer options, available options: nosleep-time,noirqs",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
-- 
2.25.1

