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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CBBC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57912082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu7AL5hK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgEJPIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:08:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so6513385pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbTaMqmI724KYLPlDNl+4pvCntdnnJ1Uj9oZE5a/Er8=;
        b=Qu7AL5hKebV7S6hdawWStWPEpsuFBhIMCFyvDFGoPmHs7AZ9ov9IkoVQTdR24QzDA8
         HwQ5s5zQk7cK3g2DckOW4CdrYY1qweoTggCMFd2PJauaQlLTsBQiQn7Ldek71a8qZJh1
         P/TbhsDM+rkm8twCcFL58FuicaelsBHvpx0j4tbv7qlFd4nt7toQFRhZa3LvoltItypJ
         LGs6LQGpBV4+GZcbjM6icqus4ex0wmQLTs0VPb1aEKlEeVb/AmlcOqSvNouzDiCMDn52
         zW7pFLqKo7XdWK8H2aBSoISiLgsaXMEuQ0kUZTPdzr1R9sgXdv0a2HOxikE2zQdU/k79
         44Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbTaMqmI724KYLPlDNl+4pvCntdnnJ1Uj9oZE5a/Er8=;
        b=SsG8bi/dKTAv/nQukKTPbfAPIAusb6u2sHNbDIiY5ljNe7kRqLlCbHmx/ETuovSUhO
         Y0DZUTmKfxvFuOWxESVZRKVSKxjYn8zrF6v+aoBX5cwzlQ1YiOMfbXp9xnraWJX5w1BQ
         8D5ad8mVz7IBSzQm785TeNQWbs6BKQk1Hs5xIuoPBf7B0GCfrUbzFf1pFe17/owuag+o
         7sMVBp8xHI7v6iBtLoyKxuxtQkIP+KmRhQF3RqqkalKuKOLCygbBnBbJnaprwDHA+ev4
         Bx0mHM5XkrYXkzrNh/i8eXJ+dPQTHm2ERNuhT1U/LUVhCR4Oc4T56ECvRpDr52Y2wqNL
         mgcA==
X-Gm-Message-State: AGi0PuacfLdCEC2872fpBCiNw0zZzoJmCAB2z2nBE/dw6FBdp9hhfKYY
        HWdxkNnChLyRPxpRgpf0JoY=
X-Google-Smtp-Source: APiQypKTBbqX+YJxSr8YMZuiJ6bUcpuWurjq+zI0NOIgiEW8Uuq3WXc0r+diS5BMrKbvBQ4jAcTB+Q==
X-Received: by 2002:a17:902:7d85:: with SMTP id a5mr11543082plm.106.1589123316733;
        Sun, 10 May 2020 08:08:36 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:08:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 09/19] perf ftrace: add support for trace option tracing_thresh
Date:   Sun, 10 May 2020 23:06:18 +0800
Message-Id: <20200510150628.16610-10-changbin.du@gmail.com>
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

This adds an option '--tracing-thresh' to setup trace duration threshold
for funcgraph tracer.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index f11f2d3431b0..20bc14d6c5fb 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -43,6 +43,7 @@ struct perf_ftrace {
 	bool			nosleep_time;
 	bool			nofuncgraph_irqs;
 	bool			long_info;
+	unsigned		tracing_thresh;
 };
 
 struct filter_entry {
@@ -213,6 +214,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	if (write_tracing_file("max_graph_depth", "0") < 0)
 		return -1;
 
+	if (write_tracing_file("tracing_thresh", "0") < 0)
+		return -1;
+
 	reset_tracing_filters();
 	reset_tracing_options(ftrace);
 	return 0;
@@ -392,6 +396,21 @@ static int set_tracing_long_info(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_thresh(struct perf_ftrace *ftrace)
+{
+	char buf[16];
+
+	if (ftrace->tracing_thresh == 0)
+		return 0;
+
+	snprintf(buf, sizeof(buf), "%d", ftrace->tracing_thresh);
+
+	if (write_tracing_file("tracing_thresh", buf) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -475,6 +494,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_thresh(ftrace) < 0) {
+		pr_err("failed to set tracing thresh\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -616,6 +640,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Ignore functions that happen inside interrupt (function_graph only)"),
 	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
 		    "Show process names, PIDs, timestamps, irq-info if available"),
+	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
+		     "Only show functions of which the duration is greater than <n>µs"),
 	OPT_END()
 	};
 
-- 
2.25.1

