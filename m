Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE293C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9667B2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nB5mGeq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgD3Oss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgD3Osr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:48:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7F1C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d15so7287975wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egiaFql39oEuCKp35vVM/J/wvaPk77SfjBPWeNkN4EQ=;
        b=nB5mGeq0nTBVhKlnlqv4Llt0TMP/aUts+rgtLkxieNFwbpS41LiH7YeZKayOBo7F+R
         C3s4TIXXrD2+7E3b4ohJJ2Axs6LeH0ESvFLXJcz1iiu5IstRNMxv3dn3yELniPZnFWrs
         vsYG1qystGlIFHe//U0q7sO/lFVYTbWPdfvdbjkAjh1ZyR6EeQKWtYh6EPRFSkl+2z8O
         Yv72rkqEG0i4koppCee/TOUYda74E3W6fuXQN7lW+Vx7NTL38ItNprvxrtlNGySkR93U
         nd2G+yQBBQlo1xbNXoHA3RsGqs0vI4ioWSV2ho9NyPiw+ANPIUVXPy5gfkspHmdfwZIN
         3Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egiaFql39oEuCKp35vVM/J/wvaPk77SfjBPWeNkN4EQ=;
        b=jUFJgwFxP0cqcYN/JjKxEQd/hKAWzK9aB2tdAk+vobQnZVClgN2M9cvu4OjjjtcgEw
         M25uo8HxuCurHKjgdv+Yx1Nee22t0QSLLe55xp9lax2XpAEiwV9V7OGmwIpYZg4bBS0m
         ZkgMEOps8N1jqZkhfuzi7Xrr6tXneNLRh03Q8StqiQVBMNO3DMDYSOnS3QHf5IxsEuNo
         fA0DL0NsQwGbfSwdlWPMkvc43T7Ob8xPFENTsvk6eHfQfUje83WtE4EoO2NqotLtz0yf
         MFv6dirFn3x6gRU55KPcqwlDz1qpXpIlrkL2A5hyqiW388UrjG/dfe7k2gXvjzxZIcF4
         fqkg==
X-Gm-Message-State: AGi0PuaGBsRiSpcg3cH+WU1cf8wKXBjrHh542SCeO21dKWh6P7F6R92O
        /BYU9uavFJqzBdqqYUbVaJ39dA==
X-Google-Smtp-Source: APiQypJGJ907ybuWp6RcJm5F8T2ltyVdz4fgwI8zgjD+9wF/LoP/M+k/GKpCYyXi1j2aYnHd1X/BSw==
X-Received: by 2002:a5d:4241:: with SMTP id s1mr4269423wrr.250.1588258125018;
        Thu, 30 Apr 2020 07:48:45 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id d143sm12354301wmd.16.2020.04.30.07.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:48:43 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH 01/15] arm64: kvm: Unify users of HVC instruction
Date:   Thu, 30 Apr 2020 15:48:17 +0100
Message-Id: <20200430144831.59194-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <qperret@google.com>

Currently, the arm64 KVM code provides __kvm_call_hyp assembly procedure which
does nothing but call the HVC instruction. This is used to call functions by
their pointer in EL2 under nVHE, and abused by __cpu_init_hyp_mode to pass
a data pointer. The hyp-stub code, on the other hand, has its own assembly
procedures for (re)setting hyp vectors.

In preparation for a clean-up of the KVM hypercall interface, unify all HVC
users behind __kvm_call_hyp and remove comments about expected meaning of
arguments.

