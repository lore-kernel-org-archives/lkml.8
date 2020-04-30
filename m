Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A2C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4792B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/61GU0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgD3HwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgD3HwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:52:01 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD44C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g55so6151443qtk.14
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9v/SqbpPNd1vIjcwX2QJUR1yjeQPBkaJciMvLWYLL8Q=;
        b=F/61GU0m0V7oJXPGOkdvG6wykOs05VPqGOsR+dmRgxiOyFT3rLi5V3iKr2jJtKTBAM
         Lnp8g0sMkgnaHOTgC8zPvBocO8HGY8nGlrC1Za6Ucp7ri6aLv1w/z1j71aBfQUdZTiMR
         aRws8DCS+abxBV4Hi1DHJX7d8e0yjkm5c9hh7iHx8FOQB5FnLcKLISeHAOCGYLkLbrzv
         3fQOjNuC62ltNCjXZJBN/tlRO5Umm3R67dX6+mnRtWl5Bw2/ZsFHuMtv4GieB+Wi5FWO
         Ek2kYQynAGDFHP5arSOeuhrPJzDjIukquiQt/GicSbp7vbpGTTd7TQdt+Es86j9mw1FA
         1fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9v/SqbpPNd1vIjcwX2QJUR1yjeQPBkaJciMvLWYLL8Q=;
        b=HRqOKGfDzlykHC4Wf4y9xQVCcuItgHGFMTubrulMix0JxTNQMKsz4tWmGtNugDDo6y
         +iVzXHTImmA51Z1Gqki4kavtieGUWlDYJ/ovzCFxZOKRglawrx/e0KwyuREmSe+2g8BA
         e0SywZKa45h1n1W2Q403QuQj31fvsmWPGkUe9mn61b5pPkhrbbzMo98z+vf632qQZFLq
         aHfZJbf3PwVKomG3eMaeVnn6VGkWN+QlyiHS8uAFLfyb+2IXb7Eyd+I8NvtKg1FmObB9
         V9zjnO3Olg2EdF9grPqAlDxfllDx6WBB0pagBAZehdzkdqk+Z8t/b51COk1ucBgLZut1
         liiQ==
X-Gm-Message-State: AGi0PuaJBNCcfFfSBxgJ8eIf3a4G8CoL0YL5iQiFFY+DdVZJ/ASIctQM
        50Es2sg19DtbTvkVL0U33EwrreMyFexg
X-Google-Smtp-Source: APiQypKkmNr425RqHsI4YEtww5Z+lt5d4UG3ZbgEFzjzXCdNcfHTgMTVh/BoWNR6VgI65nRIkK8Z28m7PV3p
X-Received: by 2002:a0c:f2d3:: with SMTP id c19mr1706150qvm.109.1588233118919;
 Thu, 30 Apr 2020 00:51:58 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:38 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-7-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 06/12] perf expr: parse numbers as doubles
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

