Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACAEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5CD20DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtSottKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgFSEeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFSEeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:12 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897B0C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:12 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g72so6186576qke.18
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B9OjWQQRubCk4XMq/CTkTwsjp8frz17P8j83zo66Jbo=;
        b=TtSottKPCuuLgqpiyKFfnA+pXx/sc+Er9VFs3CvG6L3i+PD3TOlPvTPHWolk/woh6u
         qZ+RikZ01YRJT9O5zsF5K8tTsCkZBL/V8gjcXVgJBDtgNLQKn2dZFsdw87LJ0u32scSv
         GspHq1GVCJdeKSSaehcELtzMR+q2bQnPAA3ePbQBv1ln2in7YarCVS+XzFx8FOie9sRN
         ruWVi2/HCEVRdeLuGsE4c/ZGCNe7b8Y/diAwhhO6JL+dJ27sakrEFe5TSKHhENwt47Va
         DWFYfGNY6Z6R1/cZMwynbwew4h2yi5UPpzxHrJoO96iXcPBpm47wMXossIWRkYmeZMIu
         WErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B9OjWQQRubCk4XMq/CTkTwsjp8frz17P8j83zo66Jbo=;
        b=Ea58yVGWSZ0vzI6IYCpiuvrWR1u6Dhv6Eit9dERbnApuNf54wONrR1lJAA/tTeWZyy
         THyimiP7OKtzGbXB1pmQ6aJ7ahEZiRsefq/uKJmKWmrl7eGg/XDVqzYlyiwgqu1i5DU+
         gdPSzNWiuV3kg2C2RCENO/Re6WFoTpqDbbhHDznQqD5VAtH1mAOlETSOm3CXaAdpyIgV
         PzOie8Cv6FiFr0//N2chwyDltA9+bcRnptW7iFispyFn9vxCk77oqqd78F3gJmRpHG8o
         uzzsG7spfH2K3rKJXNNpAjEkpFxDjBtTwcNOhzA3MaIiPpK9QFzLojjXToMtUXJInbpt
         ++2Q==
X-Gm-Message-State: AOAM530MndeG2s3CkwPZbgf0TZ9KOV4AkyhoVp3xvhAoRyAmdg87m5ZR
        lNtxJP/+SLq+J5GeqJjH0PdFluzd5zBq
X-Google-Smtp-Source: ABdhPJy5tuEalUmcFic6Dcp7nA2ZPQ1mMnQU+s6qnDgHxx5GHf/LLyEUIHq/i92m9Bj2ejARMdAe9ix9NN79
X-Received: by 2002:a05:6214:a0e:: with SMTP id dw14mr6918504qvb.109.1592541251596;
 Thu, 18 Jun 2020 21:34:11 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:48 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-3-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 02/10] perf parse-events: Use automatic variable for yacc input
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
index 66cf009f78d8..4e1aa52d75a8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -197,7 +197,7 @@ $(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-event
 
 $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
 
 $(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
 	$(call rule_mkdir)
@@ -205,7 +205,7 @@ $(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
 
 $(OUTPUT)util/expr-bison.c: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
 
 $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
@@ -213,7 +213,7 @@ $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 
 $(OUTPUT)util/pmu-bison.c: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v util/pmu.y -d -o $@ -p perf_pmu_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d -o $@ -p perf_pmu_
 
 CFLAGS_parse-events-flex.o  += -w
 CFLAGS_pmu-flex.o           += -w
-- 
2.27.0.111.gc72c7da667-goog

