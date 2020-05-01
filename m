Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A7C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEA924953
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oa3VQjz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgEARdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730224AbgEARdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:50 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD90DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:48 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 30so10798983qkp.21
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+ot4xu8P2SexJM6MGXYbzzq/GQaqN2BkLb72ro0O34w=;
        b=oa3VQjz/hQ8JVeQoeFDTwpiphtQMkijWONyG6GmOuXFW3ds02LZMZe8sGmRnRmRqNk
         YXktmXjXrO/KW8P2frmIfG2Vx5hJpcHMvlEnKf5qfGOVeyNya510us4XsbmGC3tMiuYs
         Jue3JcF/rOP4ICiOPciTtktngmOCwr1iLturZuJA6FxeDvie49FXwmEaSm2ar6zReBfo
         tk9MsJyl2gvEX1G21Jlm0Z2UaPZOL17TsMyS7H328Q/zvbOX+OWajOfGVu8w6d4r0Vo5
         Z10hyhHAw9QS6+Ey2+eLq2n8+VPOU00a1e8+Y9Iws5ssQ6eZDCI+98Ge/i8svHC88xTW
         lD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+ot4xu8P2SexJM6MGXYbzzq/GQaqN2BkLb72ro0O34w=;
        b=EHdOFguijhZmsHWWGioL1N1UUkRnxgORIl7mRcM/M1ikp3MapcbYqo1H3Qn8YbSbqk
         GECqj0T1D6uURe9iZdXwVdj6Jj4s5ST7pBEntmIC+DgJNWZKO1N4WY+pe90+kwbWLiJe
         V7WnJDXUcaktMFE+r/MxDeLYbSC2b8MpEKg7MCqX3XqcM/SPuyhKjQWw/1g7rjYN7Rvs
         p3ntoqtds7MQq0D8RXwvdaMmODWeDuWLyb/eWOZ63lbWb69bPEznWdG1ZVdSJhriJNiG
         +bJvungCuL9xDunuJO9kAQjuEFeh4tPImSN58rkIT9aejRMNTyhcu00OIQjWJMLWgKCk
         vZyA==
X-Gm-Message-State: AGi0PubRrkv1DfuKRPwLtu2VX49HiyS6l8rrXaWiwa61qyaJ8pVOUKn3
        XPxfuUXZauupr56Knx8Zwj6eBUO70M7W
X-Google-Smtp-Source: APiQypJlMNs5rZHFzHZO3E7RFv+oHfdk4YlMMjXOjqVGkOXfpHxetqHFnS6e1NFpRKdTGjUgbOV9OZ+4Bh2n
X-Received: by 2002:a0c:f8c4:: with SMTP id h4mr5170957qvo.15.1588354427865;
 Fri, 01 May 2020 10:33:47 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:27 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-7-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 06/12] perf expr: parse numbers as doubles
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is expected in expr.y and metrics use floating point values such as
x86 broadwell IFetch_Line_Utilization.

Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 73db6a9ef97e..ceab11bea6f9 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -10,12 +10,12 @@
 char *expr_get_text(yyscan_t yyscanner);
 YYSTYPE *expr_get_lval(yyscan_t yyscanner);
 
-static int __value(YYSTYPE *yylval, char *str, int base, int token)
+static double __value(YYSTYPE *yylval, char *str, int token)
 {
-	u64 num;
+	double num;
 
 	errno = 0;
-	num = strtoull(str, NULL, base);
+	num = strtod(str, NULL);
 	if (errno)
 		return EXPR_ERROR;
 
@@ -23,12 +23,12 @@ static int __value(YYSTYPE *yylval, char *str, int base, int token)
 	return token;
 }
 
-static int value(yyscan_t scanner, int base)
+static int value(yyscan_t scanner)
 {
 	YYSTYPE *yylval = expr_get_lval(scanner);
 	char *text = expr_get_text(scanner);
 
-	return __value(yylval, text, base, NUMBER);
+	return __value(yylval, text, NUMBER);
 }
 
 /*
@@ -81,7 +81,7 @@ static int str(yyscan_t scanner, int token, int runtime)
 }
 %}
 
-number		[0-9]+
+number		[0-9]*\.?[0-9]+
 
 sch		[-,=]
 spec		\\{sch}
@@ -105,7 +105,7 @@ min		{ return MIN; }
 if		{ return IF; }
 else		{ return ELSE; }
 #smt_on		{ return SMT_ON; }
-{number}	{ return value(yyscanner, 10); }
+{number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
 "|"		{ return '|'; }
 "^"		{ return '^'; }
-- 
2.26.2.526.g744177e7f7-goog

