Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D0BC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8562084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHZAi+ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDVWFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgDVWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC19C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:46 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id r5so3358055pfh.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YbCEU+/XsZxx/Rjj0tjknUqMeudJ748gHpjse82lZTo=;
        b=VHZAi+ZJH81bIozlbm71C7edrNvAp5QZNJqNVrOJ7Dzxrpnye4IbDj0qEbccql+ymj
         sbiyw08NRsHUkj6CyiUIOVo+Ap+ttRH3SBBNjYdVjkp97+K6xGsLBBMkLQazwjhS2jOF
         rquNBkBUOSFmZdNMpZz0j2EBPiY8qlaiSt5KBKVGOqBW7s7IoCIOpz7ctAZ4t8yujvGB
         1Nz2A5zG5DeajIcJsQG7Iykp0k3lh7ztsPcLHiUqMYitYS/MCMy/PyocCmA9Sz2Uug5r
         7uHaQyinbbT8d0Yu/jZPqQjOD7zVteSbyMk/Y0Q52WgN/NLiIH0VYWEIEel64+UwaUbH
         Iniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YbCEU+/XsZxx/Rjj0tjknUqMeudJ748gHpjse82lZTo=;
        b=r8aChNxv51zR4DKR6Hwkv8u/LSz0bsINlO6KDF7bT+nGEVPn2isojAyMbFqLHtmQBv
         oSFoUB1StkokO/VQD1SqiJukJEliVCFM0XXGJkjwkL6p8iez7kNYrtPJJa6CbwcV3zcw
         kZDz9ezIAr5J3ke6gCRWDLXzBNXbHOEPnhKdmHxC6jHsy73iZ9EzRxk56FgQ5X5rzqd5
         EpioY1AyX0IB4ZqO9bgkZpuxf9nCx5LNTrtfO2dlBGSKBAGRw4dmt19hw6eUhmlWl2VV
         +xOv0OvVcWVzfMafQpyI9WzW8cp2dTUFOnT2bH1uQD1vSRysrwebJmtYTOLxCzipDIsq
         kV1w==
X-Gm-Message-State: AGi0PuaKimt1AsPKi7zvT7Fq72SX58YKgYyVnTGnMIaAh05EEvp6XAd7
        PtZB3OrDrVhUtRgbGK88xlZF9M7ATKAP
X-Google-Smtp-Source: APiQypJf4M55jgWbdS4KNnw4aviYxSWTqAgDkHPlZk45DO69FbZJCyzkgcONOfz+xZ/lRd6usqLqYHBiRAoK
X-Received: by 2002:a17:90a:1da6:: with SMTP id v35mr981521pjv.44.1587593086151;
 Wed, 22 Apr 2020 15:04:46 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:24 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-6-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 05/11] perf expr: increase max other
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
need more space.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 0938ad166ece..4938bfc608b7 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 20
+#define EXPR_MAX_OTHER 64
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
 struct expr_parse_id {
-- 
2.26.2.303.gf8c07b1a785-goog

