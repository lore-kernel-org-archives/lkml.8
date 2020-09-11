Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61288C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FCA22208
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPiXzooy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIKQZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIKP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AF1C061786
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mm21so1719838pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7c2tVI1sHEIHH1AjuWkw+8Vv4jkByqBwniC8b3+X7E=;
        b=IPiXzooyc34XdY1D6OA308FNNt0ps3oUF0Df+DJViiEfKqHZVjejg3Ul3W/k9it8IG
         ZPjc34I3fmGpsJqjMubs6bOIJ+18H5ABsl65dH1Cv1/RcCHX+APupzonwUq2HbhPyVwO
         LwDTFeNGwv5p2zxycWhDc6202u3+/eR4/G4tPRfGltc0bK1kSgfRjV+U/X4Rufw4l735
         9+Zzcc+BnyhsOg5mpksee8x7Rv+KQRi32iKb//u+GY7kk+pB+uLyaLoH0ma8BfKjzPWY
         IxF6DhPh+EglOOw1BTq5Z1DhbyaunfohQkQDTMioOOHUnXpjq2ifNLioiorbOzQwo7Rn
         IbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7c2tVI1sHEIHH1AjuWkw+8Vv4jkByqBwniC8b3+X7E=;
        b=dc2j/5y7IZR7F3zgEpOeQbyKC9sTxu1H33cWUBxRYLbvkHRw6GyX8MJ8TvUtdRevmh
         +TMz8Up3Bl+EU5kR+UyZ06FSbUjufa+kmjW5EuRcFMgkI0g7XZQ/K+Khg7Oh4iPdVdnc
         pEWQI7lQQ2MJLnIwMGCBZvvp2cnuCp0udFdMFZ3/y0nxmlpCHRmnrZlN4bUbowD43Y9c
         45TYda45FymzOQ4pxo5+RE5tODwOKGUC10E+KjoOdMeI10gv8SkVfzarxyjvjgsVgSa6
         WCgVL7qZY9WIhwF9r30kcU1L4sTSmu8THroI+oYHENKKRqFSA53fpDFnqZbk7YD+UcAm
         VifA==
X-Gm-Message-State: AOAM532v06G9iusxyFfM1qpA6X8Ziue9Lh8qt93gArDGBtPHmP72PDHC
        qeVYtxnsX80Bks2PIPEnmnWM4w==
X-Google-Smtp-Source: ABdhPJy5G1MDK6kqBvQVO9OUwpmI/w6cEPnvwQ+s+rirVNKyqdVtvb8FhGeb80XLNvA9lxYHwbi3wg==
X-Received: by 2002:a17:90b:100f:: with SMTP id gm15mr2186766pjb.235.1599830955357;
        Fri, 11 Sep 2020 06:29:15 -0700 (PDT)
Received: from localhost.localdomain ([117.210.209.48])
        by smtp.gmail.com with ESMTPSA id e10sm557988pgb.45.2020.09.11.06.29.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:29:14 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/5] arm64: Add framework to turn IPI as NMI
Date:   Fri, 11 Sep 2020 18:58:40 +0530
Message-Id: <1599830924-13990-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce framework to turn an IPI as NMI using pseudo NMIs. In case a
particular platform doesn't support pseudo NMIs, then request IPI as a
regular IRQ.

The main motivation for this feature is to have an IPI that can be
leveraged to invoke NMI functions on other CPUs. And current prospective
users are NMI backtrace and KGDB CPUs round-up whose support is added
via future patches.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/nmi.h | 16 +++++++++
 arch/arm64/kernel/Makefile   |  2 +-
 arch/arm64/kernel/ipi_nmi.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 arch/arm64/kernel/ipi_nmi.c

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
new file mode 100644
index 0000000..3433c55
--- /dev/null
+++ b/arch/arm64/include/asm/nmi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NMI_H
+#define __ASM_NMI_H
+
+#ifndef __ASSEMBLER__
+
+#include <linux/cpumask.h>
+
+extern void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask);
+
+void set_smp_ipi_nmi(int ipi);
+void ipi_nmi_setup(int cpu);
+void ipi_nmi_teardown(int cpu);
+
+#endif /* !__ASSEMBLER__ */
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a561cbb..022c26b 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -19,7 +19,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
-			   syscall.o
+			   syscall.o ipi_nmi.o
 
 targets			+= efi-entry.o
 
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
new file mode 100644
index 0000000..355ef92
--- /dev/null
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NMI support for IPIs
+ *
+ * Copyright (C) 2020 Linaro Limited
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+
+#include <asm/nmi.h>
+
+static struct irq_desc *ipi_desc __read_mostly;
+static int ipi_id __read_mostly;
+static bool is_nmi __read_mostly;
+
+void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
+{
+	if (WARN_ON_ONCE(!ipi_desc))
+		return;
+
+	__ipi_send_mask(ipi_desc, mask);
+}
+
+static irqreturn_t ipi_nmi_handler(int irq, void *data)
+{
+	/* nop, NMI handlers for special features can be added here. */
+
+	return IRQ_HANDLED;
+}
+
+void ipi_nmi_setup(int cpu)
+{
+	if (!ipi_desc)
+		return;
+
+	if (is_nmi) {
+		if (!prepare_percpu_nmi(ipi_id))
+			enable_percpu_nmi(ipi_id, 0);
+	} else {
+		enable_percpu_irq(ipi_id, 0);
+	}
+}
+
+void ipi_nmi_teardown(int cpu)
+{
+	if (!ipi_desc)
+		return;
+
+	if (is_nmi) {
+		disable_percpu_nmi(ipi_id);
+		teardown_percpu_nmi(ipi_id);
+	} else {
+		disable_percpu_irq(ipi_id);
+	}
+}
+
+void __init set_smp_ipi_nmi(int ipi)
+{
+	int err;
+
+	err = request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number);
+	if (err) {
+		err = request_percpu_irq(ipi, ipi_nmi_handler, "IPI",
+					 &cpu_number);
+		WARN_ON(err);
+		is_nmi = false;
+	} else {
+		is_nmi = true;
+	}
+
+	ipi_desc = irq_to_desc(ipi);
+	irq_set_status_flags(ipi, IRQ_HIDDEN);
+	ipi_id = ipi;
+
+	/* Setup the boot CPU immediately */
+	ipi_nmi_setup(smp_processor_id());
+}
-- 
2.7.4

