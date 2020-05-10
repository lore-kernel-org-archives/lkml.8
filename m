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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528FC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E1320735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvybVZSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgEJPJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:09:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD93C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:09:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so6519342pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rm3gEwzwMkQ4JSt/QwcnW8+A21U/dER9sl6TdLfBoeQ=;
        b=WvybVZSKhY1Bu135cTAjVJYYgIRzEMxsKx7uFLR8wlXhitmtZnSb5f0/Tlnjtyx3z/
         +E1tqiLqbGYJWBpVgRLGmOUFuSUlokyVqNV1cgibSM+57hqBwW4uzSHf1kgu6zoJR3n4
         ZW39lmEeWhV7aKMbbgY+T7bTsZAjOVkrFpjrHT0LLxklr0NxB43BBu59ek+EqM1zKwzm
         2E87jNaFtyhX0Ar2Fhz5ZWxgxfPKeiSCjm8x8ttlGqiUJUadGRYHJUMTmygYbSl7nZsY
         Xq4ZJ/0Bvh/5V1ljm7ukBQpYsTuvLsFIK3OdNBY2yFx8PCZLHMoYQ5HLjgWbCqyUqwib
         4/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rm3gEwzwMkQ4JSt/QwcnW8+A21U/dER9sl6TdLfBoeQ=;
        b=AHRSLSazP/YVXp+0G0V8iREsshO8FwT35nkxT9VvnrVbd7Pkk7Td1/ZQImvYIuIm6E
         lpCRdOJw3/qL6kO98Ba84N3ZenB1S8VknMdNZMvRXFI+XPej8Xer48yngXPUYePohKUX
         EY3HLXExrqSo57dgbWOLf/siwdScDm5Xyf16Rp0ASu44KvxNi9TrAo6J7RxdyP9VtHVn
         /Xd7o60yrXm2n8LXAjeGxw5mylkdJof17Wsn1mELBeBvC0LpX2aM72Tlo037RdpXELBa
         ORHM+OROQx/s1j3jZQ4F+d+1cjQx30DOrJlyjQQ+9p1pzV/3RisCRt3I8EDZMdxSYZFO
         9jpg==
X-Gm-Message-State: AGi0PuZC83NHHiAkQYwqJ+8gDReAo+7d7OjjcGp0d9XGi9xPvnbOOp+D
        tw4YqehZnzoawOJlidHwvcA=
X-Google-Smtp-Source: APiQypJwAOf3wu8TmZBED1ku4kJ4hbNQudLO3DG4y1WXOGnSrIteXFnpC01rjM1mV4cKpH12olVsmg==
X-Received: by 2002:a17:90a:7349:: with SMTP id j9mr17690858pjs.196.1589123344173;
        Sun, 10 May 2020 08:09:04 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:09:03 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 11/19] perf ftrace: add option '-u/--userstacktrace' to show userspace stacktrace
Date:   Sun, 10 May 2020 23:06:20 +0800
Message-Id: <20200510150628.16610-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option ''-u/--userstacktrace' for function tracer to display
userspace back trace.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 2ef5d1c4b23c..ab76ba66bd9e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -40,6 +40,7 @@ struct perf_ftrace {
 	struct list_head	nograph_funcs;
 	int			graph_depth;
 	bool			func_stack_trace;
+	bool			userstacktrace;
 	bool			nosleep_time;
 	bool			nofuncgraph_irqs;
 	bool			funcgraph_tail;
@@ -197,6 +198,8 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("funcgraph-proc", "0");
 	write_tracing_option_file("funcgraph-abstime", "0");
 	write_tracing_option_file("irq-info", "0");
+	write_tracing_option_file("userstacktrace", "0");
+	write_tracing_option_file("sym-userobj", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -287,6 +290,20 @@ static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_userstacktrace(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->userstacktrace)
+		return 0;
+
+	if (write_tracing_option_file("userstacktrace", "1") < 0)
+		return -1;
+
+	if (write_tracing_option_file("sym-userobj", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void)
 {
 	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
@@ -482,6 +499,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_userstacktrace(ftrace) < 0) {
+		pr_err("failed to set tracing option userstacktrace\n");
+		goto out_reset;
+	}
+
 	if (set_tracing_filters(ftrace) < 0) {
 		pr_err("failed to set tracing filters\n");
 		goto out_reset;
@@ -644,6 +666,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "do not trace given functions", parse_filter_func),
 	OPT_BOOLEAN('s', "func-stack-trace", &ftrace.func_stack_trace,
 		    "Show kernel stack trace for function tracer"),
+	OPT_BOOLEAN('u', "userstacktrace", &ftrace.userstacktrace,
+		    "Show stacktrace of the current user space thread"),
 	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
 		     "Set graph filter on given functions (imply to use function_graph tracer)",
 		     parse_filter_func, "*"),
-- 
2.25.1

