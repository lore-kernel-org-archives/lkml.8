Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23026C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3A62076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzxBdMMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgD3Ot2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727808AbgD3OtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:49:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C131AC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so2194282wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bjfw6WLtQLu18dtBBq50BIhl44h6PIVIcyoJvF8/xYs=;
        b=qzxBdMMyCAD6o0fFfCMZFFwj9xWxiTwC89TTNDeEy0DERNz4Vs3+r1AMfBGsifCJNd
         1OcFJ9BYuJln9feFG9CWrpr+rGLRdA6uYTNFGx3XtzZDHwmf6LX/Zdh+SKqW+gdBOHlU
         HSVNIKcxgLgVuuYctvVXgDY6Mn3BtmLZp4tIFp/NH6Y1VIcziWGLfJpt8TAoFP3W/+YU
         Dn5DRVltXjzGqK7t71RPCVpwEcUABZQNxIj73WTbVnPlH1rB95CEBTvqR/5zeIsgpkBj
         aWD+5uGPboEh0RrIh1wRNQWwyW/c6SBYBElpYfuRnJZcWX2ssUv//XyH9JF4yOXRD7KB
         JJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bjfw6WLtQLu18dtBBq50BIhl44h6PIVIcyoJvF8/xYs=;
        b=HMm2BVkycwdzWC7WQUQOICGLRUjApxo+KykbOT3JJ7wKwrbgYpNStYLS0Vb88IuACC
         J2gfJWSZPX1OOYUJeiL1q+9DkuR8TimtlfejpdyFaFKuok3bcayDVDQ7irjYQEbvVI0w
         ZBW55HrFDdBBsUcaX6P+K9hLTPX9+zMGKQK4tANGtCKTwKGLqYGaW3ObBUeWEU172pVm
         ZQsO4LtXrFO3W22uZLovX1q9v3ll1RTEDufqrZW8fTRaZUgun15aq7wHT61+352oGRAP
         qRwS5kjd8QL3C6+WTJGhHtmebHc+m4J2eIL+yu5KX1JTaVOMiWbVyz3DYzbKjjOVcHAE
         9wCg==
X-Gm-Message-State: AGi0PuZlvtqj6MHG4iYTMlt0D+s191rtuVGp9rfKbjFdinma0M/mPXCU
        kpTpr4yeiGd3UCa/1hY/mKQsvA==
X-Google-Smtp-Source: APiQypInlMtemBSxgprrtZ1Db2OkJJ+L2RoycVH9DSN6tmY9cQoEWe6neeG85fag/QDQ6Uvh0JBf+A==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr3391158wmg.177.1588258146104;
        Thu, 30 Apr 2020 07:49:06 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id l15sm12182667wmi.48.2020.04.30.07.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:49:05 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 11/15] arm64: kvm: Split hyp/timer-sr.c to VHE/nVHE
Date:   Thu, 30 Apr 2020 15:48:27 +0100
Message-Id: <20200430144831.59194-12-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is part of a series which builds KVM's non-VHE hyp code separately
from VHE and the rest of the kernel.

timer-sr.c contains a HVC handler for setting CNTVOFF_EL2 and two helper
functions for controlling access to physical counter. The former is shared
between VHE/nVHE and is kept in timer-sr.c but compiled under both configs.
The latter are nVHE-specific and are moved to nvhe/timer-sr.c.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_hyp.h   |  2 ++
 arch/arm64/kernel/image-vars.h     |  3 ---
 arch/arm64/kvm/hyp/nvhe/Makefile   |  3 ++-
 arch/arm64/kvm/hyp/nvhe/timer-sr.c | 43 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/timer-sr.c      | 36 -------------------------
 5 files changed, 47 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/timer-sr.c

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index c2bcd5dea030..3320a22a5fb1 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -64,8 +64,10 @@ void __vgic_v3_save_aprs(struct kvm_vcpu *vcpu);
 void __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu);
 int __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu);
 
+#ifdef __HYPERVISOR__
 void __timer_enable_traps(struct kvm_vcpu *vcpu);
 void __timer_disable_traps(struct kvm_vcpu *vcpu);
+#endif
 
 #ifdef __HYPERVISOR__
 void __sysreg_save_state_nvhe(struct kvm_cpu_context *ctxt);
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index c4ff4a61eb5d..b3de24d7ecd1 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -67,9 +67,6 @@ __hyp_text___guest_enter = __guest_enter;
 __hyp_text___guest_exit = __guest_exit;
 __hyp_text___icache_flags = __icache_flags;
 __hyp_text___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
