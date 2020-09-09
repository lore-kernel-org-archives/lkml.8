Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B386AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FDD208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qkz6+9/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIIIDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:02:26 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6CC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:02:25 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z27so1274978qtu.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=W0rChnPqNSNQDFGEVqMxvWAcydmR3hcrHf+MA3EENZo=;
        b=qkz6+9/SBfdHXX9zIzflh6PsiLjrhxrlBAiT8foAqbbElqlKdZZF18tG1XgW7TE+un
         KLMosMACA3E6qIoL4URMgo0D2xY0TPUB02oc4GtKtUpmr6fkeVypcgX72b/cLyKvRCg0
         CGtrlsJCofgDnYvBWg52Zv2DOxbGAAan0Gs5NgGMVFe1i4WNDVX0tJf8GocuIdgfTu/d
         7BE7A9JvCM5Uh+C2nQOFGcHa/VakRuzn6oxbaYQ4Y/GnnPTKmnNfKYWIBWwJoizMDMjt
         D6iZoyMr7XUD9yBYG/yfEEujjEUMCphTspwNmrvmJoJpaTLh0XZcewBvjHRcbydU4InW
         8+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=W0rChnPqNSNQDFGEVqMxvWAcydmR3hcrHf+MA3EENZo=;
        b=SPASHTVRlbgK+QQCSaeYd4rauAbG03VfgtT/LuI4axRAC/dDsBH3dMhd0CN9zAGiKZ
         dxZUBdpVhL/iWSzKpNAp8H66sbJyzZ/pnkvSOkzf5cY3vHnSwFGJFEJ6WXyeSJJsRVGc
         KzjHnBNA40x6hBl7rx5/8zKH8W22xkOnHcV8s00nPIyNeEdYti9+E3AlwFqyRwUhQTnS
         OWh5PUyK0lcPoWw9n+5ulB168d5558aPs6oRA1XES1saUKUshZ1JNYNCqHINhFVhshwz
         5wpI1pbf3v/AAGrkdQe3HJGZAt1wpx0mWKiZbTuXkLf1PXx+hUEVGaDuBw4WvTanlFU7
         HAAg==
X-Gm-Message-State: AOAM5335tJ4cisc2kq8TVqe13sLxams6KrUxwogGBwqT6r8hE9GvwEBK
        S2ewQnOh3Zb0V2K2VrI2VpZ8xCZorYYl
X-Google-Smtp-Source: ABdhPJxLo8+PxuRam+6BH08bxyFrmddv9d85szADHh4VNrC6TTuLedcOZ0viK9bnFuAREfUi7isBvjwEPNVI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:ad4:56a6:: with SMTP id
 bd6mr2930809qvb.22.1599638544886; Wed, 09 Sep 2020 01:02:24 -0700 (PDT)
Date:   Wed,  9 Sep 2020 01:02:18 -0700
Message-Id: <20200909080220.254585-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 1/3] perf stat: Remove dead code
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
        Hongbo Yao <yaohongbo@huawei.com>,
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

