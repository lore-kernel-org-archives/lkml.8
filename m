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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CFFC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69018207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEyE0Iol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGQOi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgGQOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:38:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A46BC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ls15so6616401pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ski8eY3FmQcUGrl+pMAHBnHPuNvTeKQeBCTWdXdQjNI=;
        b=sEyE0IolW0leQzQs/ovOlSGer7uWeC+G7BQUFwsTLO0bOTtCDXMhLwlvrRgG2p906n
         0Yyk+2QRhdsCdlj17dpuA1LcXPtkiY/MysCz2nkjqKWgyTBXeWncTXpRDwMCFVREFnon
         Usy0aQeso5wehJdGj8XfvaxY4JTdgtiGpNOWm6cqXfWZRJsMCIyjFcD6slwk+HL/R1Bp
         MOL8lEw4x95JppZ7IUL9VPjsfN79ezwt7n4yNr2LWBi4IA7gzoBZ7ZmXT2NNPk7ke1bQ
         CcdzmcjYdhFoEZ5Oko1bG7LV8M4vjub8XoKqBGnJnk4cBR+WFP1x8SKufQvQiLrUs9IW
         NDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ski8eY3FmQcUGrl+pMAHBnHPuNvTeKQeBCTWdXdQjNI=;
        b=hIIO0Isemt1zEFunbdNXtf1UlZdocQaluR1rlhuUjnvX3YrrqbvHfrIeanmYxTRVPN
         h96j+UQf6G1YoJ4zUjX+xELEUZ2hy/QoosBX+3/SwMgTlk1Kd1KUEkHi44dOgONUDA+7
         0jfshwmwFdSNIutJNVasS/1mvTyFtkp510+I8XM9KW60Ey1plgtSbyQWW0vu5sfKD+n8
         d7m5T5JwvedUoI7YShnonlqqt0EPho9E/yxFMAaJRPIDdHoEyBWlH3yhptAo9sR+TCRT
         9B8LIXtMx4IoHro+YvEECye6Sjg/6obmndtLSRD8mvseTU/QMM3dPs7R05FTgiR7+Toh
         Ascg==
X-Gm-Message-State: AOAM530F6L2qIzKX1p+UVEAezKW7ZPVHf/bGf2v/Omgo5RX6NC4qr2Ov
        /JKdxQTmGnsAeFfACqeYmxA=
X-Google-Smtp-Source: ABdhPJz6rKAqBF9f5fJTi5yBudzOeACc6uxlqTChWd/1W8Nk7zFCfR7sja4ApSbM0/aWTVhSPc2Bmg==
X-Received: by 2002:a17:90a:1a83:: with SMTP id p3mr9598313pjp.113.1594996707775;
        Fri, 17 Jul 2020 07:38:27 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:38:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 13/17] perf ftrace: add support for trace option tracing_thresh
Date:   Fri, 17 Jul 2020 22:36:24 +0800
Message-Id: <20200717143628.47721-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
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

