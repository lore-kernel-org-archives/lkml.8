Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BDC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0455620776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YVByvnPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgDXLLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:11:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42EC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id ay1so3630502plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKk8wf3cz8RUWzn1IoJAXdPdtXtapZhuXqAKZvlxhk0=;
        b=YVByvnPda4cATjn80837BpLybRu1ueTExKc+WHBVax5RorJ+ZNuwn2MuexnHp4cYo5
         pJSZ9w7zONizNG7Z3GdcKH+Tkhn25h8TR9XHtivZtX1CpbXpXvI867BueiUOFBq9kLNZ
         KvqEdfylxYMdXjK11Cje/hpe6RxW7SkgNCglD4qg+8esQ0DGRN1unACq9B/XSrSjvNe/
         U+Gs2Tw/SQUjHpha+1570GDCr8HtTa+kiYHbNnrfrd8ZE7Tvhm3n3vodJ2Mcm89E3GwA
         /Yg4yBEGGmx3zLlYG2FU4efb942GYE84eO8krDcE4jT0MmEvsksbti+duvjQPCEo+yUl
         fsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKk8wf3cz8RUWzn1IoJAXdPdtXtapZhuXqAKZvlxhk0=;
        b=UB4uRRMmGxwSF2uYuyrAS5SUQ3wjL+VSW8trEnOhXT/foMwA4xuLqUr0awD7AZChTk
         jGfw5U1j826UJw2bY5/wTElVG+nV6fFzcM7mrytUUK1iXZ3TonhO5XtG4J5wMvNTYX09
         y3IFB/SkJKDpYWnMVX1pmBzv9ulPQwZFJz6NaLYC0RRTZKROEI1ybff4LdAhrabX8k9E
         XcTYSvdtgDUtcn6z94jd23qkKsxnwU4L53JKVIGd8gQYnGs5NEL9ubGYhCIbx9b84KMh
         kLeOW75fPuIxT8/XrzEOq1sb4RRJR7B9VcVnawx2L7cMT3biXmBKCNa++rIu5/nz9lWp
         c+Gg==
X-Gm-Message-State: AGi0PuZEztgOUGiqIgmb1oWBunc04+tdpIAHP5VgEV4MMUHMf9gsfrGa
        P99NRoMm9FI+B7DDv15sArpotg==
X-Google-Smtp-Source: APiQypJ3GgW9Pqsjfrzr6QtP90j+8rGXoeLfM9QDDeJW24ES89o3cFiti2XOv8eDeWoqo/y4W3Qbew==
X-Received: by 2002:a17:90a:c702:: with SMTP id o2mr5618006pjt.196.1587726689928;
        Fri, 24 Apr 2020 04:11:29 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.186])
        by smtp.gmail.com with ESMTPSA id o11sm4637628pgd.58.2020.04.24.04.11.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 04:11:29 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC Patch v1 1/4] arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
Date:   Fri, 24 Apr 2020 16:39:11 +0530
Message-Id: <1587726554-32018-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
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
 arch/arm64/kernel/smp.c          | 20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

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
index 40d5ba0..cc32776 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -108,6 +108,7 @@ extern void secondary_entry(void);
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+extern void arch_send_call_nmi_func_ipi_mask(const struct cpumask *mask);
 
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 061f60f..42fe7bb 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -74,7 +74,8 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	IPI_CALL_NMI_FUNC
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -798,6 +799,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
+	S(IPI_CALL_NMI_FUNC, "NMI function call interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -856,6 +858,11 @@ void arch_irq_work_raise(void)
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
@@ -960,6 +967,17 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 #endif
 
+	case IPI_CALL_NMI_FUNC:
+		/* Handle it as a normal interrupt if not in NMI context */
+		if (!in_nmi())
+			irq_enter();
+
+		/* nop, IPI handlers for special features can be added here. */
+
+		if (!in_nmi())
+			irq_exit();
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
-- 
2.7.4

