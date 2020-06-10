Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A2FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99C5207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5fo03jL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFJFRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgFJFRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:17:22 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC49C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 22:17:22 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o11so843421qtm.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 22:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hz3sSzlwN+wdQHt2gE14qhNHlugfrttGXboZ/LOUn3c=;
        b=O5fo03jLq4s5KxM6m0KmW+ZOCtGJsL+MIL4vV7mPIoxNGbUImCd9IAjlVMNoHfH6ui
         M299pKOBGsbNZUZrYWnMxiokTkHGCSau3RZi4LZEvajSAhJXzldFRJ/zW5y38CybHB5+
         q95nYneo933X4NkwNjkHF0fyjARgcHgpygDIRvS/RYTzlDaPC5Tj0TR6QAix5/UAEvi/
         Cfac5E7DZUlp8SvXM8ZHqobPMWGaBLxkTdVN61wqVehycqRKQVJn6v5HK2po5MFUfSo8
         CBACEtqG9VmGG+hdNFdXQRC8eGyKMx81xOMukIZQG4E/cv1PdjP98v9fiYgvQ4CPY07G
         njVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hz3sSzlwN+wdQHt2gE14qhNHlugfrttGXboZ/LOUn3c=;
        b=WICWmXX9BO84nhfVTE3PlXyKsoRWXEZIiBXET6xNBFuXKbcSm7pIrwWAmwoGWundjk
         fcMIMhpgIMJW9fWo0kI6S+8R7nLAUESrXcCorVO4Ca/OY+YsUY0mva9127G1ZhY0495R
         jY66fY2zrRUg5xfTmE1M+WSDrXchp75OPwPRTAN7r29s2aPsc2BglDTflqMGhjnmDqyV
         baGc3RBapEE5H0yyQTFnFs9IC0RDCwKH0w5BfA/q8VIAcJQag4CzZKunhShSNY3HV9v6
         Yw28W3DqR96GK1Tc5JH4gM5Mk4cl9rJa/04JYzrvyFxWalorGF6ToYymnEAZfYiob3oF
         L4HQ==
X-Gm-Message-State: AOAM53172TnDwDFFLmfu9kBHKkHPMfiEiw/0nk9vjyzRLauW+R4ffXgc
        C8B5bt09XS9QBEEqEC5oRmrIpi3qpL6I
X-Google-Smtp-Source: ABdhPJywghAMmYjc68TFQFGRSb0liuLUsNi8rSfnb4r89U0RtOW3WNgFro99jXLAP8vCEi3LoD2kTerpHKDR
X-Received: by 2002:a0c:fa47:: with SMTP id k7mr1490685qvo.132.1591766241662;
 Tue, 09 Jun 2020 22:17:21 -0700 (PDT)
Date:   Tue,  9 Jun 2020 22:17:16 -0700
In-Reply-To: <20200610051717.170457-1-irogers@google.com>
Message-Id: <20200610051717.170457-2-irogers@google.com>
Mime-Version: 1.0
References: <20200610051717.170457-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 2/2] perf expr: Add < and > operators
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are broadly useful and necessary for Intel's top-down analysis.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 2 ++
 tools/perf/util/expr.y | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 298d86660a96..13e5e3c75f56 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -111,6 +111,8 @@ else		{ return ELSE; }
 "|"		{ return '|'; }
 "^"		{ return '^'; }
 "&"		{ return '&'; }
+"<"		{ return '<'; }
+">"		{ return '>'; }
 "-"		{ return '-'; }
 "+"		{ return '+'; }
 "*"		{ return '*'; }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index fe145344bb39..5fcb98800f9c 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -41,6 +41,7 @@ static double d_ratio(double val0, double val1)
 %left '|'
 %left '^'
 %left '&'
+%left '<' '>'
 %left '-' '+'
 %left '*' '/' '%'
 %left NEG NOT
@@ -73,7 +74,7 @@ other: ID
 |
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
 |
-D_RATIO
+'<' | '>' | D_RATIO
 
 all_expr: if_expr			{ *final_val = $1; }
 	;
@@ -94,6 +95,8 @@ expr:	  NUMBER
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
 	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
 	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
+	| expr '<' expr		{ $$ = $1 < $3; }
+	| expr '>' expr		{ $$ = $1 > $3; }
 	| expr '+' expr		{ $$ = $1 + $3; }
 	| expr '-' expr		{ $$ = $1 - $3; }
 	| expr '*' expr		{ $$ = $1 * $3; }
-- 
2.27.0.278.ge193c7cf3a9-goog

