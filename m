Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7566DC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529432070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7XDNZPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgDVHse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726543AbgDVHs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:29 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA0C03C1A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:29 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m2so1289123pls.20
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9v/SqbpPNd1vIjcwX2QJUR1yjeQPBkaJciMvLWYLL8Q=;
        b=N7XDNZPhdsdEwyU0vzOcl7tqswM6/F96CeW5rWLFd8PJ2pGRriXzxQ4P5D5hUNnCLi
         Wkxurn0ainfOjMX3Yfd9j5mT/NDrfM3uSfbl4MIwacfbKj4q0oZ7bvuBw20IB9WmeltV
         BccwCq/J/XTgMURhICnVja+lEcQ2X3cyZAlEsfFVJIBDLFYgDFVNWxSQA+korr1df4yR
         cG15Nu3O6rPPB/tBltaGgVdCcU09ZPw7J/KawMUQsMCtvAPk9k2JuJHOopWbrWgRDF1z
         axTtqMvDoDD68E19FSn0DU2w6+ytHwu0e2clpzQJYB5NYC3aMo3CgsTBKg7M4dhBLirA
         pZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9v/SqbpPNd1vIjcwX2QJUR1yjeQPBkaJciMvLWYLL8Q=;
        b=SpmxXo9kGFFzBr/HNS2c0fJv0Ur36M9jagzU7kK8KW0rCEsP6/KklrzJL+5QkoQMPj
         IY9cef6pi1klX59IGqHFPfcZmXTOj+famY2l/YXiUScZG6XXeXLwTkaTOZqdfgeuwTnM
         +KPLcGEmdkEe0okaC4tFIkb0/MeLAIxEvcf7OjGApcislIXd0kgKotK09i1wFnAoXBEh
         L+3isyFgwI3yUUfvKpnLKtB/NkDz326pd6f04eRkb7cV5rr1SPcr01M2+kDwEWRseyeY
         AHipY8DmBgNoC5i7oLTPOet7hLVTpdPieS0aEH6f3dOeLuzBCjWI16+mZaNzMMWOP5K3
         UxyQ==
X-Gm-Message-State: AGi0PuYPaYWCktqTUFH2w8L8OAB3C7ysiF1MtVRPjl2Tx1WdFYZndyTb
        kGdfABTEGP2C3WCU2X42d1rgewcXFJ75
X-Google-Smtp-Source: APiQypIJvMaeUybTX7ACLvTZPwFUYcx9IQhuL2RnqwGJFXXWPOkTmsSQFeIsVs0cjleh72eyggYSmyuFdDt5
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr10520336pje.1.1587541709004;
 Wed, 22 Apr 2020 00:48:29 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:07 -0700
In-Reply-To: <20200422074809.160248-1-irogers@google.com>
Message-Id: <20200422074809.160248-7-irogers@google.com>
Mime-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 6/8] perf expr: parse numbers as doubles
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
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
index 95bcf3629edf..0efda2ce2766 100644
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
@@ -68,7 +68,7 @@ static int str(yyscan_t scanner, int token)
 }
 %}
 
-number		[0-9]+
+number		[0-9]*\.?[0-9]+
 
 sch		[-,=]
 spec		\\{sch}
@@ -92,7 +92,7 @@ min		{ return MIN; }
 if		{ return IF; }
 else		{ return ELSE; }
 #smt_on		{ return SMT_ON; }
-{number}	{ return value(yyscanner, 10); }
+{number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID); }
 "|"		{ return '|'; }
 "^"		{ return '^'; }
-- 
2.26.2.303.gf8c07b1a785-goog

