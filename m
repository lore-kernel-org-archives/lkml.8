Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B4C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58A7214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8eTHxpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD3HwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgD3HwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:52:07 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174A2C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:07 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id et5so5577800qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8jb1TKGtNOzFJaH+zGkIw1wrutaG9liyHI83TX/6kqM=;
        b=k8eTHxpgQuzrJ9uQslU4BZkP1qjy695olgk/kD7st0FbBQS9QYbG+4QhDv/8c9X93g
         iXERyX/zBA1PE6iznnzmz73WGdxip3vmtU+zHbcscEbtiSkev5iRp2nDCZ33put7DWXx
         fC8tpxUMk2WWQHeoaCbInHLtfJ8T3LGFzGHHFwkkGJhLZVXVd5BhSV4SmaGkqK+NVbwN
         RE7aq7Fcx7pLSpCn8g4WhikjCK/B0QRJA+TRMMbsTYyzeEF8+WqXaOyv61Iq8fuo6kNQ
         j9hVDA02cHuhrLQ5i4hnva8AFJROWpyIvuXkvFwmVYR38qTHLcQ3l/vuuflh+kpAIsXU
         jsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8jb1TKGtNOzFJaH+zGkIw1wrutaG9liyHI83TX/6kqM=;
        b=AQX8SnNFBxLkMx8PyyQP6i8dAEKITwD2RX5Uayg2LpwibhUboOKXSRDkOgiD8XJPEz
         nAI7NOYqc8X9Rslg9RfxE5o4egmWI+5KLap/9czDiOID137SGVTNjCP5D9uYY7Q3weW6
         9N8Ik+lnjeTkYjPL1veSIic2RmRjFx9FiekuLolwBA071IZZBwlDjNtMzlCi3PO9noju
         JmMTB2S+xHVqGX7uhYMzeG7BzVM8h6IG0b0b8fvWC+8c8QGTMjG9chg51cqQkyV+3Reg
         uvTrFugqc8NQtIbrnCc1C+4k8BPkstpP8Bae1U3ptZT4MYwfrLh9lmKKj8858gJE3wRi
         jbdA==
X-Gm-Message-State: AGi0PuZkaGLy2lrd+LESwbSdGjTe8wK1JVxGtfbQHB0LA4foPL9NMrWN
        qqm5A/Zbs915vT/XstR9eYgQpNUyUxuC
X-Google-Smtp-Source: APiQypJbx+AsTfv2WcA4VEbGnEOcx6a6Rp0MiE4H3CaO6J5uiyFDgN0xh6jdmpHTjVojbQr5zfV2dfywL3rZ
X-Received: by 2002:ad4:42c7:: with SMTP id f7mr1750659qvr.127.1588233126251;
 Thu, 30 Apr 2020 00:52:06 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:42 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-11-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 10/12] perf expr: print a debug message for division by zero
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
2.26.2.303.gf8c07b1a785-goog

