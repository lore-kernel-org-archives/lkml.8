Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CF5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE90208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6nAd81h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgFSEeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFSEeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EFAC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s9so541532ybj.18
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5BR32hfEpZdXnyFi+8Yks8BmSgyepFsygk5jmvxNC0A=;
        b=H6nAd81hdPg1adE+qaXQPU6G8MbSR0G+bIKfARALyp+TvVj/4VRs1xewIWl4ws0vbS
         RnrIT7Mu3kabr0RUCZWppay4xp59/95bXACIe+J0glVRpPo9woYVKYRIkg973bo6zJoJ
         i3ItfHkzWFFtA/bW1aKzWj0f0mBWStHUH70ubeI6KwsJEb7icxYhiZClNAka1oziG1wQ
         FEDbX9T1CL+1rnTJ/t4wEQDbNWJqGqtgWAUdSL/9NnDNpfTZcj2kWz/9VpNMPofeWWsd
         /VSPG6VMxyIZlVXj29bm3LoFjxNbuOi0Zk4ClT1QejBF3P7I7uCqA6LvvZF7j1JGYCw9
         Oweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5BR32hfEpZdXnyFi+8Yks8BmSgyepFsygk5jmvxNC0A=;
        b=a03glunb9b+50Y7eos+vXZsDhZ9uJtIt/CqSbT4a/42D4auhdrnVmety7NxwcNhYst
         cw/dIkSKJxdnl8o4il4sD4cM3UVbyHTJYM+OkVThEe9tzN+W4GS/WljfonONhhOLEM4a
         flvadB2ONO7j05sTpWMeaJUZOpDunDmydoaHPk6ttaDhVnaqlx5vlepgJNUMJ6Viys4D
         3J3Mt3Bl8UPrpsyIpfDriMQYFRbh6iEM+I8Gt2f0iVXDDhmafSfcVVS2sthUB3d+Doa3
         HeOLF63XuZ+yMVUi/Zx3O0vFakj7Kk0rdH9/W1l6yiS9fjOf5cbzhvjQ/4gO9+RAfC03
         p8mQ==
X-Gm-Message-State: AOAM532h+Ltj/5+FpZlTBhkMYaFRTvqOdSa55wDdNga+SLCGUFRFk+7Q
        VLPeKeZyUWoWaVzNR/3hrbr8VXw2hNqx
X-Google-Smtp-Source: ABdhPJy2wUSFrl1jLfBADDXNBeerkNO6btd9PnNzmLNaobasJ6kGrNKssxd8s0ZO0kj36gqvRHqtMOjbjgz5
X-Received: by 2002:a25:428c:: with SMTP id p134mr3307798yba.467.1592541253580;
 Thu, 18 Jun 2020 21:34:13 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:49 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-4-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 03/10] perf pmu: Add bison debug build flag
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

Allow pmu parser to be debugged as the parse-events and expr currently are.
Enabling this requires the C code to set perf_pmu_debug.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4e1aa52d75a8..3ae4adc8e966 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -213,7 +213,7 @@ $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 
 $(OUTPUT)util/pmu-bison.c: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d -o $@ -p perf_pmu_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p perf_pmu_
 
 CFLAGS_parse-events-flex.o  += -w
 CFLAGS_pmu-flex.o           += -w
-- 
2.27.0.111.gc72c7da667-goog

