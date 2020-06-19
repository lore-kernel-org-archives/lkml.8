Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9259720CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHihjPeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgFSEei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbgFSEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C515C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e192so8684081ybf.17
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4pz6j2VMR470Gj2vfpwgwF4Ge32U12Q9ReGlHMPbcFw=;
        b=MHihjPeCpQTRl/vgwU2BFl1mQW9VlRPJqLY6d1wSnp0FnnwHG1UXK2A0VDxSE4FOlB
         Wo4WhspBqpgQESsRe4VLhg6CMtBZvctEdO50xMQx29Ts03zCdQBvDldsysyEP737PHiV
         HScrjYsfUz7EQqLwjubGSvbOp1tUzkqO48t38dMcaLUCnC0GP0L/OnDI8U/hljvNhucC
         qi2JikfCW+Jyr6uryXGJScMv0hSzjH9R3iKYl+nQsMuYvswNkAQ16OQdkLc+bYLqpYak
         CvRy+8KltLS42O/2F13DovNB9hWYvFvE7EWjleknLXlXr99/Ce5eEHTNa1pmhbcJGY9w
         sB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4pz6j2VMR470Gj2vfpwgwF4Ge32U12Q9ReGlHMPbcFw=;
        b=MKzCwmWA/eleOSImm3a9DrwPrKvcJQQkt/qhVSfenKZ1Vf/Tj7BPV898WmN2uWUIEF
         sL8K5qJRe32eR+NYLBgJR0duWqF4HQSos55n0wvaaUdSCTUsf1lyvNKuW6VJ22ACOk0t
         cVmgVl9GdvI7xfFWxyhEarCq7F7iOn5h97sQjMeMtpvUsx8ChO8R6q4vn+bi+8sMuUjg
         R2Eq/LZWt0Y0eQfbnAplrbFq5IkmT7Ox3BFe6pkBrBei5kJwCgQ36HXZs2vYE++zEnyg
         FVJfhbqR9+72unzvh5tRVHs91yzGCQWxWz/gPf+BrzWag7UZBMKsGIoH0fKSw1Ir9tNp
         L1xA==
X-Gm-Message-State: AOAM5313ajm8iHI7mRoaHiIPY5lsNAnWlIrJkphwxr8Aa1hzW2iH8fa3
        D2ZpntWIwMmWDUDzX8Y0zN+UfDd/zrDN
X-Google-Smtp-Source: ABdhPJzXw5t3HnTRsyjNEvvn80kALIMkdYENFQA6HunonNMZZ8xaO0gDehpSoNFY7orzKYCR6v0t/l+msgyX
X-Received: by 2002:a25:32d1:: with SMTP id y200mr3238063yby.507.1592541266635;
 Thu, 18 Jun 2020 21:34:26 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:56 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-11-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 10/10] perf parse-events: Disable a subset of bison warnings
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
Predicate enabling the warnings on a recent version of bison.
Tested with GCC 9.3.0 and clang 9.0.1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 935ba132614c..c1692076469c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -234,9 +234,17 @@ endif
 CFLAGS_parse-events-flex.o  += $(flex_flags)
 CFLAGS_pmu-flex.o           += $(flex_flags)
 CFLAGS_expr-flex.o          += $(flex_flags)
-CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 -w
-CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
-CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
+
+bison_flags := -DYYENABLE_NLS=0
+BISON_GE_353 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 353)
+ifeq ($(BISON_GE_353),1)
+  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-error=implicit-function-declaration
+else
+  bison_flags += -w
+endif
+CFLAGS_parse-events-bison.o += $(bison_flags)
+CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
+CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
 $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
 $(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
-- 
2.27.0.111.gc72c7da667-goog

