Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77283C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44409206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZzZXV7kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgFJX6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgFJX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:58:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB03C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:58:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p22so4388758ybg.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=NYW1oslxUrjhzXJ7bTMZ4CDQ1phtBvPY5iW8pjV0AgY=;
        b=ZzZXV7kGekCGXVvqwIeVxumkrSgFKwSD8IUN6y8gTZn1ai53K99qiqSYfeUJ7+3xMP
         J5ruWthSpTkfiijOakKRz81y1ZqF2m9f0PSjBYQnUNLgm5UAZkCbRysdkLv0VscoQG/Z
         8WyqSmkJQ6Ak9xOe7UV4sRWEosKc4+VoNnM09WbqV6KndRxQIU+AYxCkwwIo5TpOXa75
         3Bq+9aJbqSQyPN++7lJfvvaREkFh9BV2Ys+UNcZJJuQwh23yhgUdpzRA3OAOHn0yDOHV
         /qOHB3dGcXsc93n18/24dkoh/wF8yLbiDVvTUuP1+s6kI0o+1W5gpI5wWYcDlLhKMKqD
         1Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=NYW1oslxUrjhzXJ7bTMZ4CDQ1phtBvPY5iW8pjV0AgY=;
        b=cWseOb3q6jREECeHMbfWc+mY8NMnApoRYdSQaupYWz2Yc87X4Z948HDy8XzY6fYdMy
         NkLBQUwjjSJpMoIOXkS6y1Ah6sXTn9Mu3jc1riyuXnf/Hvz1aG+yOBiC9Bh0kIRuzfIf
         5WfQkndoGX+VaogRWYpzdKnusxhFzjxLlmC0QmWIJAUCKTrYYNrss0kFkFruaLFNDZ/k
         gDbi8DcP+gtMaeovnVTTm4nk2zFPtVDNuLm65sAMMb8GtIYgvUjym1kb9PGbZLRD1Exq
         iHYgpX7RMwr9GlaQdLIPiiPYHC7dYNBC7Yxj+5iRPVbP+pp1OWeBH8vZ5A/Nqb3dxtCm
         nYhQ==
X-Gm-Message-State: AOAM530Ila0PoBePWdcGreTj29E121q94rHEyS9M9/socz64dQ/PqAne
        C41ZZMmOii2JigrNrIdkAc270oT+Q8Un
X-Google-Smtp-Source: ABdhPJzAZC0uog7B9B1OScECN6SNqapsCHDp0QRtFVZNrOqzsRrdYi8FfOV8ZAB/m8BdMcL6e2pH23vSpqKX
X-Received: by 2002:a25:8444:: with SMTP id r4mr9019037ybm.301.1591833509073;
 Wed, 10 Jun 2020 16:58:29 -0700 (PDT)
Date:   Wed, 10 Jun 2020 16:58:23 -0700
In-Reply-To: <20200610235823.52557-1-irogers@google.com>
Message-Id: <20200610235823.52557-2-irogers@google.com>
Mime-Version: 1.0
References: <20200610235823.52557-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 2/2] perf expr: Add < and > operators
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are broadly useful but required to handle TMA metrics. For
example encoding Ports_Utilization from:
https://download.01.org/perfmon/TMA_Metrics.csv
requires '<'.

{
  "BriefDescription": "This metric estimates fraction of cycles the CPU per=
formance was potentially limited due to Core computation issues (non divide=
r-related).  Two distinct categories can be attributed into this metric: (1=
) heavy data-dependency among contiguous instructions would manifest in thi=
s metric - such cases are often referred to as low Instruction Level Parall=
elism (ILP). (2) Contention on some hardware execution unit other than Divi=
der. For example; when there are too many multiply operations.",
  "MetricExpr": "( ( cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + cpu@EXE_ACTIVITY=
.1_PORTS_UTIL@ + ( cpu@EXE_ACTIVITY.2_PORTS_UTIL@ * ( ( ( cpu@UOPS_RETIRED.=
RETIRE_SLOTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) ) / ( ( 4.000000 ) + 1.0=
00000 ) ) ) ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) if ( cpu@ARITH.DIVIDER_ACT=
IVE\\,cmask\\=3D1@ < cpu@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ ) else ( ( cpu@EXE=
_ACTIVITY.EXE_BOUND_0_PORTS@ + cpu@EXE_ACTIVITY.1_PORTS_UTIL@ + ( cpu@EXE_A=
CTIVITY.2_PORTS_UTIL@ * ( ( ( cpu@UOPS_RETIRED.RETIRE_SLOTS@ ) / ( cpu@CPU_=
CLK_UNHALTED.THREAD@ ) ) / ( ( 4.000000 ) + 1.000000 ) ) ) ) - cpu@EXE_ACTI=
VITY.EXE_BOUND_0_PORTS@ ) / ( cpu@CPU_CLK_UNHALTED.THREAD@ ) )",
  "MetricGroup": "Topdown_Group_Ports_Utilization",
  "MetricName": "Topdown_Metric_Ports_Utilization"
},

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 6 ++++++
 tools/perf/util/expr.l  | 2 ++
 tools/perf/util/expr.y  | 5 ++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index c4877b36ab58..b7e5ef3007fc 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -41,6 +41,12 @@ int test__expr(struct test *t __maybe_unused, int subtes=
t __maybe_unused)
 	ret |=3D test(&ctx, ".1 + 2.", 2.1);
 	ret |=3D test(&ctx, "d_ratio(1, 2)", 0.5);
 	ret |=3D test(&ctx, "d_ratio(2.5, 0)", 0);
+	ret |=3D test(&ctx, "1.1 < 2.2", 1);
+	ret |=3D test(&ctx, "2.2 > 1.1", 1);
+	ret |=3D test(&ctx, "1.1 < 1.1", 0);
+	ret |=3D test(&ctx, "2.2 > 2.2", 0);
+	ret |=3D test(&ctx, "2.2 < 1.1", 0);
+	ret |=3D test(&ctx, "1.1 > 2.2", 0);
=20
 	if (ret)
 		return ret;
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
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*=
' | '/' | '%' | '(' | ')' | ','
 |
-D_RATIO
+'<' | '>' | D_RATIO
=20
 all_expr: if_expr			{ *final_val =3D $1; }
 	;
@@ -94,6 +95,8 @@ expr:	  NUMBER
 	| expr '|' expr		{ $$ =3D (long)$1 | (long)$3; }
 	| expr '&' expr		{ $$ =3D (long)$1 & (long)$3; }
 	| expr '^' expr		{ $$ =3D (long)$1 ^ (long)$3; }
+	| expr '<' expr		{ $$ =3D $1 < $3; }
+	| expr '>' expr		{ $$ =3D $1 > $3; }
 	| expr '+' expr		{ $$ =3D $1 + $3; }
 	| expr '-' expr		{ $$ =3D $1 - $3; }
 	| expr '*' expr		{ $$ =3D $1 * $3; }
--=20
2.27.0.278.ge193c7cf3a9-goog

