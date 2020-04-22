Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF78C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C76E2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9ouUeRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDVWEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVWEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF1C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:37 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id w4so2949199pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D5tpZw1i2R58vBAfGzRizvOpwrXZg+TLaUwg0kTWWxs=;
        b=H9ouUeRNQqqaqsJNq1PvVkGYNcuwc9v4OpQuRfmP8gFIdt5qWWbDKGFdL1l0BIqW8U
         dzaYfdZBo0qe9z0uEgFIh90NPuS1kn1btbuHtoM5bMxY5r0EHp5qLK7zx1XdaNe3qpEM
         KktQt+zdUTzYgrydMNGBW8pqleVf5sAMJnqL/yAdHV40uuacpzJfI+H+OMvlbKzyp4i7
         KZ7TQ5rtP18KpuSKhwAYLHX1d20fyiDGmqswCIBt4RD8pJX8wXePsXy4ATXtZD18jjh0
         KPMGA18HDf2kpclAfjOBoWSz+9FdBaVzRqRak44LPNPc0I9sQXDFbgMBg7ttK3AI6q4n
         g0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D5tpZw1i2R58vBAfGzRizvOpwrXZg+TLaUwg0kTWWxs=;
        b=Me/+VmCjZiEo7SN6QMJwByvRtmvBs8aloONaxiEx9WpaJa4m5Ezh0vDGyLLHhB8bIy
         4KlMZCCoVI1fR3Z/lHaBiEXTaXCGL5+q1peoAwHJoPsWB6aw97/vdGe6Ts/9sYP01VpN
         aH9fCUeC4cvx3zIKqPhfcRaWie79EMYHiH+pE+O+Pkc8sHwc3CDzC7zjuyH8/wA7RRag
         K3tnmfhldBrrwo27dv0qPY0krAyR96lpBU+I/yZYcAWWXX369l7HIuINDtxM9JXQxwIs
         h6HadgjaL+qygqxSzDZtmo13gwp3K4Jcg7luM8aHEF/3Bxr9tVQ/W6eBvOqIaIZlznbS
         ohAw==
X-Gm-Message-State: AGi0PuaT31TfgG0uPBeHzvII0r9IkId8IHiIUVR5MI4JXbobayRyf3kL
        JG8AJLI/9JSqdFohjL0I6ukHh5VXWkwr
X-Google-Smtp-Source: APiQypKpqBOLVqK7RAeKl+J8yjsE5Rd3cBU1iaxVr1mWyn7dS7bYj0OatAyjgfU4jxCkI6idfLkbrlewdOLv
X-Received: by 2002:a17:90a:3767:: with SMTP id u94mr922983pjb.23.1587593076484;
 Wed, 22 Apr 2020 15:04:36 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:20 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-2-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 01/11] perf expr: unlimited escaped characters in a symbol
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

