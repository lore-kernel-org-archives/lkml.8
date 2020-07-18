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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DBEC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B252074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui8ZhDCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgGRGtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRGtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:49:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6CCC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so7704787pgg.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fu+rs2+2gElCUdDzPBQL6sWFbu1uYUhKK5LQZgejHd4=;
        b=Ui8ZhDCpwAk+PxtV+sZ2TzzkCbK2f76TfokOtIqhK5o8u6V9MZp2UoZVArnOuuihL8
         shu6mybO8AsgG5yMVEvAJbG2Gm9bZFMuEJ7eqNStAxoEgGGYe1SHSdvyUZCgCLao/mIs
         HInhh8uIh9wHzcw6onTc7UAWvXjmZYhsEzgc0y8F0P96MeYaANrDFxRgxp43h1uwD0S+
         lg4lOxQLfTKl+na7deJAARkROo0JyOvuTx9UlsRmYn6K+KfTJfIbh6EnDq9m3pwi5bIE
         BhXuK+83qDzaKEc87kU0DkYoAsMGYTzotJHvC2IoRevAsUbx/ZMTxY2ZjrELPDFcFvYD
         e2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fu+rs2+2gElCUdDzPBQL6sWFbu1uYUhKK5LQZgejHd4=;
        b=Zfn5Nmr8As3RuFlxdMvqbMxMqKZ/x68KP9Q5fJu8ygganv+V8ExLAlfs0xGujAy/ut
         LN8CDm7eJO724g6JAvIm0FwHieHGlqhb64t3qn48nYGiwjVAC114KGoHnT/1iUo/B+gH
         lStgZYm8UCn5/3qjT1fKTg9lAxNrbXRu4Sc5Y92bJ9AeCqvI9b8iNv/nr+FJWMVcSapl
         i2Qo4oRS9Wl4qjGu6SNgkjrKnfSt/I/wExUehhysNvIiKY0glEOizS+DsufmWqVIwBcj
         co18VPgPA25eX6VsLNniCf3CQjc7RjZ0Cv4iFKUq/Le7rRSyGORH45ci7eKwZt67d2y6
         abCA==
X-Gm-Message-State: AOAM533vC7j0+J1jWFMwhgt6wiL/15iD8galXD81aVAkEPsZqkyHdOCN
        BuphXjgY0DLI6hpfw3zxu7o=
X-Google-Smtp-Source: ABdhPJwH3nM0uhn59qPf863GMHQQ5217yCSSJ5ghcELvkXs5oUw7iaRlbFJ9Gf9EV1CF/veOUrDTlw==
X-Received: by 2002:aa7:9685:: with SMTP id f5mr11286586pfk.223.1595054945901;
        Fri, 17 Jul 2020 23:49:05 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:49:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 03/18] perf ftrace: factor out function write_tracing_file_int()
Date:   Sat, 18 Jul 2020 14:48:11 +0800
Message-Id: <20200718064826.9865-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will reuse this function later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 3c0e60fdfe0f..9abf97c29cb6 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -168,6 +168,17 @@ static int read_tracing_file_to_stdout(const char *name)
 	return ret;
 }
 
+static int write_tracing_file_int(const char *name, int value)
+{
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%d", value);
+	if (write_tracing_file(name, buf) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
@@ -298,8 +309,6 @@ static void reset_tracing_filters(void)
 
 static int set_tracing_depth(struct perf_ftrace *ftrace)
 {
-	char buf[16];
-
 	if (ftrace->graph_depth == 0)
 		return 0;
 
@@ -308,9 +317,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
-	snprintf(buf, sizeof(buf), "%d", ftrace->graph_depth);
-
-	if (write_tracing_file("max_graph_depth", buf) < 0)
+	if (write_tracing_file_int("max_graph_depth", ftrace->graph_depth) < 0)
 		return -1;
 
 	return 0;
-- 
2.25.1

