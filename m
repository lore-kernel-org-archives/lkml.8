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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1CEC433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD17C20809
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEmSHaqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgGRGtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRGtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:49:22 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D90C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so1840946pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNrpaoZVGEfTNw615GzyXCuvGdypRr0hU2eDJlGIah0=;
        b=QEmSHaqWmNgy+oLlqon+Bh+c9XN4y+cnjTOcb61rivJ5RGfpqVBpR0x/NdKa9zCWDc
         iyjCPbD3O2/b2GHr8WQQM3gkYzV6g1z3TyMtWUqaqI5I/IIDqlTWDwEM9woKCLD8ZF08
         9LYm6HXTVof4VOQHHVzcKCOw8E/cia1EB2hZ+VqOH+WQHZZ76dunuwmPNNNVCU5SzgOd
         WkEYDI4irSj7PveDCTv49EIDtr0JdtwlJTv8eHUQ6JfJj4AZBzHoaDlRTo5tssO8D5Qo
         nlw4U+9D0XecgS/UZOSvPUwuQOv4CBNeJ2j/+8QJElhL3v+v410obDm1UCziOLVONtcY
         hWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNrpaoZVGEfTNw615GzyXCuvGdypRr0hU2eDJlGIah0=;
        b=jk7b0l1xeHYgRq2xKHQrxBV7UDpbxdTV0LhIsIoy3n1rTAGuAyX92eDQyWq0Afo7Ma
         dV6NnTxSKGkk1Z5+V0DuiIS0g4rFvz//v52u/Z5Zhn34GEm1T6JMAu3vuOY/0morME2T
         2gvoJjSGS6laUojKkhgQZU1gqK/Aj96CRulvsxA4KADK52D5LJvwqchabt9Xomn48RP7
         8u7qBcq09meLD+y+41vSBA/EFBTs2ZItEVlTi65Me3UuxLNCJkvC77rN80RjrqiRElZf
         DxJe2mHcCvhGE8LsivSgrhlPIaq0MmS7DJMhnd2WnrE2cV8r2nNpLB9QzqDZiuzL1/oW
         55iA==
X-Gm-Message-State: AOAM531FGLEKzdpBpzkwnyuXFnauQOXDPFukLWJkat319TnpJs2rdWvd
        cM/O/UgbotKLMaj2MM85okM=
X-Google-Smtp-Source: ABdhPJzvYC3a0FMdfEK1542JnyZmVG8ToGNEA5tzQxvu0Cy1a0mxXcCYhmV6VHXljiLlfGkVxVQeqg==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr6256667pjq.136.1595054961526;
        Fri, 17 Jul 2020 23:49:21 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:49:20 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 06/18] perf ftrace: add option '--inherit' to trace children processes
Date:   Sat, 18 Jul 2020 14:48:14 +0800
Message-Id: <20200718064826.9865-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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
index dcac0d75a0e5..3eee073a7042 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -57,6 +57,9 @@ OPTIONS
 	Set the size of per-cpu tracing buffer, <size> is expected to
 	be a number with appended unit character - B/K/M/G.
 
+--inherit::
+	Trace children processes spawned by our target.
+
 -T::
 --trace-funcs=::
 	Only trace functions given by the argument.  Multiple functions
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6ce626a2d0d1..765ebd56e05f 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -39,6 +39,7 @@ struct perf_ftrace {
 	struct list_head	nograph_funcs;
 	int			graph_depth;
 	unsigned long		percpu_buffer_size;
+	bool			inherit;
 };
 
 struct filter_entry {
@@ -180,9 +181,27 @@ static int write_tracing_file_int(const char *name, int value)
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
@@ -201,6 +220,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 		return -1;
 
 	reset_tracing_filters();
+	reset_tracing_options(ftrace);
 	return 0;
 }
 
@@ -339,6 +359,17 @@ static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
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
@@ -408,6 +439,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -600,6 +636,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
+	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
+		    "trace children processes"),
 	OPT_END()
 	};
 
-- 
2.25.1

