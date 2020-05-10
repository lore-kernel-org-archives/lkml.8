Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B98C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F02320735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axYthdpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgEJPJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:09:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:09:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k19so2810171pll.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Bjyti1fp4fPGeNODg/HnWos4dXFnDDo/Z9/MiCh8vM=;
        b=axYthdpmHb7vyeLTp6LQzKnCwhKJqcDaQqy1M2Pf0EQt72iOflV1Iuyc+wtEGZ0W4c
         oUdfS52kRTjVyTplHnCScUQ3t77GMb/2FAm45fkVJBWBSC43ukdpzh6pLFb41EqVKJG2
         9OTZaE9+/T3zUiKp7fGpHI1KKhx6KaKb2KB4jFtchQ4arBa0kOwFx3CT2GZUdKLzQuRu
         hqow8XeHSsH/WjvulSLvDLhZQWgXn8pQ2R7QNUYwioLu3MoWh4cWH4ar9Wc0HQvHFLWM
         pSn9QIZ9A06DPkHD0tgJ76d9/1LrSo+LmShQpcBTlhDhRYdBGhlMzcaqYg1vVbxHAPdM
         eQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Bjyti1fp4fPGeNODg/HnWos4dXFnDDo/Z9/MiCh8vM=;
        b=mRgMm/qpk4JadIgGijfr26tBFAwMvesLoJmCSv6FrfTKKcsr7ELFjIPLmYAFZ2ivLR
         dBrPFOlBl6F2/IzzKRYmWlXFk98D+yb79RsZR+3IrSonc12fENKB7jFbIupPE0PSpGTy
         64lzpgyEpz5GlFvBlry0xVivCAENybga7FOtN1DLYcmQyutqreQgfdk2o5NYIBYomaG8
         Tze0EhQFlvJOfkVDEUW1sN484TFZTGJUomoHCXd6x8EcWzHclQ/rg5ad2PC4xFAbbgVI
         dW9BdqFIF+FRbbim16JwNrZBQexJGPHsmzHqzPaFYUd/k6VJ1OU2obqTOL9l84YwIhlG
         jpQw==
X-Gm-Message-State: AGi0PubBxiqxvtzL4PCeOYTElPxcnHNpk2cyz7bvtyxwi+olpK0fOtn3
        XQkR2e3BiDyjGemyNOHbbbo=
X-Google-Smtp-Source: APiQypK+cBHgklWmN4E0DChQA4Cqj26pkVdpONEvZlhgkYiOM5Kdvcq9Sk9ucc9nf1Q8lffwC3pXSQ==
X-Received: by 2002:a17:90a:d17:: with SMTP id t23mr17574950pja.77.1589123395686;
        Sun, 10 May 2020 08:09:55 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:09:54 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 14/19] perf ftrace: add option -P/--no-pager to disable pager
Date:   Sun, 10 May 2020 23:06:23 +0800
Message-Id: <20200510150628.16610-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want perf displays trace immediately. So this adds an option
'-P/--no-pager' to disable pager if needed.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index a93fbdac6aa4..64c22f367ba2 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -48,6 +48,7 @@ struct perf_ftrace {
 	unsigned		tracing_thresh;
 	bool			trace_children;
 	unsigned		buffer_size_kb;
+	bool			no_pager;
 };
 
 struct filter_entry {
@@ -56,6 +57,7 @@ struct filter_entry {
 };
 
 static volatile int workload_exec_errno;
+static bool interrupted;
 static bool done;
 
 static void sig_handler(int sig __maybe_unused)
@@ -63,6 +65,12 @@ static void sig_handler(int sig __maybe_unused)
 	done = true;
 }
 
+static void sig_handler_int(int sig __maybe_unused)
+{
+	sig_handler(sig);
+	interrupted = 1;
+}
+
 /*
  * perf_evlist__prepare_workload will send a SIGUSR1 if the fork fails, since
  * we asked by setting its exec_error to the function below,
@@ -492,7 +500,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		return -1;
 	}
 
-	signal(SIGINT, sig_handler);
+	signal(SIGINT, sig_handler_int);
 	signal(SIGUSR1, sig_handler);
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
@@ -585,7 +593,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
-	setup_pager();
+	if (!ftrace->no_pager)
+		setup_pager();
 
 	trace_file = get_tracing_file("trace_pipe");
 	if (!trace_file) {
@@ -636,7 +645,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	}
 
 	/* read remaining buffer contents */
-	while (true) {
+	while (true && !interrupted) {
 		int n = read(trace_fd, buf, sizeof(buf));
 		if (n <= 0)
 			break;
@@ -731,6 +740,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Trace children processes"),
 	OPT_UINTEGER('b', "buffer-size", &ftrace.buffer_size_kb,
 		     "size of per cpu buffer in kb"),
+	OPT_BOOLEAN('P', "no-pager", &ftrace.no_pager,
+		    "Do not use pager"),
 	OPT_END()
 	};
 
-- 
2.25.1

