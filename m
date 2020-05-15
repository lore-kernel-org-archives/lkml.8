Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46361C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FB22074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oma0VpTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEOK7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgEOK7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:59:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EABC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v12so2965384wrp.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjCPJFyitkarvdcIAJOPK9PQxgRJtbWF1KhO25l4eJg=;
        b=Oma0VpTczioC+4xeRB75kaYXI2lIGZ/yWMfNQF1XwTrYqF+DyTsmW6MZNPqtWYQtaH
         yDurhLMFaF6JChKVKItlTc7HqbY6bSUlBg7eAqJNR9k84NxwVD3rOTryV8+aEJpqB8ab
         X065e0TX+rpDWuE7bKAe2zvyz7QtT/+KqDHMSkjshY+MN9tSCbLn0fvoNC8W9SPlQHdF
         JHi5HLpuNCKsG4VxuQZ0tn9p7U6/m3T2dfsKHK92ai1BBh2f2upZ1CmHnbHsGnqy8wgo
         blBnIfCM97l/BpfiFpcJMTxU/G/IjMvYLk2TnkM+cZbFYwbZqDkD7ufOmNMMEEu/2TNN
         LI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjCPJFyitkarvdcIAJOPK9PQxgRJtbWF1KhO25l4eJg=;
        b=MQyN2ykwU5mmqQ018g/fCBMbE+rlJBIaCpiVj9iXZbTiMRkemSFM3sCuqVd6N8sH6X
         5AnPxIBfQBFbNycpvGve8xOexDEI6KGAi9r2VInmOC+UOkKGpqdR+8yXyVP8UnhFQ2DL
         96BWsgWJW7TJJSgMLfJOizBvH6QMa0Gf2tYF4gpMqTOcizYKM8dxl90XVByxHOXJd0Tc
         wxPp48dv+WvjeA/vQfDFtq+l17FMW1uPy5O/IoM9Jir4bU5ADtMLdsyEnSvqXMeef6Jr
         2CCcNh5wMkeBMRc/kWC9YzfWAXT8F44NYh8otjo0eM9ZuUR2ShmVQSr0F/kslsYqpDL9
         4N0w==
X-Gm-Message-State: AOAM531gu6PQFRkxBZfX3szFUAyeTAtPy0mxVyCPlzpYansxZyUDlY1U
        WpIbK+rc7WqjK+0esnwZzsdutg==
X-Google-Smtp-Source: ABdhPJzageDhpllf/yEdmFCfj98cPDS81048Tth+APVCmjc5qLlKcXX2da74AD8VO7humjw9AJcACg==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr3574476wru.407.1589540339421;
        Fri, 15 May 2020 03:58:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id s2sm3010008wme.33.2020.05.15.03.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:58:58 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 03/14] arm64: kvm: Formalize hypcall ABI
Date:   Fri, 15 May 2020 11:58:30 +0100
Message-Id: <20200515105841.73532-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unmapping .hyp.text from kernel memory mappings, convert the
current EL1 - EL2 KVM ABI to use hypercall numbers in lieu of direct function
pointers. While this in itself does not provide any isolation, it is a first
step towards having a well-defined EL2 ABI.

The implementation is based on a jump table to known host HVC handlers indexed
by the hypercall ID. Relative-offset branches were chosen over
a sys_call_table-like array of function pointers to avoid the need for
re-computing the addresses under hyp memory mappings.

Hypcall IDs start at 0x1000 because comments in hyp.S state that lower IDs
are allocated for hyp stub operations. This was not originally honored by
hyp-entry.S, only the actually used IDs would be recognized and all other
values would be treated as function pointers. This is cleaned up and all IDs
lower than 0x1000 are routed to __kvm_handle_stub_hvc.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_host.h            | 10 ++--
 arch/arm64/include/asm/kvm_host_hypercalls.h | 59 ++++++++++++++++++++
 arch/arm64/kvm/hyp.S                         | 18 +++---
 arch/arm64/kvm/hyp/hyp-entry.S               | 56 +++++++++++--------
 4 files changed, 107 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_host_hypercalls.h

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 32c8a675e5a4..132233b6d853 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -24,6 +24,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_host_hypercalls.h>
 #include <asm/thread_info.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -446,7 +447,7 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
