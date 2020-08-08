Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C99C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94695221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSNea9G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHHCjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764DC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so3507145qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/NIk4L9u490pan103JsMtGnLiyDndWnod1ksgJh8xhU=;
        b=oSNea9G7WQk3pEEjcX7cTrIfRfAdf27ihCGNMAZ7Qls6kRXpBY31Aw3BXveO4N9b3S
         N3CYdZX2d53Pd9+V3fnHbn2VZ10nygmtxLnKA6/W/ItkLqnlWxElb2sYRfTefOR4EkQe
         vhEv7MEjbUkqVLJu06sVUn294i4GVZ+UXGGYE/5HzZ5pEz9X56qjAzjbel0UuqXWggvZ
         p98PnRkdP4U9uBpo8OzMIfbfHJYmaL7LK2fDvn8CqCJqGgPAxO3BO0v1KfFByW3I3MDL
         7lsQUiaFj8+V1aPamgSb5rBJWOK+cVFKVm7zS94KRGfdz7yQMRXrpRdNXONU7uZWGGZD
         Qi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NIk4L9u490pan103JsMtGnLiyDndWnod1ksgJh8xhU=;
        b=C3QojpiV5qRP2upfrKsHIckJpw7rqPu3JXi1AZL8fDB68FHn/U8EzN2oaJLCC55edz
         GPlwex0yongq/Lfqzj2nhNH9ugX7CZFb3qtBVWf8IYzg2eJvrcdjQMSJpTeIgYNNdxKU
         djoyhFktLHIElYg6Y7wcvyOQJS+pOA70MD6G7o9y1fPR7XDqCAmQxqq0mO31DCJHAXMY
         fE8NsVE2QdqjE1XyrThCVMogsHBwSClEYEFTgno5cH4gD1DT/IH3twjUnzEl8IIvjXJQ
         l2Vv4bCbLGRzbwxPOl3LZmdzUECf9B5LX3Ec5a/953VPhJ9O1ZjZKAF00P5SoYBuJkhO
         RFrA==
X-Gm-Message-State: AOAM532Rq7rGvhzg7gXTDQOQp3lyyAVON+z709EBdvZLKzbHhGQuv+oi
        MvOV3zjQ/6203TjW5Qn0DRw=
X-Google-Smtp-Source: ABdhPJx8nsTKm7hZb/N9qJePfFMMcLxIOBV3ZiFkdLz7zxDNKblbn6AR6dqKSIw42vf6cbaiaDWsew==
X-Received: by 2002:a37:9d0d:: with SMTP id g13mr16519975qke.165.1596854371346;
        Fri, 07 Aug 2020 19:39:31 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 10/18] perf ftrace: add support for trace option funcgraph-irqs
Date:   Sat,  8 Aug 2020 10:31:33 +0800
Message-Id: <20200808023141.14227-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
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
index 3380a2e2c9ad..fca55ac55ff3 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -104,6 +104,7 @@ OPTIONS
 --graph-opts::
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
+	  noirqs       - Ignore functions that happen inside interrupt.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 47d63bba6a48..b4c821be4fb5 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -45,6 +45,7 @@ struct perf_ftrace {
 	bool			inherit;
 	int			func_stack_trace;
 	int			graph_nosleep_time;
+	int			graph_noirqs;
 };
 
 struct filter_entry {
@@ -207,6 +208,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
+	write_tracing_option_file("funcgraph-irqs", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -399,6 +401,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
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
@@ -483,6 +496,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -662,6 +680,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
+		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = NULL, }
 	};
 
@@ -733,7 +752,7 @@ int cmd_ftrace(int argc, const char **argv)
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

