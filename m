Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63819C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6A021655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayF+6gIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDVWFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgDVWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013D7C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id i9so2946952pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8jb1TKGtNOzFJaH+zGkIw1wrutaG9liyHI83TX/6kqM=;
        b=ayF+6gIswEMHPNht9DRwjemw9VXGHQmmH+WQZwyrxUEVDiQGMQTxhFqqbQL3CAJ3hS
         g8b6n8lWjMwG0kvdSZWrlldhI5uIHsWQ33Be8do2mBbMYsLMkpeuboO6xdkybJBJGgWE
         rLlW6aW2sMA/ORzubO35PxvarD4+HB2KvIe8+2QsPRJ4tAKWjX5mvP1jx7gxlGdtbzaF
         Fwx7nsHtDNTaSNH+iNDDEc933apf+WIeexxAT1KDtoauG9SSpgNCi62GDxS95xL2tAIz
         ghtuSFBu4ih4TbQS0590sbxvwdINGt7Pvk32Wj3Vms6m6ZcYk+D8J2+5d/QDj6nQlrAo
         r0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8jb1TKGtNOzFJaH+zGkIw1wrutaG9liyHI83TX/6kqM=;
        b=lZuJ0VD6B7clALstQkzKhdh/J/ckqBUkQW/8kmNHW2tSjA3z+GPw9kaYHCQZeuTmWK
         fHdbNsbR9nwJP1rHA8Wv54nfP//A+zcK78QthKYoqnqaRydaG9GBXxwxQDFFkckHwND0
         gEjdArn41ajD4hlIJXKHf0ZzQIMhVPJ1ihl6ewtNrweMOiROEHDARclJ5DyboE6To5Wt
         H3OUvLMWTUTB+yhw+FzXzzF6I6DqbXiYkzIJdZXogmU1P8XD3ANf71iZemjd5pQ+mbVW
         B2TJ4SMaHYVU0oC9nDp2Q9TzevvTahhnBfByuo8HkQUQa2losqUg+2SdlQQLdvj6pSj9
         oRYQ==
X-Gm-Message-State: AGi0Pua2twMk2TlnDxoWUFJXxZ5WIyzauIoFSukQSXnsnQQBxS41RWaN
        8C2+BQGUZ3WBCslDizKCbHNUxakG5QyI
X-Google-Smtp-Source: APiQypIcRniLx2dAK6np1iyd92nSVT7y5C8wddV7Z01zuWs3KW+xK/j6SSGfKeLeZegOBRgqZMDZ77vd28P8
X-Received: by 2002:a17:90a:2f64:: with SMTP id s91mr973455pjd.30.1587593098406;
 Wed, 22 Apr 2020 15:04:58 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:29 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-11-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 10/11] perf expr: print a debug message for division by zero
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
2.26.2.303.gf8c07b1a785-goog

