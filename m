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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D8C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E47D20820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erS9ZikC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgEJPJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:09:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A563EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:09:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so2814117pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gJ/iBhKrq0r7C4wRhaQHeL8thxSYrIDdDv0I9G+lD4=;
        b=erS9ZikCUnuS/43aa4v4XEvdJNNRLLgyUP3Djk55Hem/a8cwR2RtvsdYnwHUNPy9GL
         hCCXatDEs3gWTNmDeFYjO0qX05EU+cvSfP6c4rsic8LtK4HDs70GUCGIqzj48LJACCGg
         gDZUrhPqSpUP4ljqhTzHGkJDFKiRoJGDl8TfENz28Vmp/9IAN+hwETZO6ZQnb9L6zMxf
         IA2sF6xK6KDfAxIHUm1srmWIVxJgZr4XAdRpQ7g2VbP/YhLH0fFCzIP/RLDThva2OUGf
         uX/yEjrU3sMMNVF9GMspY2YOibCzKUYIbkL9DxEzrbOYhXAqEetvxm4zs2fOOyJfhBuC
         zkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gJ/iBhKrq0r7C4wRhaQHeL8thxSYrIDdDv0I9G+lD4=;
        b=qw3bwfuHoQ72tVCQIigW+vVLP/LySTBRxQw7NG9S2iIdMTNMHwfNb1TkctePdYAJJz
         lZFI12gtrHvngkVwzS8J161AGbPBxHHytQQ8smadLVBmNVD6He+WQONfF61WZSGieEgs
         9w/v2DY8ov7dsikIeCG16mYMDnnVvwyMBEVIz16s3Twl60PjK5oA6jwm2+uD4xoCWD2i
         nYrx4Jl/g4NkBhlO3ekT8+MYK7GamvSHZTBuS3w6MEWmytYjxAqP3Qyhr07vWxcXpdQ1
         +0hIZQY3n4IAPC2LDXqLEG/0uPFBd3FobSLm315UjXHYshSSveVr9bSS9/4t9Hgnuwcu
         jjeg==
X-Gm-Message-State: AGi0PuZ/fWr18eStZPa/5hJ9fQYN7FYw0zMydWFEKp4KqEEePY1I27PL
        JAYoW+Oenun1jU5yjsXMXyI=
X-Google-Smtp-Source: APiQypJ4HkYTXj3vfDjOF2wI8E2cjkimmAKpIOie15ckNfTfkMG/ZCpJg7/9nYxI4LxosZh0b+gEdA==
X-Received: by 2002:a17:90b:b07:: with SMTP id bf7mr17456825pjb.231.1589123372279;
        Sun, 10 May 2020 08:09:32 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:09:31 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 12/19] perf ftrace: add support for tracing children processes
Date:   Sun, 10 May 2020 23:06:21 +0800
Message-Id: <20200510150628.16610-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--trace-children' to allow us trace children
processes spawned by our target.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index ab76ba66bd9e..8fd95c109fe8 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -46,6 +46,7 @@ struct perf_ftrace {
 	bool			funcgraph_tail;
 	bool			long_info;
 	unsigned		tracing_thresh;
+	bool			trace_children;
 };
 
 struct filter_entry {
@@ -200,6 +201,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("irq-info", "0");
 	write_tracing_option_file("userstacktrace", "0");
 	write_tracing_option_file("sym-userobj", "0");
+	write_tracing_option_file("function-fork", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -441,6 +443,17 @@ static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_trace_children(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->trace_children)
+		return 0;
+
+	if (write_tracing_option_file("function-fork", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -539,6 +552,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_trace_children(ftrace) < 0) {
+		pr_err("failed to set tracing option function-fork\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -686,6 +704,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Show process names, PIDs, timestamps, irq-info if available"),
 	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
 		     "Only show functions of which the duration is greater than <n>µs"),
+	OPT_BOOLEAN(0, "trace-children", &ftrace.trace_children,
+		    "Trace children processes"),
 	OPT_END()
 	};
 
-- 
2.25.1

