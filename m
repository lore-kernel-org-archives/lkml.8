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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A40AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B12206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bATwOvAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgGHQrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgGHQrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:47:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF271C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:47:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so15068841pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWmf4GbZC/L6jfD+gr6Dtqltxu8YDgGBQoZIgH7qAxQ=;
        b=bATwOvAgK11OMZDCB79zFJc0pg+DtqVJFf3mguxnu/02mU34MYr0gxNklFr4b9BuYg
         PbkU9qM3MfZQzlanXAjA/jXtcc51AkXtz8dKouiQGriSpSx2ZPCXLTjChJQTpYxugMht
         amyKB7vpiO8D7PJJr3Vwx7aIraY+JPIzP4DG89lLdEd3T0NmkkulRuMGPZEo+3cBIEAx
         21Q44W5Z6CPVavPULIZT0oAQ3D8WLHTkmHWvNGOWCvQTMwBZsP8wAMl1k6S4APq2FKxC
         U94VOuTtR9AacH+C9ZjPz/dsXUIIOppU+d+P/105aRSTMVlp4RfN50G4Defk0jdyIET8
         u4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWmf4GbZC/L6jfD+gr6Dtqltxu8YDgGBQoZIgH7qAxQ=;
        b=PZguHxQ0gkWS8nOmhQ58/2uTOHBB890iQJYY75JWxqiryrd/6JD86eIMXRRGeSdn9i
         PzOx/25QImsZw8GV/Nq58G4HYhWrO89Q4f/QB40LY92eb/PQ1eQOtopypjFMt9i1vr9a
         Nx9JRvtGVzsPfFEDPv7dFDAzhGD65pTkX9PMdl+oMp06gaYcCst6W9Yv+YpPYEFXejSy
         Y7k9bBxRUK0Fzez4E20aNAxT0BG4169hfolrb863/qDc5lIrG/fBklR3+lHQ8ZBhrfzE
         w+bMBTVd2aSOBlsPLNiMpACVJhz3X1Bt2uXe+w7xaIFnE+M/wNPDnZ6FZNCIsONNcBQq
         YQMw==
X-Gm-Message-State: AOAM531/DuWf/qIyNcmLvoOdzuw5kv12ERq5gHNe9SjhyISXYsZOkx1g
        IcudZSTPVNK6+SrGOmp67LQ=
X-Google-Smtp-Source: ABdhPJzjvbIOUOpPOpbAjqXq/Qosmi9q9zC1dbH+jGumGfIJ8wqvVyOqvrl0fDTkTXVxjZSuF11Y+g==
X-Received: by 2002:a63:3e09:: with SMTP id l9mr51756259pga.235.1594226831291;
        Wed, 08 Jul 2020 09:47:11 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:47:10 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 04/17] perf ftrace: add option -d/--delay to delay tracing
Date:   Thu,  9 Jul 2020 00:45:52 +0800
Message-Id: <20200708164605.31245-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-d/--delay' to allow us to start tracing some
times later after workload is launched.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  4 ++++
 tools/perf/builtin-ftrace.c              | 19 ++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index e204bf6d50d8..fd1776deebd7 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -42,6 +42,10 @@ OPTIONS
 --tid=::
 	Trace on existing thread id (comma separated list).
 
+-d::
+--delay::
+	Time (ms) to wait before starting tracing after program start.
+
 -a::
 --all-cpus::
 	Force system-wide collection.  Scripts run without a <command>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 1188b82c6541..7793c3d083e0 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -38,6 +38,7 @@ struct perf_ftrace {
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
 	int			graph_depth;
+	unsigned		initial_delay;
 };
 
 struct filter_entry {
@@ -402,13 +403,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
 	pollfd.fd = trace_fd;
 
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
@@ -535,6 +546,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
+	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
+		     "ms to wait before starting tracing after program start"),
 	OPT_END()
 	};
 
-- 
2.25.1

