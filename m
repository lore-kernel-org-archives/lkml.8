Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E68C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB631206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ub0W/dvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgIDH1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:27:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD275C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 00:27:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gl3so1627542pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TgEt8H+NBD+F8URPekcdTaS5rZdyCM+EvxLWR30FOiA=;
        b=ub0W/dvoBg2zKUB/J4dDvyf19oZE3EkMDnRw4FZgPqqlPFLm1iQzIGfIB1DWfeO8fg
         Tin+64HGWfR4pM1VeZiYH8QnsfSSBb9bhDDdCk01easF3GYcf3/gI4EDyPuzhrLmN251
         tbiP3Hv++EwyBvIwIpqiMrkaGKsW8RyrFYAKUH596QftZuwk9KdVxIESSy0O1iu1EAKr
         PqXfM+v/AI5ZV0ZYDFcgVn5qk3dKUhmAIuFj87rmRIOAZQkWUUCi6ItuM9eyKUEEDcz5
         knYk12++G1ww/BE7Agqddk85UEZDzVK4Q6ZUtbctRIkLtsRbDuh+hRgrtW2T1ZyD/ihQ
         9ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TgEt8H+NBD+F8URPekcdTaS5rZdyCM+EvxLWR30FOiA=;
        b=pyF3QbU/2Io0zZEPr5zr+oRZwqRmurXIRECxYnzyZICGFTO4sNMSbRmJy5vKj0w4z7
         qOKk8XO9QkQHPSs3qX81H2e4mO695q+53E2jAKhBShQMpGF0kLrmhUn1oFHk7rewNJtF
         h8CG+NNWUq9iPG90HUAlzJY+gbRh0UheVqScSDy7lCHVCVV9bnOVjpF+nBA5dD4BeHkm
         7wHneSb8mFpqSGOOuooLveS2pevbPfrUKEKZHOZQil1x9wXFrbmFmHahj3hSJCZdmfnY
         vL/2zCjhwRTnckrovAoVg6V+jb3xvKZupdSXaJ8CHDgHzxsF8eZbFKDjkCAB7yRn4ncU
         WosA==
X-Gm-Message-State: AOAM532zMrPcNDqj+rImej6jgto0UWLXyYR8UdwXloDbHRJDAWPRTgtJ
        t2SpX47Xmqq8ZfQ+jS0HdJi6tw==
X-Google-Smtp-Source: ABdhPJyjjtV1valstzHz0BYLGZIfySHbd7ltGIEe28CxXX0EFcVviI7rTZ+13BEFAtXJ7L2f70f+NQ==
X-Received: by 2002:a17:902:e789:: with SMTP id cp9mr7492899plb.215.1599204417823;
        Fri, 04 Sep 2020 00:26:57 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.248])
        by smtp.gmail.com with ESMTPSA id bj2sm4540160pjb.20.2020.09.04.00.26.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 00:26:57 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, alexandru.elisei@arm.com,
        swboyd@chromium.org, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3] arm64: Enable perf events based hard lockup detector
Date:   Fri,  4 Sep 2020 12:56:37 +0530
Message-Id: <1599204397-17596-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent feature added to enable perf events to use pseudo NMIs
as interrupts on platforms which support GICv3 or later, its now been
possible to enable hard lockup detector (or NMI watchdog) on arm64
platforms. So enable corresponding support.

One thing to note here is that normally lockup detector is initialized
just after the early initcalls but PMU on arm64 comes up much later as
device_initcall(). So we need to re-initialize lockup detection once
PMU has been initialized.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
- Rebased to latest pmu NMI patch-set [1].
- Addressed misc. comments from Stephen.

[1] https://lkml.org/lkml/2020/8/19/671

Changes since RFC:
- Rebased on top of Alex's WIP-pmu-nmi branch.
- Add comment for safe max. CPU frequency.
- Misc. cleanup.

 arch/arm64/Kconfig             |  2 ++
 arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++++++++--
 drivers/perf/arm_pmu.c         |  9 +++++++++
 include/linux/perf/arm_pmu.h   |  2 ++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d23283..b5c2594 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -167,6 +167,8 @@ config ARM64
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 5bf2835..2fb5b60 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -23,6 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
+#include <linux/nmi.h>
+#include <linux/cpufreq.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
@@ -1221,10 +1223,21 @@ static struct platform_driver armv8_pmu_driver = {
 
 static int __init armv8_pmu_driver_init(void)
 {
+	int ret;
+
 	if (acpi_disabled)
-		return platform_driver_register(&armv8_pmu_driver);
+		ret = platform_driver_register(&armv8_pmu_driver);
 	else
-		return arm_pmu_acpi_probe(armv8_pmuv3_init);
+		ret = arm_pmu_acpi_probe(armv8_pmuv3_init);
+
+	/*
+	 * Try to re-initialize lockup detector after PMU init in
+	 * case PMU events are triggered via NMIs.
+	 */
+	if (arm_pmu_irq_is_nmi())
+		lockup_detector_init();
+
+	return ret;
 }
 device_initcall(armv8_pmu_driver_init)
 
@@ -1282,3 +1295,27 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_zero = 1;
 	userpg->cap_user_time_short = 1;
 }
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+/*
+ * Safe maximum CPU frequency in case a particular platform doesn't implement
+ * cpufreq driver. Although, architecture doesn't put any restrictions on
+ * maximum frequency but 5 GHz seems to be safe maximum given the available
+ * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
+ * hand, we can't make it much higher as it would lead to a large hard-lockup
+ * detection timeout on parts which are running slower (eg. 1GHz on
+ * Developerbox) and doesn't possess a cpufreq driver.
+ */
+#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long max_cpu_freq;
+
+	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
+	if (!max_cpu_freq)
+		max_cpu_freq = SAFE_MAX_CPU_FREQ;
+
+	return (u64)max_cpu_freq * watchdog_thresh;
+}
+#endif
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index dd9d7f6..2cd0f40 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -718,6 +718,15 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 	return per_cpu(hw_events->irq, cpu);
 }
 
+bool arm_pmu_irq_is_nmi(void)
+{
+	const struct pmu_irq_ops *irq_ops;
+
+	irq_ops = *this_cpu_ptr(&cpu_irq_ops);
+
+	return irq_ops == &pmunmi_ops || irq_ops == &percpu_pmunmi_ops;
+}
+
 /*
  * PMU hardware loses all context when a CPU goes offline.
  * When a CPU is hotplugged back in, since some hardware registers are
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 5b616dd..5765069 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -160,6 +160,8 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
 static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 #endif
 
+bool arm_pmu_irq_is_nmi(void);
+
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 struct arm_pmu *armpmu_alloc_atomic(void);
-- 
2.7.4

