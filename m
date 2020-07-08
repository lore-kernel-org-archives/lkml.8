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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F9AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F80B206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IblHjysa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgGHQrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgGHQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:47:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEE5C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:47:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so9140829pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKr8CJ+1/bHpfCCPn8YyRkvbxiJt0CaVo5UMlNNJe5c=;
        b=IblHjysai2BApa2Zyj4f0pkizhhkyLeBEhv/OGRVxNKY9Qp/T2ru1dM41Yps9Q9cJF
         kebWV9/d6PmWoOzctkXdQ7y9EHCQrXjIdc6OAIoyhQpHetOU9NLqLwBxY+4TPae9xdoy
         N1rrrXIkUnRaTMGkhxMDfC+2GR+o3V7eR2m1paXT2R/5/xtM7fV+gpRlVClQ9+z/mVWp
         AiUuyVXO9xGi5jMXqkCtPDkjK7MM6sBKO2LWSss1Jb6aTRy0c5nLloLtXm3kYLRyveXR
         Sz9H+7sgX7mxIRSWjm1WBvew8/jwuyptN0juqmh2jZ8r7yyrK0MthsgUEdY/h2t39Ul8
         Q1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKr8CJ+1/bHpfCCPn8YyRkvbxiJt0CaVo5UMlNNJe5c=;
        b=Gazezill3qxPEWOSjF3p/A1vPir7sdzj6XBLB2/rWTs1biBwqqoyUy/RplS/2Y00EQ
         S+6K66lWYFSI0uO6uFfnkxcZR/6PY8BdUoY4Hy8L6s7B77FbL90yrUTbfpMqF7OxPH4c
         4qpuK2+n80cfeuci3iUrN8s6+hSIXLHBkrvHLhi0kbrW6pqCEBRXS53SdmmXRjWOTqMQ
         /4+bnUqUznVZvAcck6Ou+WdqEcE8KeEm4NUX0aHEkDQNS3MGYdPXWF9cZLyKcGO5mm//
         IHerjK9Pn150gEiAFGFMBbdMySzs46IiwUjm5xtUUQtboE9XfBe1MM615eK1vSsC2Gan
         437Q==
X-Gm-Message-State: AOAM5327Da1M6VqbiwCIWzkdpxiNa/mBsXU+F47fLYsfDsdtHkU3yr2x
        D/W00liLiXXpWmoMTXiSB6k=
X-Google-Smtp-Source: ABdhPJwMoYcltjtd+/m/cLjqJArfwzAdVGq2SoxJp+EKo7mBHjdR3Ju7l+FTnbeXgV7cFmtBsM9Pvw==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr10652372pjv.139.1594226837128;
        Wed, 08 Jul 2020 09:47:17 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:47:16 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 05/17] perf ftrace: factor out function write_tracing_file_int()
Date:   Thu,  9 Jul 2020 00:45:53 +0800
Message-Id: <20200708164605.31245-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
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
index 7793c3d083e0..7eb41f7027c8 100644
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

