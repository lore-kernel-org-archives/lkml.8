Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37827C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080A4207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krIWOXFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGPFMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:12:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F736C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so3368518plk.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9SuwXG5wYWJjKAU5flve9nJ1dK7+MJYoWmtIlrptV4I=;
        b=krIWOXFgIeM3ecJz/r74xx6HpdmDjHKKU8d9VmYrCjaWOM76YlH8WKFVtDlhMXxJCV
         N1kshlioH70saQvzgIiD65BamQnO4wxV8dDroEHJx9BpV+u3dPt5Gx3L6SX3Zb9r80Ab
         b3GJ3j7tjwTDQm7q7A1ZYBHDKzhZwJSCyIiegcXYthgzta8sT+dPfBYyVprpkKjzm4GS
         nPO1b6tGOKS+ihfG4Sc58vMmdbRyqxsjsIouW60F8Fn1zkuEeqVBkVLqIB5Dw0jMBmeh
         nmz3G6ZdO12uxRk1zXHRxurZueMzMS5BkuJ3HkkwYGk3dtWmbExR1yxyOccsZSUwptA/
         ckDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9SuwXG5wYWJjKAU5flve9nJ1dK7+MJYoWmtIlrptV4I=;
        b=mmn99omYAeSdzAvnMFsoKj/QrEt/G6+6x++NTz1cHUdyrnMBTENI6eOZY5hMCslRrA
         EPaXgN4a+0aKXSUd2BAbCi5YclGe4N/I5ybfYpSGGGIst8xGy7llrjF/NJqolEpFpcJE
         oK8kv/LdKJLQ2A1NQ7tg/bsd09n5TxFXRk3tzg5+ftQ9/CB8BMsYSyuAGy309NAOwrJ0
         Xes+CfqSh6w5SwPgohUTBrixGsKrG+280wgt44vBP009YJFkJGH8U0wVpeEh3w65ydW2
         J4l8gI9huDI8DfuW/Q5ojMakpiEAibG+tyV6VjxJA7UZu1OB8V5fj7TM2u+K7toORaVU
         ga9A==
X-Gm-Message-State: AOAM530kzf+ut2+0f47yeQxMtxWGgUoxvP4GXgYNzJdfTK55JCXg9iIG
        I+iptSFD718i8MvQlUVyl9+1Rw==
X-Google-Smtp-Source: ABdhPJzOQxiFHywkTQOU5cdSK+Q4FRgeK3RFG1TxHSXZ1LJrkJiq2mpEHfQHBWxgWjUYdMVODsOS/g==
X-Received: by 2002:a17:90b:4b12:: with SMTP id lx18mr3346143pjb.156.1594876364801;
        Wed, 15 Jul 2020 22:12:44 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id n25sm3525709pff.51.2020.07.15.22.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:12:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 6/7] arm64: perf: Add cap_user_time_short
Date:   Thu, 16 Jul 2020 13:11:29 +0800
Message-Id: <20200716051130.4359-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716051130.4359-1-leo.yan@linaro.org>
References: <20200716051130.4359-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

This completes the ARM64 cap_user_time support.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index c016b116ae33..888bcb5d1388 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1174,6 +1174,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
+	userpg->cap_user_time_short = 0;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
@@ -1184,13 +1185,13 @@ void arch_perf_update_userpage(struct perf_event *event,
 		userpg->time_mult = rd->mult;
 		userpg->time_shift = rd->shift;
 		userpg->time_zero = rd->epoch_ns;
+		userpg->time_cycles = rd->epoch_cyc;
+		userpg->time_mask = rd->sched_clock_mask;
 
 		/*
-		 * This isn't strictly correct, the ARM64 counter can be
-		 * 'short' and then we get funnies when it wraps. The correct
-		 * thing would be to extend the perf ABI with a cycle and mask
-		 * value, but because wrapping on ARM64 is very rare in
-		 * practise this 'works'.
+		 * Subtract the cycle base, such that software that
+		 * doesn't know about cap_user_time_short still 'works'
+		 * assuming no wraps.
 		 */
 		ns = mul_u64_u32_shr(rd->epoch_cyc, rd->mult, rd->shift);
 		userpg->time_zero -= ns;
@@ -1216,4 +1217,5 @@ void arch_perf_update_userpage(struct perf_event *event,
 	 */
 	userpg->cap_user_time = 1;
 	userpg->cap_user_time_zero = 1;
+	userpg->cap_user_time_short = 1;
 }
-- 
2.17.1

