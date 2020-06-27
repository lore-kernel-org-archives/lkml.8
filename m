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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3DFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3452158C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZc7wCN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgF0Nie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF0Nid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E5C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d66so5901013pfd.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ocw2nj/QVIoY2spNhYqY3tBQTGjW0GRqvaOQC3+0V3Q=;
        b=gZc7wCN3Q0aFTa3xt/58lyQ99wLUnqqDWIjWAdPXYdZnvQ5gRPprS4jOxfbCqrnTXF
         2FDwrK94gjYff0OJkKnZ4EnplHfKsIXe8DUrZSvmI99kjQoe1n5rsBHewMnt+Pv+yArP
         XRsolwbxeiUO450FTDfgGCWn5ci6zQUCg0iZPVSJ3K9TecAl0T8KvguBaY0E9mO2KmNj
         ZiAW+7hR+tZ2GHQRmaue/x2J2ifWBHYOkmaqs2rxiv7NJzocW1jmDt24acJSAzVPtoVm
         V2KSfWIDee6sI+7WGrM+NiNDMcfwFuDLGf0FdtBkc0qDv5VCY1mI00QWJumsMJYfOAOv
         9bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ocw2nj/QVIoY2spNhYqY3tBQTGjW0GRqvaOQC3+0V3Q=;
        b=si72OFhKFTb8xxlT/cLqkDdA9qBl5xwnnaXZ2gLCZVIJ0fRUZthcHsWzSGJVw86Xw3
         HNif2LO9jVIfjcajZs9SNKcwTr9WBEIsTwWa7kV5FHEh+hSN4rWBrEWr8HgeeHbwqNJh
         J1Pa7aLXjD33CI7wc8CZGO+/dCwjjOy/TvQyhcR0sQkMFvaZu5hwHGFKgZcknalNg6s5
         8gVD1PsBjESDRZHi2m+Cu/fbm31gDyCTmhhJ1+1HxXT6bGEuJgdqj11wk7BmzUihN02A
         6jJrryPUY15PWoJx+IyyRz0A1CB2Q66nDgVh2Cp95weSQm6Duvc9Q3CrXRZoJX4mfXsK
         nJeQ==
X-Gm-Message-State: AOAM532byIHnOJNJ+Cgvw3YH1doICDeZ8tGuHV4bL8vBPKqGAlWKVRIT
        9G0UjXfEMTcw2MgJTTsrA78=
X-Google-Smtp-Source: ABdhPJz3Zr9ATC4RKsBrTYX2SnHNkTPv2I5T+LHRzCYy4toTiJsgdK6TctZ3lZ7Urfi3SN3pqqo8RA==
X-Received: by 2002:a63:3d85:: with SMTP id k127mr3082952pga.29.1593265113645;
        Sat, 27 Jun 2020 06:38:33 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:32 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 11/15] perf ftrace: add support for trace option funcgraph-irqs
Date:   Sat, 27 Jun 2020 21:36:50 +0800
Message-Id: <20200627133654.64863-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-noirqs' to filter out functions executed
in irq context.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: option name '--nofuncgraph-irqs' -> '--graph-noirqs'.
---
 tools/perf/Documentation/perf-ftrace.txt |  3 +++
 tools/perf/builtin-ftrace.c              | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index a3000436f80b..b616e05d5156 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -107,6 +107,9 @@ OPTIONS
 --graph-nosleep-time::
 	Measure on-CPU time only for function_graph tracer.
 
+--graph-noirqs::
+	Ignore functions that happen inside interrupt for function_graph tracer.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-trace[1]
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index eba125a60820..876c8e800425 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -43,6 +43,7 @@ struct perf_ftrace {
 	bool			inherit;
 	bool			func_stack_trace;
 	bool			graph_nosleep_time;
+	bool			graph_noirqs;
 };
 
 struct filter_entry {
@@ -202,6 +203,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
+	write_tracing_option_file("funcgraph-irqs", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -393,6 +395,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
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
@@ -477,6 +490,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -658,6 +676,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "trace children processes"),
 	OPT_BOOLEAN(0, "graph-nosleep-time", &ftrace.graph_nosleep_time,
 		    "measure on-CPU time only for function_graph tracer"),
+	OPT_BOOLEAN(0, "graph-noirqs", &ftrace.graph_noirqs,
+		    "ignore functions that happen inside interrupt for function_graph tracer"),
 	OPT_END()
 	};
 
-- 
2.25.1

