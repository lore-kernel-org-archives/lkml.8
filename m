Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6936FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393F6208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3NKuX5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgFSEeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbgFSEeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:24 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC2C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:22 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c22so6188970qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2YVWbzsYI6vvD/ROFxjwqvUAthg1lBm2QvGRFm3ObyE=;
        b=H3NKuX5PcWt7S1zNUic5ewDlOqPkSf7D4KFm2f0BgircXRZ+52UX/q2ry+eoho8/RD
         AS3P5QClpU7CQRwqUz4q+OjBSMPA48AR3RQjY+0km3dR9eXu8ri4IjNVx9Ubtq9hni9s
         F8E3EMBwsSZHMbb1pFbtOsMBAhifzUtPbrV+fNBFTQzJHXvcMmF+OOx/GWIFMgA3G2+O
         j8AHTCf6+CMtlTrQORPyww1AAYp/Ut/wIu7pSgkOuE3mOv/68EbDpi0TKTKNNY2k/s7u
         8BxPhYApuVnMrWAfIpIxy4fYDgRtXekDWPRzm3/yHxOH/yEEJK1FlcmMTVKX95Yojj4v
         FuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2YVWbzsYI6vvD/ROFxjwqvUAthg1lBm2QvGRFm3ObyE=;
        b=Bq3YiVNoYUbed+iBFr+cDTPD7V1E7BeZDl0QFElCwg/6Y1PsliMIipDwbNVfHB5qlr
         UbBFNoVLmb18GcAls4EFkPAQHLke0SwQrvvYICzbdSGBRGXM1vOEiNHUiaTX2/4PxSoe
         IzoluHqqbYZy1a51gQA0kaLXNul6IIVYR5QydVdehdhmUJKH6z0DKwkk39R7OvUrL4Mp
         DXKiPcFW8K09x7rmsZLO7sTqNtf2tbmoFBx4mQuOzvkPTRR5VsiNp6C1IIDBQDevzR2R
         Na/nTfldbdiFn018OUfx+vFHNCiszxDp1xfWDOlCzvpPyHRrECPYec2WqtcyuManyCMQ
         G26g==
X-Gm-Message-State: AOAM532OGbRVybLHH+hF9GqHEPjTXW0iBOAcRHICu7BNocuq1aP6hw7B
        UleWXCB2793XKNAqOUoDk9ep39ghe5mu
X-Google-Smtp-Source: ABdhPJwhyPonTlK3TO9bFtUtcDOo+0cfQOzDKLcspBZkmv/dE8KnHWJ3hAA1DAQ5jfdgiZ6HTpWZqxf5foXY
X-Received: by 2002:ad4:50c6:: with SMTP id e6mr7215295qvq.156.1592541261346;
 Thu, 18 Jun 2020 21:34:21 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:53 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-8-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 07/10] perf parse-events: Disable a subset of flex warnings
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

Rather than disable all warnings with -w, disable specific warnings.
Predicate enabling the warnings on more recent flex versions.
Tested with GCC 9.3.0 and clang 9.0.1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 504a6bb991ba..53383bd6f4e2 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -221,9 +221,15 @@ $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
 		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
-CFLAGS_parse-events-flex.o  += -w
-CFLAGS_pmu-flex.o           += -w
-CFLAGS_expr-flex.o          += -w
+FLEX_GE_264 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 264)
+ifeq ($(FLEX_GE_264),1)
+  flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls
+else
+  flex_flags := -w
+endif
+CFLAGS_parse-events-flex.o  += $(flex_flags)
+CFLAGS_pmu-flex.o           += $(flex_flags)
+CFLAGS_expr-flex.o          += $(flex_flags)
 CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 -w
 CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
 CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
-- 
2.27.0.111.gc72c7da667-goog

