Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A1C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2982166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QM34kNMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgEARdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729686AbgEARdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y7so12980657ybj.15
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=agpNpPb9ABPgrcjzE8UbvUM5oHf8Sq5TEvUJcEJ/6IE=;
        b=QM34kNMsCx0+4tv0oRZyUH8NA8dfsiePcSzrvx07TX9QYE/169VO40ms6zKoYRXqOB
         ZRloW11lnpci1oIMgfmb3vwokNto/F8+DI7pvKrCC5FajYY7UxE4lrGFuSVHwZILbivB
         4EtxEvSDR3xm9Zd4618+mZkbHq2eC2zOMUNy7LBNTDJfmJYiCS/yKIrD72zCl1ZSqsXx
         sCYboMAUKwROHwuCNwcHVdlFAKxnjy2AQwqNf2cQTc2RJ/qf6rSWlpvfLkAN3dcXtBER
         S/8cpQa64luy+l9NxWZfcfkaUOV3zIhwPSgxoL/koDMZV6j7s/3Xwnddyn8caOGZ5L1s
         iftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=agpNpPb9ABPgrcjzE8UbvUM5oHf8Sq5TEvUJcEJ/6IE=;
        b=A/K/clRMW6ccg4Rj7K8iVCprKemx+IZUJY2KwSEtzWKdH0sshi8z6nw1mETMs2l9xB
         yvmG08zYKJ1icE2eqxvDIjWX4hfF2d4cOokxcozFVS4sfYsMq1viFoXFWXdg+55AGn4m
         UfxDQA4EmFrBePB+NNDojMfYtDpT+RPB2sQkJJOve2lXr/Rtg49Pfe+mzoxupX1eT+Me
         Cmfd61UFGtsAc2j/EmY0v/H0QuxIU7BNe4ErWNF7IC3HD2JkHBFcan9cNxogszIU2hr+
         UjvteFxTw3CGPva2ofQzxrF2vlODlbDttGoeTdxF2khI60of40kUfaAel9QJzHSoUX1t
         rFow==
X-Gm-Message-State: AGi0PuZB5pPM9nWjTerfheYkWHJYu80IyKcRd9RHo+Qw2UgZrkdeSgFn
        wGTl8jyBfUUNX2B0S+QS159qi6UnPolj
X-Google-Smtp-Source: APiQypJ3BFpDpnhasLwEaaXp8rulOJohwyLJ0Fv7c7tI7ZYHuuAjTfQOxxdQ2VuR04BdbDKhFQDNUgR40BAP
X-Received: by 2002:a25:8183:: with SMTP id p3mr7967365ybk.408.1588354418386;
 Fri, 01 May 2020 10:33:38 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:22 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-2-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 01/12] perf expr: unlimited escaped characters in a symbol
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
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
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
index 74b9b59b1aa5..73db6a9ef97e 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -86,7 +86,7 @@ number		[0-9]+
 sch		[-,=]
 spec		\\{sch}
 sym		[0-9a-zA-Z_\.:@?]+
-symbol		{spec}*{sym}*{spec}*{sym}*{spec}*{sym}
+symbol		({spec}|{sym})+
 
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
-- 
2.26.2.526.g744177e7f7-goog

