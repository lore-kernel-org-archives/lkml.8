Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D32C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95883206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8IOZzWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFJX6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgFJX63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:58:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D0EC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:58:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k186so4398446yba.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eDgMkHC9aMQiQJx4OUa3bPnVaGP4eT/xeeaM2hioIaY=;
        b=s8IOZzWlBbdJ9d2SfwmqR6+acv/xEKvItqOqz9NktuoK/1fooO3W+7ZMb5yD5F+gMB
         8abU92bXzCC5ereV5v6xdG60bsupP0ikcpo7WzAn8oWrdznEtq4OdQQ8m/cjNTD8EodG
         C5TLZnGlkStcdSCW4IF9D3bZbDLhHt30MRU+aqQR54t1m33WTGUQym8xn6SCE4kfP6bn
         uvAVq4SSMtaLBi0NqATbrtBt7qQT2aVnJmA11SoQw1qmNykOI8pQxN523r0jDvUQpYEU
         cf2P6qTJamDLVsAHJnHIADIpKe3H2UoyYgRliNlgMeRhZtRO4irRhHB/oYIZjfxLW0oN
         6ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eDgMkHC9aMQiQJx4OUa3bPnVaGP4eT/xeeaM2hioIaY=;
        b=pYZOcxsMDtCOLQCNv+8R3Vqkjqv8aKkxUQA/3XYo4oaJyASBFPKdl3VpZaoOj1C1Ii
         1rJbaYI3oSB3wKhQehESd5vOiPd7SuXnd/pDIzN3JjalU9wBrLbrx+Z8ZF2sIDswYmNi
         pp2hh7eU3x0vX/KoMT3Qcp3C6fx4mvGAFytccldU/ECeHcc+kN5+bud6uo4VI+lJLofY
         36fOQXTtCSnpTAarvixBr3h6PzBjDrlAHIvmsojOHNf2YPtbFGgA8bkrBmlnKgEnmnq0
         wcuMLbLkcKWOt2UXY/heag0DCgfkvHGYmQ4/BpNEVATAgD6NIvcND8TmNjcmFA7GFUmU
         ksVQ==
X-Gm-Message-State: AOAM533MwZnE5iwDAHZhoYxKZ40UtqG8PvunW0OzbVIYF9Lf/frc6Orr
        rA90MFwL1lIbuGo6yuUcEH2v2rJkQU6M
X-Google-Smtp-Source: ABdhPJzqHpmuZiuqNnLummpwHjIOJAw3JRgNZVBXjPrtnonH0GuHmjES2VCPpuoH9kvW6tX+I8J0+kGTOYo5
X-Received: by 2002:a25:b8c:: with SMTP id 134mr10405324ybl.428.1591833507248;
 Wed, 10 Jun 2020 16:58:27 -0700 (PDT)
Date:   Wed, 10 Jun 2020 16:58:22 -0700
Message-Id: <20200610235823.52557-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 1/2] perf expr: Add d_ratio operation
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

d_ratio avoids division by 0 yielding infinity, such as when a counter
doesn't get scheduled. An example usage is:

{
    "BriefDescription": "DCache L1 misses",
    "MetricExpr": "d_ratio(MEM_LOAD_RETIRED.L1_MISS, MEM_LOAD_RETIRED.L1_HIT + MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT)",
    "MetricGroup": "DCache;DCache_L1",
    "MetricName": "DCache_L1_Miss",
    "ScaleUnit": "100%",
}

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c |  2 ++
 tools/perf/util/expr.l  |  1 +
 tools/perf/util/expr.y  | 14 ++++++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 1cb02ca2b15f..c4877b36ab58 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -39,6 +39,8 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
 	ret |= test(&ctx, "1.1 + 2.1", 3.2);
 	ret |= test(&ctx, ".1 + 2.", 2.1);
+	ret |= test(&ctx, "d_ratio(1, 2)", 0.5);
+	ret |= test(&ctx, "d_ratio(2.5, 0)", 0);
 
 	if (ret)
 		return ret;
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

