Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F8C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B872076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9ZDFYaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDVWEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgDVWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:50 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF7C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:49 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q8so2924746pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9v/SqbpPNd1vIjcwX2QJUR1yjeQPBkaJciMvLWYLL8Q=;
        b=Y9ZDFYaLlv/caQHJDJGOLNMlKtvgP/RHif2GdM2dYMRT8BjhpShvSkupnhyS45r2J3
         9zJ/8qSGsJ48Wqz9Tj5Vg0XK07NtRJngYBO6zsd2f9ZJ+zmV62O2VN/mK4g6FQP/pnXT
         ST/bbEMcob/5Jph1u1/2vG3KT1vz9MXIZUzv9YRMFIw7zHbZCjEERljAu8es6/O1d5iD
         WUG8hwOMbhLhQt7EPQJiUmw6DaYY3s8nvMpmTUYMY3SmvHHLMvIpF+J6QOdMI8mNYmor
         VpnphvBPMMyYlqEDkV/jbGSQBueu7/R6Ymdi/A93u5v7SLkkEzEel2eS1NYobxharUVl
         +r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9v/SqbpPNd1vIjcwX2QJUR1yjeQPBkaJciMvLWYLL8Q=;
        b=f27c8XvpJkev2wDXmJ3zNKyKxeEsTFOeMXdndLYXr9hBP/BxWw8vxsLpek0fTaXijz
         3yFhOuXLBtCmeiG3ZVihgsRukF5E/uDRM4BV6cepSxwF6pKbyiRViloPauzqs/isyZa0
         IdmNdEa9NMo1DsCrh9epOEc3O+xmt1LTFGllHGK3QpoCX2OIWu6VX+JFRDVCKZ+tokbe
         toZnt+YraBgBovjnXdMfByf933LYbdOlx3l4u5FtV6l8eaqqtgO/bZw+eZxsXbD0ifB6
         KsC/5P2lN50w5Oup7om86TA/LwJaHrTvgP1SzWOEhAbD1V7PPt6jgNiassDgQoAhoIu5
         CRrw==
X-Gm-Message-State: AGi0PuZGFz9/vgknQf4+SaGE+4z6s3SqDYaAM48m4NjA3cwo9DNTQkKT
        TGrhpBs836SL82CMCaHjPtisfA+JEk4d
X-Google-Smtp-Source: APiQypJfr+rjd4dp5a35iJuNNe/Dp1OBDYKwXx0p1Wk2KrHwkFmxa3gIA0fGvBxJA6vZqXsXIZGd4jIWQMiq
X-Received: by 2002:a63:4f0a:: with SMTP id d10mr1135904pgb.146.1587593088624;
 Wed, 22 Apr 2020 15:04:48 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:25 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-7-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 06/11] perf expr: parse numbers as doubles
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
        linux-perf-users@vger.kernel.org
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

