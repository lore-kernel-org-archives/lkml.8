Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515EFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB88208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7eROnAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgFSEeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgFSEeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5DC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s9so541664ybj.18
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4USmYIVNReLSlev2jJCWZaZp/wYZr3AyIY63wfDnD3c=;
        b=B7eROnAnooGOLCbAxkE01FuhuvRsZi37ihSKp4JmzQLlG7DqTqPw9lZ224OqLd1sak
         u7e1sy7v8n/vkEF25Gqssgk+rj+Yyw7gEgRbHk4Ixi2d64RHNCclMgwHCDlZunICLjWe
         jDSOF4+1/pbx+7bDVIi1TelLq4dJsvGn+irHDNh0hejqHrcyQcBoky2XqIPg57QzU988
         d+94Pynx7YsOpHWRPmH+9Mg490T4bDgE37yHeAcdez9YvSW7PwHYQkBf594df+x9YxcL
         clOPcvf2VOQltJ64AHvrAVn6JBCkgPNykPC9Zj36pfsNvM33MDbRQQkyHHW8srGTZVhQ
         a6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4USmYIVNReLSlev2jJCWZaZp/wYZr3AyIY63wfDnD3c=;
        b=grV8E99ikRJhXYWRvpniU339hRTyUJoJFMU4AhZgHjbNh87FjjhVudRWYoheJzQWnW
         8C+8KC166L4nsZr12SxhsurjTYSlA5eoYJxv+aegQw02ESEF33QiVPGl3K5acv4aHUoA
         r9kOV0OfKOmtUAexwur2KNYsIAWQnQ0O0jMIb3HlhSyiUYCKwkAFp3j/Cp4XxVK9fkyU
         mnZQMpz29OS3G7OWmMsV5DIC3KVe29mNtwwaft97OgBMsmE3B1L6xuKlBpVmDB1QAgR9
         lvg5jAVyD2XOLgPqKy9hRX0dQqEd/9QrlpXblSwvptt9QnMucIJRediYht09GY6hjHO9
         pLZw==
X-Gm-Message-State: AOAM530hlnzbLhqwcPxvxweHe0G1Sg/1K2055lwXfuTbWFNC9tfw9cvo
        yAyxT4y7+c9udIYZtY2gFf7yYZZJ5hFq
X-Google-Smtp-Source: ABdhPJzMYHGYLuY12VSE1rvAw8+NwO+oFlHySNNHL2XYZa/zjdNxi4RtlBP4UsHG4MhM/n4a8y7MdNT2+wdU
X-Received: by 2002:a25:4f44:: with SMTP id d65mr3188729ybb.175.1592541257530;
 Thu, 18 Jun 2020 21:34:17 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:51 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-6-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 05/10] perf parse-events: Declare flex header file output
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

Declare flex header file output so that bison C files can depend upon
them. As there are multiple output targets $@ is replaced by the target
name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e63bfc46d50f..55c78ac53f04 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -191,25 +191,28 @@ CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
 # avoid compiler warnings in 32-bit mode
 CFLAGS_genelf_debug.o  += -Wno-packed
 
-$(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
+$(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $<
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
+		--header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $<
 
 $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p parse_events_
 
-$(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
+$(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) $<
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/expr-flex.c \
+		--header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) $<
 
 $(OUTPUT)util/expr-bison.c: util/expr.y
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p expr_
 
-$(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
+$(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h $(PARSER_DEBUG_FLEX) $<
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/pmu-flex.c \
+		--header-file=$(OUTPUT)util/pmu-flex.h $(PARSER_DEBUG_FLEX) $<
 
 $(OUTPUT)util/pmu-bison.c: util/pmu.y
 	$(call rule_mkdir)
-- 
2.27.0.111.gc72c7da667-goog

