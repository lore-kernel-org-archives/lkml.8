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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3EC54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E4020708
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN4x0oQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgEJPIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:08:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35440C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so2813558pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCULGEDTZGQZVxrZMuVYDZiYVb574z5BNPRTB8ivMQA=;
        b=VN4x0oQqHvUFRqHgzhC+fTEBGuHe0NuRyvLjDmUujx4YUSpbj/o84TC7AUVT3UJGLA
         ueZUvRZmj7I4YFEGj/9V3Og+UnMC6eWde7oUHytrUoeTcgn0giojXdJq8tiHTmu8wB2Y
         5lHGhfkedTlxAHwfNqANDU41K3ik33HqzjsaGQCOxxE36Gj/L7IVA1pMk5Sx/9wQJgDh
         lsc7Jb2vYnglj/SM2Vx0b8x2WWKOkqi9IyUdE1Msvm9mrxRvzmnJ3xxPyu1LyR/dGzvz
         IYbIpg9zG5KJb4pmnRvfiCgY4TE60u+HsCRWST+lmhbP7g/j51kQcTzXCnLD4+hgF8DC
         1bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCULGEDTZGQZVxrZMuVYDZiYVb574z5BNPRTB8ivMQA=;
        b=GGGzHnxT0aW9J87vV5fghIXkS1cuQalItyUqD8Q1+5/239e7lhz4NNI/eobDR7AOlq
         2hwhTODvAIvgG7Hsof8jVreTVQhIAnPMjGoa1OeyRUI8DxTOGnnlESrK6ALW4GWpr2M2
         RqdrLvntmK038vm3xyEz3p7opNVLKsqJGQFRASSoONgUDEwcI5Ano2VD+3DVAHS+jHnY
         yq7fGHAy2y7/W+PMP5zaKZ7cNHcHt/Jl3I6ptU106Gb05sH+0p8uSM4YgwEZnT8w8ZbM
         HX7BVEoBKjDeubv0FjXxVXR3n6LRkGZIqdC09YBwoIDzE2VOVZWwejCRggKR0a1Z/J19
         KfPw==
X-Gm-Message-State: AGi0Pua0laFty3WTDMJmTrsPgEDjUW2vCgHNzJ5Sq5uUNHc4WAVnw5y0
        +6d7yQ75TSUEBRyGJpJavrI=
X-Google-Smtp-Source: APiQypIYehYEeIjWlUpNUsb9578BX5e0q6cv6pq2lZIirC52f/ZEZvEmZ9XlvtNPFn5qcaf9qIlOOw==
X-Received: by 2002:a17:90a:f2c6:: with SMTP id gt6mr16269816pjb.61.1589123325778;
        Sun, 10 May 2020 08:08:45 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:08:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 10/19] perf ftrace: add support for trace option funcgraph-tail
Date:   Sun, 10 May 2020 23:06:19 +0800
Message-Id: <20200510150628.16610-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--funcgraph-tail' for function graph tracer.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 20bc14d6c5fb..2ef5d1c4b23c 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -42,6 +42,7 @@ struct perf_ftrace {
 	bool			func_stack_trace;
 	bool			nosleep_time;
 	bool			nofuncgraph_irqs;
+	bool			funcgraph_tail;
 	bool			long_info;
 	unsigned		tracing_thresh;
 };
@@ -192,6 +193,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-tail", "0");
 	write_tracing_option_file("funcgraph-proc", "0");
 	write_tracing_option_file("funcgraph-abstime", "0");
 	write_tracing_option_file("irq-info", "0");
@@ -411,6 +413,17 @@ static int set_tracing_thresh(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->funcgraph_tail)
+		return 0;
+
+	if (write_tracing_option_file("funcgraph-tail", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -499,6 +512,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_funcgraph_tail(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-tail\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -638,6 +656,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Measure on-CPU time only (function_graph only)"),
 	OPT_BOOLEAN(0, "nofuncgraph-irqs", &ftrace.nofuncgraph_irqs,
 		    "Ignore functions that happen inside interrupt (function_graph only)"),
+	OPT_BOOLEAN(0, "funcgraph-tail", &ftrace.funcgraph_tail,
+		    "Show function tails comment (function_graph only)"),
 	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
 		    "Show process names, PIDs, timestamps, irq-info if available"),
 	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
-- 
2.25.1

