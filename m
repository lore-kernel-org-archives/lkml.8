Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A570C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C38A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cS481nZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGOCGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOCGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:06:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:06:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm21so1302674pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BWe0eEqZlg5KtSwKDX8dzWYLdIuFkfJ6SNclopNBxM4=;
        b=cS481nZ8/3HVzld0YdIzWieqhAS+5a+P/1/6y2CDxpjrr2uEmRvRLWK+yj+evifIdc
         /AQ3xdfPdgLCAe/oav8qqHhWmSr9Dj52DxEayP9acPeRibhBjKQGHKq+raaOSYPCEI/2
         SedvXRdZ0vf2XkFdXpqA/fYZdxr2h299zO5Cz51iiymn+wsTRcv1Y677C16BYHxX7ek+
         M4xtKEpCBO6tN+B5w8ypoYhIf3RCchT8hL/QSxm2fkmDHDXijK4Bmpv4Sru5Y5Y3gN4L
         bBb4QQsrgr1oCub37rzRNo4yQCqNwWEqPg0G+WVGGRqHSydwwae8EiFpLFzlzwlAUi+t
         EwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=BWe0eEqZlg5KtSwKDX8dzWYLdIuFkfJ6SNclopNBxM4=;
        b=tRD6Gu8EQd6lGf7p2SpgGahGoTL3nEGwOEl3FXsXOCiI/9n+tdFeQvOHgR5HIe9hpN
         QcNyQHrEQOhSC91QeekeFU9hHbz3N+SvrU+hYEqfEcfHXqQurrx7uOGFHiXnQ23x7sEh
         cDGDzsiWHDAjdInqiPzd0ZydSlnf/Asx48e+EKuIuJ1pIN4SuXL/IbMdOtzsMrWPGLyj
         uQNX09vKosGOAtbKYXkLc98PVB89N9BwRZ6WMi+YrXtgiuMUb9JAqA1p+FtamWor/70w
         xiS/FrwlPvh+cnh43hHFS3U1vMYtoiLtmmu+9xnQH/83jx2at67cETCdexASfygPn5dV
         5DKg==
X-Gm-Message-State: AOAM533WbtrI6ljyxJVz8905u0I99ZH4h/fD7zTVdQ3UvPdpAejayJtw
        n9LuSijnLj85sxdolsHQeGNBVA==
X-Google-Smtp-Source: ABdhPJxcAQQNi6Qcy+NhhnvhF349xyBGbkOGhog3d/+wdL8gBWjrl4CsxqOiTM4TFRwDBkTeEA5Pcw==
X-Received: by 2002:a17:90a:a78b:: with SMTP id f11mr7261791pjq.42.1594778766537;
        Tue, 14 Jul 2020 19:06:06 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id y24sm364459pfp.217.2020.07.14.19.06.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:06:06 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: perf: Add cap_user_time_short
Date:   Wed, 15 Jul 2020 10:05:11 +0800
Message-Id: <20200715020512.20991-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715020512.20991-1-leo.yan@linaro.org>
References: <20200715020512.20991-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

This completes the ARM64 cap_user_time support.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/kernel/perf_event.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 76f6afd28b48..1e0f15305f67 100644
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
 		quot = rd->epoch_cyc >> rd->shift;
 		rem = rd->epoch_cyc & (((u64)1 << rd->shift) - 1);
@@ -1218,4 +1219,5 @@ void arch_perf_update_userpage(struct perf_event *event,
 	 */
 	userpg->cap_user_time = 1;
 	userpg->cap_user_time_zero = 1;
+	userpg->cap_user_time_short = 1;
 }
-- 
2.17.1

