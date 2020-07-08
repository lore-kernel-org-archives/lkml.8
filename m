Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06315C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FE8206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDGmQ0m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgGHQrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgGHQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:47:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCBEC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:47:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so17517383plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHdqHMTOVO6XNQDgjsoso8NUmYPVc+DTd6dUDpA/+tI=;
        b=GDGmQ0m/hqUvO8OJ279RysyAwF4mBP14QB7hTMApccMyVFUvn9z4WLgN/EWiPwGnRG
         V9/keIT7kf8DrwwuYSrjcIM1B5ElDGWV799EtDh3c2i+gx038Qvz5eXCPpxhJemy6QRS
         gxHtcixlxFC99BIU9FL2T/2lL7dHTV/kOI2WF7oSoQNqd3wa0M3yMV/xuVcsnIB+IqUm
         rV0oPEsda1Hhp/PRn7v6na5L90hP+nBCHSMhYJ4d5+eKkuLJT+gmiBZDaC5KMOQ3I6ox
         uJjkaAPwvyqWpC7hYr+rGudh2ZEaEuPTQKtySaIbQNLT3RnVmezNrhiYye3QNLSWjs3I
         0+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHdqHMTOVO6XNQDgjsoso8NUmYPVc+DTd6dUDpA/+tI=;
        b=k1YUngFNeK7uaGFCc3yjZCLLTTEo/uCEdkFu74AWXCv83fjD4HnNydIQFQKVSEekjQ
         jUbfk/hYiu1JZh8JO7XVKE3aRMPBPpxjhlGrds1ZhUoGT3HQlaYAxzvVXcCC2J4AGiIk
         UMSLHdjNVRbybs8Oz6s701KEXw76n5PbAEzAxnBnrhUt1EYsfHGYOKUDTlEhWbITg5NJ
         ahZRgfyNSixY+502rmtfwG+6yMRLkRmRvbcKD2qf0CSIyToQdKXvn/71c6SXeuUYsv0K
         YH3/Vf3FIjEt8Whhgj0cJlwWdGckxuxzjou+wn30yuCqQ5s62moQGHZFyIBM+4kaNACB
         PAog==
X-Gm-Message-State: AOAM5339dGcGQARwcN/rzuCvY8pg4sUOSlw7xE6xu9KZCafbSIIdo6Pd
        xJkE/WDkMgJyx7PTHBx9Utw=
X-Google-Smtp-Source: ABdhPJz7enOLgIFDRYjSGGqq8AI6ZJPWsfCIpfhYSg3KP3ZwSS4TZKZcLtZ2aBI4Me3X1xp9tr0tOg==
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr10563995pjb.153.1594226862514;
        Wed, 08 Jul 2020 09:47:42 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:47:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 08/17] perf ftrace: add option '--inherit' to trace children processes
Date:   Thu,  9 Jul 2020 00:45:56 +0800
Message-Id: <20200708164605.31245-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--inherit' to allow us trace children
processes spawned by our target.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: option name '--trace-children' -> '--inherit'.
---
 tools/perf/Documentation/perf-ftrace.txt |  3 ++
 tools/perf/builtin-ftrace.c              | 38 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index a26593dbdd76..27381c0dafe7 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -65,6 +65,9 @@ OPTIONS
 	Set the size of per-cpu tracing buffer, <size> is expected to
 	be a number with appended unit character - B/K/M/G.
 
+--inherit::
+	Trace children processes spawned by our target.
+
 -T::
 --trace-funcs=::
 	Only trace functions given by the argument.  Multiple functions
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 885d11f369fc..ab1435c2cd0e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -40,6 +40,7 @@ struct perf_ftrace {
 	int			graph_depth;
 	unsigned		initial_delay;
 	unsigned long		percpu_buffer_size;
+	bool			inherit;
 };
 
 struct filter_entry {
@@ -178,9 +179,27 @@ static int write_tracing_file_int(const char *name, int value)
 	return 0;
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
+	write_tracing_option_file("function-fork", "0");
+}
+
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 {
 	if (write_tracing_file("tracing_on", "0") < 0)
@@ -199,6 +218,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 		return -1;
 
 	reset_tracing_filters();
+	reset_tracing_options(ftrace);
 	return 0;
 }
 
@@ -337,6 +357,17 @@ static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->inherit)
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
@@ -406,6 +437,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_trace_inherit(ftrace) < 0) {
+		pr_err("failed to set tracing option function-fork\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -612,6 +648,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "ms to wait before starting tracing after program start"),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
+	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
+		    "trace children processes"),
 	OPT_END()
 	};
 
-- 
2.25.1

