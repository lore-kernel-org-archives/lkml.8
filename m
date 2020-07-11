Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586DDC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACB42076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1yg7yls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGKMnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGKMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04934C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so3368425plk.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2hRN1o8EhoWJ7fMKxLmJVUsfsNgfHlSCMCgFfm4Eu0=;
        b=R1yg7ylscd3dtJGfSD6X8VU53CaYeaAiNis/Ps0Ikg+0iLZu3DUH0MsvRLYhATD+ib
         I0HNCXSaklAbckgnaGezYXSGA3sEpHkw5DCA+uTnrdxnfjzIN1X0VI7cv8xJ+olPKyu4
         BdBixJx34BNFd2TvRHlmGJssYzJbv8ElvefTozlN/1zrI9A0Oen38nP+bn97CB1G1So/
         1jfPLmd4TksinX078/yfxWtwOMNS9NvP/geEUzCIa4ZoU6LnKd4ELWtpmUV5o6krpXNi
         WjaH3fxg8KkIWz9ey4FB+jhSZRtjO86JDJhoxK7GucY4LZmppZkjSYxRt1c8BcdKSts0
         wrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2hRN1o8EhoWJ7fMKxLmJVUsfsNgfHlSCMCgFfm4Eu0=;
        b=P5GuVyZCytOnKmakJzx4XpN6keLcN1L89TNWD5JrmlSbqhWrOQipM+u+46MfmgueQU
         Abgt4e/sJnZ0VtMZd73C6vTyXVdccofEaOIrIdAazlwu+4/fAfCSFhHWt7jXACav1FZw
         xDWTvQOZm4/7hnoPH4Fzo0ITXH7HePjmV07vZ+OjGy2U6g3kwwHDXwtDv3mM2DIkzGLB
         /SpDvNYOViAY75V6c4OrKqeIbYkF4v2W5pKu6Kx+WPptb7ex5Ozlq8BA5K2uXLmQBSiM
         HDo9aGSa2syHKbZlzq1IKbSajCWvVaDJxzvZeDAtS+dr21QErZuj5RX30va7wP0wFiEn
         ROBw==
X-Gm-Message-State: AOAM533ZeU6ozVW6f6tYcaB0KZjdryx1VsEV1EojheKcvtLn5Hmfk79O
        JS8/q5Y6SobT20sGrKhHNdA=
X-Google-Smtp-Source: ABdhPJw6QCztyuRE873NcvwIXkZy1Q0D3U4YD4hHmSBHs4f3C9BTAPp0rvyKCCCuE5qB5NYdO3XQFw==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr60489476plq.314.1594471416581;
        Sat, 11 Jul 2020 05:43:36 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:35 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 14/17] perf ftrace: add support for trace option tracing_thresh
Date:   Sat, 11 Jul 2020 20:40:32 +0800
Message-Id: <20200711124035.6513-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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
index 0dd5ef4f9c65..a103e3fd8d42 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -108,6 +108,7 @@ OPTIONS
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
 	  verbose      - Show process names, PIDs, timestamps, etc.
+	  thresh=<n>   - Setup trace duration threshold in microseconds.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d169d6329454..c6d0194e4d0e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -46,6 +46,7 @@ struct perf_ftrace {
 	int			graph_nosleep_time;
 	int			graph_noirqs;
 	int			graph_verbose;
+	int			graph_thresh;
 };
 
 struct filter_entry {
@@ -229,6 +230,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	if (write_tracing_file("max_graph_depth", "0") < 0)
 		return -1;
 
+	if (write_tracing_file("tracing_thresh", "0") < 0)
+		return -1;
+
 	reset_tracing_filters();
 	reset_tracing_options(ftrace);
 	return 0;
@@ -441,6 +445,20 @@ static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
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
@@ -540,6 +558,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -723,6 +746,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
+		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = NULL, }
 	};
 
@@ -779,7 +803,7 @@ int cmd_ftrace(int argc, const char **argv)
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

