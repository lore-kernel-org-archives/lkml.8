Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310EDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031D02072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dz9o6gyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFJVvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgFJVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:07 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E072EC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:06 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q5so2878734qvp.23
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oxqvjGtpSOsagEDpRrrAmarRkYjvCJoCXb0ZhUNa4Ts=;
        b=dz9o6gycEEWoEVtevOUbjC8yQuzSQTLrSxSKRjEyKW6EBdxf2Hd0Bc8QameiemHA7b
         wDGcc1H/Z1xKkXxwmTMgJEC0n8Yo4mNGwPSW5yHxIxdL3MTomnCLWZS3dRYObOvXTyfh
         boFg9v7yXUquzjO7KUkNnCRhmF3RUcNrynDEs+YrJwLSn2bon5WPB50MzhIuLmVQPNoY
         GvxM4xNyTyJGIGkMTtehdiao6Fz5Fb62Z59B2ES/ZymB5XMVHtLFqE5F9OG6TfLRz6oN
         Sj+vVq3IrY+vwVWOnimHZ+RiRqGMxjhTZE9q5Rx4j32/6/0x2zb6VKlPQFWg1wLEnVe1
         jZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oxqvjGtpSOsagEDpRrrAmarRkYjvCJoCXb0ZhUNa4Ts=;
        b=kmc0euLYkYxn43ZByh3gcsXBgqfBhe+rNGOiGw72gbBPnwj7NvPMS/qnw/zTbautwM
         kjFouT2u0Lw/slkP+HyfZcbSaI9JFEMGN/zH2jvUlgyPUxPrOjWiwRTuxEf0ePn7o7UF
         li5K7371OQsrg3N/W+YTQdrSOi+05AfrnnIll40lUd3NbkAHr39IDWBaxVsGw0w1qDwz
         TC/zBo8XJMY5zI3YXOiPxs2XongEE7lj1/KOwsgUpG2NY8//VuW+EyvTyAUqw5rP+v+F
         wz0XLUU2d6sqFH7m1q3FxSdvsIODMtNn6Q56r95ycpRLPnHUJQKz2nxbnIJfomGU9VlC
         MfVQ==
X-Gm-Message-State: AOAM533M6rEVqX35bf/rQdkakt5t7wjDvLFBLJHeTFp+yMaRIjTNIkJl
        Iu616icVoGEHTxaTFGHkbyzFYasnGGmx
X-Google-Smtp-Source: ABdhPJylQHsoF8+GGsyZIVn9EUTyR1EO9rAbp3orIwMSkgiDJ+iTl2H+ApxL+6hAchhQSRlLY8FdZJxGJkGs
X-Received: by 2002:ad4:4368:: with SMTP id u8mr5008330qvt.227.1591825866104;
 Wed, 10 Jun 2020 14:51:06 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:51 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-2-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 01/10] perf parse-events: Use automatic variable for flex input
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
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reduces the command line size slightly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8d18380ecd10..66cf009f78d8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -193,7 +193,7 @@ CFLAGS_genelf_debug.o  += -Wno-packed
 
 $(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) util/parse-events.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $<
 
 $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
 	$(call rule_mkdir)
@@ -201,7 +201,7 @@ $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
 
 $(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) util/expr.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) $<
 
 $(OUTPUT)util/expr-bison.c: util/expr.y
 	$(call rule_mkdir)
@@ -209,7 +209,7 @@ $(OUTPUT)util/expr-bison.c: util/expr.y
 
 $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h util/pmu.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h $<
 
 $(OUTPUT)util/pmu-bison.c: util/pmu.y
 	$(call rule_mkdir)
-- 
2.27.0.278.ge193c7cf3a9-goog

