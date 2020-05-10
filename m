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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED5C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FA520735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGu1Qv/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgEJPII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgEJPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:08:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EDFC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f15so2816008plr.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/D51KRBfgHPLGzkJHJadx75PdlayeJcRyxV0asK4CGE=;
        b=eGu1Qv/kM3GdK+nvznzbqKw34j7nL438tQBFsg1roMiLyjvQKXlicBKTnZB6svOqrY
         tFyqKAU7h9YSg11POJZtDFZ51372dNIPJPLJuQHm6Fq2YaxOXQRgFOZKc29xvHGUrYdG
         cpomvqg9NUGU4nl6zk2Ol9+ijSr+fkCX2bjYzs4wS8dQ/GpSPoZ7D58A1+844fqeYJ55
         Q/FqN1tLlhrhdLXetIcyTdYv9dbNOQDRs19/XNmbZeMndkuovTx2GY9nrhimzdgqyuc5
         uGkcuNlVvTPszjT7JCzJuR0AH6FCyeaotjqyddlHkP/tkxX0lMOUOmlWFFNEucgYKr4+
         viMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/D51KRBfgHPLGzkJHJadx75PdlayeJcRyxV0asK4CGE=;
        b=hDNmmJqDQkIjk+BUuy8MW5dPT898+SQnZAFq6tSEEXqmYWHcptE3RSWNsqfVKWA8pt
         5hTdApSSre4D6qsLN1oEnuBuHurNj5HyYX+2Kf7667WzX87StLvbIxYELgebUMvNMQAi
         KJtGS06xPSRNqmw+K6x1v4SBQdyAgHpHG/5NFGX7bVRj8BACpwa94JUf809Wlm+aVfml
         hwG3HdhhxREjubqfBJGGWOsseoxeXJ1AE9bAw0q8ohD00BD1ugtvx8PXWj6jDPD6MP0n
         nX69gKBLi+X5Ud/HdpTFy/E+2g6BzkR/KAmSBADScr+bgFop55icD87epwcOsra0Kv7x
         WoPg==
X-Gm-Message-State: AGi0PuZXd5U0emJZuUc0+Y8J7ACKqt32lxI13Mhyr9CxiuePCd86KWUD
        S5zPtj05IBzox+ugTqv6xB4=
X-Google-Smtp-Source: APiQypKHeaxe3Sp3XFVqZIYonY1qvwDML2T6CynWtcBwkkvY1H2guDx6tSmP7Ncd7Qpz+eIcPDAHWw==
X-Received: by 2002:a17:90a:d17:: with SMTP id t23mr17566493pja.77.1589123287626;
        Sun, 10 May 2020 08:08:07 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:08:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 05/19] perf ftrace: add option '-l/--list-functions' to list available functions
Date:   Sun, 10 May 2020 23:06:14 +0800
Message-Id: <20200510150628.16610-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-l/--list-functions' to list all available functions
which is read from tracing file 'available_filter_functions'.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 1d30c2d5f88b..8133d910d5d8 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -33,6 +33,7 @@ struct perf_ftrace {
 	struct evlist		*evlist;
 	struct target		target;
 	const char		*tracer;
+	bool			list_avail_functions;
 	struct list_head	filters;
 	struct list_head	notrace;
 	struct list_head	graph_funcs;
@@ -142,6 +143,43 @@ static int write_tracing_option_file(const char *name, const char *val)
 	return ret;
 }
 
+static int read_tracing_file_to_stdout(const char *name)
+{
+	char buf[4096];
+	char *file;
+	int fd;
+	int ret = -1;
+
+	file = get_tracing_file(name);
+	if (!file) {
+		pr_debug("cannot get tracing file: %s\n", name);
+		return -1;
+	}
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		pr_debug("cannot open tracing file: %s: %s\n",
+			 name, str_error_r(errno, buf, sizeof(buf)));
+		goto out;
+	}
+
+	/* read contents to stdout */
+	while (true) {
+		int n = read(fd, buf, sizeof(buf));
+		if (n <= 0)
+			goto out_close;
+		if (fwrite(buf, n, 1, stdout) != 1)
+			goto out_close;
+	}
+	ret = 0;
+
+out_close:
+	close(fd);
+out:
+	put_tracing_file(file);
+	return ret;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
@@ -332,6 +370,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
 
+	if (ftrace->list_avail_functions)
+		return read_tracing_file_to_stdout("available_filter_functions");
+
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
 		goto out;
@@ -483,6 +524,8 @@ int cmd_ftrace(int argc, const char **argv)
 		NULL
 	};
 	const struct option ftrace_options[] = {
+	OPT_BOOLEAN('L', "list-functions", &ftrace.list_avail_functions,
+		    "List available functions to filter"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.25.1

