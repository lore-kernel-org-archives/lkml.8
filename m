Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B16C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFAB2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilTyU0Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405054AbgFYNPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404972AbgFYNOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:14:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so5800184wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3YELHjM1BgSWP0+S5toOkAsepEf5nX9XhvGc5i2xbU=;
        b=ilTyU0AgGSK7WeD/FKjM2QHVp2cuKnlScEo1zl+lyPExxPoKPjmWmxrNy9vzUr1mRY
         LzhR1Rh/UrAFo+GhEztERMJc68vpsrQf6W3Yf/nriOW/2dZqo/7DP4Zp4pMQVSBJssi2
         p43nHoW3yDaXkm6m59mcwjp3SWGZzfs5TpMBZ1WnFW1PujxCKDBFsl98R5ZXj7SUpseQ
         7F6DtEC8ATtjrHxUeMEE9knb7uVqie5aq7Z3mAIJnOXwRuR7zRBeibXTuUdRk7JGlIbF
         9tqc0j50JvMD3FZbP/CRI1A4AcSct/0mJ1tdqD0Wix2G1JmGnXnuf3C5/79LgEmNgUD0
         ltPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3YELHjM1BgSWP0+S5toOkAsepEf5nX9XhvGc5i2xbU=;
        b=VYu2pN64SWFx0m/HutSmBBFoRPBIoRX5lfEyuY744aXBiXtEe860NLjV36yg4qhfYe
         zADR1nAJojtT6xABNaKGp2/ml1FxEDmDT32Fd9lms/vn7Vcm/3tWRKDq5Gt/ascIkRW5
         O/XO/23mWL/na4Y2UBdSKdg/tdPiAhuQDf3TiWG3LhnbtoWW7TGkMqGmfP0MIk+wpYc6
         QnLMEBYkmX2FUnC82xt5z/7K4U0mxG/nIp30NyXjWIHHZWANsfsO/ueGkjCI/qQczZup
         jVlHyc2SvtbRrNGXztwUan7sZg4UKR0X6dykihx8LJQLSkmUDGDhwiW0LeKyQPVsNEh3
         ZB+Q==
X-Gm-Message-State: AOAM531eB0JCjjkWrXADAQKt9mUkIoXSW2vkcat0/f88RxDERkTdB/us
        43F991rOvV+PavmKwSRPvo7G8Q==
X-Google-Smtp-Source: ABdhPJyLXF+uU/BlSix30zQts4PivrY6/W4SxO/M5sYmX4ja0Dr3vI+AEEytk5FhJrUCpy+0J45FDw==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr2898229wrj.264.1593090889018;
        Thu, 25 Jun 2020 06:14:49 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id g13sm5650833wro.84.2020.06.25.06.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:14:48 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 12/15] arm64: kvm: Duplicate hyp/timer-sr.c for VHE/nVHE
Date:   Thu, 25 Jun 2020 14:14:17 +0100
Message-Id: <20200625131420.71444-13-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timer-sr.c contains a HVC handler for setting CNTVOFF_EL2 and two helper
functions for controlling access to physical counter. The former is used by
both VHE/nVHE and is duplicated, the latter are used only by nVHE and moved
to nvhe/timer-sr.c.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_hyp.h         |  2 ++
 arch/arm64/kernel/image-vars.h           |  5 -----
 arch/arm64/kvm/hyp/Makefile              |  2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile         |  3 ++-
 arch/arm64/kvm/hyp/{ => nvhe}/timer-sr.c |  2 +-
 arch/arm64/kvm/hyp/vhe/Makefile          |  2 +-
 arch/arm64/kvm/hyp/vhe/timer-sr.c        | 12 ++++++++++++
 7 files changed, 19 insertions(+), 9 deletions(-)
 rename arch/arm64/kvm/hyp/{ => nvhe}/timer-sr.c (95%)
 create mode 100644 arch/arm64/kvm/hyp/vhe/timer-sr.c

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 997c5bda1ac7..19f8b40fe6cf 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -63,8 +63,10 @@ void __vgic_v3_save_aprs(struct vgic_v3_cpu_if *cpu_if);
 void __vgic_v3_restore_aprs(struct vgic_v3_cpu_if *cpu_if);
 int __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu);
 
