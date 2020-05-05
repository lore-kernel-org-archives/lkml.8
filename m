Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A8C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA533206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7XU/uh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgEEN4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729213AbgEEN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:56:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A76C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:56:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so847614plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SUqpwl4dX7jj+lLGJIm4d2JPI0kCLiGuhtY6NV9FT/c=;
        b=L7XU/uh6V5tz6vktKYXmi/XwxORUtcF15+kxdkEn3S/K3YhYvAAdOTqTsOeyZl8P6o
         uVoCOooPY44m+si/AOD7EZ9wT6f/v6Gs9mZEHBRRmoGIkmLfdfv3zBoayQTR9iKM6AeC
         QcGboVdr61cK16ErRdrDxEWVSnLxHjr/F5B7VFxBmqja6YhoNOamBbs0e4LzVZ2B7u6m
         zl3YsK1Y36SLblwFRbESgqhZO/LEBiW+pmsXtyOfQ62dUjG7DbUJM8F92HrwgAjXXapS
         5PWzixm65+OyB4KkY4A3V2DYUSVRzgmb/VuJBfSdrj+3ktlPHT7scxVu7z15M2kxfueW
         5R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SUqpwl4dX7jj+lLGJIm4d2JPI0kCLiGuhtY6NV9FT/c=;
        b=nYqocSH5M190Gxf38tngHWCxJqjnyiGM2AXWzwsKnukVupuxGIrKEGYdEhdeJN3Z2g
         0iBRUzlgQjRfCaEf11I3R3/e3N7GVqMq+oxJt+RFErD/ocBeL3SHdxxaiRZodbU/v7r6
         DaIorZG8+1xXB07H1tjXd7DEf6UTn8oRXDYLB0e2lnIRMnokf0bxZEfpUF08G1BvGbv/
         R2fMlSIjJPsWdHuGGqDDI+SM3ocp/JmgrukoxPatfj9tz56s09mZnNVgizWDrop3y6RM
         0z41NjzG9aQhPdLqm7mq/YDpxtCNmTqoE9PxYsZIHpuBJLqA4NLP2wlhhLhZCw4+iEla
         erig==
X-Gm-Message-State: AGi0PubHp6OtTeWuJ44iUdv64vj9yT8fnNEi/+bJdTdufXwviGZihGnE
        AMHy+Blxx8ezBKO16i5FtYTQBQ==
X-Google-Smtp-Source: APiQypIQVZ59e8r8wEOVk5i2Y1mP2Z7kLyRUi51y3D4HDuLkwu7L/BYWmpDbtRn1Eg1F2AdjGnnhWA==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr3331870pls.144.1588686976387;
        Tue, 05 May 2020 06:56:16 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id z60sm2226453pjj.14.2020.05.05.06.56.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 06:56:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/3] clocksource/drivers/arm_arch_timer: Handle time offset prior to epoch
Date:   Tue,  5 May 2020 21:55:43 +0800
Message-Id: <20200505135544.6003-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505135544.6003-1-leo.yan@linaro.org>
References: <20200505135544.6003-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since arch timer can be enabled at any time during boot, this patch
changes to invoke variant sched_clock_register_epoch() so it can
retrieve time offset prior to epoch (in nanosecond).

Arch timer driver doesn't directly use this time offset, but it needs to
pass this value to Perf framework to allow Perf tool to use it for
timestamp calibration.  For this purpose, this patch introduces an API
arch_timer_get_epoch_offset() which returns the time offset for arch
timer's counter.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 10 +++++++++-
 include/clocksource/arm_arch_timer.h |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2204a444e801..10d0b15a7674 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -78,6 +78,8 @@ static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
 
+static u64 epoch_offset;
+
 static int __init early_evtstrm_cfg(char *buf)
 {
 	return strtobool(buf, &evtstrm_enable);
@@ -942,6 +944,11 @@ u32 arch_timer_get_rate(void)
 	return arch_timer_rate;
 }
 
+u64 arch_timer_get_epoch_offset(void)
+{
+	return epoch_offset;
+}
+
 bool arch_timer_evtstrm_available(void)
 {
 	/*
@@ -1009,7 +1016,8 @@ static void __init arch_counter_register(unsigned type)
 			 &cyclecounter, start_count);
 
 	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register_epoch(arch_timer_read_counter, 56,
+				   arch_timer_rate, &epoch_offset);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 1d68d5613dae..a566e82a40ba 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -83,6 +83,7 @@ struct arch_timer_mem {
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
+extern u64 arch_timer_get_epoch_offset(void);
 extern u64 (*arch_timer_read_counter)(void);
 extern struct arch_timer_kvm_info *arch_timer_get_kvm_info(void);
 extern bool arch_timer_evtstrm_available(void);
@@ -94,6 +95,11 @@ static inline u32 arch_timer_get_rate(void)
 	return 0;
 }
 
+static inline u64 arch_timer_get_epoch_offset(void)
+{
+	return 0;
+}
+
 static inline u64 arch_timer_read_counter(void)
 {
 	return 0;
-- 
2.17.1

