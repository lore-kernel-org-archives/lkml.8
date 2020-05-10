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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96372C54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B5720820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyGmyvFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgEJPIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgEJPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:08:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7E9C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f15so2816179plr.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NpM/ijFwbSoPlLQVQ01gf0hqXiBa151ApMA2ShJDAE=;
        b=qyGmyvFVxdI1tt3UUACq/6PHoEQ7KstS6iicTyDfB2h6TdHVQKBOWPJJQVwa5UqlVj
         gwZW+Z22uCgn4Kw9Y488YJ4KINDVWmlEk+xYJ9xMduzWY6jkslwolUNI395Pmv+JO50z
         OHmA5HXqdbN8U1rVrf0wV6y9WGqGiI6UTHh7po5KDZGbYt2XCqvsiIhuJPAHxa20z4ji
         lwpLPy12QTC5M6JQKjRBdld6gbqJfG7NL+uuIUhxET6u9yxKw25Of56ReVUkalgtxTYr
         Q33Au/8vfyW6QbbY3QUAlRGywN1Cctvg3v+kDRGf1X4ZZOl12kk8aIlB0z8Ma/aWzErK
         OtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NpM/ijFwbSoPlLQVQ01gf0hqXiBa151ApMA2ShJDAE=;
        b=CpzHljfwAcdBcr+z0mscOK/BKea/2F4l1JEz2clxQ8wCSvaLv5CD8Cs+aGrpXrty8a
         fyBVmxyuyvw8/hj0lu0vRjD2cOuEawXmToGVJ/XGR2xbI0qzUHmbdtUe5YVec5YRaR1Y
         WNbDVyD3urEv3fPZ3CVqGJcArkbsORyoCCmXizOrM6TvzfP0rhJ1iLAQK0LnslKNMlTr
         F8ocrLNNYgq1SlRdmchXXXl6n8o8YuXqdbrc8PaGfVvt9zyUCUEDksYQs8d/x5FZV1uE
         YCYqOhc5szJvMpeyk+ZDVb1V4AKC0X9ShdylcmRo3dl3JkiH5O9G/8KUlhTqAqZPLNLN
         YIsQ==
X-Gm-Message-State: AGi0PuaBrTL3ltmK7M9hoKopsvwbq1mFUwTVkIYHpq45n5GBJ0PMcNoY
        FBFVF6jSxRTK01Q28mwMpWo=
X-Google-Smtp-Source: APiQypIYIckL8pDMg7ZWoRaRvQtrMYySIu2zj781PGFikQfx5k09fYPiufF4hfadOZ+LMuYMERst9Q==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr16511616pjb.56.1589123302608;
        Sun, 10 May 2020 08:08:22 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:08:21 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 07/19] perf ftrace: add support for trace option funcgraph-irqs
Date:   Sun, 10 May 2020 23:06:16 +0800
Message-Id: <20200510150628.16610-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--nofuncgraph-irqs' to filter out functions executed
in irq context.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d3fcf3b0b792..b16600a16efa 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -41,6 +41,7 @@ struct perf_ftrace {
 	int			graph_depth;
 	bool			func_stack_trace;
 	bool			nosleep_time;
+	bool			nofuncgraph_irqs;
 };
 
 struct filter_entry {
@@ -188,6 +189,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
+	write_tracing_option_file("funcgraph-irqs", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -358,6 +360,17 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->nofuncgraph_irqs)
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
@@ -431,6 +444,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -568,6 +586,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Max depth for function graph tracer"),
 	OPT_BOOLEAN(0, "nosleep-time", &ftrace.nosleep_time,
 		    "Measure on-CPU time only (function_graph only)"),
+	OPT_BOOLEAN(0, "nofuncgraph-irqs", &ftrace.nofuncgraph_irqs,
+		    "Ignore functions that happen inside interrupt (function_graph only)"),
 	OPT_END()
 	};
 
-- 
2.25.1