No functional changes intended.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 12 ++++++-----
 arch/arm64/include/asm/virt.h     | 33 ++++++++++++++++++++++++++++--
 arch/arm64/kernel/hyp-stub.S      | 34 -------------------------------
 arch/arm64/kvm/hyp.S              | 13 +-----------
 4 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 32c8a675e5a4..e61143d6602d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -25,6 +25,7 @@
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/thread_info.h>
+#include <asm/virt.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
@@ -446,7 +447,8 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
-u64 __kvm_call_hyp(void *hypfn, ...);
+#define kvm_call_hyp_nvhe(hypfn, ...) \
+	__kvm_call_hyp((unsigned long)kvm_ksym_ref(hypfn), ##__VA_ARGS__)
 
 /*
  * The couple of isb() below are there to guarantee the same behaviour
@@ -459,7 +461,7 @@ u64 __kvm_call_hyp(void *hypfn, ...);
 			f(__VA_ARGS__);					\
 			isb();						\
 		} else {						\
-			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
+			kvm_call_hyp_nvhe(f, ##__VA_ARGS__);		\
 		}							\
 	} while(0)
 
@@ -471,8 +473,7 @@ u64 __kvm_call_hyp(void *hypfn, ...);
 			ret = f(__VA_ARGS__);				\
 			isb();						\
 		} else {						\
-			ret = __kvm_call_hyp(kvm_ksym_ref(f),		\
-					     ##__VA_ARGS__);		\
+			ret = kvm_call_hyp_nvhe(f, ##__VA_ARGS__);	\
 		}							\
 									\
 		ret;							\
@@ -551,7 +552,8 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!system_capabilities_finalized());
-	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
+	__kvm_call_hyp((unsigned long)pgd_ptr, hyp_stack_ptr, vector_ptr,
+		       tpidr_el2);
 
 	/*
 	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 61fd26752adc..fdc11f819b06 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -62,8 +62,37 @@
  */
 extern u32 __boot_cpu_mode[2];
 
-void __hyp_set_vectors(phys_addr_t phys_vector_base);
-void __hyp_reset_vectors(void);
+/* Make HVC call into the hypervisor. */
+extern u64 __kvm_call_hyp(unsigned long arg, ...);
+
+/*
+ * __hyp_set_vectors: Call this after boot to set the initial hypervisor
+ * vectors as part of hypervisor installation.  On an SMP system, this should
+ * be called on each CPU.
+ *
+ * @phys_vector_base must be the physical address of the new vector table, and
+ * must be 2KB aligned.
+ *
+ * Before calling this, you must check that the stub hypervisor is installed
+ * everywhere, by waiting for any secondary CPUs to be brought up and then
+ * checking that is_hyp_mode_available() is true.
+ *
+ * If not, there is a pre-existing hypervisor, some CPUs failed to boot, or
+ * something else went wrong... in such cases, trying to install a new
+ * hypervisor is unlikely to work as desired.
+ *
+ * When you call into your shiny new hypervisor, sp_el2 will contain junk,
+ * so you will need to set that to something sensible at the new hypervisor's
+ * initialisation entry point.
+ */
+static inline void __hyp_set_vectors(phys_addr_t phys_vector_base)
+{
+	__kvm_call_hyp(HVC_SET_VECTORS, phys_vector_base);
+}
+static inline void __hyp_reset_vectors(void)
+{
+	__kvm_call_hyp(HVC_RESET_VECTORS);
+}
 
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index e473ead806ed..78d4ec5c4290 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -84,37 +84,3 @@ ENDPROC(\label)
 	invalid_vector	el1_irq_invalid
 	invalid_vector	el1_fiq_invalid
 	invalid_vector	el1_error_invalid
-
-/*
- * __hyp_set_vectors: Call this after boot to set the initial hypervisor
- * vectors as part of hypervisor installation.  On an SMP system, this should
- * be called on each CPU.
- *
- * x0 must be the physical address of the new vector table, and must be
- * 2KB aligned.
- *
- * Before calling this, you must check that the stub hypervisor is installed
- * everywhere, by waiting for any secondary CPUs to be brought up and then
- * checking that is_hyp_mode_available() is true.
- *
- * If not, there is a pre-existing hypervisor, some CPUs failed to boot, or
- * something else went wrong... in such cases, trying to install a new
- * hypervisor is unlikely to work as desired.
- *
- * When you call into your shiny new hypervisor, sp_el2 will contain junk,
- * so you will need to set that to something sensible at the new hypervisor's
- * initialisation entry point.
- */
-
-ENTRY(__hyp_set_vectors)
-	mov	x1, x0
-	mov	x0, #HVC_SET_VECTORS
-	hvc	#0
-	ret
-ENDPROC(__hyp_set_vectors)
-
-ENTRY(__hyp_reset_vectors)
-	mov	x0, #HVC_RESET_VECTORS
-	hvc	#0
-	ret
-ENDPROC(__hyp_reset_vectors)
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 3c79a1124af2..f6c9501ddfc9 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -11,22 +11,11 @@
 #include <asm/cpufeature.h>
 
 /*
- * u64 __kvm_call_hyp(void *hypfn, ...);
+ * u64 __kvm_call_hyp(unsigned long arg, ...);
  *
  * This is not really a variadic function in the classic C-way and care must
  * be taken when calling this to ensure parameters are passed in registers
  * only, since the stack will change between the caller and the callee.
- *
- * Call the function with the first argument containing a pointer to the
- * function you wish to call in Hyp mode, and subsequent arguments will be
- * passed as x0, x1, and x2 (a maximum of 3 arguments in addition to the
- * function pointer can be passed).  The function being called must be mapped
- * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
- * passed in x0.
- *
- * A function pointer with a value less than 0xfff has a special meaning,
- * and is used to implement hyp stubs in the same way as in
- * arch/arm64/kernel/hyp_stub.S.
  */
 SYM_FUNC_START(__kvm_call_hyp)
 	hvc	#0
-- 
2.26.1

