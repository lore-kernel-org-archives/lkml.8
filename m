Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD770C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F3F20678
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOm8HnDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgHKFf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgHKFf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:35:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C77AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:35:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so6174699pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=244GqzY4/oX3NlWeCdM9jADJQeGD2iomYA6mMwXvC1k=;
        b=TOm8HnDEYZxlXlH1umxFQbPTo9m/L/9vMgEGFGU0t+vcR/PERV/t6+0lVphpXoqOql
         JZWl7z5I8Zk+/2XObpjxNu115hGuOJS2GdE4PDj0zXcpcVcAdG3DRgnh/63vQ+UmQO08
         6mb+iDT3u/0V9z5uyUjKTxCvVzolESUqIVk2VK/qTyBlLjmJ18a8SaydaxMQ83Hf0Z/e
         Cveikn9nlGAEmxnaXsTdZoTfn6HUxpoAmr2AQgG6xvKiJBX9FMRiLxZgIulO5O4tN3EF
         jItngCeDk6LwiftHO3WTqcWI8/VZ/Ba5SOIv2LSPi8O2TvGzd/jo5FYvI/E7ecaVjApz
         3GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=244GqzY4/oX3NlWeCdM9jADJQeGD2iomYA6mMwXvC1k=;
        b=BvSgnb9kSyXYJ6/Buh7phD/H466MFpNd0WuOjieevPqEfFNhQmzq2GbguT5WItLFEk
         zR7DJeAlgguu1Um2co+tgl2Z3kw2PN8adPSnFn05ZS1GOtvEnb8hRFzxLudV8Y2ptHF2
         MVufDcMMmW4O3Zu23A3NLMcGQzBDE8oNaNaC3IbO8TV3nxK23+Tsa+0Bw/TEKj0R+O+M
         msryeygNHM577ZvVKBE8Hu6UZuwzI+oI/4WRE85QI/vHVwmH404+cfsEGm2rhsUxM0pK
         CKiBl4eb2+3VHytfo9e9OmfxiCTDOdck+PnJr4Q5c7KzecduZ7VlQjcASJk2TE68QBVM
         p6UQ==
X-Gm-Message-State: AOAM532QGKuTnHTVUG7LvTup7zBxgsylxpGsmi/sCM4mm/xK96wxLgjc
        KMZyXIp+0PczugesFksMm1ky+g==
X-Google-Smtp-Source: ABdhPJzlUZErYDsrPhJG4ps7cBUwZqefZ/4PfhqeW7JXeCSe9O0FxZt3vZkYTRyeavR1/9EnPvyYmw==
X-Received: by 2002:a63:6fc7:: with SMTP id k190mr24442812pgc.54.1597124126881;
        Mon, 10 Aug 2020 22:35:26 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l62sm1324921pjb.7.2020.08.10.22.35.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 22:35:26 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] arm64: perf: Add general hardware LLC events for PMUv3
Date:   Tue, 11 Aug 2020 13:35:05 +0800
Message-Id: <20200811053505.21223-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add the general hardware last level cache (LLC) events
for PMUv3: one event is for LLC access and another is for LLC miss.

With this change, perf tool can support last level cache profiling,
below is an example to demonstrate the usage on Arm64:

  $ perf stat -e LLC-load-misses -e LLC-loads -- \
	  perf bench mem memcpy -s 1024MB -l 100 -f default

  [...]

    Performance counter stats for 'perf bench mem memcpy -s 1024MB -l 100 -f default':

        35,534,262      LLC-load-misses           #    2.16% of all LL-cache hits
     1,643,946,443      LLC-loads

  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 462f9a9cc44b..86e2328b0c2e 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -69,6 +69,9 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL,
 	[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB,
 
+	[C(LL)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS_RD,
+	[C(LL)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_LL_CACHE_RD,
+
 	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_BR_PRED,
 	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 };
-- 
2.17.1

