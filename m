Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E3DC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D692082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVaXZ0mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEGOKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgEGOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:08:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52600C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:08:36 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i2so5916103qkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+ot4xu8P2SexJM6MGXYbzzq/GQaqN2BkLb72ro0O34w=;
        b=lVaXZ0mh6FK8Prt7mNxTyIcNt6EFgoSCMlglY8lrSqIasj9pRYsWpcCEztWEsHYepH
         g5HwSqM4GKiXBK4Lil2OEElO+27ehGfV9SxtHiBWHZYCYHtRjfVben1h3D4ESq2wKWs7
         4lCLPZxDH1N31XcmOoo7qSvDFcDJ/AHBCqGKKg6ouvjs3TYuasNXfE324sZNnpQMT9VC
         Ak9hWT/Qxd5dWoPkTB1Gs8JOTJ6LkOMyQiQLHqmHHROwUrqgvBMof3ObRgQyJIPaEpJj
         OCQi6OIPQCLcX8q3h6YpuqQ44j+eISJeXbhrIZZBzRtl218CVoO87VlFmsfoGbX/9IQV
         ayTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+ot4xu8P2SexJM6MGXYbzzq/GQaqN2BkLb72ro0O34w=;
        b=fg7beFCT1JjC0YeBPOaseN8t9KcC4PfC9AngwxWK0cWwKp8DkHVjerBGELiqiK/EFL
         5paqd9OVMehXbhUT9zpvtNNEulbYE9OT/LjZ7hr565Tb0N40D5Cg9e0+LO1IcgMGJ2Fo
         DBpYAsENuf0veTDZZzSTYVZgYnHehAu7xfbOeGGG/qagl/PwJrrtjFlxh1iP8AWdOOEc
         sQCdIYONhcRzshYcXBGp0YO3mRsKr/vzmWX4uzfpLpj+izrHXW+h5A+vo/+WdDClNSXL
         wn/bTbalsT1Aqrtw9/AxHlmKxmUKzqfeRUxG/USZL7WdkwU01FwE0WZgUbymtw7VP+A1
         oPgw==
X-Gm-Message-State: AGi0PubVpT8TwD+09/hcwnPrEyNfEVBOIciKR3BV0Y9cAhNoIFzh+bNr
        ie/KtAAeYlHKwrU1/28lxwyG14mMsQTH
X-Google-Smtp-Source: APiQypLSwGFaeQ3jLZNr0eoQmZByLc8kamDR6qEDf34qocQyZvZ+qRw+9vkmNyoQZakPK3lBCHhQ4zRh0Iaq
X-Received: by 2002:ad4:55e7:: with SMTP id bu7mr13866483qvb.88.1588860515414;
 Thu, 07 May 2020 07:08:35 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:02 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-7-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 06/23] perf expr: parse numbers as doubles
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
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

