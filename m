Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502DBC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD272166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/cR320k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgEARdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730146AbgEARdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:46 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D2C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:45 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 11so10839700qkh.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GWDC0G8zdjTIbAQzpkGDW81gGtVpMcQxDDRhUTLRxU0=;
        b=U/cR320k6vLaiczVFbMpcbz2AiJ7tUav2C3g/C7++Gr6hAYFgzw95LdTkG6/6H873/
         EEPfBNkgfWeuXr2l6a03Ci/b5k2jmCF+ioS7rO7QFdyGsQk9xfMXiV8+R6BKXnrvoGjL
         pP910yMK1PurVdmmUDe0IbkR7TVUs+AtjhHNdvn+JvhqK7jMoC21wlVr66fLpq4oKosi
         YjVSPlKEevAjBtj7Ac1ZXHHB2VBLA3ymuynw21LrqBsSGFHXJi8ZQhx+DGLQhZ2Pmbde
         eTWGna1vHXtQhwwcEOFkh7+4v0tiCxwTj6o0eaUc7MxnDkDm6szkVyleZW30D3fIMpVP
         g6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GWDC0G8zdjTIbAQzpkGDW81gGtVpMcQxDDRhUTLRxU0=;
        b=M9UUOOMNV//7nIVH3WxkznSLJq5jVDr/kNoMRLy4Ir8u1khzgjhqfSkg38e9cs7X0k
         rnuMm9cwW0hXD3nkHlEosRhLs4d+LVBJeeQwBGVRYe2iEnQB8lUY6j5JWrcWD3AVpOCl
         jXFQ6gOMu1Dz5J5Q3dI5UOA2BbQ0GRsezo/m4A7XP2W1mvpFraUJ3S0a9aIRPSi2EgUE
         1g0RiiZVVEuTp/KrrtHn4QuipYQyiD/PGkgYnb3cuunXe4L1wgcQraSF+cU6IcSYP3If
         DkklCjNCkI/rXJbhuR6mv3wxAI+0U9Udidq67cjsMvSvfPRBC6mmKrn/sKtE6BKyZPHx
         aniQ==
X-Gm-Message-State: AGi0PuY0Cs7/6u8zRPNFPzVP9qtd45gpCKZtWM58gjA88msvgwpiXK/k
        QD/47/Gnr46wJ0vgyGoOX/phiNBndofs
X-Google-Smtp-Source: APiQypJWI+W29LdVBGa/2+bauhGlIdoqAbs5375miNO9D8xIDvGf+DDMksMeeAmrwmmT3PolvRPDNvYPySVe
X-Received: by 2002:ad4:5a06:: with SMTP id ei6mr5129839qvb.70.1588354424082;
 Fri, 01 May 2020 10:33:44 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:25 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-5-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 04/12] perf expr: allow ',' to be an other token
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

Corrects parse errors in expr__find_other of expressions with min.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index cd17486c1c5d..54260094b947 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -80,7 +80,7 @@ other: ID
 	ctx->ids[ctx->num_ids++].name = $1;
 }
 |
-MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')'
+MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
 
 
 all_expr: if_expr			{ *final_val = $1; }
-- 
2.26.2.526.g744177e7f7-goog

