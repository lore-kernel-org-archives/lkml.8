Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A6CC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE8E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mF3VO5nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDVHsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgDVHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:17 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDABC03C1A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x16so1017856pgi.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D5tpZw1i2R58vBAfGzRizvOpwrXZg+TLaUwg0kTWWxs=;
        b=mF3VO5nn+0V0WQZGmFq3OmpNmldsAk2V1nDaBzIyI98U3m+z30xNsWm1xn55GudLVa
         BLmK/YMD0QTtBvyDFWXzwKMUAXEHQIShuIeY0+nuaJTK9eEbSu0v8KKrdlTIINma23/j
         akbcVUKffaMDETqAqAc4CLHKWXqHiJMDxjec2FlqjyPNeiWRp8S11RpFvaKyEXXjPNrs
         wDFuOY4hEYAM/SVPcK17AvOxhqIpls1/K1YFly2aAPU/0qLgiAH99BdZUEAOuplGMXwh
         LduuaO1EWFJ29FBYwwmSEUiI8bQg+4oLtQfwB+cWByotugfWvPO+nNTZy1SVwPXsNP8q
         7iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D5tpZw1i2R58vBAfGzRizvOpwrXZg+TLaUwg0kTWWxs=;
        b=hvpW7xGD7ntVHxa6rnxQosqksZemRCY+SXIDOLfRCHDouS3mgYmgZgjvFpdDavvUms
         hA1Z8tF8aMh3M/UyD2QeXlNe1Ykm1dVKz4e5otr5oSJMzLtEUqCWzJr3o3EigxhUn01/
         7fryNsKYA1b8IeYCjCG1nnltB+w6UCHpnhCQ6AEpnDPIqXg414Z9zAop6B+2+rLXbE4Q
         y7S34JKGmHBE5NuAG/SOWsQ3H4GpjQIH1r6JjwJDqnyGJsW5SNsgMaqWy27CtXUsqimB
         yQGvR5i/XPAlrJ30+q5nAGdm2v7vbg9KC8zbWuviDRo57PNaMw8IuGf7Zshu1Vtgr4Xb
         jw+A==
X-Gm-Message-State: AGi0PubdZ3lw0ubrZ/1VtXB+9pUkupFxc6LR4w06HOfPJL/FNhd4uITz
        0IByEvJevUK+0XND1UE9BR0Tge1M1raw
X-Google-Smtp-Source: APiQypKEDsb2XJwyiTIKy+E9xSYQzRKrEnvVyggmLHtTzDA89Ky+xrOfIAX0h7HIsxrLf3S3mnnQ7j6Wf0AA
X-Received: by 2002:a17:90a:24e7:: with SMTP id i94mr10482216pje.117.1587541695879;
 Wed, 22 Apr 2020 00:48:15 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:02 -0700
In-Reply-To: <20200422074809.160248-1-irogers@google.com>
Message-Id: <20200422074809.160248-2-irogers@google.com>
Mime-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 1/8] perf expr: unlimited escaped characters in a symbol
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
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current expression allows 2 escaped '-,=' characters. However, some
metrics require more, for example Haswell DRAM_BW_Use.

Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 2582c2464938..95bcf3629edf 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -73,7 +73,7 @@ number		[0-9]+
 sch		[-,=]
 spec		\\{sch}
 sym		[0-9a-zA-Z_\.:@]+
-symbol		{spec}*{sym}*{spec}*{sym}*
+symbol		({spec}|{sym})+
 
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
-- 
2.26.2.303.gf8c07b1a785-goog

