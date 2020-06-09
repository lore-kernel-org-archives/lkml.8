Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF39B206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLZpM3+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgFIXny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFIXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:43:52 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EDC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:43:51 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h18so513799qkj.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gMRBzjvysze8Agf8g8kNyo9lParqFQP7yHyzsJ4UrPc=;
        b=TLZpM3+iosfgS+UcVdM17SW7X0TN+AxxqA5/tAXzRNDbe7ao/fTbS/fy22P1Mh4ETc
         5Bul4BsGvzM2K4h5DScLD5K2g5FUuouAgLCqYhBNB7/LtxTpWx8BIJJagcV2H4Ju892M
         M7LQa81/SkvfA3v/OzvEO050yoHzgiUKuARU0tjchWBrgS3zYmZfbjhNcae2cVMSK9ka
         tigJQTU9YpK0c/J0hPnX/hwsiE/ZvY+/yKxLW5pidtltf1/IioHeCscNxZWlzyjwGb3B
         zCVS7CSD3jbBrvIFF6UP2/Zj3UDVELATZ913SLGSLcyryHgH6yby8msCxxEGkIPlxWsz
         pi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gMRBzjvysze8Agf8g8kNyo9lParqFQP7yHyzsJ4UrPc=;
        b=hPnIyZfzzNeCfNZiD+XwvEa2KJ2jJKc14fOj3oxq65TWw2QdXhmbSpymFL51MK0Tq3
         i6YpCZcTIFrw00VGFSYpz8Vt6qnRY7H4HRljnKyFQA2R0oJ8DdOjow75Kx82aObeX5cA
         dJUnuQj3hX0kX388mEdevCZ+DnL/83T4hYun2mIyJHnwU2wsXGVmBxUwo4GpojSfCS4O
         C6LkltYH+fpTINjOSsjbVQb9Nzc841bbcdCLQrKvJ0nCHAIsCL0EpYbuBGZzwluxEcdz
         xK2ZHn4GIiMQ6u14NyXt4u6BqN6M9ARLOw4Nap3HfmAD+cLLLKkpz+PXAWIq1nt2xigs
         z1Eg==
X-Gm-Message-State: AOAM533FTqs7ENIh1gy6YzAKMp90+UVfynpIEkqqoxSsUd/evs8qRhJc
        S9ZBqrV9qgNhNYz7algohQuWRkyE03Eu
X-Google-Smtp-Source: ABdhPJyK2DL8GMw2si2PRbWhfusqHGvphHNUeBWBaL2fjinB5tyj+AzldhW7IQbE6d7rRBShK4xhPz91eoOR
X-Received: by 2002:a05:6214:365:: with SMTP id t5mr633814qvu.126.1591746230137;
 Tue, 09 Jun 2020 16:43:50 -0700 (PDT)
Date:   Tue,  9 Jun 2020 16:43:44 -0700
In-Reply-To: <20200609234344.3795-1-irogers@google.com>
Message-Id: <20200609234344.3795-2-irogers@google.com>
Mime-Version: 1.0
References: <20200609234344.3795-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 2/2] perf parse-events: enable more flex/yacc warnings
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

All C compiler warnings are disabled are disabled by -w. This change
removes the -w from flex and bison targets. To avoid implicit
declarations header files are declared as targets and included.

Tested with GCC 9.3.0 and clang 9.0.1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build          | 55 ++++++++++++++++++++++------------
 tools/perf/util/expr.y         |  2 ++
 tools/perf/util/parse-events.y |  1 +
 3 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8d18380ecd10..8d47dd3ecf2e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -191,36 +191,53 @@ CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
 # avoid compiler warnings in 32-bit mode
 CFLAGS_genelf_debug.o  += -Wno-packed
 
-$(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
+$(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) util/parse-events.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
+		--header-file=$(OUTPUT)util/parse-events-flex.h \
+		$(PARSER_DEBUG_FLEX) $<
 
-$(OUTPUT)util/parse-events-bison.c: util/parse-events.y
+$(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v util/parse-events.y \
+		$(PARSER_DEBUG_BISON) -o $(OUTPUT)util/parse-events-bison.c \
+		--defines=$(OUTPUT)util/parse-events-bison.h \
+		-p parse_events_
 
-$(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
+$(OUTPUT)util/parse-events-bison.o: $(OUTPUT)util/parse-events-flex.h
+
+$(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) util/expr.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/expr-flex.c \
+		--header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) $<
 
-$(OUTPUT)util/expr-bison.c: util/expr.y
+$(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v util/expr.y $(PARSER_DEBUG_BISON) \
+		-o $(OUTPUT)util/expr-bison.c \
+		--defines=$(OUTPUT)util/expr-bison.h -p expr_
+
+$(OUTPUT)util/expr-bison.o: $(OUTPUT)util/expr-flex.h
 
-$(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
+$(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h util/pmu.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/pmu-flex.c \
+		--header-file=$(OUTPUT)util/pmu-flex.h $(PARSER_DEBUG_FLEX) $<
 
-$(OUTPUT)util/pmu-bison.c: util/pmu.y
+$(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v util/pmu.y -d -o $@ -p perf_pmu_
-
-CFLAGS_parse-events-flex.o  += -w
-CFLAGS_pmu-flex.o           += -w
-CFLAGS_expr-flex.o          += -w
-CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 -w
-CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
-CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
+	$(Q)$(call echo-cmd,bison)$(BISON) -v util/pmu.y $(PARSER_DEBUG_BISON) \
+		-o $(OUTPUT)util/pmu-bison.c \
+		--defines=$(OUTPUT)util/pmu-bison.h -p perf_pmu_
+
+flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls
+bison_flags := -Wno-unused-parameter -Wno-nested-externs
+CFLAGS_parse-events-flex.o  += $(flex_flags)
+CFLAGS_pmu-flex.o           += $(flex_flags)
+CFLAGS_expr-flex.o          += $(flex_flags)
+CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 $(bison_flags)
+CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
+CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
 $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
 $(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
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
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index acef87d9af58..ae0aa47dbafb 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -17,6 +17,7 @@
 #include "evsel.h"
 #include "parse-events.h"
 #include "parse-events-bison.h"
+#include "parse-events-flex.h"
 
 void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
 
-- 
2.27.0.278.ge193c7cf3a9-goog

