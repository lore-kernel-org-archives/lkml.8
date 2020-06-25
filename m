Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989BAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B9C20724
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5+P3u/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404897AbgFYNOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404834AbgFYNO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:14:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA8C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j4so3328881wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1nJ1ieQpwNl0Pfw6B6FeqmHmOVT4IL4HZr2WtH3E820=;
        b=I5+P3u/ybHhlGS18JjAn1ZjLv6bR28LbgebFgG/w9VsgANqy8JBuJes3yv3leJ0CiN
         2Z3lfThuvuOqCeTU2ix7fcWZFNduqbwLBACGdO/ClPo6BMQfGdtD/T7/W33nMHJKn+Uq
         6Hc6V5pZfzk5xLPssLkXWMx1QYk3nAswm4kWs3TAnM9MLaabYskSi/qQS4rbX1045/Ae
         bbOtu19iiprRDl6agJmCiBiBI5ezKqqRaCYJmnftY3y/7nInBYSi+Xu1T6R49dtKOhYC
         ZdkH/3JoP+jVIj17Sc8Kb8Br5/9OqnHCq2NOh9ViFhaskHdp4vCus3RCDWC63A/k7+X3
         ar7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nJ1ieQpwNl0Pfw6B6FeqmHmOVT4IL4HZr2WtH3E820=;
        b=UGgl53FN5HUvR223OppvdFSyFiju9cS7xOGJi1OlhWBII6cTjXy29qHjY8GB/IE8o8
         8ADXv46z0e2R0piuaq3ortdrs0lWUipPh3o1K1RQRzNdu4lFH+kHjV86js9diS8DMfNL
         3JBRBG1Pn0kYKKbar9W0ITxnCjpzFoAnlEw+/UX2qFY7bKzuYXiritWtnZTvyVZhbeuM
         7L0BAtQP4FTwBu4QIBkwz1SRko3Qk5tevejVnhrTACIFGw2G//EdG2gW6bRq50nuv+BH
         hWF9v1LKS5zJAztw4mrb0qcrgnOOygeyLpFeDmdYOvS4eAp2m1BJ4xOr6U657oNJTgGD
         P+JA==
X-Gm-Message-State: AOAM530kmZ8mHMWuId/m//uSk7DI8ILDCp0oexB+oImJanlCitbBqrCn
        Yqul5LPu9rv47ewb/BcvXBSdXA==
X-Google-Smtp-Source: ABdhPJxZyOZhuCkCHMP8yaqY1hsW/6w4L0M3eUhJ8CkRDos6inOe28ZOBSDT0wbf2qrGrV/+bkISLg==
X-Received: by 2002:adf:dfcd:: with SMTP id q13mr23473875wrn.295.1593090867881;
        Thu, 25 Jun 2020 06:14:27 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id u20sm11201541wmm.15.2020.06.25.06.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:14:27 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 02/15] arm64: kvm: Move __smccc_workaround_1_smc to .rodata
Date:   Thu, 25 Jun 2020 14:14:07 +0100
Message-Id: <20200625131420.71444-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/smccc_wa.S  | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 16 deletions(-)
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
index 000000000000..b0441dbdf68b
--- /dev/null
+++ b/arch/arm64/kvm/hyp/smccc_wa.S
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2018 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/linkage.h>
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
+SYM_DATA_START(__smccc_workaround_1_smc)
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
+SYM_DATA_END(__smccc_workaround_1_smc)
-- 
2.27.0

