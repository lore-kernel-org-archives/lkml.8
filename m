Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B01C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8333620716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0+JDYUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgICPMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbgICMFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:05:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2573C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 05:05:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t9so2151698pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Llf97xQzuVj1Ljy7SQLNwqvcHttw+vqN9qNvesLWdDk=;
        b=c0+JDYUrGCnpb/G/my1hmcnRrwWug0dnnFoSkE5Sw1nXQDHo/cLtcHKQmSaumkFbeH
         AnUKZEYnvMHNE/6oR8jAvucjsyVSt2y8De5zqTzfFQ06zyqZ+VWJ/fy8K/PZUHfRidAp
         MkC8GFMN9qg+kEI2EmzGdFS0vnnNeEKb6Cp5rPt1C6csrRlMa7JHunAy92hRRfPGTJdN
         9wG7RAfRCWsugjacZ+3Yy2w2LAn5NtF+uW0UnHF0Lc0gZTg2HY0yE3vPsAfnoEfD7jzO
         eKsTMzvprBDaBlrr62SBKJAXjsWCAe9ilJPwCwlsIWyRhE+o1zfDTyAY50KKurcJDgiI
         eqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Llf97xQzuVj1Ljy7SQLNwqvcHttw+vqN9qNvesLWdDk=;
        b=Pgp4cXOWSWX1DxyIRthU9Ahm91cwRH2wpRaaxCBeXdUh+zPhbfVFLbvO8bSOM9+nrY
         /Qq6A9ucx9XshIQk1Hn5Ke1inDgylY/NrGJtslKCp9+Qgxgg0WMiGeUwW0kNOIiFXrfk
         wsE9TJ3/85JyAIBGACxdjwcOAoNQ0Xqv48ANHAIQdicf71gjk2czz+N/5h2ldRYAOaVm
         4IyEQXhq4aad3If6L4q6BjY5raFXZC/+EkNO1yrL19XXZGLgw1eCEc46whEHzSMcWVZh
         Li4TKm13lC7YxLS52TdJmDbdztyAGu6HnVvAZ7wtWwegmeRo/mnuSM+AhDFye7EMuzHW
         XSgw==
X-Gm-Message-State: AOAM531eUrLqyeNA1ejK4EJU1Bj0v8v9tyqz3WXDC0fj/aZpu+hFVbSn
        8nsj6jNaOa0uID78x5yGtR8FcA==
X-Google-Smtp-Source: ABdhPJw6HtsVUIQpVpFCbqkFJyoJHA+cOMhTpfShrs4LKTMEak2ao3uyit7Wpi0M6ASCOtkZ8T/eAQ==
X-Received: by 2002:aa7:94a4:: with SMTP id a4mr3528509pfl.49.1599134748396;
        Thu, 03 Sep 2020 05:05:48 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.248])
        by smtp.gmail.com with ESMTPSA id s1sm2922022pgh.47.2020.09.03.05.05.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 05:05:47 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/4] arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
Date:   Thu,  3 Sep 2020 17:35:09 +0530
Message-Id: <1599134712-30923-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
References: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
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
 arch/arm64/include/asm/smp.h |  1 +
 arch/arm64/kernel/smp.c      | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 2e7f529..e85f5d5 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -89,6 +89,7 @@ extern void secondary_entry(void);
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+extern void arch_send_call_nmi_func_ipi_mask(const struct cpumask *mask);
 
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b6bde26..1b4c07c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -74,6 +74,7 @@ enum ipi_msg_type {
 	IPI_TIMER,
 	IPI_IRQ_WORK,
 	IPI_WAKEUP,
+	IPI_CALL_NMI_FUNC,
 	NR_IPI
 };
 
@@ -793,6 +794,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
+	S(IPI_CALL_NMI_FUNC, "NMI function call interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
@@ -840,6 +842,11 @@ void arch_irq_work_raise(void)
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
@@ -932,6 +939,10 @@ static void do_handle_IPI(int ipinr)
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

