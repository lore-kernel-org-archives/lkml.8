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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AA3C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D0120774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX3I6hB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgD3OtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728117AbgD3OtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:49:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEBAC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so7668350wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZpgAl6fMrlc5u+7N0e4lNcYAQFE8vx0PX4usrIn+P0=;
        b=SX3I6hB788ySFMgbr/rM3LkF68Ci9qfXsIghXpFwqbnIH5nqpq4tpqhp72dFsDspFP
         l3UFPrIPLeudxatMwxGS+EsPPq37dfq1qOA9g8BADdDSNvNbCQ6Tgj0o3HYMT/pfJr2n
         kjwzSr65zRs8e76mtma+2iOjxmNAqybrXTDO804duu7l4n9plmTelyLuXUUCe6sRu42M
         MYaJbo8/Ha38meP4QbbajReufb5yeOWUsELqwh1tn+PVW6WIXZraVWNMZ1bs+E2Z60C3
         +JmhUPO2s7Vwn7ONG6jWg3NNl8tbN77Lo1ZxZaQB3W9u3TvvpATnYJsAqQHKzXn7ar71
         pvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZpgAl6fMrlc5u+7N0e4lNcYAQFE8vx0PX4usrIn+P0=;
        b=LubMQbGXbxThJCRM52o+5ctStUKc2lTepctie5jIPf1+IzYz8ykajDovPn1vcMXM/l
         V9GA7l+ed/7MHY4/lWm4BK95PvFHaQfYBQuiwyK+0HiownrAqUb3c/en9hVhelx8pCjh
         PEv+QzZX6xBvMg80ha5bBZi9pAorojtcmMUgJTqRIQSEhUuK/uticAnNSIFVtfgapzf6
         NL0pjC+GWH0RvPmmXqEsoxAWNGVOIyFqm/NlHaFhj9kjp2tVz7J8RV5nKP/Az//Iejzf
         44vSnVqOtXqkD1kSIiBCSxneQNLAYMfwtPDx8fFYy9R6lI4pKhOEmQIVwcTP+ZRDXDye
         PQpw==
X-Gm-Message-State: AGi0PuaNwR04nWxkWGQjxpzRS118jV230HoYT3Mi1+zBKx+G2DX0BFIL
        2uuyYjEBaQDnK1/iUxwo9PH5Sw==
X-Google-Smtp-Source: APiQypLW6Nig0UV3UxPwMQWsDextdgKl/RgP7EjE2YYldolo5oR0wfSM+K/XSQ+tU3/0TJN/EhOlAQ==
X-Received: by 2002:a1c:bd89:: with SMTP id n131mr3334436wmf.3.1588258138333;
        Thu, 30 Apr 2020 07:48:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id a1sm4278392wrn.80.2020.04.30.07.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:48:57 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 07/15] arm64: kvm: Split hyp/tlb.c to VHE/nVHE
Date:   Thu, 30 Apr 2020 15:48:23 +0100
Message-Id: <20200430144831.59194-8-dbrazdil@google.com>
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

tlb.c contains code for flushing the TLB, with parts shared between VHE/nVHE.
These common routines are moved into a header file tlb.h, VHE-specific code
remains in tlb.c and nVHE-specific code is moved to nvhe/tlb.c.

The header file expects its users to implement two helper functions declared
at the top of the file.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h   |   8 +-
 arch/arm64/kvm/hyp/nvhe/Makefile |   2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c    |  69 +++++++++++++
 arch/arm64/kvm/hyp/tlb.c         | 170 +++----------------------------
 arch/arm64/kvm/hyp/tlb.h         | 129 +++++++++++++++++++++++
 5 files changed, 216 insertions(+), 162 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/tlb.c
 create mode 100644 arch/arm64/kvm/hyp/tlb.h

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 59c53566eceb..c0a0ec238854 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -62,14 +62,11 @@ __efistub__ctype		= _ctype;
  */
 
 __hyp_text___guest_exit = __guest_exit;
+__hyp_text___icache_flags = __icache_flags;
 __hyp_text___kvm_enable_ssbs = __kvm_enable_ssbs;
-__hyp_text___kvm_flush_vm_context = __kvm_flush_vm_context;
 __hyp_text___kvm_get_mdcr_el2 = __kvm_get_mdcr_el2;
 __hyp_text___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
 __hyp_text___kvm_timer_set_cntvoff = __kvm_timer_set_cntvoff;
