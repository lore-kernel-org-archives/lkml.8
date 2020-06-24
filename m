Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08421C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D974620857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CNSsQcuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbgFXJDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgFXJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:03:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C7C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:03:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d12so825092ply.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gKNJSJH3SZ7s7ZY0q11chWiPCztbqXJoTwSFOWOwg0g=;
        b=CNSsQcuuIGwLhEkgYiQPdmaAFo4ZfVKGzVEe55xFjnpR71t/Ywd+JdQugR3swayRFC
         l0/kz1bAJPcmDeLj7WdLn+GBQsdAZMKk7gRyI0jtDuPz+xhu3C8R3LS873Vgq058Ma/A
         wWcEW6AvJEaxoSMN8KmRcYaGS94pnex6fxRLM26qUp5cQHXiY5NOCX27COlnH+Tar202
         NmVaiwxJh+bimEHBDyQmwiaZnlwaYpwMKHU6aHCpMzxtKgAqyUr2Ha+ChMWO3elTS3wx
         HAnu7cFJ9A2qSHnx88eZfUlbPxaFXRAGzWODgN3sEPcDe6y7YEZ/9APZRwPmIAOKY3dw
         Duug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKNJSJH3SZ7s7ZY0q11chWiPCztbqXJoTwSFOWOwg0g=;
        b=Yi/bnih2Uqbh92v8xe+n2xcMnmEae1OVXlIKOBWcRp8Csf86/ZnvFk8RVrCgwT8QJm
         yGWwP9qq/0B7Aa1DsDq0n8lR0kDG+9zNlWXC83FS9QsSYYeTzYy8e/k4FkU6J11XCrmR
         a8J73urC4PVV2rrJ79EZOnzDnQSnWuTsS8FAB579dzoJfNvztYOAU/NR86J9cdzACTS0
         o2w53HPkvNs0IidWtlSb9rfWvttQZSSH0OjffIwjhUSPq5nJwwiYB4q/i2fr3Gk8q0XR
         JrjlyxIMfVMPFS93UA/4GLSTaACcu60Xl0VSnM+ywe8uR7Ie79smt9VsXrkpOGSOt2v3
         /6/A==
X-Gm-Message-State: AOAM53216X7U32mTQ4wjZatxHGravl0RpvdBfqt5lHWw5JC8XGevhh8m
        LSFm7TOumoER77ITRPflHosoDg==
X-Google-Smtp-Source: ABdhPJylRi6vyu5/NoCH/pS0CM/oiFPlDLXN/6Yq2cgajLPQtbKymDeDQJfnp2CmE9t6NMDnFvtNRA==
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr27271421plm.179.1592989407445;
        Wed, 24 Jun 2020 02:03:27 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id v1sm8062046pfn.210.2020.06.24.02.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 02:03:26 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        guoren@linux.alibaba.com
Subject: [PATCH v2 1/2] riscv: Support irq_work via self IPIs
Date:   Wed, 24 Jun 2020 17:03:15 +0800
Message-Id: <283e048d23d124f390fbe9087addef1a7dce0027.1592989082.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592989082.git.greentime.hu@sifive.com>
References: <cover.1592989082.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for arch_irq_work_raise() and arch_irq_work_has_interrupt() was
missing from riscv (a prerequisite for FULL_NOHZ).

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/irq_work.h | 10 ++++++++++
 arch/riscv/kernel/smp.c           | 15 +++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 arch/riscv/include/asm/irq_work.h

diff --git a/arch/riscv/include/asm/irq_work.h b/arch/riscv/include/asm/irq_work.h
new file mode 100644
index 000000000000..d6c277992f76
--- /dev/null
+++ b/arch/riscv/include/asm/irq_work.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_IRQ_WORK_H
+#define _ASM_RISCV_IRQ_WORK_H
+
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return true;
+}
+extern void arch_irq_work_raise(void);
+#endif /* _ASM_RISCV_IRQ_WORK_H */
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b1d4f452f843..554b0fb47060 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
+#include <linux/irq_work.h>
 
 #include <asm/clint.h>
 #include <asm/sbi.h>
@@ -26,6 +27,7 @@ enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
+	IPI_IRQ_WORK,
 	IPI_MAX
 };
 
@@ -123,6 +125,13 @@ static inline void clear_ipi(void)
 		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
 }
 
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
+}
+#endif
+
 void handle_IPI(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
@@ -158,6 +167,11 @@ void handle_IPI(struct pt_regs *regs)
 			ipi_stop();
 		}
 
+		if (ops & (1 << IPI_IRQ_WORK)) {
+			stats[IPI_IRQ_WORK]++;
+			irq_work_run();
+		}
+
 		BUG_ON((ops >> IPI_MAX) != 0);
 
 		/* Order data access and bit testing. */
@@ -173,6 +187,7 @@ static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
+	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 };
 
 void show_ipi_stats(struct seq_file *p, int prec)
-- 
2.27.0

