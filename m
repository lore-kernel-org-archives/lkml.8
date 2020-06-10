Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD6D207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDycjjsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgFJVvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgFJVvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:19 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82771C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d145so3309878qkg.22
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BF01MpNUoucrrX0AJsxReGEJJRKDDAPDM66H0tVMVFo=;
        b=uDycjjscRy5M1dxT1A+M99FeWMYYrnwblXlTwDLekg05hQg6jS/qPEzTxj1bisoisW
         xNY+hxRFXBXUTHteiTKCL7hy/HKDkxGPaYOMwU9L7fKbo6Ugtc2FvjBnBd4FChX/cAmO
         hdqFJr83XRyzG/yWIiRvznlKzV7TQveJ8L2ydK+jc/Uk7y7HadyGj9DKeg85tpy4oAxu
         wR7Kh9o/sPegvOJZrwtkxMpQzy2JkcasFa+XPrZeT9b7wNKmdeQe+lyNRKgp0771FVy9
         G6O8de0FLcwsV5R+i+ryojh3aY8tFZ0yWhQfeFPp/dq87Djg2kA/uwKxwym8tbECx+55
         cUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BF01MpNUoucrrX0AJsxReGEJJRKDDAPDM66H0tVMVFo=;
        b=oFZ8pDv2LYfo5Lt4x1jlxgWVAo8VJWaf9mV9LBen7m/eegNOr5gfUVnwXyg4+o4Rww
         VF9i23SLMACeDLYJjjgrn4QFKFIOsYzMMAkISuMvyD0juKvVuHe77CEKs1tnfMn3OgOC
         a/1jofZJjGCE9KbT+9glhVDhyDCFH7e576o/wLrdbBFSDp1C3/7jqRO7/WpKxD84MMn/
         N8v/PgeSZIJp3St022flztO72eXoA1ekEE4kDqHFqRyC8rrP8PX03M2LqyQBDCf9os2q
         aZysPx/w4DRc0qBhOvQI+oNCz31IwLdzyINUkL9Uh77z2wtF8bj+EWre5aX7YMD6qhP+
         gGAA==
X-Gm-Message-State: AOAM533lT+CDCg03L4goso2ju0toh5Mhdz4hIlqS4QseZl313Lr2kft9
        NP4IzQI4+esDOIothfe4VU7bopJcs046
X-Google-Smtp-Source: ABdhPJzbWQhdteRIzmFP/jQdfYzCoD6zjexfGwtRTlaGk0W501xj2LHyyuAnLe0vsctlVWhtW4YH+7mZ9fC2
X-Received: by 2002:ad4:48c7:: with SMTP id v7mr4952079qvx.190.1591825878683;
 Wed, 10 Jun 2020 14:51:18 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:58 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-9-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 08/10] perf expr: Avoid implicit lex function declaration
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

Add include and a dependency.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build  | 2 ++
 tools/perf/util/expr.y | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 43f3310827c4..dc5b80ae39ac 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -211,6 +211,8 @@ $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
 		-o $(OUTPUT)util/expr-bison.c -p expr_
 
+$(OUTPUT)util/expr-bison.o: $(OUTPUT)util/expr-flex.h
+
 $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/pmu-flex.c \
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index bf3e898e3055..f34a5e544a41 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -39,6 +39,8 @@
 %type <num> expr if_expr
 
 %{
+#include "expr-flex.h"
+
 static void expr_error(double *final_val __maybe_unused,
 		       struct expr_parse_ctx *ctx __maybe_unused,
 		       void *scanner,
-- 
2.27.0.278.ge193c7cf3a9-goog