-__hyp_text___kvm_tlb_flush_local_vmid = __kvm_tlb_flush_local_vmid;
-__hyp_text___kvm_tlb_flush_vmid = __kvm_tlb_flush_vmid;
-__hyp_text___kvm_tlb_flush_vmid_ipa = __kvm_tlb_flush_vmid_ipa;
 __hyp_text___kvm_vcpu_run_nvhe = __kvm_vcpu_run_nvhe;
 __hyp_text___vgic_v3_get_ich_vtr_el2 = __vgic_v3_get_ich_vtr_el2;
 __hyp_text___vgic_v3_init_lrs = __vgic_v3_init_lrs;
@@ -79,8 +76,11 @@ __hyp_text___vgic_v3_save_aprs = __vgic_v3_save_aprs;
 __hyp_text___vgic_v3_write_vmcr = __vgic_v3_write_vmcr;
 __hyp_text_abort_guest_exit_end = abort_guest_exit_end;
 __hyp_text_abort_guest_exit_start = abort_guest_exit_start;
+__hyp_text_arm64_const_caps_ready = arm64_const_caps_ready;
 __hyp_text_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
 __hyp_text_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
+__hyp_text_cpu_hwcap_keys = cpu_hwcap_keys;
+__hyp_text_cpu_hwcaps = cpu_hwcaps;
 __hyp_text_hyp_panic = hyp_panic;
 __hyp_text_kimage_voffset = kimage_voffset;
 __hyp_text_kvm_host_data = kvm_host_data;
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index fa20b2723652..0da836cb5580 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,7 @@ asflags-y := -D__HYPERVISOR__
 ccflags-y := -D__HYPERVISOR__ -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 	     $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y := host_hypercall.o ../hyp-entry.o
+obj-y := tlb.o host_hypercall.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
new file mode 100644
index 000000000000..1b8f4000f98c
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <linux/irqflags.h>
+
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+#include <asm/tlbflush.h>
+
+#include "../tlb.h"
+
+static void __hyp_text __tlb_switch_to_guest(struct kvm *kvm,
+					     struct tlb_inv_context *cxt)
+{
+	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
+		u64 val;
+
+		/*
+		 * For CPUs that are affected by ARM 1319367, we need to
+		 * avoid a host Stage-1 walk while we have the guest's
+		 * VMID set in the VTTBR in order to invalidate TLBs.
+		 * We're guaranteed that the S1 MMU is enabled, so we can
+		 * simply set the EPD bits to avoid any further TLB fill.
+		 */
+		val = cxt->tcr = read_sysreg_el1(SYS_TCR);
+		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
+		write_sysreg_el1(val, SYS_TCR);
+		isb();
+	}
+
+	__load_guest_stage2(kvm);
+	isb();
+}
+
+static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
+					    struct tlb_inv_context *cxt)
+{
+	write_sysreg(0, vttbr_el2);
+
+	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
+		/* Ensure write of the host VMID */
+		isb();
+		/* Restore the host's TCR_EL1 */
+		write_sysreg_el1(cxt->tcr, SYS_TCR);
+	}
+}
+
+void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
+{
+	__tlb_flush_vmid_ipa(kvm, ipa);
+}
+
+void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
+{
+	__tlb_flush_vmid(kvm);
+}
+
+void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
+{
+	__tlb_flush_local_vmid(vcpu);
+}
+
+void __hyp_text __kvm_flush_vm_context(void)
+{
+	__tlb_flush_vm_context();
+}
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index ceaddbe4279f..ab55b0c4a80c 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -10,14 +10,10 @@
 #include <asm/kvm_mmu.h>
 #include <asm/tlbflush.h>
 
-struct tlb_inv_context {
-	unsigned long	flags;
-	u64		tcr;
-	u64		sctlr;
-};
+#include "tlb.h"
 
-static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
-						 struct tlb_inv_context *cxt)
+static void __hyp_text __tlb_switch_to_guest(struct kvm *kvm,
+					     struct tlb_inv_context *cxt)
 {
 	u64 val;
 
@@ -60,40 +56,8 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 	isb();
 }
 
