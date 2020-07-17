Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AFFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB092076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y53rjYKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgGQOis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgGQOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:38:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326EC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so5510568ply.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGmY2yM7IBrhvEVueqg0kykP3l1lO9dWCgs8ldRYKD4=;
        b=Y53rjYKfCbke7+OOGEfgyCpR7IIno3OjyAWyQvFlw6zMWg9Z9kbqnfVF6tK9u7x7qB
         UDzk4Dk7VOOX+equLqUh/9kS3W9P+wNOB1+7o0DLXGfcjM5HcgEvxU+d/+jkk/yugRhC
         LJzhMKdNMbnzQkmU0CpelzeqnVE8mQuRBjT7ueltjHvCkYcS5tvAZw2TJYoUxtghNC39
         WzajwDmwOWg+MXsNlqmYiAsMTdQ+PtXGwqe9d69yhOBMWDvQCWBU8QqOJ01EG/uSNPSm
         NTWw/pXu5JFjv2kGrV6CPQbd2i6ZWUf52YAVTOtx2Iaibr46FjWqTDFCK8FKT+lX6zTD
         sEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGmY2yM7IBrhvEVueqg0kykP3l1lO9dWCgs8ldRYKD4=;
        b=oFkhzu+2yiufIdwMTpKK1GY9xXEV668h/2cwHPLsIlbLDMPDsY+eBxnGcA5UEgfdl1
         VXWcSD/hY2x29BjUPNV3pNyb+hFI/z/K/l7tSX61Vbl1monxrh7d/OzxHEE7dtiJAnMr
         9k4yhdugtRbsiPhLL3TrGpwEq73ZFo00fbpJNjuv0XVmIpjhQ5ZdEnzX2w5p7uCP0rCB
         FGXG1eVIplfjNQK74Kwi5QcjJs1l1qOuL00aeSFn87gqjR+35e6BI3i8RauRCkjnmz29
         0n1N9EeJoyBt1HrymwZYir/8x1U3e30hVUg0lc2sxiaIqI3mA5Qwl1VQydoaxX6sUkGh
         hgtg==
X-Gm-Message-State: AOAM533cS4rkoagi+FDR2DDnRY1kTsp1mmxcRFeBd1XBLrhyyVys3SAY
        C7xU8AptLPGibCTMwIVewEo=
X-Google-Smtp-Source: ABdhPJzhfKm9nQWNAxbSphuEzCQZuJj/j3w0vZZCrT1MAHLJ3PBRxLsDARUtj2kZrAKCUaRmfG81WA==
X-Received: by 2002:a17:90a:1f81:: with SMTP id x1mr9458446pja.115.1594996727522;
        Fri, 17 Jul 2020 07:38:47 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:38:46 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 15/17] perf ftrace: add option -D/--delay to delay tracing
Date:   Fri, 17 Jul 2020 22:36:26 +0800
Message-Id: <20200717143628.47721-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-D/--delay' to allow us to start tracing some
times later after workload is launched.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  4 ++++
 tools/perf/builtin-ftrace.c              | 19 ++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 6f17939b8789..077249c979f2 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -38,6 +38,10 @@ OPTIONS
 --pid=::
 	Trace on existing process id (comma separated list).
 
+-D::
+--delay::
+	Time (ms) to wait before starting tracing after program start.
+
 -a::
 --all-cpus::
 	Force system-wide collection.  Scripts run without a <command>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 3ddd7568b456..64b68331048a 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -47,6 +47,7 @@ struct perf_ftrace {
 	int			graph_noirqs;
 	int			graph_verbose;
 	int			graph_thresh;
+	unsigned int		initial_delay;
 };
 
 struct filter_entry {
@@ -594,13 +595,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	/* display column headers */
 	read_tracing_file_to_stdout("trace");
 
-	if (write_tracing_file("tracing_on", "1") < 0) {
-		pr_err("can't enable tracing\n");
-		goto out_close_fd;
+	if (!ftrace->initial_delay) {
+		if (write_tracing_file("tracing_on", "1") < 0) {
+			pr_err("can't enable tracing\n");
+			goto out_close_fd;
+		}
 	}
 
 	perf_evlist__start_workload(ftrace->evlist);
 
+	if (ftrace->initial_delay) {
+		usleep(ftrace->initial_delay * 1000);
+		if (write_tracing_file("tracing_on", "1") < 0) {
+			pr_err("can't enable tracing\n");
+			goto out_close_fd;
+		}
+	}
+
 	while (!done) {
 		if (poll(&pollfd, 1, -1) < 0)
 			break;
@@ -809,6 +820,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "size of per cpu buffer", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "trace children processes"),
+	OPT_UINTEGER('D', "delay", &ftrace.initial_delay,
+		     "ms to wait before starting tracing after program start"),
 	OPT_END()
 	};
 
-- 
2.25.1

