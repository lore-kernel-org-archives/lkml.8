Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CAEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE6F208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vApI/mMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgFSEeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgFSEe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6FC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s7so8726157ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rsKy1A+fwJ3bJGowwqgvyHssXzv9DUfmiZjxbupoGgQ=;
        b=vApI/mMC983LUX6Nmm9f9vwZlEwWYQFjyfw06/rnJ3d4d/tRqUQDR2Kway9nqJILC7
         o+Byz/wWYFj+evp1KNkhlB88RryiuU3ccL9hP82XqayhUAHPTaTRvBHdqRKskjHP/iHG
         9tK+SjbT5G5A7wmeroL61O0gnyBSbaYj3d65gK585IvIKAx6+2wBhM2o6euZrr8KaFaN
         m6EEoMICVvTdpgWgRsaRA+kJnNRtFe9/8N1ypOyBfetgUNEfgyonwTRt0sWeE8BBqp6v
         kzkmjzHBqsQ4quUr9gFA0PJI3nxrw3R3+tn87ygntz3xpgaiX3Gjc1g+RC/CaRvkEFMq
         JhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rsKy1A+fwJ3bJGowwqgvyHssXzv9DUfmiZjxbupoGgQ=;
        b=LOR6UAuvCLSRjGBncFU5elWPK0/FZtQHJVOt4FJDW1t47k31Kd/pl9Rp6m1+bXcaJ6
         07BWxnZOROmCl8Ywg0vhsRQ1mu681ttSe7GXbAjwfmSZgL4OfqQJlLP7iljW0/gzNJpP
         LKrVKQ9ye2PxjqarjEl7u3rWQLaCjfqi7lMK7ysEBc8eD4GkHUBurduZg5mcfTsP1aLe
         wzFop2DKKtA8Uk6Ze4NgPyQgYvZ92Q4YTtRMYtBV5d4dWK/Mo+jtApRrsw404dEDPRbF
         7mDraoyDmJKqpKuDHmDz6qpzGJVHX147CqbRosY9hg7dxR84PERlYKrJjVIeSTLegY3f
         NjSQ==
X-Gm-Message-State: AOAM530iw80pHcS3ByIhdlBtFfK7343qXEeRQzLFfnaBFuv+1jNgGhqb
        CncXKylMTxcybNsIPRVigym6DZAKrX25
X-Google-Smtp-Source: ABdhPJz7dwO2g0chOTctTWv7LVXFuJgjwpmmXJOMJugtHO1fGtPVkrX3X7MoLv+xwszopw6VtOGFtHX5ADeG
X-Received: by 2002:a25:7804:: with SMTP id t4mr3397484ybc.43.1592541264912;
 Thu, 18 Jun 2020 21:34:24 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:55 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-10-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 09/10] perf parse-events: Avoid implicit lex function declaration
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
index 43a9ae712544..935ba132614c 100644
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
2.27.0.111.gc72c7da667-goog