+#ifdef __KVM_NVHE_HYPERVISOR__
 void __timer_enable_traps(struct kvm_vcpu *vcpu);
 void __timer_disable_traps(struct kvm_vcpu *vcpu);
+#endif
 
 #ifdef __KVM_NVHE_HYPERVISOR__
 void __sysreg_save_state_nvhe(struct kvm_cpu_context *ctxt);
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 05c642621d61..221024e745c9 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -76,11 +76,6 @@ KVM_NVHE_ALIAS(abort_guest_exit_start);
 KVM_NVHE_ALIAS(__fpsimd_restore_state);
 KVM_NVHE_ALIAS(__fpsimd_save_state);
 
-/* Symbols defined in timer-sr.c (not yet compiled with nVHE build rules). */
-KVM_NVHE_ALIAS(__kvm_timer_set_cntvoff);
-KVM_NVHE_ALIAS(__timer_disable_traps);
-KVM_NVHE_ALIAS(__timer_enable_traps);
-
 /* Symbols defined in vgic-v2-cpuif-proxy.c (not yet compiled with nVHE build rules). */
 KVM_NVHE_ALIAS(__vgic_v2_perform_cpuif_access);
 
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index f49797237818..ef1aa7fe8f5a 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -13,7 +13,7 @@ subdir-ccflags-y := -I$(incdir)				\
 obj-$(CONFIG_KVM) += hyp.o vhe/ nvhe/
 obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
 
-hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o entry.o \
+hyp-y := vgic-v3-sr.o aarch32.o vgic-v2-cpuif-proxy.o entry.o \
 	 fpsimd.o
 
 # KVM code is run at a different exception code with a different map, so
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 61a8160f0dd9..0f4c544f07db 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -6,7 +6,8 @@
 asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
-obj-y := sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o ../hyp-entry.o
+obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o \
+	 ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
similarity index 95%
rename from arch/arm64/kvm/hyp/timer-sr.c
rename to arch/arm64/kvm/hyp/nvhe/timer-sr.c
index fb5c0be33223..42c8ed71d06e 100644
--- a/arch/arm64/kvm/hyp/timer-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
@@ -10,7 +10,7 @@
 
 #include <asm/kvm_hyp.h>
 
-void __hyp_text __kvm_timer_set_cntvoff(u64 cntvoff)
+void __kvm_timer_set_cntvoff(u64 cntvoff)
 {
 	write_sysreg(cntvoff, cntvoff_el2);
 }
diff --git a/arch/arm64/kvm/hyp/vhe/Makefile b/arch/arm64/kvm/hyp/vhe/Makefile
index 2801582a739a..a1dbbc5409bd 100644
--- a/arch/arm64/kvm/hyp/vhe/Makefile
+++ b/arch/arm64/kvm/hyp/vhe/Makefile
@@ -6,7 +6,7 @@
 asflags-y := -D__KVM_VHE_HYPERVISOR__
 ccflags-y := -D__KVM_VHE_HYPERVISOR__
 
-obj-y := sysreg-sr.o debug-sr.o switch.o tlb.o ../hyp-entry.o
+obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o ../hyp-entry.o
 
 # KVM code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
diff --git a/arch/arm64/kvm/hyp/vhe/timer-sr.c b/arch/arm64/kvm/hyp/vhe/timer-sr.c
new file mode 100644
index 000000000000..4cda674a8be6
--- /dev/null
+++ b/arch/arm64/kvm/hyp/vhe/timer-sr.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2012-2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <asm/kvm_hyp.h>
+
+void __kvm_timer_set_cntvoff(u64 cntvoff)
+{
+	write_sysreg(cntvoff, cntvoff_el2);
+}
-- 
2.27.0

