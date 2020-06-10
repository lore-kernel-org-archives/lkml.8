Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B952074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1yJJaoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgFJFR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgFJFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:17:21 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933EBC03E96B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 22:17:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m29so1031184qkm.17
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bjUzZJaADYRF4NLSKw6448G2+8oa1CjvslyitcA1NeA=;
        b=F1yJJaohPY6eu44cZvga29SFphG0UBJ5Cxa5rvKvlLQSh/fvT6tTrbxNQogH+vZIc0
         yIImENMcR7iX4rhLmKzmpwy/oI3GfZJN5yAfoLRGYf9XTZtnhcz8r+I8zwSI/dLSgcGY
         khVlbQfBAdXXW7OOUzQpoN0t9nMIZ7349gVTJfGbS0d5FKJpxSg8E7IR0ZToeE0PCnsR
         PEjHSLx8f+cn3hHcPJRdn/E5S8ArwJWrrXLxllTuEgzWAM39R+bMmpoz/2fLLYIviQu/
         UYAy1zpjikmyMluecEUcVr8KGolhbrZFqrasOKtCM9RMHowMMXUregdJuU5SjPbFmfWK
         LF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bjUzZJaADYRF4NLSKw6448G2+8oa1CjvslyitcA1NeA=;
        b=djKttOjokYCUnc1McigNDeHaUCk/SJzdpJb/AM0t7cd7vqfoLmcxplPdSXrZMYXV0i
         sx6n3tDe+CAAH5mqn+CMetkiPGKo9ykvpwWrpdfAnq9zurI3IxanITchoVdRAQmx9rs9
         PoNAcu/Gi0WxA5l4efZg/AynBlYlGJ1J8rBloKkSPuG4v9q9tEfeR73N/oAjDE0o/dF+
         0YIu1A1GtahirJ59ZhHkW8IbO7HcmD3jwfD/sjh88Yce42vxRqDIoTfeZ8teUgocTY5J
         UDUEXnAwPlL8ezidGhki3elsG+d07+aLbnNbTKdtbYBtRrh5y++8lDjpbK7o/Ha2fjeF
         c9lg==
X-Gm-Message-State: AOAM531lyRsHpRHNDzEtcysSIkNK7ah/XrH2yt9uYjvc/Ic6tpXFXIZm
        CQ2TEnMG1vmUhWVnAdqFO1wUCBqSGAxj
X-Google-Smtp-Source: ABdhPJxdBSfpE747ZAaEyhU8E3zHGyh3p6+B4jW0woylrVVIEuPQeFAbfyo7RsKfcp++zcez40YhXL9eqFz+
X-Received: by 2002:a0c:d6c1:: with SMTP id l1mr1434290qvi.173.1591766239585;
 Tue, 09 Jun 2020 22:17:19 -0700 (PDT)
Date:   Tue,  9 Jun 2020 22:17:15 -0700
Message-Id: <20200610051717.170457-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 1/2] perf expr: Add d_ratio operation
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

This simplifies computing ratios in json expressions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l |  1 +
 tools/perf/util/expr.y | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index f397bf8b1a48..298d86660a96 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -100,6 +100,7 @@ symbol		({spec}|{sym})+
 		}
 	}
 
+d_ratio		{ return D_RATIO; }
 max		{ return MAX; }
 min		{ return MIN; }
 if		{ return IF; }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index bf3e898e3055..fe145344bb39 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -10,6 +10,14 @@
 #include "smt.h"
 #include <string.h>
 
+static double d_ratio(double val0, double val1)
+{
+	if (val1 == 0) {
+		return 0;
+	}
+	return  val0 / val1;
+}
+
 %}
 
 %define api.pure full
@@ -28,7 +36,7 @@
 %token <num> NUMBER
 %token <str> ID
 %destructor { free ($$); } <str>
-%token MIN MAX IF ELSE SMT_ON
+%token MIN MAX IF ELSE SMT_ON D_RATIO
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -64,7 +72,8 @@ other: ID
 }
 |
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-
+|
+D_RATIO
 
 all_expr: if_expr			{ *final_val = $1; }
 	;
@@ -105,6 +114,7 @@ expr:	  NUMBER
 	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
 	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
 	| SMT_ON		 { $$ = smt_on() > 0; }
+	| D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
 	;
 
 %%
-- 
2.27.0.278.ge193c7cf3a9-goog

