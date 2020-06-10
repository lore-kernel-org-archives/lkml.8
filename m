Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C6EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85222072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+75+CqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgFJVvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgFJVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F2C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:15 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 16so3328540qka.15
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Va6zICY0o6sAetjCOSnNkvSXddJGYqh++m01ui51Hck=;
        b=V+75+CqQXBe5X0bhvSjGZiHOqUWZC4Ivtut/gRYm21sm9hIpfHY6lVQUSTHRoq8q/s
         sWvmYwtwoBNEk2Eyn77pkSQjRSQAFG/vWO91vpBOrOEqd/uYieaNPtsYfc/vsdVjJ1iq
         XtdNU6n/nEQe8oCZNYbeOCNLoABIyA1lmhuvzzSg/+2VMevPFuzTM14BD1n5UGv/kO9l
         zHiZmw+MdIADK2n/8nnAOOlXEcu/KPIu131XkW4Nb3ok4f2Pnlpdmv/ts1/g/CMpnzA3
         DSYZblnmCtJ/eBpoEGZRw7uRn9CAh4wQ2ABBBRrDsBXwG2DwMfC4Ig0WuNG+eOjUGGVv
         Y5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Va6zICY0o6sAetjCOSnNkvSXddJGYqh++m01ui51Hck=;
        b=scPTCczJOXzv863kJGaPlXWmM/8S1B6cMUgwqI4TswOXftunITMkzQV035X5UwQGdd
         senLNVlm9JlJx16vLzNYelTnfiwr6XUw1WSrf+bTdl5zLAq7fjqNxWB4f7qxfiQOWO5A
         jHTI6zqB9xmG0mDOIOqjNR3KBQsggRjJ19Hliu6gy/EHU8QlJ8ME+woOKpcrWzNgoUJX
         DXaeVSslyK6jA7NTd+Lfx373Gl9b8zNhbS/ntRCAO33tjj7f/RoJlPJ5sqSAJLUQouTz
         vVpAsT5Jk14u1okC6HCBSzrU4/C2sHWsqxfJqUAqIMik6SsoeoI2slW417iyypi4IwCZ
         nnrg==
X-Gm-Message-State: AOAM5315ANADmSXb0ZHmjCOmQCDFFvZneLOKAryWu5fuzroJXkvZOUrI
        lu0gJPBfvHCnnuU+Ay6fvEjY4kwJ9SQn
X-Google-Smtp-Source: ABdhPJz9e3UGMm5QLHUkMCacjnns6VgDmZ5n30WPATLB9DPL0d7vb28KoDjJqipn2A/GTWLJ846N7vL9tyDm
X-Received: by 2002:a0c:ffca:: with SMTP id h10mr5190242qvv.238.1591825875149;
 Wed, 10 Jun 2020 14:51:15 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:56 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-7-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 06/10] perf parse-events: Declare bison header file output
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
2.27.0.278.ge193c7cf3a9-goog

