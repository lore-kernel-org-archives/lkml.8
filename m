Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E164CC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB929206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAkdfDRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEMGWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgEMGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:22:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B219C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:22:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 132so13905856ybc.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CcMpTPZtggrH4tdyeVIIN7j0y8jhk+wku/Lim8bW6KI=;
        b=BAkdfDRzjGEanTQJjvCGHRvoyXQJ11Fh9sEO6Ofi/KVuxLHoOhu5TLiqtMPQXnukRk
         2v7jXHzAB1xY92Fj/E4Z3hHD++QYburnCcL3WxavIdek+rGVlW9ShTE4GAPA4OljlMWS
         SEUIIqVRe/cacT7NRfYiDpkdIfAq/JBYqJERgFtUib2/m1zmps5KTC8O4AD/Il4oz8Lu
         Rzh78KyKTvvA13lazlyKCafHVCT315hagmGBOfh3DagMQeZeawcUEK/Su4RtKDbvknDh
         2IH0KF/w5mO/EcnMpmIii8/Q1TD0qvxMNPn8bn4xIyA6tqUuhMcqI8mZ7xhoNBkelZHZ
         BBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CcMpTPZtggrH4tdyeVIIN7j0y8jhk+wku/Lim8bW6KI=;
        b=NKLInIVA3DyK3DjpUXOEEyQrzu7JiOa2boEh57mOF8kZpLs2Xu/PIa0Le21X3NuCO/
         DDp8DJZR+RTVXmmtbf6pG5XChAcmjgEDrlkBsDXDppq39iVtmV32+vt4BMjSZAzBf+fl
         6GZuOkB/MQ2rdCEsbzm4rRs2LGuJhmpUOlAMC61lrZFD1UI9aaDvtkkWxZomAD36b4rt
         45cdOLad+cyzilHkndoxmNAb6Buz1lSOGjtOJisTfAwpfqQrTrF1ug4+fmCsKcHQRCV1
         Y3hCnfbWqZjJR2RmU8I9jqGnueETPMNDxG2Y67iQbYS0T03hLbgzqLjqKWSu4ZPMyHy6
         1xJg==
X-Gm-Message-State: AOAM531kNDsRCVikCbNyHl5AMQJctfez3wPO1KPeh4da2na3iyfTrMYy
        hkcx/f/JMWA3u1hXTaZUhsDWwy2A0MTF
X-Google-Smtp-Source: ABdhPJymZi6+8CM18gnr4u+yB/eJc34JkqRvqr6ocOAQsy0OqwwS0RjhTxdgIUAkUEbBD4TnsNgzPkgDUiVQ
X-Received: by 2002:a25:b908:: with SMTP id x8mr14807534ybj.258.1589350959599;
 Tue, 12 May 2020 23:22:39 -0700 (PDT)
Date:   Tue, 12 May 2020 23:22:35 -0700
Message-Id: <20200513062236.854-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 1/2] perf expr: Test parsing of floating point numbers
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

