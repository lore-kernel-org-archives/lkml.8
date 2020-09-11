Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9055FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46077208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuQDuBTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgIKQWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgIKP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72911C061799
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b17so1713540pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UMF4bf/xlX5iMhhFdvv4POZJxLXNJMbFMY0/ylfkgBU=;
        b=EuQDuBTvOvwLK210071x8IREFokQkgZaord4oFCyWIF92/r5O+/EHGVhTZB7Xa3ZYA
         O6Y2+67Gs5ian2S/VK+fTAa2hAr+hTP0YsK989soxdqSat1sWOjtSlXx5AUdQdheN/r7
         l+FNLv+QNEE9hzRIazVRwnfqsbKvqZLqCiwKBW/iegqkTtCcFFxV4oK/Aay+X8OFVNwt
         ea7F6VWqHxZ4ol/1WXrJ5YTrlZSyygzFH08zKGn8NikhCkP2wRHgnIytnzENhf+9t8q5
         EeOBCzZuDaOq0opR7A5YOpMF84iYa5OGzmk8Wn8tzIGeF3MAZphGwwlyFNNa9ikyVoXk
         rKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UMF4bf/xlX5iMhhFdvv4POZJxLXNJMbFMY0/ylfkgBU=;
        b=hZoxVkyWg+3+o88Pe/kpu+f5z8aH1nY2iX4MkCFuCeLLdNaJx+aQL4YBsG9OmQeMTb
         akofBzFNFPJ+1DBXBRGlwvnULtD3HZAjBeKyjFowpWewOoaUcOdk4bTzPo2BikwpgP1X
         lG8FOsHvI39Ag7ORZqvyW5s4HtmRsArrPvLtaIlOQPCnRcUJsex5/ewGMoTakFHktCHG
         QJbmy4PEoNJTm9XywitfzyGhu1FGtxAwyxX2kHWg/1Np7WwQBiXbWG/VkwSN7pTgBGLM
         mIN+qpt03kficfcJZVY5CrF52JMFNDcp9P3O6wzaVQYqvFGJTEDoxnH2ZelfIzwYpquZ
         csNg==
X-Gm-Message-State: AOAM530fq/q0akv443nbpvTBHEWACkHD3SmchkmjFsOeecMXrnlJMcp3
        REEG6NHGeF7hgWAVLsjKGMP0lg==
X-Google-Smtp-Source: ABdhPJxB8cUOtjFdM+vSMsIEhsYFJvwax+iseMhfwh9gbEQK9y8yNt7VouZeSvdSOUYF8uN7QozcNQ==
X-Received: by 2002:a17:90a:f992:: with SMTP id cq18mr2296365pjb.136.1599830983031;
        Fri, 11 Sep 2020 06:29:43 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.48])
        by smtp.gmail.com with ESMTPSA id e10sm557988pgb.45.2020.09.11.06.29.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:29:42 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 5/5] arm64: ipi_nmi: Add support for NMI backtrace
Date:   Fri, 11 Sep 2020 18:58:44 +0530
Message-Id: <1599830924-13990-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable NMI backtrace support on arm64 using IPI turned as an NMI
leveraging pseudo NMIs support. It is now possible for users to get a
backtrace of a CPU stuck in hard-lockup using magic SYSRQ.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/irq.h |  6 ++++++
 arch/arm64/kernel/ipi_nmi.c  | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b2b0c64..e840bf1 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -6,6 +6,12 @@
 
 #include <asm-generic/irq.h>
 
+#ifdef CONFIG_SMP
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+#endif
+
 struct pt_regs;
 
 static inline int nr_legacy_irqs(void)
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index 627bc11..d3aa430 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kgdb.h>
+#include <linux/nmi.h>
 #include <linux/smp.h>
 
 #include <asm/nmi.h>
@@ -25,12 +26,21 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
 	__ipi_send_mask(ipi_desc, mask);
 }
 
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self,
+				      arch_send_call_nmi_func_ipi_mask);
+}
+
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
 	unsigned int cpu = smp_processor_id();
 
-	ipi_kgdb_nmicallback(cpu, get_irq_regs());
+	if (nmi_cpu_backtrace(get_irq_regs()))
+		goto out;
 
+	ipi_kgdb_nmicallback(cpu, get_irq_regs());
+out:
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4

