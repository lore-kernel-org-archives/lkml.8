Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D435C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1AD208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4qfuP9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgEJPIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:08:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C0C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so6513161pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBEZRP+VnIfa0Frn8xyE5U/oNqnLOPY+QHZM3x5oRPs=;
        b=A4qfuP9ZcGq5+lT+KLr9XL5BuJfxMLRcXRRl30yaKnnVKmlFv6pueIDG03rXXUrUh3
         4AboE1u1d8/sX+KV3OVMfnTWRiyZR0V/k54J5tAcmISUeiXeZGWNrAY7OnWQhqQgb+NB
         oSvsKwLhltH4hTwiAvzKBDL6VDBaBL2DeqSoSzhQckVDJP84ijKRT5GoE31s0IYjT8RJ
         jV8+7JiVG846Qpe3SLxufcHsGbkOjmC19kV8tjUTBs6ltTzoJ4VbZ9Scztrnzw0gq/+Q
         rFLf2PnzQHBwQPj5XweRr+JEOodXEfWzPyfWWKH5eE4kE0DHnC+8jNXWl4H81zRVGTDl
         YX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBEZRP+VnIfa0Frn8xyE5U/oNqnLOPY+QHZM3x5oRPs=;
        b=Jj0InqFLUOiKzfabkWE2IvuR2BHm94MiPHn6uAd2VARG0ypGqJkKK8+kFanFFej8NE
         F/Rw0RTJ80GdzV3xUUYHX6BJESg/WDQUwzjogqtOPNfYUPhA2qqDkrcqZDRnO9a2hEn6
         Wd/poCQipZE/hZhFVDzdTfXzgv2lqb5XhoQyQ26E8NIq5cQUae7SI8DtOfJiMajdBOdY
         p6SpKKz/UQbJtbHAs3vCvGVrF20ro5LYmBFdzxisDdSFFZpUGrLqn3VUCXlIST7slxbO
         K1LON4NWOV3HpuLrGqEylRI/fpaaV/z/a3ufduEDyb21uSGHjXymwjxYeMiOoDLJRf0w
         XN9w==
X-Gm-Message-State: AGi0PuZYkifii70hihUc+XbRK7XexE9KxOcjNsgXIpaW24UILd/zGjWS
        smnyopuyOh+pkaGCHOIj5pI=
X-Google-Smtp-Source: APiQypLa+VLxavRv0vyeixfTpaIzdU0ycU1ypJ89ATCXmNfrzwjVOupuWRZh7qAYOSgky6K0ScHDpg==
X-Received: by 2002:a17:902:784c:: with SMTP id e12mr10949927pln.191.1589123296064;
        Sun, 10 May 2020 08:08:16 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:08:15 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 06/19] perf ftrace: add support for trace option sleep-time
Date:   Sun, 10 May 2020 23:06:15 +0800
Message-Id: <20200510150628.16610-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--nosleep-time' which allow us only to measure
on-CPU time. This option is function_graph tracer only.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 8133d910d5d8..d3fcf3b0b792 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -40,6 +40,7 @@ struct perf_ftrace {
 	struct list_head	nograph_funcs;
 	int			graph_depth;
 	bool			func_stack_trace;
+	bool			nosleep_time;
 };
 
 struct filter_entry {
@@ -186,6 +187,7 @@ static void reset_tracing_filters(void);
 static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("func_stack_trace", "0");
+	write_tracing_option_file("sleep-time", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -345,6 +347,17 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->nosleep_time)
+		return 0;
+
+	if (write_tracing_option_file("sleep-time", "0") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -413,6 +426,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_sleep_time(ftrace) < 0) {
+		pr_err("failed to set tracing option sleep-time\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -548,6 +566,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
+	OPT_BOOLEAN(0, "nosleep-time", &ftrace.nosleep_time,
+		    "Measure on-CPU time only (function_graph only)"),
 	OPT_END()
 	};
 
-- 
2.25.1