-static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
-						  struct tlb_inv_context *cxt)
-{
-	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
-		u64 val;
-
-		/*
-		 * For CPUs that are affected by ARM 1319367, we need to
-		 * avoid a host Stage-1 walk while we have the guest's
-		 * VMID set in the VTTBR in order to invalidate TLBs.
-		 * We're guaranteed that the S1 MMU is enabled, so we can
-		 * simply set the EPD bits to avoid any further TLB fill.
-		 */
-		val = cxt->tcr = read_sysreg_el1(SYS_TCR);
-		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
-		write_sysreg_el1(val, SYS_TCR);
-		isb();
-	}
-
-	__load_guest_stage2(kvm);
-	isb();
-}
-
-static void __hyp_text __tlb_switch_to_guest(struct kvm *kvm,
-					     struct tlb_inv_context *cxt)
-{
-	if (has_vhe())
-		__tlb_switch_to_guest_vhe(kvm, cxt);
-	else
-		__tlb_switch_to_guest_nvhe(kvm, cxt);
-}
-
-static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
-						struct tlb_inv_context *cxt)
+static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
+					    struct tlb_inv_context *cxt)
 {
 	/*
 	 * We're done with the TLB operation, let's restore the host's
@@ -112,130 +76,22 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
 	local_irq_restore(cxt->flags);
 }
 
-static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
-						 struct tlb_inv_context *cxt)
+void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
-	write_sysreg(0, vttbr_el2);
-
-	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
-		/* Ensure write of the host VMID */
-		isb();
-		/* Restore the host's TCR_EL1 */
-		write_sysreg_el1(cxt->tcr, SYS_TCR);
-	}
+	__tlb_flush_vmid_ipa(kvm, ipa);
 }
 
-static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
-					    struct tlb_inv_context *cxt)
+void __kvm_tlb_flush_vmid(struct kvm *kvm)
 {
-	if (has_vhe())
-		__tlb_switch_to_host_vhe(kvm, cxt);
-	else
-		__tlb_switch_to_host_nvhe(kvm, cxt);
+	__tlb_flush_vmid(kvm);
 }
 
-void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
+void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
 {
-	struct tlb_inv_context cxt;
-
-	dsb(ishst);
-
-	/* Switch to requested VMID */
-	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest(kvm, &cxt);
-
-	/*
-	 * We could do so much better if we had the VA as well.
-	 * Instead, we invalidate Stage-2 for this IPA, and the
-	 * whole of Stage-1. Weep...
-	 */
-	ipa >>= 12;
-	__tlbi(ipas2e1is, ipa);
-
-	/*
-	 * We have to ensure completion of the invalidation at Stage-2,
-	 * since a table walk on another CPU could refill a TLB with a
-	 * complete (S1 + S2) walk based on the old Stage-2 mapping if
-	 * the Stage-1 invalidation happened first.
-	 */
-	dsb(ish);
-	__tlbi(vmalle1is);
-	dsb(ish);
-	isb();
-
-	/*
-	 * If the host is running at EL1 and we have a VPIPT I-cache,
-	 * then we must perform I-cache maintenance at EL2 in order for
-	 * it to have an effect on the guest. Since the guest cannot hit
-	 * I-cache lines allocated with a different VMID, we don't need
-	 * to worry about junk out of guest reset (we nuke the I-cache on
-	 * VMID rollover), but we do need to be careful when remapping
-	 * executable pages for the same guest. This can happen when KSM
-	 * takes a CoW fault on an executable page, copies the page into
-	 * a page that was previously mapped in the guest and then needs
-	 * to invalidate the guest view of the I-cache for that page
-	 * from EL1. To solve this, we invalidate the entire I-cache when
-	 * unmapping a page from a guest if we have a VPIPT I-cache but
-	 * the host is running at EL1. As above, we could do better if
-	 * we had the VA.
-	 *
-	 * The moral of this story is: if you have a VPIPT I-cache, then
-	 * you should be running with VHE enabled.
-	 */
-	if (!has_vhe() && icache_is_vpipt())
-		__flush_icache_all();
-
-	__tlb_switch_to_host(kvm, &cxt);
+	__tlb_flush_local_vmid(vcpu);
 }
 
-void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
+void __kvm_flush_vm_context(void)
 {
-	struct tlb_inv_context cxt;
-
-	dsb(ishst);
-
-	/* Switch to requested VMID */
-	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest(kvm, &cxt);
-
-	__tlbi(vmalls12e1is);
-	dsb(ish);
-	isb();
-
-	__tlb_switch_to_host(kvm, &cxt);
-}
-
-void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
-{
-	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
-	struct tlb_inv_context cxt;
-
-	/* Switch to requested VMID */
-	__tlb_switch_to_guest(kvm, &cxt);
-
-	__tlbi(vmalle1);
-	dsb(nsh);
-	isb();
-
-	__tlb_switch_to_host(kvm, &cxt);
-}
-
-void __hyp_text __kvm_flush_vm_context(void)
-{
-	dsb(ishst);
-	__tlbi(alle1is);
-
-	/*
-	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
-	 * is necessary across a VMID rollover.
-	 *
-	 * VPIPT caches constrain lookup and maintenance to the active VMID,
-	 * so we need to invalidate lines with a stale VMID to avoid an ABA
-	 * race after multiple rollovers.
-	 *
-	 */
-	if (icache_is_vpipt())
-		asm volatile("ic ialluis");
-
-	dsb(ish);
+	__tlb_flush_vm_context();
 }
