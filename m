Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A782C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4736922204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMLE8rM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIKQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgIKP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08962C061798
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c196so7490796pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8XXWl4v9PBTaJqTU0LTHaO4yR2LTPizMFNymaqYIWU=;
        b=oMLE8rM8iM22jHrw1tJVriGCJdRA1UU9284YM4yPrEVz8JGMXc468KKUHFkOv8kZaM
         IQntWXGwecrKYhSd3zKZekV9erPYLtHP2zh2m+vEJKSME1gs9vAzG2PduN7/i5AI59yy
         0txAVl3MJnpldlYdvFKDUWTEpnosfq1O51eVJtT97YcTYT28Ln+iIQbpO741qfgW0rtf
         xcOwz5P8xsckuDs+y/C97e/Np1ciQuyhzZmKh2cDDh88U5kG0pjFoYklwm7SACpSOI11
         4N+M6aUC/v72MEEGG7Zj4jGDZUl1daCgdXxJt4OgYItqqWGNOLZCLTJvL6d0OktecC/G
         svXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8XXWl4v9PBTaJqTU0LTHaO4yR2LTPizMFNymaqYIWU=;
        b=OdcP+XFK9lt/sefB0FD+KHsQqKmu6/ZV3EFnK7N7TblGh17diQ6MrR8VAE9Ln56XrW
         ewYC7xVXt5sZy+0RCgGZJVG12atpXKImfrUvPBS7RR3mSlt80PGew6jkTDqn3mMHTKZi
         OcuYQvtlM7y81VdIiSjrBeEqpsaDYZmpSXb8PIWosNxK/YLdTDlMklNPVYLKkx3rTZCG
         sukvLgf5lZ5qILTFHyC+hpeTNlJ65M72W8K9WbNJ96he8xtR8SKJA26vzx672eV72bpK
         W1HJDuXuUIG/WsddrD2c2fg5iV+dWXCsSHy/FZhtJqFlUrlYE4g4JO2VAH9CT9WzoboH
         BajA==
X-Gm-Message-State: AOAM530uM+ueOqnHlGW/gRATn+akHJLJhbpu/owsT6FkRIzJfYmLXGOK
        Uqpg65E8Vw9MEz6ajB5dNIJz6w==
X-Google-Smtp-Source: ABdhPJw8LOM8mjmqzKYH9VAZAt/tSr5GGEC3yJjnUtjTsmmZ+TNtaich1KH/B6flKrFEBX4t5n1h7g==
X-Received: by 2002:a62:cfc5:0:b029:13e:d13d:a083 with SMTP id b188-20020a62cfc50000b029013ed13da083mr2213644pfg.26.1599830975328;
        Fri, 11 Sep 2020 06:29:35 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.48])
        by smtp.gmail.com with ESMTPSA id e10sm557988pgb.45.2020.09.11.06.29.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:29:34 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 4/5] arm64: kgdb: Round up cpus using IPI as NMI
Date:   Fri, 11 Sep 2020 18:58:43 +0530
Message-Id: <1599830924-13990-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 platforms with GICv3 or later supports pseudo NMIs which can be
leveraged to round up CPUs which are stuck in hard lockup state with
interrupts disabled that wouldn't be possible with a normal IPI.

So instead switch to round up CPUs using IPI turned as NMI. And in
case a particular arm64 platform doesn't supports pseudo NMIs,
this IPI will act as a normal IPI which maintains existing kgdb
functionality.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/kgdb.h |  8 ++++++++
 arch/arm64/kernel/ipi_nmi.c   |  5 ++++-
 arch/arm64/kernel/kgdb.c      | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index 21fc85e..6f3d3af 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -24,6 +24,14 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
 
+#ifdef CONFIG_KGDB
+extern void ipi_kgdb_nmicallback(int cpu, void *regs);
+#else
+static inline void ipi_kgdb_nmicallback(int cpu, void *regs)
+{
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index 355ef92..627bc11 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kgdb.h>
 #include <linux/smp.h>
 
 #include <asm/nmi.h>
@@ -26,7 +27,9 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
 
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
-	/* nop, NMI handlers for special features can be added here. */
+	unsigned int cpu = smp_processor_id();
+
+	ipi_kgdb_nmicallback(cpu, get_irq_regs());
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 1a157ca3..0991275 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -17,6 +17,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
+#include <asm/nmi.h>
 #include <asm/traps.h>
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
@@ -353,3 +354,23 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+void ipi_kgdb_nmicallback(int cpu, void *regs)
+{
+	if (atomic_read(&kgdb_active) != -1)
+		kgdb_nmicallback(cpu, regs);
+}
+
+#ifdef CONFIG_SMP
+void kgdb_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return;
+
+	arch_send_call_nmi_func_ipi_mask(&mask);
+}
+#endif
-- 
2.7.4

