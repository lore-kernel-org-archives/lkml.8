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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39905C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DBE21582
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZffcuJu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgF0NiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgF0NiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF0C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so5353563pls.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fy1K28Fcb/yrrbzootz0WKnVD3wVNq3gJQOpdR6OO00=;
        b=ZffcuJu/C7+pHA9U0uzq5UmEBSQxLPc8OyfeNc6w+zLLiZOztcSTSCabs0We+sBd/z
         v05Us8mltl+7am2x9JAsvz2zfFLEU+AUdJvseieCdoQdI57rtewrpNPRXyQrfM5hko5p
         Lqptddqd2iPU6IL4D5gzYV2ERBZ5K1qh/uwtAAGVjx3pj6MbP7BPOTb+5Yi6M0DnOxkL
         egO5FgFJUBjI7Lllc4lak+bwACw7OSAFumZyfYnfSRrwPs2EMfgy1LaAda26fqG9pevB
         L/8HOPBH8Ctwc27GZqe4dfbjuuRX9ha0fseDZfzIO6zq6L38fjX2kATSrtOokHSVEl2s
         TXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fy1K28Fcb/yrrbzootz0WKnVD3wVNq3gJQOpdR6OO00=;
        b=jEasHag0ULbfWxn75oOGh2dNscJU5P6bqs02sBRIKrocbMGvqIdn5xezvoLQNSIhOo
         c00vtf4z+uVRulCHN+zQHxg1WOZnGOCPNnF3Df+mYpCsW8zVR6v8ax0FTm/XasYMgyYC
         HPRmvYQiTUGKGC9c95NXHPZuukzbf4hmA07AS+E8XPC+xRjFSY3OSvsWMHf80UfPgmWG
         8tdPNpGuqsoCaRkiiOHMVRVuO65AHgsFmhwvW2LzAhGlEBHUkl8Dt+LEsAxTFvahmXTh
         3p9fjVNyXsvZI03nKSLblYebqZeYa+qfDX1gaVsPLEv19VosTSwjMjNIoboAJrj1x0ut
         XjBA==
X-Gm-Message-State: AOAM53155kSwg8EIyrgyBhqNXRwbzNlnKSOoSx5QwgSx0e3ksFvMalXS
        36hIjJ6WyOcANyH1kBsLIkY=
X-Google-Smtp-Source: ABdhPJyG5xfIttzuIi+90/lx4HjV495j6W7FN5OSs3hh+Y4Dk0iSyitbtBgqfi/s9PfgTEEb4g33EA==
X-Received: by 2002:a17:90a:e398:: with SMTP id b24mr8328357pjz.235.1593265087107;
        Sat, 27 Jun 2020 06:38:07 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 06/15] perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
Date:   Sat, 27 Jun 2020 21:36:45 +0800
Message-Id: <20200627133654.64863-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-m/--buffer-size' to allow us set the size of per-cpu
tracing buffer.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  4 ++++
 tools/perf/builtin-ftrace.c              | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index fd1776deebd7..a18d640e90bb 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -60,6 +60,10 @@ OPTIONS
 	Ranges of CPUs are specified with -: 0-2.
 	Default is to trace on all online CPUs.
 
+-m::
+--buffer-size::
+	Set the size of per-cpu tracing buffer in KB.
+
 -T::
 --trace-funcs=::
 	Only trace functions given by the argument.  Multiple functions
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 003efa756322..e45496012611 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -39,6 +39,7 @@ struct perf_ftrace {
 	struct list_head	nograph_funcs;
 	int			graph_depth;
 	unsigned		initial_delay;
+	unsigned		buffer_size_kb;
 };
 
 struct filter_entry {
@@ -321,6 +322,20 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_buffer_size_kb(struct perf_ftrace *ftrace)
+{
+	int ret;
+
+	if (ftrace->buffer_size_kb == 0)
+		return 0;
+
+	ret = write_tracing_file_int("buffer_size_kb", ftrace->buffer_size_kb);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -385,6 +400,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_buffer_size_kb(ftrace) < 0) {
+		pr_err("failed to set tracing per-cpu buffer size\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -555,6 +575,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Max depth for function graph tracer"),
 	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
 		     "ms to wait before starting tracing after program start"),
+	OPT_UINTEGER('m', "buffer-size", &ftrace.buffer_size_kb,
+		     "size of per cpu buffer in kb"),
 	OPT_END()
 	};
 
-- 
2.25.1

