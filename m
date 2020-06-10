Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14765C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4882072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hc06Ilhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgFJVvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgFJVvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB28C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s90so4041631ybi.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n4Bbg/As1iaG4AA84mx/1IEFJA7h66ehdp5+DsisSLU=;
        b=Hc06Ilhbrd1sBcDWkV7tJPkJNJ8Fsau5VVT5xV8TBHZH5txuKEs7AuKyFr+EFJhRWR
         ZJQK3aHjCmZV6JHuv/MTGbFHv/6sHk760zPN0AsBqkrzVN/8mWQD3jafjidiLDDWD4iL
         xl/vD06HrAEhHHcI5YebQgy9/EQGHKWzbIPIzx6SmTrMTigh92xXvZGDYXH1ELbPaQ9D
         aAdC8lQaRW6QxZiwhMSX0IPrj5+YL9M62EOcZhbuPfCW/WO8FA/tO2+LaTtHOmcTVnpy
         G0HQFsW09uzYVOZyVcOwQFbUBEZloc5iT2fO6/G3Bh8Gya60qI3fH64WzLnsZKxEmlGg
         XH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n4Bbg/As1iaG4AA84mx/1IEFJA7h66ehdp5+DsisSLU=;
        b=hNNE5H5ZV6Db6oFHrfuPT/kJcB7PBdfzmhEam0DHPe2lSaYrsVduFJ3bD24T4sqL0D
         cA+NPuw/lsDVeb8FxYI9U4NoP2vI0m5k0PBdA3DM6eJ4MBrEZzIWL6apbepkQFfh1r5+
         4CZoXROH/B0LctKvUbZrAAHnBgA2+9xorU4iyScJ1QzXC5bAEBFrjVrap1dToJgUbAa1
         wbX4ChCKk4LBh4iCOnsIOWQYnmBRbl+rq9FjOTPq38sIxWOa7OdCHZhi16H6a3wZunHm
         +ygQJbpj7in5TGxW7cu7NptxoR3Ohb9R9TCCKocDYB3+iOYf0R4wpoxzIdW+LIbf+zPX
         7zmg==
X-Gm-Message-State: AOAM531/g8RrAl8WaSd3ARZZD0Z9o5gsf8QFATjrxbnIzYXZVBHSKIxH
        Ea+yOOJEvz4eIFnx9MWCmdZVZjJCkzjG
X-Google-Smtp-Source: ABdhPJwp66cqSQuSyD6KOQlAc90NVYURK8dC84SGQIWjf4uu8V1FYcjRz1TfDPGPxDsU3sjoQ4L30ztHPeQU
X-Received: by 2002:a25:bd4c:: with SMTP id p12mr9531542ybm.471.1591825873458;
 Wed, 10 Jun 2020 14:51:13 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:55 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-6-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 05/10] perf parse-events: Declare flex header file output
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
2.27.0.278.ge193c7cf3a9-goog

