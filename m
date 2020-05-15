Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DA82074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2DytUW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEOK7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgEOK67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:58:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3FC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:58:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so3022259wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ai6Fwl8UyJm6B87jvYHBuJcbjLJDaWpZZPVaPcXdfLA=;
        b=u2DytUW7gTaWjKgKY0D29Drbg//IklH60EMwY3UFqgWODthsP3akJrIYzhlnI5FJKv
         RNUVgMc+XbbpJVoDkByhNUhNdw9T7bxR6ZjOn0hrivmRGUWB8qbGL1mfRJ18I/0tACbJ
         xeAuqFwIfPJp8vLLJXuTVyl27cwnBPE91ENGsEqjeMFv1vVmgE5F2C8Wh9+EkaIbSqar
         cYFpZWx5UpuZwEqqAV5GKNOYKQdjT52uS1qNza/RpJ+CZUQEyO6g/W+JJVKg6K4E0vIu
         Ql55gaM8m+fAEIqi1nqzANNnf0liHhnaKFjWRwDrVGkGM6t52MBlqnsp4q+zlQsDI4kQ
         8Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ai6Fwl8UyJm6B87jvYHBuJcbjLJDaWpZZPVaPcXdfLA=;
        b=dy7is2q6B11xZpeYdImxLU7XmVjZ6BP/Lu/dbYGr35hnaI6f/pIvm/PJmxpJU2BlU4
         rVRcsXoh/zUykLidrp4pfCB0mExuMvbyMAq02onRhm7P3xOpuoMRnoXyX3uxIgOGj2YP
         n3gsO8qBxpKmXSslyTqj75xzPLqLaO9g+FtEz5ZCpHFGUHsvQF3tPZtMtDGX+KLXj9c1
         8KXP1r6g+LgJD2Z7b7ckCEHP0C5fcr2ZrLOk/meS7ehh5WCZnZrm8TXUW+WMzekAEjhY
         QPVA0mpeqRyNcXp4bFK3vWxLxa+LsuB8hAOqGsnSufIgKYY4mCUVDk5HJMaHeR8YzD16
         Gc3A==
X-Gm-Message-State: AOAM530HG1c+FD0ULFASjFazBBucDJplxNj4nSrC3rOtf25YQ3IjmQUE
        o2QG6s5e88O9ygCIsP6T8IHQjg==
X-Google-Smtp-Source: ABdhPJxJSLJpRVMm0dV2T5Dk4zybjMjD8L0/aFOEv7m2OekpRetlA0SYTkbeLI0O0Ger9pleD5J2kA==
X-Received: by 2002:adf:f84c:: with SMTP id d12mr3627382wrq.248.1589540337673;
        Fri, 15 May 2020 03:58:57 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id t7sm3106188wrq.39.2020.05.15.03.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:58:56 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 02/14] arm64: kvm: Move __smccc_workaround_1_smc to .rodata
Date:   Fri, 15 May 2020 11:58:29 +0100
Message-Id: <20200515105841.73532-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
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
index c2a13ab3c471..65ff99a7e02d 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -319,20 +319,4 @@ SYM_CODE_START(__bp_harden_hyp_vecs)
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
2.26.2

