Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0351DC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAE12084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYTg2umD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDVWEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgDVWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730C2C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:44 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u137so3399598pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OXZleKkWZzKKnBm05g6e7Gyf0CCs6T7oZwd1F3IVZx4=;
        b=cYTg2umDQWeLFwrsYb3qGNYLJE3TMAeXJn+l+sHhOql+YRciViqc9brBZDd1iqajR0
         Ws7+D4dooyfuwKytQAPColOWKkYcMTQDs0oniw/rtv4WK7PMwpd6pUnaqFci/n2+SzOk
         CmATRt7LOrKZb0/iAMPToCChGezAAeeYTa8ptYxDhV/TSX8nS1PXi+ndHrvvN4xwu26G
         fKJCRa+MSPhrxbL88kJAt3KkVAsAcvhireQwwx/TSw/ik2699UvHcS2LGi5raaWfYBrA
         UOEIa2lXSBoOaR/OpTVg9S9GPyNki3xMMa3ewe3HTDCy8Y7QDTkJLDgMkze6c32TzQ8/
         TV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OXZleKkWZzKKnBm05g6e7Gyf0CCs6T7oZwd1F3IVZx4=;
        b=G4uL2K6HsFXnDJVGofbo4MWPsGmkbsv+EgcQCiVWvqHyEtp6i8T6QqhTnVY91KmsH0
         sUkjaCJzKyh/UiK4ZPhyHU8K4vCMQmBMn9yhwHyIk3QFKTsjnXP0JGaa8CUa0M8jtMkQ
         EragUaKMDrNFgqCsBztYDb5dhlKF8GbxN5sFscsW/YjEtnBa44X1d/k3XFlUFpTocvTq
         gludJAi3V9R9vugYX9BjOBQbXeDvxlt8z9vPTPi+ojf6X+juXYp6gAspy5L/Pkqa50BJ
         QHY1FyPxC/VepPHync1zmy/uJRP9JYrHqg3HFmkm5qXgna9yw3RIu2uB8THEZ5u8QIDd
         P+MA==
X-Gm-Message-State: AGi0PuZw8a8sGMccYK4D3EDk5maUVgvrOXc8F8tyWVVpgGUeKgkEzQlF
        vDm6vwZiE0Q+qUJHfR+fTisdAuH2gW41
X-Google-Smtp-Source: APiQypJhYEQke2Fp8ch2ZkmcZtiJ6fOz+khTT8e6JIhgqSawBO+CQmZC2zvuKDljcojdurFZy2IEJhDhKON3
X-Received: by 2002:a17:90a:a113:: with SMTP id s19mr895836pjp.161.1587593083819;
 Wed, 22 Apr 2020 15:04:43 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:23 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-5-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 04/11] perf expr: allow ',' to be an other token
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

Corrects parse errors in expr__find_other of expressions with min.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index cd17486c1c5d..54260094b947 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -80,7 +80,7 @@ other: ID
 	ctx->ids[ctx->num_ids++].name = $1;
 }
 |
-MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')'
+MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
 
 
 all_expr: if_expr			{ *final_val = $1; }
-- 
2.26.2.303.gf8c07b1a785-goog

