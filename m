Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5DEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C723208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/rFgF1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgFSEek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbgFSEeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AEEC0613EF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s90so8754051ybi.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EJMwko4UK0ri92xnZnwrKFeARTwovDj6WxcQH1Rg5vQ=;
        b=q/rFgF1O/3gKbIDyQ0NDYNPXL8JGyr5m8PGEIp1Z4ONs9ZG+WeEyIFgJgnQzt9DXOO
         9x+cPns8rHjbzZYj1LJQGww2yzIgMUWFXqVIkb6qKYmyLqLJpqvdsimMffdd/ADF+iD1
         B4ux3RrDHW+fKSyLLoBmyin5nukdpDD6j//nYnvnup7ylbAiHE/1OINoj1xAiUI7APtc
         ZsgzQ8qe6VurC8RpuG5pfiMdOMUA0cBCCtf3Wkhb/OLFkSx08NZ4ciLKJF1Zs8AHlek2
         FOpoapZBOC8FWvtXqqKcPROdmBAmGz3usGWREA7jFjKgQtcYguIlaVDSevQdPg2Wk3JS
         +kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EJMwko4UK0ri92xnZnwrKFeARTwovDj6WxcQH1Rg5vQ=;
        b=p3letMfLj+CA6zxq9t8VudiuS5X6dDY6DfPqJ/N7t3kVXXe4BmDv6T86zVgfd19DqG
         DqSFc2BRnsji5kdiinzwIyFtHTVbqGb+KijXPI+djEEYF724YFH4c75Sq8N2ErJ2sqeg
         gyMHdfo8OtQlGDD2JSpkaPzp5udvJNfcYriYtvlglyR15tBvV1+UqPxv+RCDZv47gh1h
         HQfT0a6oqOPcnr1b7pvIbvH3FjSWsO5lG78GGDgcbk64qH9oCpy9GPCpMiQEST7F1/OD
         8olU74c338ZcAyGHa/VjKnqiWNBZgFcoBS49SjzBH9PJvq7PUa9A2+9a3SzoRdU/fvPR
         M7xQ==
X-Gm-Message-State: AOAM533dS9mMiBxinh3oMAeqEOa7g5uBwVTklxYqE2FsekkfvDOD/KbN
        57RbMMWQbFe97IyGYA3a2dAL+giWzLRM
X-Google-Smtp-Source: ABdhPJzJAoTlu5hLFopZznAeigi2E3Wt7/NPrsne9PXyyYFKEZe1u4HKgXcyi/bfBOG8p2xE+jznJJE/dNrT
X-Received: by 2002:a25:8b05:: with SMTP id i5mr2973012ybl.301.1592541263092;
 Thu, 18 Jun 2020 21:34:23 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:54 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-9-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 08/10] perf expr: Avoid implicit lex function declaration
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
index 53383bd6f4e2..43a9ae712544 100644
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
2.27.0.111.gc72c7da667-goog

