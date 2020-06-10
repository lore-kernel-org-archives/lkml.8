Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8732072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LA1/0Km2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgFJVvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgFJVvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:09 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C4C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:09 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x6so3132651qts.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GaZ5yNVujUQuXOGBEqSALglLcJ45S/WJV+13DFibPQE=;
        b=LA1/0Km2mwIXaj77u2/XU/apZxKBoqS6v4QV7EB/f3gM96+B+n931Jy2NYfzyqSbm/
         45RXwHq8HQnzOJnDOcdaOkw8tzRyb7t5U2V+t/rz3VjBb0W4AHC1zCvXZ7B61OO8ZiNF
         j+wMHQQ6bxeHhJ6tGYN82omniQTzBNZvPEvx3oUYfnJBX/cULG4mLH4Qgr1n/KK1ejM+
         34qtyGv+wpBc0nvVARxKWx1etIjzNtx+EOF66DAmvbxGmnmFtVQynKkqxgeCKXUze3BZ
         VAt+lwYN2pGvVADYkTvxj9NAQmvGE3JZX6mc+cy08Q4EX0KxPOyqOe0hPOvmL956FyAn
         U2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GaZ5yNVujUQuXOGBEqSALglLcJ45S/WJV+13DFibPQE=;
        b=cuZvfh4CyP5ayPrIx0jPqEW7p8ZDoE+ZhYoGKYZHoONImwTPzGAKx79gtt/ufEFnY2
         ln7Rrzlg10Zjb65SVnrQDatldHr18ovcc74Ing8MJ+SdGqSHtIHx5BbUc5CBmQC/zEdB
         Hw7q2XA6lW0C2hkZWcx74F3drrG0633hQZjWbWsb5ioKd9VVOYtAyO6mOkfPwPf+cvKn
         f4hRoRd0+td3DAKvejFNJgSeKegTM0xJJsx9XZCtiHTQVPrvTyd+Ke23OQpD2Rtf5s9B
         6O/hm4lDxh084naapwXlB4FkpAvbhejqVfVPo2KL6gelf5malYvoWhNug8YAmp6JBnZf
         Pm9w==
X-Gm-Message-State: AOAM532Txdj1stmn5A2rlM+d6JPU5AbxFG6wtdrWOAnCBm3W9QRJMtrI
        ZVRk2sxjkrMM7ne6FiUVpjGF5qwVkFik
X-Google-Smtp-Source: ABdhPJwpFNLo0e/9mKtERtZ4a4qHU2viFMGyKLu03DBSMuGnAk2iIRRv/VoJcgnaJtkHnrew7lw1z1s0zkA4
X-Received: by 2002:a05:6214:15c3:: with SMTP id p3mr4867252qvz.192.1591825868082;
 Wed, 10 Jun 2020 14:51:08 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:52 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-3-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 02/10] perf parse-events: Use automatic variable for yacc input
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
2.27.0.278.ge193c7cf3a9-goog

