Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE88C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB2BC2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NI5DoMF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDVHsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726577AbgDVHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:32 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3BDC03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:32 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z3so1563265qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sO5BGMnC3muRvVqxOCgNBH4Ftq8H2ieY1lBwILjyo+Y=;
        b=NI5DoMF/owW2aZ5VxZUSuylgSMaEjauN6nilTzGlADR3PgAO1bFr7LZOubyt4n76+y
         kiHg+vwUf761EXMA+iC7czaEqgKGLsfdY7ofWV3LrEQ4zDXpB+QVRWJKXq0uOTarN4j2
         8yBI1n4UI6qMGsaURmxhtK9f2JDRv4yDcODuGJls2RHrKZ8QgAO+CK2JOWZlo86c5HAl
         g8U9CrYIxjRFfZ/gJ0pwMGGU9GsGe1atcTxT8KppmghucC//ufRGx8HTpHuplIGXbZS5
         hMsnBYEPqP78iqGxqJrbm7Qlw5emygt5xhzX1gs7q9B194mNbhA/3+EbdMypGPeH3WTw
         ryDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sO5BGMnC3muRvVqxOCgNBH4Ftq8H2ieY1lBwILjyo+Y=;
        b=emCBbAbUSVKhfRyEa1KESc1T/0u3V0gCEgy0CaU3LqFxeXFdwpdHd/hrtCEvagJWz2
         aS7hvYJe14dDElH3x0p24QsvOwy2GCeHIt/ddBShj5FgUoK3Dke8nugqH0kyPAvXD9Y3
         B0n01IxsoWVPVgccr5wgxolTU7WmvolpKYL5XboLk8o4tGhFVH7QcbgLL6M0MiPfHKDE
         pL/tI1c76Nyi/Y7oxoLoDUNuhjJt9n9z79R2S3i0C2XOv2bqaXWouiKDLHILc1FvGuPR
         9mJRjcgOY2N2eMWGxwVyzy6Myyc61HqqKjacIUSYICE9Lraa3jWnR4PHrAUqo6gc61No
         7Z2A==
X-Gm-Message-State: AGi0PuZBly+fEIG2GI2G1XFYpJOIqKTswuW1i5g0wLliLMfYUyDNeM09
        RMtKRzLlfu/ovWnml3xR0ZvMEEQwV/IA
X-Google-Smtp-Source: APiQypJ0RIPZlQIw6798l9F9cXKVdTJwTuI6GHmTM781lC50iAL3+WsiJ2iXQ/cVVDWXR7zWEOoxulq/08ND
X-Received: by 2002:a0c:c28b:: with SMTP id b11mr4161450qvi.112.1587541711533;
 Wed, 22 Apr 2020 00:48:31 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:08 -0700
In-Reply-To: <20200422074809.160248-1-irogers@google.com>
Message-Id: <20200422074809.160248-8-irogers@google.com>
Mime-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 7/8] perf expr: debug lex if debugging yaxx
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
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

