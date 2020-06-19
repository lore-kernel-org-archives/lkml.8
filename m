Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7557BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4487C208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvTuGnvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgFSEet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFSEeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:21 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414D8C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:21 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id u48so6157989qth.17
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cjsDEQ6wkFVAP826jltGaMg5SguvvdgWlTd8+GYZSFQ=;
        b=lvTuGnvFfp6vNDPCekBQWbvPU8X66VrXyl8fIwdzEm1omVrVmp95L/8WbLeejC3tav
         9wOBO8YkFBJ2PPYejuzo03S67/6CAFvLx5LcPOE9m+hdXqFUHIBlmekVIqU2AIotvLrK
         KoivdS+DsQbuOHE/bb3bDa9CbeTbBApHQZRswamothXM+k0upWUr8xszBmQlfuPtHj34
         b+NYmTf1c+Hv82rRGIGDgSEsakxeA4CBnG5bh67xhaT02ED9YNNyfwOVERttXqU/cXqc
         bnaSepiyYvGDJBNylQc0tK123QR9OxZzhp1PFyTmbpi70rGRq29bY/0WZt7B42VunRP6
         40WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cjsDEQ6wkFVAP826jltGaMg5SguvvdgWlTd8+GYZSFQ=;
        b=YHHtJiQUmSa3FddlGGfopELJ3YJ88HuYWW8WlSjChycOsvBvlf0CQe8Xz6JeKiaAOw
         ehzBShkgatE6XXIDovVK5LKBJkxIM1b3PjKtalHXzu3njISHKuTp+P9TW/3+gPQOspGS
         VBHM+qaqtYJbmDsUEpSmrpt8oGaYj0zr3uFeQBr0Ov2I7whlAXh6sgTI9KI4WCELiyZy
         KHrpjOuEKbwcJFtI8oRKz/cR9ZsJPIcVadmZBOLL5cK9sR3hiMVuRpJFZkxB5K7OjaBd
         49T8XlbXthA9kh4EDatgJrze+ivzv7hveYFl3O8mfVpDkdfD2QnMbZ4RBv+1stzHlmQJ
         VNfw==
X-Gm-Message-State: AOAM530oSHYhUhszzCdEUA3pWC86tzYHGrsPWdqYiw4zmt9r616gnLZD
        o8CQr5UtkfqwlZzh7wNR6CmsnSVsoDzm
X-Google-Smtp-Source: ABdhPJzLfsGCYaReZRdAtoj/rVUji3Lw3xeiQLS2IP3fh4xeBBZi5v1C/waeLGN2ODYigz6lQwQVMXlxKWpp
X-Received: by 2002:ad4:54ee:: with SMTP id k14mr7159723qvx.9.1592541259308;
 Thu, 18 Jun 2020 21:34:19 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:52 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-7-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 06/10] perf parse-events: Declare bison header file output
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

Declare bison header file output so that C files can depend upon
them. As there are multiple output targets $@ is replaced by the
target name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 55c78ac53f04..504a6bb991ba 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -196,27 +196,30 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
 		--header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $<
 
-$(OUTPUT)util/parse-events-bison.c: util/parse-events.y
+$(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
 
 $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/expr-flex.c \
 		--header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) $<
 
-$(OUTPUT)util/expr-bison.c: util/expr.y
+$(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+		-o $(OUTPUT)util/expr-bison.c -p expr_
 
 $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/pmu-flex.c \
 		--header-file=$(OUTPUT)util/pmu-flex.h $(PARSER_DEBUG_FLEX) $<
 
-$(OUTPUT)util/pmu-bison.c: util/pmu.y
+$(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p perf_pmu_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
+		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
 CFLAGS_parse-events-flex.o  += -w
 CFLAGS_pmu-flex.o           += -w
-- 
2.27.0.111.gc72c7da667-goog