diff --git a/arch/arm64/kvm/hyp/tlb.h b/arch/arm64/kvm/hyp/tlb.h
new file mode 100644
index 000000000000..f62ed96cb896
--- /dev/null
+++ b/arch/arm64/kvm/hyp/tlb.h
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <linux/irqflags.h>
+
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+#include <asm/tlbflush.h>
+
+struct tlb_inv_context {
+	unsigned long	flags;
+	u64		tcr;
+	u64		sctlr;
+};
+
+static void __hyp_text __tlb_switch_to_guest(struct kvm *kvm,
+					     struct tlb_inv_context *cxt);
+static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
+					    struct tlb_inv_context *cxt);
+
+static inline void __hyp_text
+__tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
+{
+	struct tlb_inv_context cxt;
+
+	dsb(ishst);
+
+	/* Switch to requested VMID */
+	kvm = kern_hyp_va(kvm);
+	__tlb_switch_to_guest(kvm, &cxt);
+
+	/*
+	 * We could do so much better if we had the VA as well.
+	 * Instead, we invalidate Stage-2 for this IPA, and the
+	 * whole of Stage-1. Weep...
+	 */
+	ipa >>= 12;
+	__tlbi(ipas2e1is, ipa);
+
+	/*
+	 * We have to ensure completion of the invalidation at Stage-2,
+	 * since a table walk on another CPU could refill a TLB with a
+	 * complete (S1 + S2) walk based on the old Stage-2 mapping if
+	 * the Stage-1 invalidation happened first.
+	 */
+	dsb(ish);
+	__tlbi(vmalle1is);
+	dsb(ish);
+	isb();
+
+	/*
+	 * If the host is running at EL1 and we have a VPIPT I-cache,
+	 * then we must perform I-cache maintenance at EL2 in order for
+	 * it to have an effect on the guest. Since the guest cannot hit
+	 * I-cache lines allocated with a different VMID, we don't need
+	 * to worry about junk out of guest reset (we nuke the I-cache on
+	 * VMID rollover), but we do need to be careful when remapping
+	 * executable pages for the same guest. This can happen when KSM
+	 * takes a CoW fault on an executable page, copies the page into
+	 * a page that was previously mapped in the guest and then needs
+	 * to invalidate the guest view of the I-cache for that page
+	 * from EL1. To solve this, we invalidate the entire I-cache when
+	 * unmapping a page from a guest if we have a VPIPT I-cache but
+	 * the host is running at EL1. As above, we could do better if
+	 * we had the VA.
+	 *
+	 * The moral of this story is: if you have a VPIPT I-cache, then
+	 * you should be running with VHE enabled.
+	 */
+	if (!has_vhe() && icache_is_vpipt())
+		__flush_icache_all();
+
+	__tlb_switch_to_host(kvm, &cxt);
+}
+
+static inline void __hyp_text __tlb_flush_vmid(struct kvm *kvm)
+{
+	struct tlb_inv_context cxt;
+
+	dsb(ishst);
+
+	/* Switch to requested VMID */
+	kvm = kern_hyp_va(kvm);
+	__tlb_switch_to_guest(kvm, &cxt);
+
+	__tlbi(vmalls12e1is);
+	dsb(ish);
+	isb();
+
+	__tlb_switch_to_host(kvm, &cxt);
+}
+
+static inline void __hyp_text __tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
+	struct tlb_inv_context cxt;
+
+	/* Switch to requested VMID */
+	__tlb_switch_to_guest(kvm, &cxt);
+
+	__tlbi(vmalle1);
+	dsb(nsh);
+	isb();
+
+	__tlb_switch_to_host(kvm, &cxt);
+}
+
+static inline void __hyp_text __tlb_flush_vm_context(void)
+{
+	dsb(ishst);
+	__tlbi(alle1is);
+
+	/*
+	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
+	 * is necessary across a VMID rollover.
+	 *
+	 * VPIPT caches constrain lookup and maintenance to the active VMID,
+	 * so we need to invalidate lines with a stale VMID to avoid an ABA
+	 * race after multiple rollovers.
+	 *
+	 */
+	if (icache_is_vpipt())
+		asm volatile("ic ialluis");
+
+	dsb(ish);
+}
-- 
2.26.1

