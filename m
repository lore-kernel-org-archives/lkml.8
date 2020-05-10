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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28025C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB85424962
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrRjgW3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgEJPHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgEJPHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:07:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DABC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:07:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f6so3294879pgm.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdOgeBzvlze6SKSr0UCP1W0oll18GjuTNr9k1rKU7Gs=;
        b=GrRjgW3ris2WnHTETiarDpvXjg1ZVJojoRFCVyImkMwbx4Iz2zeCbuuyab3TEKW2ig
         jtoEI9pBvKFo+kqsLtnLY/9oqF8P3vRhvcQTPiYDQ1tub2bbRTKnhJ3ibxXTuQI46+rB
         iRIVuNATU84WFvAzfEpIeZlCJIlKg4y3FepWVsRgQ+c14e44lGRvhNfP+yF8c1PLU0Ha
         uETPoWmz3EVlclQV1erZQ9K1vkKAkBvn6DQy0JdwMhb5SHqzfDs//A3xg3pMN2hE/FUr
         av4PC7sFycbcXUFIrajK06sfEQeppi4c7D/ByBRW31ZhKdG+kl6xHpSgbqhBKCXwwinz
         4ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdOgeBzvlze6SKSr0UCP1W0oll18GjuTNr9k1rKU7Gs=;
        b=X+b/dEGK2d3cvkWpqYR13aHZZNHoconu+GqUGJ6N+ieicyCFNn4nYZrnmYkccsaDRv
         Wt7EB0RfSmpvixQFkAWz1wD6HQMylQJ3RnayPAxF7z5x5uS9UDKAqW4KJcBIPVZ8v7hr
         MEY3hqUdtdFilwCRxh5hCiBDP5dZNcZvMUe27BF81xAlhLbiOi0+EZUjLvlBDGYYFA8l
         bHqUd+yZTnrMGQc5U+Qb240uujFhYDzfDPuMBXbpTd79vvMWiIPCKAJ0m6JddpwYh9C+
         2SzVX09Q4FNM1vXwmSP5Dko+9UFp0ZxTyHULg1dcPgOH0/z73CH3BhmBz7sY8iP01ZXz
         d5Qw==
X-Gm-Message-State: AGi0PuYolje03iNvicEMXiVhIHzdBnarHABW9/a8gAl29oKRzjuHS+lt
        ARwMpUK/c4IyqHECWjcef54=
X-Google-Smtp-Source: APiQypJrz4pUmBO/pabjTkolJYiXXzNxDwQboIDnANXenoFMIIg5GStSB5yAt1mHpXMIIf5yyNWHTw==
X-Received: by 2002:aa7:9a11:: with SMTP id w17mr12186281pfj.314.1589123269968;
        Sun, 10 May 2020 08:07:49 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:07:49 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 04/19] perf ftrace: add support for tracing option 'func_stack_trace'
Date:   Sun, 10 May 2020 23:06:13 +0800
Message-Id: <20200510150628.16610-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to display call trace for function tracer. To do this,
just specify a '-s' option.

$ sudo perf ftrace -T vfs_read -s
 iio-sensor-prox-855   [003]   6168.369657: vfs_read <-ksys_read
 iio-sensor-prox-855   [003]   6168.369677: <stack trace>
 => vfs_read
 => ksys_read
 => __x64_sys_read
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
 ...

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 57e656c35d28..1d30c2d5f88b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -38,6 +38,7 @@ struct perf_ftrace {
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
 	int			graph_depth;
+	bool			func_stack_trace;
 };
 
 struct filter_entry {
@@ -128,9 +129,27 @@ static int append_tracing_file(const char *name, const char *val)
 	return __write_tracing_file(name, val, true);
 }
 
+static int write_tracing_option_file(const char *name, const char *val)
+{
+	char *file;
+	int ret;
+
+	if (asprintf(&file, "options/%s", name) < 0)
+		return -1;
+
+	ret = __write_tracing_file(file, val, false);
+	free(file);
+	return ret;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
+static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
+{
+	write_tracing_option_file("func_stack_trace", "0");
+}
+
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 {
 	if (write_tracing_file("tracing_on", "0") < 0)
@@ -149,6 +168,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 		return -1;
 
 	reset_tracing_filters();
+	reset_tracing_options(ftrace);
 	return 0;
 }
 
@@ -204,6 +224,17 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
 	return set_tracing_cpumask(cpumap);
 }
 
+static int set_tracing_func_stack_trace(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->func_stack_trace)
+		return 0;
+
+	if (write_tracing_option_file("func_stack_trace", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void)
 {
 	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
@@ -326,6 +357,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_func_stack_trace(ftrace) < 0) {
+		pr_err("failed to set tracing option func_stack_trace\n");
+		goto out_reset;
+	}
+
 	if (set_tracing_filters(ftrace) < 0) {
 		pr_err("failed to set tracing filters\n");
 		goto out_reset;
@@ -459,6 +495,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "trace given functions only", parse_filter_func),
 	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
 		     "do not trace given functions", parse_filter_func),
+	OPT_BOOLEAN('s', "func-stack-trace", &ftrace.func_stack_trace,
+		    "Show kernel stack trace for function tracer"),
 	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
 		     "Set graph filter on given functions (imply to use function_graph tracer)",
 		     parse_filter_func, "*"),
-- 
2.25.1

