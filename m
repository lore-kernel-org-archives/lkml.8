Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F76207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGADS/21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgETLMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:12:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9CC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:12:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x18so79194pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ijhEJD7IduE0U1E8AnSJDUXoqHR53bJuCE3Hju6nI0s=;
        b=aGADS/21PIt44tBDepA8z7JH39hjNazac7GxhdW+KNVWe0A3Hy/0c4bYlV9oSf3BvP
         LCgJNx3/hzoPEak3bXvFApjYrByfQNhAzTXG5QWGS0f9YWJQ/d5zIvHCql8pYNUeH5AB
         KwuWXI952vPjmL4r8O+gG2aHXkvWJj67H1moGsmx5H3+FDhMPIL4n8NFTGOiPj+uDX+P
         e7tbjJDHqLT/H61jYEE4EYXZCQLYRYrkiYnBD8YDRE0tRnAy8r/nOGBwUHcvbIPMWXDC
         JtFTEPl/aeX1mocEmBiGSRNvlcCmOhBfuctZV+oD7NuAApDIrmmWK7YDlqYAjPzUWdT+
         BN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ijhEJD7IduE0U1E8AnSJDUXoqHR53bJuCE3Hju6nI0s=;
        b=sweZLCZjMxV5JbKSZO0e9GPqs8CcJdtJ/tV8L378Wr4kQ+nJ0tPZD8qHK+VWK6JDAu
         LYahPmPcHkqsB+4ULfKnbZAWOZgvpJWP4luZpR8kxHmIFlsRXyg23sWiUrVobr27sjV+
         jQAWowi8chQfj9ReVDwFPw30gvpOKuQhiftaKiGbrGTKeEW2uUvUpBO7LF5dJn8WYjVR
         b4cIFIOS84oGIrkxC8hYfaMPo+iaOZSRjbdUpdWli0FeEprAvzUvBFnI0jEYAqgJptON
         C7Y9IIRVQ/fyOjCM/8ym9eRgPR1ON2J0NT7e4XtIt0FEJ+iQ9TqGVkcKCST/cAMH+6Vx
         Sw3A==
X-Gm-Message-State: AOAM531A1K59W+6w6GXF930l26/xI52gsE0okNfWpkU7pPwkMJl/Rkhc
        I3/KAm2HgaPpV8rlj5vilv5DHw==
X-Google-Smtp-Source: ABdhPJzNvSwUoGbq89C1ybvRuntAvjJr6uSw+V7BIYsslChvoR7r5VHqx1MN7bVP2u8IX7evwU3kkg==
X-Received: by 2002:a17:90a:2325:: with SMTP id f34mr4619400pje.91.1589973169271;
        Wed, 20 May 2020 04:12:49 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id q134sm2044974pfc.143.2020.05.20.04.12.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 04:12:48 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 1/4] arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
Date:   Wed, 20 May 2020 16:41:52 +0530
Message-Id: <1589973115-14757-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
References: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new inter processor interrupt as IPI_CALL_NMI_FUNC that
can be invoked to run special handlers in NMI context. One such handler
example is kgdb_nmicallback() which is invoked in order to round up CPUs
to enter kgdb context.

As currently pseudo NMIs are supported on specific arm64 platforms which
incorporates GICv3 or later version of interrupt controller. In case a
particular platform doesn't support pseudo NMIs, IPI_CALL_NMI_FUNC will
act as a normal IPI which can still be used to invoke special handlers.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/include/asm/smp.h     |  1 +
 arch/arm64/kernel/smp.c          | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 87ad961..abaa23a 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,7 +13,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-#define NR_IPI	7
+#define NR_IPI	8
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index bec6ef0..b4602de 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -106,6 +106,7 @@ extern void secondary_entry(void);
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+extern void arch_send_call_nmi_func_ipi_mask(const struct cpumask *mask);
 
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d29823a..236784e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -81,7 +81,8 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	IPI_CALL_NMI_FUNC
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -802,6 +803,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
+	S(IPI_CALL_NMI_FUNC, "NMI function call interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
@@ -855,6 +857,11 @@ void arch_irq_work_raise(void)
 }
 #endif
 
+void arch_send_call_nmi_func_ipi_mask(const struct cpumask *mask)
+{
+	smp_cross_call(mask, IPI_CALL_NMI_FUNC);
+}
+
 static void local_cpu_stop(void)
 {
 	set_cpu_online(smp_processor_id(), false);
@@ -949,6 +956,10 @@ static void do_handle_IPI(int ipinr)
 		break;
 #endif
 
+	case IPI_CALL_NMI_FUNC:
+		/* nop, IPI handlers for special features can be added here. */
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
-- 
2.7.4

