Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A9DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90E521D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NDCrCoAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgIJD1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgIJD0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:26:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 20:26:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t127so4121141ybf.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 20:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=W0rChnPqNSNQDFGEVqMxvWAcydmR3hcrHf+MA3EENZo=;
        b=NDCrCoAOOFRQd9QMP6oeo5D/YSJmGJ9qZRBlmP/ovRtzqr+VCBrGuN0Hk6EKwHssSe
         EvH+GErYfxq/WfqA8sLdzI5NCoOBOPM45+IIb+mLhlB4k1tcs9ZBZ5EVgqOScTBDokcB
         /ZwUVQM6ynrIj8OUF2iysx/SZyCiC6t2rflon6uPChntCiPXHGzVvtdCveHUx9fYBzHt
         VrKXbfctPCM0Emmmh6kAYugjFDU2uzP/Ax1AtsCB7mRUItw6aD+2Ntzk6hkO7izvq81I
         zpdW1e4KJr1/hfevujiDxTsIkeT5sZ8B043/pE8K+m7mzmGwrCJOJuUSW1dvQHXBzM4J
         x0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=W0rChnPqNSNQDFGEVqMxvWAcydmR3hcrHf+MA3EENZo=;
        b=aHV0GWYhN2jWu+bLa12lpRYUu0ZMRUUqdTL3KAjTR5vN8qX1lyLYYE/gqf6F9AyDzn
         KOoXVB+TUzrBJ83bAxrnjP43RZIbPQTgwSGDBRtFyNlMhsteQH5Oje1KDgGIceLAwALl
         hBLmdDDJFiIqC6qalc4yZd4ljp6oui5oN2NqelKvo7RulBl9vGrVrldyLHwixfrKkVlE
         R+nIFpQvCZcPNpYFwFLB4je7mQIeQG+gOmCyH12VInyDsJOsHNshGmJhl251ZbWUvVuM
         JrRoprNXKgKroy6RLSklfpdwH3yhOqUh/vsFHjzxq7Nz2ryDc6NbJdLhtTUY+NrN6SsN
         6r2A==
X-Gm-Message-State: AOAM5305+QDPxF8y9XJdnywfFAtmTm5CNddMoGnb8ITYaNkhtdvTXTWm
        pxrVqIxieltmxXWz3izWV8CZ2OKvvs2A
X-Google-Smtp-Source: ABdhPJxxSO48kT0YRv9fnwNdNWKA1Z9ftioz9tYsiuZ2ElBZPH7BTX3LV8OENek4PCyZKr4VWt9kLySJh9Jk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:c50b:: with SMTP id
 v11mr9880975ybe.426.1599708396451; Wed, 09 Sep 2020 20:26:36 -0700 (PDT)
Date:   Wed,  9 Sep 2020 20:26:30 -0700
Message-Id: <20200910032632.511566-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 1/3] perf stat: Remove dead code
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to set os.evsel twice.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 493ec372fdec..4b57c0c07632 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -946,7 +946,6 @@ static void print_metric_headers(struct perf_stat_config *config,
 		out.print_metric = print_metric_header;
 		out.new_line = new_line_metric;
 		out.force_header = true;
-		os.evsel = counter;
 		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
-- 
2.28.0.526.ge36021eeef-goog

