Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B01C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906D320663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUR6Lc3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGOCFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOCFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:05:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so1168741pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7/Gfwk+DS7GBHyMfJAg29h1M+nONHVWzDeqMwBHi0xE=;
        b=YUR6Lc3G6i0FvqSkKps61Lmea72qgGLz3WCUuMsu2AhhimxaJdhtNLl8AyP9aFXJ0I
         1QZtqBY4iFk7eUDQlJWcEQPDnmJtPlcCeUiDxkXfre5ORokCj2KlDwuXTXPNTQXeyMoF
         jl1ucKXQAqSHcmpIyyBB65pDXgY3cyAdDnVwvbj7su/I6kzfeC5a1sQhgr0iAkgSn5A4
         UyYfMOBdOo5qlgqpw+8WAKzmr3DOx4VybjG0hVA3K3vYbsQ5D42BOuN/MOZzkKT5QEq/
         7uUJQyXcSawVxdRaz6phyOveay0PuxUZDU0jCg4B9b227FDPM8DAyKOfP5VXWLFyOh8/
         vnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7/Gfwk+DS7GBHyMfJAg29h1M+nONHVWzDeqMwBHi0xE=;
        b=P+CgGAl/vl18CNf1oDBctlw1bAZ9rRtUvY1IQeP6WadZRtcXmnckY5sCoHU26PvyPl
         ZIzrER/XLvCNuQl57DuO5+IrnmI+Juee6vx064NEFwHYtH7yyIqKeXnH9exWGGC2Rtu/
         2XdrHqhsYguWJCWoq8WZvm9R5wgAbuWSMlSF0fSHt3wDTV5t5ZlpbwmbdzNySO3+BnSm
         RrNrHDVQjT65cdsh7ivvVhogtI205y6yVuE3ltV65Htu983Ep+OejtXq6Y3VRWJNpICI
         OMMJKtj9o/Xfo+moFxnteAmItOq9C4zUVfexckcNTNbdBnt9U/Pe7CjVaLvBZ3EJWxoZ
         9Osw==
X-Gm-Message-State: AOAM531JC0e2gjW04kEu3njvC3XTOGAXZtG1uh1LwE7XouGZiJx5mp6r
        OPX1k22YRY0bPKicyYfa11t3xw==
X-Google-Smtp-Source: ABdhPJwV/5lGCdOshqU/M3J8xvahpLeG8JkJAxdd84ZmMrsq1MKHsDo2FG1Jwtv9lwt07qLGKhqisA==
X-Received: by 2002:a65:6411:: with SMTP id a17mr3406498pgv.450.1594778750164;
        Tue, 14 Jul 2020 19:05:50 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id h15sm366740pfo.192.2020.07.14.19.05.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:05:49 -0700 (PDT)
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
Subject: [PATCH v2 3/6] arm64: perf: Only advertise cap_user_time for arch_timer
Date:   Wed, 15 Jul 2020 10:05:09 +0800
Message-Id: <20200715020512.20991-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715020512.20991-1-leo.yan@linaro.org>
References: <20200715020512.20991-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When sched_clock is running on anything other than arch_timer, don't
advertise cap_user_time*.

Requested-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/kernel/perf_event.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 35c2c737d4af..76f6afd28b48 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -13,6 +13,8 @@
 #include <asm/sysreg.h>
 #include <asm/virt.h>
 
+#include <clocksource/arm_arch_timer.h>
+
 #include <linux/acpi.h>
 #include <linux/clocksource.h>
 #include <linux/kvm_host.h>
@@ -1170,16 +1172,15 @@ void arch_perf_update_userpage(struct perf_event *event,
 	unsigned int seq;
 	u64 quot, rem, ns;
 
-	/*
-	 * Internal timekeeping for enabled/running/stopped times
-	 * is always computed with the sched_clock.
-	 */
-	userpg->cap_user_time = 1;
-	userpg->cap_user_time_zero = 1;
+	userpg->cap_user_time = 0;
+	userpg->cap_user_time_zero = 0;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
 
+		if (rd->read_sched_clock != arch_timer_read_counter)
+			return;
+
 		userpg->time_mult = rd->mult;
 		userpg->time_shift = rd->shift;
 		userpg->time_zero = rd->epoch_ns;
@@ -1211,4 +1212,10 @@ void arch_perf_update_userpage(struct perf_event *event,
 		userpg->time_mult >>= 1;
 	}
 
+	/*
+	 * Internal timekeeping for enabled/running/stopped times
+	 * is always computed with the sched_clock.
+	 */
+	userpg->cap_user_time = 1;
+	userpg->cap_user_time_zero = 1;
 }
-- 
2.17.1

