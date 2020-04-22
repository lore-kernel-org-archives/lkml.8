Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855DCC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C22084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5lOH4+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgDVWEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgDVWEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4918C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:51 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b14so2942319pgi.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sO5BGMnC3muRvVqxOCgNBH4Ftq8H2ieY1lBwILjyo+Y=;
        b=j5lOH4+w3H4+mxPChNCzyHNoo+iRo5ro+YWw3vl6J4zIGjqwpO1y4axhI17u0uM3tg
         LQXb215dMbovQz1gx9VOqMLWnE7WWooBSgcin1lm/xQrH4mC5fI0wWtg7bDRx7YyXoeu
         UzA4MklLNvZ4qICvgl2Wza0IGg9GCZml9pRcG9/YOrQh2lLq4O637X29u522ZNtD5lLQ
         G5618Tz2HfgucOJ1awvmd5s5TFbC4hMGrQAvhmBojk5TnddzUny01WBEsW9jG8FtJeYD
         78gaYnbOIEMh0B+UcmajYcaH0UFeH8TbN63uEphx5lBH/Ha2suOa1/5/rPr3B5PJWsOC
         suUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sO5BGMnC3muRvVqxOCgNBH4Ftq8H2ieY1lBwILjyo+Y=;
        b=bsTBSiFh6d2jtk+QTpsf9xaL1cGig93/3QaHGx8ijAXDo1z8z+5uml9eTp1MkNFgG+
         6grBWkHXtmGBuPGKal3FeBu2V/Onol0NoeF2wr07SUhjEmHgFvSFpOuO5HxL2HI1lyVZ
         pNuEkBy03kIdwBMTmFc+ysHfbL2cL4Ap/AivOIHuOgHijZ47OoQM0XfR5KZDrVPMSK39
         9Fi1ko/9tn+ZHe2auSpalywfWqZeKtFD5LwrjpKS7TpASp9PET4piuo1gEmaNTCjaqVz
         cdzadd4tpOQ2CaKoAQG8CMecNn7uOr7eyuhQlhBLf9f/NHHXwry9L16mCGdvHtQQOug5
         XJpA==
X-Gm-Message-State: AGi0PuZjhqj6LlGjwWfH2lEMDGa2/wjaS/KpuiXjuMUOqib7HbbyEgjU
        ojQXN7ZKZJqM12gODB7g6h2xKATs3obL
X-Google-Smtp-Source: APiQypIBKSELPnngxhpHnsLsjEQREoNWZ7TorEu6actMmKpCO4FqEUZ74DQpxjB18PHjXzCpzVYdXpXdx4JE
X-Received: by 2002:a17:90a:f00b:: with SMTP id bt11mr891819pjb.121.1587593091113;
 Wed, 22 Apr 2020 15:04:51 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:26 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-8-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 07/11] perf expr: debug lex if debugging yacc
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

Only effects parser debugging (disabled by default). Enables displaying
'--accepting rule at line .. ("...").

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c3382d58cf40..8694bec86f1a 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -44,6 +44,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 
 #ifdef PARSER_DEBUG
 	expr_debug = 1;
+	expr_set_debug(1, scanner);
 #endif
 
 	ret = expr_parse(val, ctx, scanner);
-- 
2.26.2.303.gf8c07b1a785-goog

