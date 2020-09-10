Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF93720C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LSxaUvvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIJIXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgIJINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D0C06179B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so3835524pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SrU/aV5djDmaDbtCrXOklDn69/w5fLRLzoaNlWHzHHU=;
        b=LSxaUvvdfF3lBKbAhOWTjwB4AgDTuczCCklLYSX3hi6hg84TLH4NmlP3Tt95aJFoiD
         vXlh2eEBegCQaozL1V3sCkBsYPTa/EyCX4Rft9Th2UpsnCQ60RaUKWYiVF63CKI8J+gS
         1h3UxfKyePczUDD1sa0eU/IO5OpBXkRu8s9vMDjDEV5cKtuy6HmcpXMFp+6e/ZHGlJww
         k9J+AGxBkZWSvAWyPLCsiS8uQ8ZRqVHSigXFR7y4hOe5HWN8jtJ+PpNfuPRw7xia8qp4
         usbyA7LDEJY4jq4FR+AFtFmeb+eADnCvl+nwkT5+F7vK9z/7B34SaiJ2L0JKp58xDS8H
         cljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrU/aV5djDmaDbtCrXOklDn69/w5fLRLzoaNlWHzHHU=;
        b=r4/PuXu+YdK1/4e+hlXo1yL/CgpY6VOoPIXViCMDydZRK529R2j0JM/n/eBBse9EhK
         LRZMbq5nGnXu8X3k55p5FLiR7eQdmmlj1hpXuDJMOJGKRFsA1afM65tJU3WHzVfedXB2
         0mUfJRSyFCOtwIbX9yNGWkTuJmvHJmjsYp7DxeD/NVoZbJyHnRNPPZ8p3q7ZUJwZ746K
         rkHpNjR8yPLXMG4f87gE+orXiX8XzIDe2sgTXIq4MJHQlSNjDQ/eci4fo6svMUUfNQSM
         FkA3N1hm3Y69/HS2nLc+MqtuPrRvoVsuhiDxu9LYH9z3mqV/q6uSldKNgYB41cgLtDjb
         GPTA==
X-Gm-Message-State: AOAM531oLT0TKedsjHtzhDOFWM92RQVxeZvIJGtfsWYc1MP7qisomr10
        A0KUc2A5zqBw5cVceZ7U43RVcg==
X-Google-Smtp-Source: ABdhPJzWgi6Ubl4GdF0/Uz0xQpnK40N3l0YfXPssqx2Zej/bAc1QOIHwHrOThIY6F4NPvJ69zWzVqg==
X-Received: by 2002:a63:ba5e:: with SMTP id l30mr3539698pgu.425.1599725585503;
        Thu, 10 Sep 2020 01:13:05 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:05 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: [RFC PATCH v7 14/21] riscv: Add support for kernel mode vector
Date:   Thu, 10 Sep 2020 16:12:09 +0800
Message-Id: <a219f9213d1e8efec8e27498318f096ad4d505b2.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add <asm/vector.h> containing kernel_rvv_begin()/kernel_rvv_end() function
declarations and corresponding definitions in kernel_mode_vector.c

These are needed to wrap uses of vector in kernel mode.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/vector.h        |  16 +++
 arch/riscv/kernel/Makefile             |   6 +
 arch/riscv/kernel/kernel_mode_vector.c | 184 +++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 arch/riscv/include/asm/vector.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
