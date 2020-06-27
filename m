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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0784DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF33421582
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q05+HZ9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgF0NiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgF0NiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AACDC061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so5342458plo.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fJeC/w38J3A4p3KBZWDeZ2QkmjVYo2OE3plCtum5zE=;
        b=q05+HZ9Z1Ds2LzF5saLPmP5/fZdUYeRVD4iHHWkhV3i+qnFYnnEcNWs+c48SI161Va
         N/ZU8yetNgq55umIMLe4iQf95m3OAxRdzjJ/kCZTfJtz29EjTjaCJgWdIL+H+rE53BTe
         Pl0avN59lYdcKZDtUCCWqQE9B69BI2IzdL7K8DkNpFgtK7V2+kuz5jmOi7PA0aUAwuQP
         6Q6Ww+5X3ZnzAHdLjhLj3xFNY8J5AueK2jsZ4RaTKjHdBEyZS+G7EdGRRwxdf0Kaw5Vc
         v8B8ZyBF/Ic97fyOv2JF7fF5pGy66k8Y7PvNAufOjddheAkxgnzvynOOjk6Br7htWmfk
         Lv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1fJeC/w38J3A4p3KBZWDeZ2QkmjVYo2OE3plCtum5zE=;
        b=Er/5JfjEc7KwPB94gaY3UKp21d9/zZzNA5NxqvYMeqhhSlP/3yZvl0EkLtX2imQ9P/
         r1sElVB0+wPBjGbfuW+Yu8WhAdiaRmv9ibGfh7KCGCLpqUGEbhAkffrvvgQl7tlYTS6d
         fo5fYCt4C9IfySiZDe477wPuu+dcbHpEGckfPTQ71kWrl5wo7QnHOJnn4g8ql/yWUO/g
         utljZSO0TXeoKRInQdwJ5LukvuWucRhu1k9CHgu1eD8nXFGnL7C6rgU3yG91sj7t/RqC
         OBo6k006cffVL839dhxrVTH2+14+CRS55dD1VGehTmta/OtAdWvz0TWRK3RbkBpS4BSK
         3CVw==
X-Gm-Message-State: AOAM530+nC5GxbOb/0gtdF7RwBI0j9cqrNbZJUgY+4FFPosyTcKkGjWu
        eqTsy/eFIVSDAwfsJPtUPuo=
X-Google-Smtp-Source: ABdhPJwOK+wjWEZiT4nP+1HSpAD6gSarjA4DpHWte1IOqNuUhiJYgp5vfYWk2GLZ94wqu0F2ZGEpeg==
X-Received: by 2002:a17:902:c082:: with SMTP id j2mr6651648pld.175.1593265082232;
        Sat, 27 Jun 2020 06:38:02 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 05/15] perf ftrace: factor out function write_tracing_file_int()
Date:   Sat, 27 Jun 2020 21:36:44 +0800
Message-Id: <20200627133654.64863-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
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
index dceae70c3a22..003efa756322 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -166,6 +166,17 @@ static int read_tracing_file_to_stdout(const char *name)
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
 
@@ -296,8 +307,6 @@ static void reset_tracing_filters(void)
 
 static int set_tracing_depth(struct perf_ftrace *ftrace)
 {
-	char buf[16];
-
 	if (ftrace->graph_depth == 0)
 		return 0;
 
@@ -306,9 +315,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
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

