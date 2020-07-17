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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C5C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FC620717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4A5RSHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGQOiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgGQOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:38:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858BCC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so6777529pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPCZkzgvYsNx67LrNj9/kDqAKiM3/VI4Z3LHYpW0hPM=;
        b=e4A5RSHJzLKYYmJIAuDtrFFUsjcVRNq/2nWdZ6hWoALGfeYSv+A9PrfkR805dg5FvG
         UkGtCo80/8Afl/K4AObFhfOzR1ZIJztSlr3u9DkeHsoW794RUpjDv1l4KEzIDzv4DSiJ
         f2DtDt4ikbqncwNxBON5b/RjolYNu47H1hwKhwnufBM4MIo/+I8nr/IL47rFSOiSgHy3
         QGhtQ9675XB4iM3xG8nnrb6CONH/F2V4wq+gwIQg3JTpt+NnnA5X7nyTpkVf773137tO
         ALhRGQvCZPAabOtCRSKirAJcQcRH5//mOZKRnzqprOabFW9PW0s3SvbJ6TXT0wK48bRn
         jIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPCZkzgvYsNx67LrNj9/kDqAKiM3/VI4Z3LHYpW0hPM=;
        b=q9yUVF54Dck2LPJ2b9kCfQM8LgALLs5ur0C0dqJqZphre28CuBrrwOPgM8rgNeOg8P
         E1hTo0iHuoWwU2gnLHJexvThmgN5BTOaoql9dNmLETFBEvhK7AqojoHYIk131f8fUx4r
         c+o0ZKV2gbIJvVSQMkDn7JJ/LyfFfHRDTuyObF7hPpoHpa096q+5vrGziWrA0Ryi/MN4
         vpgcrCVDiugkIJZO2zP/f7Jgdai4sMOjT3DqXyHgfR6RiRiCtFXCLdcqbYgnJFQNcP+z
         TMoQWia4iJv9xR7Bfcy3+mcHdqCi6LHbro04V7BkHQOYY3C+GhhM7YGl9xHq78bUXire
         eMFQ==
X-Gm-Message-State: AOAM531KbrQ7YSsIysUYT9GCE3u/RSq1j6Wl0/J8GYOmigFhK4cF4cn2
        fPxtY1lWH2K5YOt9kfkUYRU=
X-Google-Smtp-Source: ABdhPJzY4FNTwbyJa3FOsR6gDiPxCrRka+31CvSbCpMlllum8px3/eq3wBXB3JZcOZMHvLPla6QnZw==
X-Received: by 2002:a63:7c42:: with SMTP id l2mr9192309pgn.35.1594996684084;
        Fri, 17 Jul 2020 07:38:04 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:38:03 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 10/17] perf ftrace: add support for trace option funcgraph-irqs
Date:   Fri, 17 Jul 2020 22:36:21 +0800
Message-Id: <20200717143628.47721-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
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

