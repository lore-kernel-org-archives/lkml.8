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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D3AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2D92065E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ2vxYNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgGRGui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgGRGui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:50:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA75C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z3so6416439pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ski8eY3FmQcUGrl+pMAHBnHPuNvTeKQeBCTWdXdQjNI=;
        b=bJ2vxYNYusWnYFHrwJ8UheDSHAp2KVLaDmFtSBrAngFVxxO1JoZAe9JAsrNE09fINf
         EcNDYEN1/8mcdtm6rGnXlDpC7goelFtRKJYUeo/4+/2WFCNat9j99/Frsxp23+zfQ69w
         Mh34Zz+VjdJ0goAg8XW3Qq3vALCMiX8RoepfGR4Ex+eLnxXi9K51sabyTnIzkFfpqQtR
         d8iomzb8Mp061tEhrxL2dE5iVeIbm5eC1AU8I1Y/PheUHeMThJtsuwP/zcfghyYvjxEQ
         wt/SilYY7DERkl5swtxwRAqVyhA00NmR4xncY623Vazkg97TqZ9vRiFFmoHnGSSg2fYq
         kE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ski8eY3FmQcUGrl+pMAHBnHPuNvTeKQeBCTWdXdQjNI=;
        b=QK/qsWi8KBGbG7ukGp6XBHpZQoVrAvKfUHxwoQIjpz/a4ph4Y80ehHFnUQi45MhrJW
         6oLL2E6JFj4sxxV25QBF76+3zGleE/RlUbXkL2OqRcf5UViai2jAu4DMcmcIeUPCmSPd
         tN54DrFo5rP8Ya9RUnhl8lUEqDu21FTqRfVxwKIl27eT8GcNnqQrO3ejklT2caxH1fFD
         VVRi6Q2WQfS0ApMbJ1mbt/sLkri++iGl5qwIOrEO0G3N6AmvMMW4pEWHGR/wKlOXn7Li
         WyqxIHkx1YxrOE7RhbbpNzn8Ox55/+WOz/w+V2xetHVRDbi0CKFMcORlxcsxU+4xYTls
         Rxaw==
X-Gm-Message-State: AOAM533Jw2MtzWl1GrT/yrSqMRo2t3OIjHRm7mfX/b1ZoNV7wAIwLiDj
        NHx1RBATWExmg+HLbySB080=
X-Google-Smtp-Source: ABdhPJyB1jcl79O1z3MbKko27FzFqkP3VX99722XQ7zg4lG6QMo/29qogh0ObGT0D9M2BnGZix2vdA==
X-Received: by 2002:aa7:9e89:: with SMTP id p9mr11483956pfq.110.1595055037539;
        Fri, 17 Jul 2020 23:50:37 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:50:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 13/18] perf ftrace: add support for trace option tracing_thresh
Date:   Sat, 18 Jul 2020 14:48:21 +0800
Message-Id: <20200718064826.9865-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-opts thresh' to setup trace duration
threshold for funcgraph tracer.

$ sudo ./perf ftrace -G '*' --graph-opts thresh=100
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
index 319ec6375228..96e5e8d7f65c 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -104,6 +104,7 @@ OPTIONS
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
 	  verbose      - Show process names, PIDs, timestamps, etc.
+	  thresh=<n>   - Setup trace duration threshold in microseconds.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 0d893d97691d..5d948239bd70 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -46,6 +46,7 @@ struct perf_ftrace {
 	int			graph_nosleep_time;
 	int			graph_noirqs;
 	int			graph_verbose;
+	int			graph_thresh;
 };
 
 struct filter_entry {
@@ -232,6 +233,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	if (write_tracing_file("max_graph_depth", "0") < 0)
 		return -1;
 
+	if (write_tracing_file("tracing_thresh", "0") < 0)
+		return -1;
+
 	reset_tracing_filters();
 	reset_tracing_options(ftrace);
 	return 0;
@@ -444,6 +448,20 @@ static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
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
@@ -543,6 +561,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -726,6 +749,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
+		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = NULL, }
 	};
 
@@ -780,7 +804,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time,noirqs,verbose",
+		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
-- 
2.25.1

