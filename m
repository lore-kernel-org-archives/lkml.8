Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C78C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E724207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KUi65K/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgFJVv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgFJVvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7EEC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c3so4037406ybp.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wEUxoz0aIR9XI46Q2NxWVO4Locz/BNvVC1V22ArmJhY=;
        b=KUi65K/TCk/BYTa+RrARZynPjTtiQ9F1HXDXvZX1k9sAA3GQLF5/63YcMb/qEe3Ywi
         X0XaSOPiD/vzkLlryGtgxEiUzq3m8YuetzRQQe5BMtDHSoG0cPuogJKyhXQDQLg8x/qn
         lBZpBo83BwZjTMiGkH6pXn7PiW3iDDZKekYKlAVD85oq7mtpFPC5ggOodXa8ESCYzf+t
         YjFJLf+KE7bp0gH2m4v3bBd00s2aG/M+x38/mfEni0TA2gwk9SDG0wgn7f7fkGcYcyPc
         z3xKixUkAruNuTeufQZGI6i6oAHiTW6LFDbxriLXoDR7qfiFr1rDx02oAf6V27+hedN2
         qpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wEUxoz0aIR9XI46Q2NxWVO4Locz/BNvVC1V22ArmJhY=;
        b=gxTFz0zIzl7tK//XSOVHKol/qF7kO6aEKOcsaJydHd1Okrkcx7Rlr+Htwqb9KWr3Ee
         yQQn0qCEUwQXzJmg9NQAHxILJbGhuNnC4kqrkbDJmfeOyqxfeXwxxQ6v/MO62QnKrFiv
         HFCnvjttd5VxYjrXzOwR7sEMNSb+mAJ4YZyOeP26tvg0MVjfc7p6jMjQrewI1Mu26nRC
         f6KM3mLedUjxz4ZGO61C14Us0eXG8U2FRBwOq39KyNXcEhYw8uBqml1Nr9VCvs3am/Gl
         HuYkNZ7UR9fd5aAvApxCiUP9ktB4JAqPDHg9AoJVFDEhdjhSDdT6lhMgm1ThNFKI/ygZ
         aWlw==
X-Gm-Message-State: AOAM530kxARQNXqBuRJyFBPoFP/an/zQSGRvi5rVrF+ecs6cBmpdro74
        aAKUO91VXsK6BG2dlFK8lXQpQlpo5YVc
X-Google-Smtp-Source: ABdhPJylRPwYbNfDcsA+F+3a6ycMajBkoac1UmCpsBJlVgCg2WlSjlnBQLCrkB9YANE74VdKGPlL1UUL3GZ2
X-Received: by 2002:a25:a567:: with SMTP id h94mr9240157ybi.95.1591825880498;
 Wed, 10 Jun 2020 14:51:20 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:59 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-10-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 09/10] perf parse-events: Avoid implicit lex function declaration
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
 tools/perf/util/Build          | 2 ++
 tools/perf/util/parse-events.y | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index dc5b80ae39ac..68885bae466e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -201,6 +201,8 @@ $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/pars
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
 		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
 
+$(OUTPUT)util/parse-events-bison.o: $(OUTPUT)util/parse-events-flex.h
+
 $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/expr-flex.c \
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b9fb91fdc5de..d3294e76e7dc 100644
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