new file mode 100644
index 000000000000..3fc8d84e23c6
--- /dev/null
+++ b/arch/riscv/include/asm/vector.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * linux/arch/riscv/include/asm/vector.h
+ *
+ * Copyright (C) 2020 SiFive
+ */
+
+#ifndef __ASM_RISCV_VECTOR_H
+#define __ASM_RISCV_VECTOR_H
+
+#include <linux/types.h>
+
+void kernel_rvv_begin(void);
+void kernel_rvv_end(void);
+
+#endif /* ! __ASM_RISCV_VECTOR_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 3a166c21ea49..09f092f54d48 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -34,6 +34,12 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_VECTOR)		+= vector.o
+obj-$(CONFIG_VECTOR)		+= kernel_mode_vector.o
+riscv-march-cflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
+riscv-march-cflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
+riscv-march-cflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-cflags-y)c
+riscv-march-cflags-$(CONFIG_VECTOR)		:= $(riscv-march-cflags-y)v
+CFLAGS_kernel_mode_vector.o	+= -march=$(riscv-march-cflags-y)
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP)		+= cpu_ops.o
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
new file mode 100644
index 000000000000..108cfafe7496
--- /dev/null
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
+ * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2020 SiFive
+ */
+#include <linux/compiler.h>
+#include <linux/irqflags.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/types.h>
+
+#include <asm/vector.h>
+#include <asm/switch_to.h>
+
+DECLARE_PER_CPU(bool, vector_context_busy);
+DEFINE_PER_CPU(bool, vector_context_busy);
+
+/*
+ * may_use_vector - whether it is allowable at this time to issue vector
+ *                instructions or access the vector register file
+ *
+ * Callers must not assume that the result remains true beyond the next
+ * preempt_enable() or return from softirq context.
+ */
+static __must_check inline bool may_use_vector(void)
+{
+	/*
+	 * vector_context_busy is only set while preemption is disabled,
+	 * and is clear whenever preemption is enabled. Since
+	 * this_cpu_read() is atomic w.r.t. preemption, vector_context_busy
+	 * cannot change under our feet -- if it's set we cannot be
+	 * migrated, and if it's clear we cannot be migrated to a CPU
+	 * where it is set.
+	 */
+	return !in_irq() && !irqs_disabled() && !in_nmi() &&
+	       !this_cpu_read(vector_context_busy);
+}
+
+
+
+/*
+ * Claim ownership of the CPU vector context for use by the calling context.
+ *
+ * The caller may freely manipulate the vector context metadata until
+ * put_cpu_vector_context() is called.
+ */
+static void get_cpu_vector_context(void)
+{
+	bool busy;
+
+	preempt_disable();
+	busy = __this_cpu_xchg(vector_context_busy, true);
+
+	WARN_ON(busy);
+}
+
+/*
+ * Release the CPU vector context.
+ *
+ * Must be called from a context in which get_cpu_vector_context() was
+ * previously called, with no call to put_cpu_vector_context() in the
+ * meantime.
+ */
+static void put_cpu_vector_context(void)
+{
+	bool busy = __this_cpu_xchg(vector_context_busy, false);
+
+	WARN_ON(!busy);
+	preempt_enable();
+}
+
+static void rvv_enable(void)
+{
+	csr_set(CSR_STATUS, SR_VS);
+}
+
+static void rvv_disable(void)
+{
+	csr_clear(CSR_STATUS, SR_VS);
+}
+
+static void vector_flush_cpu_state(void)
+{
+	long tmp;
+
+	__asm__ __volatile__ (
+		"vsetvli %0, x0, e8, m1\n"
+		"vmv.v.i v0, 0\n"
+		"vmv.v.i v1, 0\n"
+		"vmv.v.i v2, 0\n"
+		"vmv.v.i v3, 0\n"
+		"vmv.v.i v4, 0\n"
+		"vmv.v.i v5, 0\n"
+		"vmv.v.i v6, 0\n"
+		"vmv.v.i v7, 0\n"
+		"vmv.v.i v8, 0\n"
+		"vmv.v.i v9, 0\n"
+		"vmv.v.i v10, 0\n"
+		"vmv.v.i v11, 0\n"
+		"vmv.v.i v12, 0\n"
+		"vmv.v.i v13, 0\n"
+		"vmv.v.i v14, 0\n"
+		"vmv.v.i v15, 0\n"
+		"vmv.v.i v16, 0\n"
+		"vmv.v.i v17, 0\n"
+		"vmv.v.i v18, 0\n"
+		"vmv.v.i v19, 0\n"
+		"vmv.v.i v20, 0\n"
+		"vmv.v.i v21, 0\n"
+		"vmv.v.i v22, 0\n"
+		"vmv.v.i v23, 0\n"
+		"vmv.v.i v24, 0\n"
+		"vmv.v.i v25, 0\n"
+		"vmv.v.i v26, 0\n"
+		"vmv.v.i v27, 0\n"
+		"vmv.v.i v28, 0\n"
+		"vmv.v.i v29, 0\n"
+		"vmv.v.i v30, 0\n"
+		"vmv.v.i v31, 0\n":"=r"(tmp)::);
+}
+
+/*
+ * kernel_rvv_begin(): obtain the CPU vector registers for use by the calling
+ * context
+ *
+ * Must not be called unless may_use_vector() returns true.
+ * Task context in the vector registers is saved back to memory as necessary.
+ *
+ * A matching call to kernel_rvv_end() must be made before returning from the
+ * calling context.
+ *
+ * The caller may freely use the vector registers until kernel_rvv_end() is
+ * called.
+ */
+void kernel_rvv_begin(void)
+{
+	if (WARN_ON(!has_vector))
+		return;
+
+	WARN_ON(!may_use_vector());
+
+	/* Acquire kernel mode vector */
+	get_cpu_vector_context();
+
+	/* Save vector state, if any */
+	vstate_save(current, task_pt_regs(current));
+
+	/* Enable vector */
+	rvv_enable();
+
+	/* Invalidate vector regs */
+	vector_flush_cpu_state();
+}
+EXPORT_SYMBOL(kernel_rvv_begin);
+
+/*
+ * kernel_rvv_end(): give the CPU vector registers back to the current task
+ *
+ * Must be called from a context in which kernel_rvv_begin() was previously
+ * called, with no call to kernel_rvv_end() in the meantime.
+ *
+ * The caller must not use the vector registers after this function is called,
+ * unless kernel_rvv_begin() is called again in the meantime.
+ */
+void kernel_rvv_end(void)
+{
+	if (WARN_ON(!has_vector))
+		return;
+
+	/* Invalidate vector regs */
+	vector_flush_cpu_state();
+
+	/* Restore vector state, if any */
+	vstate_restore(current, task_pt_regs(current));
+
+	/* disable vector */
+	rvv_disable();
+
+	/* release kernel mode vector */
+	put_cpu_vector_context();
+}
+EXPORT_SYMBOL(kernel_rvv_end);
-- 
2.28.0

