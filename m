Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480872075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N30CS11r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgFRM0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgFRMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:25:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A3C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l11so5870428wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EI3NYrtwn6qJxPWPwh60aHXJB+vFaqkjVnXPNPOUvlM=;
        b=N30CS11r8sn0rGiPBf7Y+li2ePVY+jY9p3+fPyUt6oXi+Hb8X9cFUGgXLuswEudrWb
         R6lpv7ssWn6pFLjvITdLvoqc8nOphTTAvpILm710A8CgQ6SfXSwMc0ch4EVXyguq4LUj
         e1V29s0KvlvbpnQt+mdxjze4D4q9izalNSzHHXOoel0ZK0U/wkcHr3zLXg3k1JT0WNMf
         ebCEtjNPbgocdWIiK3vxM93imD08qIV19XzPFFVGBrRIUx3JGvYWOLYUNrlW4Pa8qDGT
         /PeUsKnG272Pgn2Ehdx9Qpj8vfpth/Hd2z5bPv219EmkHrvL6DPUSlEQnRrknv78BM1/
         ghwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EI3NYrtwn6qJxPWPwh60aHXJB+vFaqkjVnXPNPOUvlM=;
        b=JeDD8jlQ0D3LCBIetNfU4qTHr71PxgOmV0aIGuonHtvODK6XUidTICDf98D2FFcupD
         MwGs/SzQDy5ZPgLgEKDODzWjBiGbFnL3Lx6nPgeq+JkjkqwT7aKIcjmOxC8zsjm1kdCq
         UFawM59tW1JKklSlRQvmOoZs2WXzmofwaLQRXok6pNt/NQs5rpW9LlsWdYA8Pmsk1+Gb
         PLQS5I8bpT/FimQanlVYpeTjDDoHtU0T1LLaudkH0dyW/ff87O8+934CcIrS6Plz4sno
         jgml35GqK30vJl1hwW+Co1Dwqe07A4qqHozFb2mXlXRzIBq0d7ygM5hCosAVXYhQ3Bi9
         f77g==
X-Gm-Message-State: AOAM53274vGXMPzQjJCV58mQfENkGYcgR7+2lAcn9NlLECwZ3G7CnfS7
        WHkye+3BpDw7bdt7lmyxuaG0VQ==
X-Google-Smtp-Source: ABdhPJwa2EW6p36Iawe8UNLmui6v2zHWYcLTdQb2AQWxuuBBIWLUvLId9MfLH1gRIgvgURkn+W35jg==
X-Received: by 2002:adf:f08b:: with SMTP id n11mr4229961wro.312.1592483152531;
        Thu, 18 Jun 2020 05:25:52 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
        by smtp.gmail.com with ESMTPSA id n1sm3343936wrp.10.2020.06.18.05.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:25:51 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 02/15] arm64: kvm: Move __smccc_workaround_1_smc to .rodata
Date:   Thu, 18 Jun 2020 13:25:24 +0100
Message-Id: <20200618122537.9625-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618122537.9625-1-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This snippet of assembly is used by cpu_errata.c to overwrite parts of KVM hyp
vector. Move it to its own source file and change its ELF section to .rodata.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/Makefile    |  1 +
 arch/arm64/kvm/hyp/hyp-entry.S | 16 ----------------
 arch/arm64/kvm/hyp/smccc_wa.S  | 30 ++++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/smccc_wa.S

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 8c9880783839..5d8357ddc234 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -7,6 +7,7 @@ ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 		$(DISABLE_STACKLEAK_PLUGIN)
 
 obj-$(CONFIG_KVM) += hyp.o
+obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
 hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
 	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 9c5cfb04170e..d362fad97cc8 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -318,20 +318,4 @@ SYM_CODE_START(__bp_harden_hyp_vecs)
 1:	.org __bp_harden_hyp_vecs + __BP_HARDEN_HYP_VECS_SZ
 	.org 1b
 SYM_CODE_END(__bp_harden_hyp_vecs)
-
-	.popsection
-
-SYM_CODE_START(__smccc_workaround_1_smc)
-	esb
-	sub	sp, sp, #(8 * 4)
-	stp	x2, x3, [sp, #(8 * 0)]
-	stp	x0, x1, [sp, #(8 * 2)]
-	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_1
-	smc	#0
-	ldp	x2, x3, [sp, #(8 * 0)]
-	ldp	x0, x1, [sp, #(8 * 2)]
-	add	sp, sp, #(8 * 4)
-1:	.org __smccc_workaround_1_smc + __SMCCC_WORKAROUND_1_SMC_SZ
-	.org 1b
-SYM_CODE_END(__smccc_workaround_1_smc)
 #endif
diff --git a/arch/arm64/kvm/hyp/smccc_wa.S b/arch/arm64/kvm/hyp/smccc_wa.S
new file mode 100644
index 000000000000..aa25b5428e77
--- /dev/null
+++ b/arch/arm64/kvm/hyp/smccc_wa.S
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2018 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <linux/arm-smccc.h>
+
+#include <asm/kvm_asm.h>
+#include <asm/kvm_mmu.h>
+
+	/*
+	 * This is not executed directly and is instead copied into the vectors
+	 * by install_bp_hardening_cb().
+	 */
+	.data
+	.pushsection	.rodata
+	.global		__smccc_workaround_1_smc
+__smccc_workaround_1_smc:
+	esb
+	sub	sp, sp, #(8 * 4)
+	stp	x2, x3, [sp, #(8 * 0)]
+	stp	x0, x1, [sp, #(8 * 2)]
+	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_1
+	smc	#0
+	ldp	x2, x3, [sp, #(8 * 0)]
+	ldp	x0, x1, [sp, #(8 * 2)]
+	add	sp, sp, #(8 * 4)
+1:	.org __smccc_workaround_1_smc + __SMCCC_WORKAROUND_1_SMC_SZ
+	.org 1b
-- 
2.27.0