-u64 __kvm_call_hyp(void *hypfn, ...);
+u64 __kvm_call_hyp(unsigned long hcall_id, ...);
 
 /*
  * The couple of isb() below are there to guarantee the same behaviour
@@ -459,7 +460,8 @@ u64 __kvm_call_hyp(void *hypfn, ...);
 			f(__VA_ARGS__);					\
 			isb();						\
 		} else {						\
-			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
+			__kvm_call_hyp(KVM_HOST_HCALL_ID(f),		\
+				       ##__VA_ARGS__);			\
 		}							\
 	} while(0)
 
@@ -471,7 +473,7 @@ u64 __kvm_call_hyp(void *hypfn, ...);
 			ret = f(__VA_ARGS__);				\
 			isb();						\
 		} else {						\
-			ret = __kvm_call_hyp(kvm_ksym_ref(f),		\
+			ret = __kvm_call_hyp(KVM_HOST_HCALL_ID(f),	\
 					     ##__VA_ARGS__);		\
 		}							\
 									\
@@ -551,7 +553,7 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!system_capabilities_finalized());
-	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
+	__kvm_call_hyp((unsigned long)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
 
 	/*
 	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
diff --git a/arch/arm64/include/asm/kvm_host_hypercalls.h b/arch/arm64/include/asm/kvm_host_hypercalls.h
new file mode 100644
index 000000000000..ed02878fbda5
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_host_hypercalls.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Google, inc
+ */
+
+#ifndef __KVM_HOST_HCALL
+#define __KVM_HOST_HCALL(x)
+#endif
+
+#define __KVM_HOST_HCALL_ID___kvm_enable_ssbs			0
+__KVM_HOST_HCALL(__kvm_enable_ssbs)
+
+#define __KVM_HOST_HCALL_ID___kvm_get_mdcr_el2			1
+__KVM_HOST_HCALL(__kvm_get_mdcr_el2)
+
+#define __KVM_HOST_HCALL_ID___kvm_timer_set_cntvoff		2
+__KVM_HOST_HCALL(__kvm_timer_set_cntvoff)
+
+#define __KVM_HOST_HCALL_ID___kvm_tlb_flush_local_vmid		3
+__KVM_HOST_HCALL(__kvm_tlb_flush_local_vmid)
+
+#define __KVM_HOST_HCALL_ID___kvm_flush_vm_context		4
+__KVM_HOST_HCALL(__kvm_flush_vm_context)
+
+#define __KVM_HOST_HCALL_ID___kvm_vcpu_run_nvhe			5
+__KVM_HOST_HCALL(__kvm_vcpu_run_nvhe)
+
+#define __KVM_HOST_HCALL_ID___kvm_tlb_flush_vmid		6
+__KVM_HOST_HCALL(__kvm_tlb_flush_vmid)
+
+#define __KVM_HOST_HCALL_ID___kvm_tlb_flush_vmid_ipa		7
+__KVM_HOST_HCALL(__kvm_tlb_flush_vmid_ipa)
+
+#define __KVM_HOST_HCALL_ID___vgic_v3_init_lrs			8
+__KVM_HOST_HCALL(__vgic_v3_init_lrs)
+
+#define __KVM_HOST_HCALL_ID___vgic_v3_get_ich_vtr_el2		9
+__KVM_HOST_HCALL(__vgic_v3_get_ich_vtr_el2)
+
+#define __KVM_HOST_HCALL_ID___vgic_v3_write_vmcr		10
+__KVM_HOST_HCALL(__vgic_v3_write_vmcr)
+
+#define __KVM_HOST_HCALL_ID___vgic_v3_restore_aprs		11
+__KVM_HOST_HCALL(__vgic_v3_restore_aprs)
+
+#define __KVM_HOST_HCALL_ID___vgic_v3_read_vmcr			12
+__KVM_HOST_HCALL(__vgic_v3_read_vmcr)
+
+#define __KVM_HOST_HCALL_ID___vgic_v3_save_aprs			13
+__KVM_HOST_HCALL(__vgic_v3_save_aprs)
+
+#define KVM_HOST_HCALL_NR					14
+
+/*
+ * Offset KVM hypercall IDs to avoid clashing with stub hypercalls
+ * (defined in asm/virt.h).
+ */
+#define KVM_HOST_HCALL_BASE 	(0x1000UL)
+#define KVM_HOST_HCALL_ID(name) (KVM_HOST_HCALL_BASE + __KVM_HOST_HCALL_ID_##name)
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 3c79a1124af2..f603d03cb599 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -11,22 +11,20 @@
 #include <asm/cpufeature.h>
 
 /*
- * u64 __kvm_call_hyp(void *hypfn, ...);
+ * u64 __kvm_call_hyp(unsigned long hcall_id, ...);
  *
  * This is not really a variadic function in the classic C-way and care must
  * be taken when calling this to ensure parameters are passed in registers
  * only, since the stack will change between the caller and the callee.
  *
- * Call the function with the first argument containing a pointer to the
- * function you wish to call in Hyp mode, and subsequent arguments will be
- * passed as x0, x1, and x2 (a maximum of 3 arguments in addition to the
- * function pointer can be passed).  The function being called must be mapped
- * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
- * passed in x0.
+ * Call the function with the first argument containing ID of the function
+ * you wish to call in Hyp mode, as defined in kvm_host_hypercalls.h, and
+ * subsequent arguments will be passed as x0, x1, and x2 (a maximum of
+ * 3 arguments in addition to the hypcall ID can be passed). Return values
+ * are passed in x0.
  *
- * A function pointer with a value less than 0xfff has a special meaning,
- * and is used to implement hyp stubs in the same way as in
- * arch/arm64/kernel/hyp_stub.S.
+ * Hypcalls with ID less than 0x1000 are propagated to operations implemented
+ * in arch/arm64/kernel/hyp_stub.S.
  */
 SYM_FUNC_START(__kvm_call_hyp)
 	hvc	#0
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 65ff99a7e02d..ab14de8d0131 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -13,25 +13,12 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_host_hypercalls.h>
 #include <asm/mmu.h>
 
 	.text
 	.pushsection	.hyp.text, "ax"
 
