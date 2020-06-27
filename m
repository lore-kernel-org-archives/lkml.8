Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651A9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BADA2158C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXDXgulM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgF0NiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF0NiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120F8C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so2643997pje.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKAhuheJ9I7zz8s1D73AOBOh+vgUrAdwM4UZgeXW708=;
        b=KXDXgulMReommwMX3KLTpOT48mBpUtifY5D+2Es8kCInxTyxfQWA7/xuXFlHLj5tM1
         oZTZRrf4Xp1uAPmfmmUxHEyGH7GL/lgcQzh7AAadqQIDC5aiEfOW5yfd/bDmMUuCTMy+
         yGBsvFp1SxkgZ8W4Cgrh2WXVWuYP3lZjusaDIcu6CrwEiJ6l1Fo/gnWVYsuLxLAG4acq
         8dKJxRt39TJZabEQPDDEI8JU1zfAsdlJibqgCk4CY093zEpHyeDXcqN5JFMrqtHTM10S
         Ke0eYJOMcC3X55yD9uwOUeZ3nnMg3gpapMMYoPSSW+DKnaEhDhduVzFHWh5pBJ4Zg3L1
         DEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKAhuheJ9I7zz8s1D73AOBOh+vgUrAdwM4UZgeXW708=;
        b=SS72mUvFJJk/JCeqyCIUxhrSxafQOQ95SPpbYCnEP1+4ODSX5o9y/8Z7tTdYYL8FCb
         3ANipE+xitRTOT/RfSpOx2+KqptWSiV3o+8Xr/mAPQAn8UtQpf+d/B3J9FY7uyJ+EoQ9
         lelvc9Hus0SLz9MvdCnKiQenRoZWTg/RFlVzuS915uw2bEEDo1vl7bK3lJSoqlNAxseD
         aoKoAifw0jHoN4qWkOgIUuyKgiB3tv+J3An/6e0tYdT0+jUpRSvn6kPPNd+777mseUWe
         +0qsfGqPvcNUnGsq7T6ne7q+CkFMKcmLFMRawnnC7d1Rgv59BJWg5DMbKpEA4poiLhOk
         0Fgw==
X-Gm-Message-State: AOAM532vFEzVb7B3Y+ay4LWQdYM2JCXrZiSvlT+JmN0tgpe2zKLe3dHC
        Flf/UBhgSEEIS+oTBDQssNw=
X-Google-Smtp-Source: ABdhPJxTtIvf07vyaHpsv5Sy/QJL0nzwfPH2UTIa2L/G/Ro0KwVVxLSWXwgSU2Q/S4yGr10p7RjlqQ==
X-Received: by 2002:a17:90a:1117:: with SMTP id d23mr8581699pja.136.1593265097692;
        Sat, 27 Jun 2020 06:38:17 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:17 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 08/15] perf ftrace: add option '--inherit' to trace children processes
Date:   Sat, 27 Jun 2020 21:36:47 +0800
Message-Id: <20200627133654.64863-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
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
index a18d640e90bb..66876e79cc24 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -64,6 +64,9 @@ OPTIONS
 --buffer-size::
 	Set the size of per-cpu tracing buffer in KB.
 
+--inherit::
+	Trace children processes spawned by our target.
+
 -T::
 --trace-funcs=::
 	Only trace functions given by the argument.  Multiple functions
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 686d744d5025..b2651b9bd6d0 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -40,6 +40,7 @@ struct perf_ftrace {
 	int			graph_depth;
 	unsigned		initial_delay;
 	unsigned		buffer_size_kb;
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
 
@@ -336,6 +356,17 @@ static int set_tracing_buffer_size_kb(struct perf_ftrace *ftrace)
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
@@ -405,6 +436,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -580,6 +616,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "ms to wait before starting tracing after program start"),
 	OPT_UINTEGER('m', "buffer-size", &ftrace.buffer_size_kb,
 		     "size of per cpu buffer in kb"),
+	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
+		    "trace children processes"),
 	OPT_END()
 	};
 
-- 
2.25.1

