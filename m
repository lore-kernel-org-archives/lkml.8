Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7DCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1AF207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbM2nQcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgFJVv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFJVvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:18 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E2C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:17 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 140so3298688qko.23
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qx5y6D4MDY04wGyKLk1//ZTwsmynRrfnFOOeKE7BZjg=;
        b=GbM2nQcFDqkZJvYBU4+wb7/F7SWR+5czFy+aRwqtnD5w3yGGGSQn4zC/FdQB9jcJCB
         wlIMEe/R1qfRbLcvzuRCsUWafJ+G50//szwOTzsKXCvh7CkPvKn8S/0dgrZ3VHYkth2/
         GRgMg/H410dw38CUvD74APBQjcXMMUWNExmqFawExhUyof0Vfz6kXpCj3kvLfZB884k1
         p6ZQmapehRGTW+T2LXGetEXk9N1eYfveDeKnuifjVE4FVvnEkTNseoy7g112ktNV++ss
         xcwtEhEmaW2usS+BVYppJz+8Dy8wlguKJSjbIIqn8W9zob7YOJB4z55ZfU4/5d93nVne
         9osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qx5y6D4MDY04wGyKLk1//ZTwsmynRrfnFOOeKE7BZjg=;
        b=cNL0H3oYupxdCmgzR+ZjlmLnYu1QzdGh5N9oxqquR+pgeniIIUoSFJodPAI84r4G3n
         5v14w2orjQOC5Yz4jEoJW5WXCCOYXQNO2ec5uHLcLN3QICA1zGOFosC6fkq9LSCxTmhR
         TSGSi290OHr6tY/kxA5AJsOjB81kAXF2qe3sdEaJM28xaMFeW1L3rOU7BI9qsWXdgqOo
         U6F/kZakrautTgMBIf/jPgYGANO9laKcP/M8lExW6JSJdbZLEcLdL3a8DPkEbPw1h5aC
         AUyafj9euzrEpnYzoHXZOm62RMo1yj9I1UAAHaOABuomqC8qoWxcUunUSGHxmVrgrhS+
         cTHQ==
X-Gm-Message-State: AOAM533+NVtCxKuCphiS2VnHIdTZt0gOe1UVHaRJnvUj7DRUHk0vIS/3
        4CSLHmjOecKu/B/rNYVgiGQYOaZTcufo
X-Google-Smtp-Source: ABdhPJxyt/HmEKAmzIbWifhi2eDq8i4yJ3WMmnPA9FPl/iP/Pwv0zV2s+wPDlCPPtyHdOOxo2GTDuwCReA/i
X-Received: by 2002:ad4:4429:: with SMTP id e9mr5098394qvt.143.1591825876926;
 Wed, 10 Jun 2020 14:51:16 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:57 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-8-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 07/10] perf parse-events: Disable a subset of flex warnings
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
Tested with GCC 9.3.0 and clang 9.0.1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 504a6bb991ba..43f3310827c4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -221,9 +221,10 @@ $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
 		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
-CFLAGS_parse-events-flex.o  += -w
-CFLAGS_pmu-flex.o           += -w
-CFLAGS_expr-flex.o          += -w
+flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls
+CFLAGS_parse-events-flex.o  += $(flex_flags)
+CFLAGS_pmu-flex.o           += $(flex_flags)
+CFLAGS_expr-flex.o          += $(flex_flags)
 CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 -w
 CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
 CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
-- 
2.27.0.278.ge193c7cf3a9-goog