-.macro do_el2_call
-	/*
-	 * Shuffle the parameters before calling the function
-	 * pointed to in x0. Assumes parameters in x[1,2,3].
-	 */
-	str	lr, [sp, #-16]!
-	mov	lr, x0
-	mov	x0, x1
-	mov	x1, x2
-	mov	x2, x3
-	blr	lr
-	ldr	lr, [sp], #16
-.endm
-
 el1_sync:				// Guest trapped into EL2
 
 	mrs	x0, esr_el2
@@ -46,9 +33,9 @@ el1_sync:				// Guest trapped into EL2
 	/* Here, we're pretty sure the host called HVC. */
 	ldp	x0, x1, [sp], #16
 
-	/* Check for a stub HVC call */
-	cmp	x0, #HVC_STUB_HCALL_NR
-	b.hs	1f
+	/* Check if hcall ID (x0) is in the hyp stub hypercall range. */
+	cmp	x0, #KVM_HOST_HCALL_BASE
+	b.hs	el1_host_hcall
 
 	/*
 	 * Compute the idmap address of __kvm_handle_stub_hvc and
@@ -65,13 +52,38 @@ el1_sync:				// Guest trapped into EL2
 	sub	x5, x5, x6
 	br	x5
 
+el1_host_hcall:
+	/* Check if hcall ID (x0) is in the KVM host hypercall range. */
+	sub	x0, x0, #KVM_HOST_HCALL_BASE
+	cmp	x0, #KVM_HOST_HCALL_NR
+	b.hs	el1_host_invalid_hvc
+
+	/* Compute address of corresponding branch in the jump table below. */
+	adr	x10, 1f
+	add	x10, x10, x0, lsl #2
+
+	/* Call the host HVC handler. Arguments are in x[1,2,3]. */
+	mov	x0, x1
+	mov	x1, x2
+	mov	x2, x3
+	str	lr, [sp, #-16]!
+	adr	lr, 2f
+	br	x10
+
+	/* Generate jump table of branches to all defined host HVC handlers. */
 1:
-	/*
-	 * Perform the EL2 call
-	 */
-	kern_hyp_va	x0
-	do_el2_call
+#undef __KVM_HOST_HCALL
+#define __KVM_HOST_HCALL(hcall_fn_name) \
+	b	hcall_fn_name
+#include <asm/kvm_host_hypercalls.h>
+
+2:
+	ldr	lr, [sp], #16
+	eret
+	sb
 
+el1_host_invalid_hvc:
+	mov	x0, -ENOSYS
 	eret
 	sb
 
-- 
2.26.2

