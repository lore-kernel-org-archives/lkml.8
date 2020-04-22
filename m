Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76338C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474FD20738
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piV1LTan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDVHsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726363AbgDVHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:24 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C67C03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 189so993713pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OXZleKkWZzKKnBm05g6e7Gyf0CCs6T7oZwd1F3IVZx4=;
        b=piV1LTanFc70NR+r9jRoJBIka9YA42dJ3uR84Dp/LxbBUlrzb66Fc4Yzc8yYFrlar3
         YkGX1+iVNc7KnurONdqfiVL/sXfRPahOocQMNUyafUP9TdWwYjukCQI/XV2E6SQKQOR9
         /Hsfr90B8Gqo+SI7LR/Z0CtEZZLLWVvGrXSh9GwT7UUZ/jFrXhui5FG4b4lxIADgAgJ8
         hAq6C3rjvo+Q/CWWzeotjcy0WuiXNKvsvodBsL0zI5G2I5PDizFg1uvnEt8RHZbhcKFt
         an2HCk+dgm4YYEZs3RW/m58/UhphNvnZzGYEwXgYkltwVGvwSy1Rn8F8RSLy251w9skU
         hCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OXZleKkWZzKKnBm05g6e7Gyf0CCs6T7oZwd1F3IVZx4=;
        b=LhzPyf3CIQy+I9g8XONCi1XmUQCsv8DC2BtySn4jSbpQEcEc7gkwzLx9a8xnbMoyE5
         Kq8N5T6X1TBXcR6SkLo0EiYBjkhqUHvxM0T8CpOh+wMDyOfD/4mDjg9UWSWRwNWDruhr
         6WEBsOyf1gE79f35AUc7jpUdhSk8gpWbv8fC7dZpmNFAECo0LuPWm5iAzpCJNQ3WSkCR
         wuzIR9lRNIgFn8/pR2/bkcok364iAbvphEH3ETsS71tFlaP+zZ4j8XykT5yyeRVni58c
         Oxm9kejxwj2hsSW0SoWH4buVv2rWyy5FDRxUj6B73BA3OwVqvAq525KZc/DjBYAQGtQX
         yJeA==
X-Gm-Message-State: AGi0PuZwlU5RfcWgY2ntVS6Ur5KJX2PW8J23/9Dg9ubWJ7aOrAp8gK7o
        Fs3amCcEA92tmAIaR7A1R54+3R1mXcRL
X-Google-Smtp-Source: APiQypIyJTHGfpp6A4QQxTBiZ3b+h8XXcgNpuiTC0F/FXhrotj5YSMwZWq0PznA+cS86xqsFG6U/aY+SWXQ/
X-Received: by 2002:a17:90a:de0e:: with SMTP id m14mr10282958pjv.54.1587541703261;
 Wed, 22 Apr 2020 00:48:23 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:05 -0700
In-Reply-To: <20200422074809.160248-1-irogers@google.com>
Message-Id: <20200422074809.160248-5-irogers@google.com>
Mime-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 4/8] perf expr: allow ',' to be an other token
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
2.26.2.303.gf8c07b1a785-goog