-__hyp_text___kvm_timer_set_cntvoff = __kvm_timer_set_cntvoff;
-__hyp_text___timer_disable_traps = __timer_disable_traps;
-__hyp_text___timer_enable_traps = __timer_enable_traps;
 __hyp_text___vgic_v2_perform_cpuif_access = __vgic_v2_perform_cpuif_access;
 __hyp_text___vgic_v3_activate_traps = __vgic_v3_activate_traps;
 __hyp_text___vgic_v3_deactivate_traps = __vgic_v3_deactivate_traps;
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index cfb55c01b3ff..2b8286ee8138 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,8 @@ asflags-y := -D__HYPERVISOR__
 ccflags-y := -D__HYPERVISOR__ -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 	     $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y := sysreg-sr.o debug-sr.o switch.o tlb.o host_hypercall.o ../hyp-entry.o
+obj-y := ../timer-sr.o timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o \
+	 host_hypercall.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
new file mode 100644
index 000000000000..f0e694743883
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2012-2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <clocksource/arm_arch_timer.h>
+#include <linux/compiler.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_hyp.h>
+
+/*
+ * Should only be called on non-VHE systems.
+ * VHE systems use EL2 timers and configure EL1 timers in kvm_timer_init_vhe().
+ */
+void __hyp_text __timer_disable_traps(struct kvm_vcpu *vcpu)
+{
+	u64 val;
+
+	/* Allow physical timer/counter access for the host */
+	val = read_sysreg(cnthctl_el2);
+	val |= CNTHCTL_EL1PCTEN | CNTHCTL_EL1PCEN;
+	write_sysreg(val, cnthctl_el2);
+}
+
+/*
+ * Should only be called on non-VHE systems.
+ * VHE systems use EL2 timers and configure EL1 timers in kvm_timer_init_vhe().
+ */
+void __hyp_text __timer_enable_traps(struct kvm_vcpu *vcpu)
+{
+	u64 val;
+
+	/*
+	 * Disallow physical timer access for the guest
+	 * Physical counter access is allowed
+	 */
+	val = read_sysreg(cnthctl_el2);
+	val &= ~CNTHCTL_EL1PCEN;
+	val |= CNTHCTL_EL1PCTEN;
+	write_sysreg(val, cnthctl_el2);
+}
diff --git a/arch/arm64/kvm/hyp/timer-sr.c b/arch/arm64/kvm/hyp/timer-sr.c
index ff76e6845fe4..46e303281a2c 100644
--- a/arch/arm64/kvm/hyp/timer-sr.c
+++ b/arch/arm64/kvm/hyp/timer-sr.c
@@ -4,10 +4,6 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
-#include <clocksource/arm_arch_timer.h>
-#include <linux/compiler.h>
-#include <linux/kvm_host.h>
-
 #include <asm/kvm_hyp.h>
 
 void __hyp_text __kvm_timer_set_cntvoff(u32 cntvoff_low, u32 cntvoff_high)
@@ -15,35 +11,3 @@ void __hyp_text __kvm_timer_set_cntvoff(u32 cntvoff_low, u32 cntvoff_high)
 	u64 cntvoff = (u64)cntvoff_high << 32 | cntvoff_low;
 	write_sysreg(cntvoff, cntvoff_el2);
 }
-
-/*
- * Should only be called on non-VHE systems.
- * VHE systems use EL2 timers and configure EL1 timers in kvm_timer_init_vhe().
- */
-void __hyp_text __timer_disable_traps(struct kvm_vcpu *vcpu)
-{
-	u64 val;
-
-	/* Allow physical timer/counter access for the host */
-	val = read_sysreg(cnthctl_el2);
-	val |= CNTHCTL_EL1PCTEN | CNTHCTL_EL1PCEN;
-	write_sysreg(val, cnthctl_el2);
-}
-
-/*
- * Should only be called on non-VHE systems.
- * VHE systems use EL2 timers and configure EL1 timers in kvm_timer_init_vhe().
- */
-void __hyp_text __timer_enable_traps(struct kvm_vcpu *vcpu)
-{
-	u64 val;
-
-	/*
-	 * Disallow physical timer access for the guest
-	 * Physical counter access is allowed
-	 */
-	val = read_sysreg(cnthctl_el2);
-	val &= ~CNTHCTL_EL1PCEN;
-	val |= CNTHCTL_EL1PCTEN;
-	write_sysreg(val, cnthctl_el2);
-}
-- 
2.26.1

