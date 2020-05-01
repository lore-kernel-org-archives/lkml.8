Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BBAC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D158924954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbkFQJBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgEARdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730228AbgEARdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A3C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t2so12892327ybq.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kaPuV4QeaPOgBS5KpMFoLQOvshqKxuzG67jCzUS9Y1Y=;
        b=sbkFQJBCqgE+woRVVpeo+0KJ++czny488UOeAt88SxIWBZ1gH2z9WMIHrqwaz0FRyE
         wVGmNPiqAXD4LozzOJo0U/CuPvK5KLdhI6fzv47BEL9qs0r0G0Boy2CztgYqK/HU8axg
         RZUMbkBFV8fhQWz18pS6FwiPcpRi2C3lx1xsq76ME4tJIoIq/23wKNSw/yla2J77nNXd
         qqYiiwdbVOHs2zyaSbALTawZihHCxzTq5IFcpXT1Q6Pt0d49Y9CfTKiMhqyzTy91U32v
         tyOjK3x0nYI/aS5X0rQEmEocBAkTwZeFCZKNp/KDppYIXzXcN9cgm1Vpfgq2mtOu3Q7K
         qPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kaPuV4QeaPOgBS5KpMFoLQOvshqKxuzG67jCzUS9Y1Y=;
        b=QiHHSoKp5e98J+sbCwXi8yV76iOxeXGH0Y/xzY3C2XXB1GK81ejciRGBHkHrHcnO5t
         6a0MCYSabg7fWcC8iGa3Tlz3gBH6chzTmjXN6sGIyhbdR7apxAMW5fx8z0/ecgmO3JF7
         Vy6IVjY3RO+X7Nq2mqkNu6P1BmEreEJccUBoktum7M4cqMDaLFD/NkTzK8YQc8D8IZYl
         kIsiIMKAF48NdgDmmCgeAFqzVWPbGC3Kl1MQ93IsKNXWLLVpL63sNOkGCbhLZvVORU5F
         5B+va7bbiDAPxVeBQAJnhNMRC4JClAjvcbaYE2OSDTLPRrW6HlQt7Dvpor82aj6Bh0sM
         V8hw==
X-Gm-Message-State: AGi0PubmIOTgWv01EFbv+r37F7wkMNMRZ41Mtqvqb6aY1mV96cyVGTGf
        b6RhzY2eu2yREgAjJNaRIGFTYNxSsrAX
X-Google-Smtp-Source: APiQypJXJ/2ea57hphP/4ScjpQLK7GQGVBjHVbaelmREdAvsrj4EtURAHdwq93MLmPzwdCaEw8LgxmqvWhxd
X-Received: by 2002:a25:9707:: with SMTP id d7mr5213507ybo.336.1588354429803;
 Fri, 01 May 2020 10:33:49 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:28 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-8-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 07/12] perf expr: debug lex if debugging yacc
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

Only effects parser debugging (disabled by default). Enables displaying
'--accepting rule at line .. ("...").

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index aa631e37ad1e..8b4ce704a68d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -45,6 +45,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 
 #ifdef PARSER_DEBUG
 	expr_debug = 1;
+	expr_set_debug(1, scanner);
 #endif
 
 	ret = expr_parse(val, ctx, scanner);
-- 
2.26.2.526.g744177e7f7-goog

