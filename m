Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EA3C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD16D24955
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4V1QQ8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgEAReK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730287AbgEARd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB74C08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j14so13020216ybt.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YFMRcn6rc8qdrbrVjoj3zlWs4rTfREC3MZdtnI5wP3I=;
        b=C4V1QQ8SD3Jr0NU62WBkkTqu7JbcvyOO1hmZLDd8JdBKJHDamsT9VhU6lkANZ6+50c
         7fNiAzspGEve2lDd2BKXAxgIwmUWZgvRWgvrFbbfaYMhFV2qaJZ2s9VYKxStTbwjlhG+
         W/WdUETQfFV2aDVBUltUTMNEtd1dSui3CLWjezDAAU3FoqSKMBKgO6nBfIXCCB/GwOx9
         IwfrGM/D09uoXFyM3zG1ChslkyagIZ3YOLPr8GgiTwcoPV8Pe06iM4T2pObs6PdT9YSg
         z8LP7cVkggr6qTocENnGWgd+PvCwGZdvs9O+2j0GegBejLJxR7j1diQfckHUo0q+ElAH
         HTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YFMRcn6rc8qdrbrVjoj3zlWs4rTfREC3MZdtnI5wP3I=;
        b=Gc2/OPbgb+MCsUFmL4KZ92psI02y55V/ne53oJSw7jaRWc3yfWzGV6GbS9jCAxByg3
         SiGBOnQqJUeP6vTnzXCmAQNkrL+Q+GBGEzl+0XoZF8w4dSg+B0J3aEIDP4yiiNU72z6t
         jCi2XRbmFenJ0RHc8RcRfIbfYVKEeb16jygjCpzv5vFd6Rsmd38/tZSqAN90RdQ2X7rL
         lrO2f2db65e2zL9WDcE0qvrIA5E8WeAcR1fO9jNLh7b/KO5fT42baPt+JFV9HAkhIEwi
         8K7yJIq8/Npdl1xCELRFglkkLeK/fF6KY/UcajjHDxBN0ObMBo0ESWJpAiepMFsxJvOg
         kJ9Q==
X-Gm-Message-State: AGi0PuaKKiuyWo5ld3PrJ/gd1jOV0nFF3KmtO+HEQ+fwe29hE1hP7vBi
        wJcMSMAt9aNPsFMxvINFLthHkhIARQvm
X-Google-Smtp-Source: APiQypIOuTuhHMQS310TWI51IZr3ltvCFscs34FSCMUFr/G4PVEZPfZqc25yqH7d+6Sstr09llmdJaaboXwc
X-Received: by 2002:a25:cb17:: with SMTP id b23mr8263994ybg.515.1588354435817;
 Fri, 01 May 2020 10:33:55 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:31 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-11-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 10/12] perf expr: print a debug message for division by zero
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

If an expression yields 0 and is then divided-by/modulus-by then the
parsing aborts. Add a debug error message to better enable debugging
when this happens.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 54260094b947..21e82a1e11a2 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -103,8 +103,18 @@ expr:	  NUMBER
 	| expr '+' expr		{ $$ = $1 + $3; }
 	| expr '-' expr		{ $$ = $1 - $3; }
 	| expr '*' expr		{ $$ = $1 * $3; }
-	| expr '/' expr		{ if ($3 == 0) YYABORT; $$ = $1 / $3; }
-	| expr '%' expr		{ if ((long)$3 == 0) YYABORT; $$ = (long)$1 % (long)$3; }
+	| expr '/' expr		{ if ($3 == 0) {
+					pr_debug("division by zero\n");
+					YYABORT;
+				  }
+				  $$ = $1 / $3;
+	                        }
+	| expr '%' expr		{ if ((long)$3 == 0) {
+					pr_debug("division by zero\n");
+					YYABORT;
+				  }
+				  $$ = (long)$1 % (long)$3;
+	                        }
 	| '-' expr %prec NEG	{ $$ = -$2; }
 	| '(' if_expr ')'	{ $$ = $2; }
 	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
-- 
2.26.2.526.g744177e7f7-goog

