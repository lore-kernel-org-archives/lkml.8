Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2745C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2B1207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6rqhLs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgFRM3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgFRM0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:26:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2171C061796
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:26:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r9so5005797wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyJVc4e+GoUAEUncaRu7Abitq8XUwuB4SemkCGVL7hU=;
        b=j6rqhLs+9os6IUKzcc97SvmbzHvnm7iqekCNBV594Zz30SPAzzCrDgd66fUViZUI2O
         K8z74PXDmGJBAuIgnxkGg4mCcAmULENp3iY4u++w/w6LgKk9ZACdhRBzvItmpMrPQKF+
         R+/nF1ktCKfoT7htrA46PeHuWXPobMcsq7yu1TnjnM8f2rI+Qasb3LcxvkSwHbwQTsn3
         gKyDSsnPYr2uut1d01KbynGrj2nuWCBCFM/pK3RcJZxQv16IA4IQoySJVSG9PXxkksHe
         QbccuKwjmDkQcSY+6ZwqLpcDDD5yAsnzn6vXNg1M0Ch0YZ/IcuFacuxZ02lQ4Sw+QAwR
         4gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyJVc4e+GoUAEUncaRu7Abitq8XUwuB4SemkCGVL7hU=;
        b=aFhxYKC0B/4oLUaqy8z7+n7rKOPT+6MQPU+cGjs7mJAx8nVOr/Y9oIpz1b1xeZF+rW
         3twIn5qObGipB6a7vbUxiCDU4OiJLUoYCM+e6eGk3FsN2iTBKTtucOUHoRtn9Xx3iZBP
         wu1WxF+pHSYvu/a0I7NHuv5bt2MJpoCb7CsYiS++/P0O62JX9ASzjq4wGf0q64XDIDZ4
         O3KGy5LrlFBb4dNg0aBKyilUg6cJ0XjFKMDA6l1dkVlPAPb5Y7b1gCGLuyhDjf8+Bnn3
         667gfBVYRn6eKHWb6Ue3nAftBW4FQACRb4+lxRVyHwqv6rFdpwzywO4QVMrUeh7JLXy0
         co0g==
X-Gm-Message-State: AOAM5324q3YAK/lYoQU6Gf6R9ZCQrj6gnN5fm4azko26XPR1EWwWF6M3
        FRIzqC517Imz+d/L4O1qxChawQ==
X-Google-Smtp-Source: ABdhPJxpr4HRSO92YDjrRYPnbc5L3TTKiVCvuPbkGpjbaCdfcJuGc2VlZl8Wnwp1JTVFdgXjnGyXRQ==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr3791350wmf.4.1592483159389;
        Thu, 18 Jun 2020 05:25:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
        by smtp.gmail.com with ESMTPSA id q13sm3400341wrn.84.2020.06.18.05.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:25:58 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, Andrew Scull <ascull@google.com>
Subject: [PATCH v3 06/15] arm64: kvm: Move hyp-init.S to nVHE
Date:   Thu, 18 Jun 2020 13:25:28 +0100
Message-Id: <20200618122537.9625-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618122537.9625-1-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Scull <ascull@google.com>

This patch is part of a series which builds KVM's non-VHE hyp code
separately from VHE and the rest of the kernel.

hyp-init.S contains the identity mapped initialisation code for the
non-VHE code that runs at EL2. It is only used for non-VHE.

Adjust code that calls into this to use the prefixed symbol name.

Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/include/asm/kvm_asm.h         | 4 +---
 arch/arm64/kernel/image-vars.h           | 3 ++-
 arch/arm64/kvm/Makefile                  | 2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile         | 2 +-
 arch/arm64/kvm/{ => hyp/nvhe}/hyp-init.S | 0
 arch/arm64/kvm/mmu.c                     | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)
 rename arch/arm64/kvm/{ => hyp/nvhe}/hyp-init.S (100%)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 2baa69324cc9..bab14b64c4fc 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -73,9 +73,7 @@
 struct kvm;
 struct kvm_vcpu;
 
-extern char __kvm_hyp_init[];
-extern char __kvm_hyp_init_end[];
-
+DECLARE_KVM_NVHE_SYM(__kvm_hyp_init);
 DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
 
 #ifdef CONFIG_KVM_INDIRECT_VECTORS
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index dc7ee85531f5..4dc969ccda9e 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -62,10 +62,10 @@ __efistub__ctype		= _ctype;
  */
 
 __kvm_nvhe___guest_exit = __guest_exit;
+__kvm_nvhe___hyp_stub_vectors = __hyp_stub_vectors;
 __kvm_nvhe___kvm_enable_ssbs = __kvm_enable_ssbs;
 __kvm_nvhe___kvm_flush_vm_context = __kvm_flush_vm_context;
 __kvm_nvhe___kvm_get_mdcr_el2 = __kvm_get_mdcr_el2;
-__kvm_nvhe___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
 __kvm_nvhe___kvm_timer_set_cntvoff = __kvm_timer_set_cntvoff;
 __kvm_nvhe___kvm_tlb_flush_local_vmid = __kvm_tlb_flush_local_vmid;
 __kvm_nvhe___kvm_tlb_flush_vmid = __kvm_tlb_flush_vmid;
@@ -82,6 +82,7 @@ __kvm_nvhe_abort_guest_exit_start = abort_guest_exit_start;
 __kvm_nvhe_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
 __kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
 __kvm_nvhe_hyp_panic = hyp_panic;
+__kvm_nvhe_idmap_t0sz = idmap_t0sz;
 __kvm_nvhe_kimage_voffset = kimage_voffset;
 __kvm_nvhe_kvm_host_data = kvm_host_data;
 __kvm_nvhe_kvm_patch_vector_branch = kvm_patch_vector_branch;
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 8d3d9513cbfe..152d8845a1a2 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_KVM) += hyp/
 kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 $(KVM)/vfio.o $(KVM)/irqchip.o \
 	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
-	 inject_fault.o regmap.o va_layout.o hyp.o hyp-init.o handle_exit.o \
+	 inject_fault.o regmap.o va_layout.o hyp.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o sys_regs_generic_v8.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
 	 aarch32.o arch_timer.o \
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index c68801e24950..fef6f1881765 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -fno-stack-protector \
 	     -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y := ../hyp-entry.o
+obj-y := hyp-init.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
similarity index 100%
rename from arch/arm64/kvm/hyp-init.S
rename to arch/arm64/kvm/hyp/nvhe/hyp-init.S
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 8c0035cab6b6..592afe5e7003 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2346,7 +2346,7 @@ int kvm_mmu_init(void)
 	hyp_idmap_start = ALIGN_DOWN(hyp_idmap_start, PAGE_SIZE);
 	hyp_idmap_end = __pa_symbol(__hyp_idmap_text_end);
 	hyp_idmap_end = ALIGN(hyp_idmap_end, PAGE_SIZE);
-	hyp_idmap_vector = __pa_symbol(__kvm_hyp_init);
+	hyp_idmap_vector = __pa_symbol(kvm_nvhe_sym(__kvm_hyp_init));
 
 	/*
 	 * We rely on the linker script to ensure at build time that the HYP
-- 
2.27.0

