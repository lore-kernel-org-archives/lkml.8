Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D8C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5763320718
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdh31nLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgEMG2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgEMG15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:27:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA305C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:27:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s8so18528762ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CcMpTPZtggrH4tdyeVIIN7j0y8jhk+wku/Lim8bW6KI=;
        b=tdh31nLyzVQq1kLOE0FQ12W7/zIg1okQELIkAXCPvY1p2yLSbqE3SNfH0lMhLC0BIW
         upV24cNi1jvHm4OThcT24WRXQvqVDP+crDGPZVJfkUGxxPTDCuJoHKGdMuTd7/B15gkk
         LrMWn2A0qKdHYEGWnYBFpe2TnS/pHTLr5m5fJ1x2NPFxWa8bfJgfD09S3aiTooicLGys
         nKWSb7eudcraKiqc0lCna4T7H3G469BUqqOxSykL2fLI4aRrED1802k+0YW1geS3s5jm
         fy6SojBNo1l56jPrAYoxyIDc9sBRSifttZJKdN8Qkyd0MNDtxZxsaaVYP9k/O3i/bXVW
         hVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CcMpTPZtggrH4tdyeVIIN7j0y8jhk+wku/Lim8bW6KI=;
        b=jzsrStpoJTcVkdvAPab1y7+yK7kSROXfnxi+X8GT6mQ+lcEakpcQldoHxsfPf5Zom2
         50s0x3h2ObrOGr25OVD+qUzm/6HBPVUirsixrNvTz/rpYqPGcBa0lbqqY5dl8boLgt6X
         0LjGRCco04y+SVfNcOslvzj1tCr+Ti3jTkIgkq/PVba0y2n1Tyes/8zwSHYKTYqegg/+
         JPOBFnf06Ndj4OZOItvFUPjHCQD7fF9UVjvev00DPWIGmyJ8EMLoCWDb6UYunHTCA4yz
         EtKn2/zLDSBFmfynsatThTKyDkX/moVa+WvZ/nTkTFbPkFsvcOacKnsamPrIEnyEU5iK
         FtCw==
X-Gm-Message-State: AGi0PubspMKVvrG+3+gRDBiniYusyNep2ehEt/1yNdf6rM2+J1R9VDGF
        cOwaO7kLD5+KkwSZRk3Ct6HZ5/khC75D
X-Google-Smtp-Source: APiQypJ49xsSZCxasORUAGf3qnEXiLG29xkqytkgSb4bejHzbIbWH8sKjCYIy1fe+h8WSZ2Ts92UlngzeyQS
X-Received: by 2002:a25:3855:: with SMTP id f82mr39804007yba.212.1589351276975;
 Tue, 12 May 2020 23:27:56 -0700 (PDT)
Date:   Tue, 12 May 2020 23:27:51 -0700
Message-Id: <20200513062752.3681-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v2 1/2] perf expr: Test parsing of floating point numbers
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
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test for fix in:
commit 5741da3dee4c ("perf expr: Parse numbers as doubles")

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index f9e8e5628836..3f742612776a 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -39,6 +39,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	ret |= test(&ctx, "min(1,2) + 1", 2);
 	ret |= test(&ctx, "max(1,2) + 1", 3);
 	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
+	ret |= test(&ctx, "1.1 + 2.1", 3.2);
 
 	if (ret)
 		return ret;
-- 
2.26.2.645.ge9eca65c58-goog

