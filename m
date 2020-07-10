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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85381C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623942082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpK0zbKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGJNpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgGJNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:45:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C8C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:45:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so2639726pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grZiNUXxO5Gku/+KU2rnghwGFFTqDfKaKvmZrXKFOAs=;
        b=OpK0zbKWOchlQ09TIm+jEOEfIfAQFNQHiYpb5IqLlh/6R9eDLBlMYKw/5GnbLAHPXV
         staFiCH3C0u7qokJfBvYK8BhP4lh/j6wJBw8mFIHRDzYgU1CpQOihSXOvQLElXoOxzhC
         NfEOPAMMOruIdrMtdGldTFpwY3Fx/+ZF/c6gybepz8pzYt0KN6rVAoTE6yYQkpXhNtgO
         OGuCyrAERKp8bqqk5SANNsbyUgwtvNrHzULqKDOfcmgvE5DDG8x+ITdSzQ6hD2KmQdds
         SET6tmYZ8OfhFcQWd2+uvKHMVtPGDzgA50j0EekVM2eySfXaiMvpJzgi6x11vIjfVi3h
         pQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grZiNUXxO5Gku/+KU2rnghwGFFTqDfKaKvmZrXKFOAs=;
        b=WJBX4W+MOUFL0D7jDsXjXKqYSlV1d6XoTU3XyBJUD+WnvM6mwjbBi6mmj9IjKGH45G
         C5CW0jvmliZTy7MX4z8eIz3IbA8DurKWeNZh3hs6K8D6PPZWUBjH1ICXFovXa3V80CX1
         Aqj5tIVrUZeoJf7GIyuBJqLxlXeqSk7JXoIfqDshrp9bloixM8yJRfIYgz7EXCJEFc0q
         7E16jZwrAlPL+gEdAUYfdUgZb+Cwp7+NaIBxmd9fGUu4YOXZBVXS7nzZp6gNeyq58fv5
         p7AQXvHAvRFGuK+/6qOM8I62vvyogXcV31lxrOkvgq0DmcsMNY93JvIxkPiLeZl2vtS7
         OK5Q==
X-Gm-Message-State: AOAM533Oi1xxzk+ggYBmefAySjdS1Ds2k6+FsQVlXS7xohEbHKVFRYyI
        fiQa6lXP1/6gh1AYRmUkT3Y=
X-Google-Smtp-Source: ABdhPJzFKxVVOC1yLaR7x3E1xNoueHJeWuHMu2K5soPd7pBdLR9WWWTH+nsPma+uDtdNFftey6lmUw==
X-Received: by 2002:a17:90a:ea86:: with SMTP id h6mr5540146pjz.167.1594388703150;
        Fri, 10 Jul 2020 06:45:03 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:45:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 11/17] perf ftrace: add support for trace option funcgraph-irqs
Date:   Fri, 10 Jul 2020 21:43:16 +0800
Message-Id: <20200710134322.15400-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
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
index 760c2b78c305..2e16e1e588d9 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -105,6 +105,7 @@ OPTIONS
 --graph-opts::
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
+	  noirqs       - Ignore functions that happen inside interrupt.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b4eda459ba78..179c5da678e3 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -43,6 +43,7 @@ struct perf_ftrace {
 	bool			inherit;
 	int			func_stack_trace;
 	int			graph_nosleep_time;
+	int			graph_noirqs;
 };
 
 struct filter_entry {
@@ -202,6 +203,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
+	write_tracing_option_file("funcgraph-irqs", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -394,6 +396,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
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
@@ -478,6 +491,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -658,6 +676,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
+		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = NULL, }
 	};
 
@@ -714,7 +733,7 @@ int cmd_ftrace(int argc, const char **argv)
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

