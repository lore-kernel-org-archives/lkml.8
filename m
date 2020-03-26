Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F7C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7816620774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fiB9ueCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgCZDZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:25:00 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38931 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgCZDYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:47 -0400
Received: by mail-qv1-f66.google.com with SMTP id v38so2271139qvf.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=uH50jv2KMwpjM9MUqJEA6M9mjf0TYnrFc+j0/4JA2/8=;
        b=fiB9ueCsANwmQzTKLdMTwl073niDxot5bMY8SHMvRN7zmHWFcrQH7scnjR2/1TGnfK
         dVIOFwbvoAVCesAKXWXgQbZUh/zmmYX3iv5+zHFR5bUds4KxsRNggisBdbNLASd90B35
         7lcQ5vIafAsStIIPwSFjT2Ihhnkb4cjQJdoZ9AWIkmMTWs63lb4W+f5EjzM/CFYwjp2h
         0tSJglzq70UYYtHzJ1aa2v5ejWZTzxjE0bUi2ki/7F2ik+qa8qRnwZmxvfmUvds9LZ9m
         sfcZqJd1S5chEMjK5bYIapAf1x6QQPcCRIO01A4WZjbtTYzLi4pJ2vB0h5FtXqAviG0v
         AZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=uH50jv2KMwpjM9MUqJEA6M9mjf0TYnrFc+j0/4JA2/8=;
        b=JoHddsYrq/TJ4FFdrQHeVUwYCjo0QLQT2b5M+C4TnXP3J11GR3Iz8mE7AUFu3jIokc
         XIWemkDWXDjQEbesOQ0waugxGFgs8+GIz9Cdhdh2WUCXghhDe/h0J/ms+6TNeZOK4oEA
         rt305Bx0/OwZsd4fKdR5s0KKhoFzPXKocoxe7/TSApYVHQeY+EVA+k/u7YXPj+gUlQS6
         gTwR6psMR3WgR/XS4UKmQCVlHZ2hIMfN0+vuzr0JTAFJ4uT/uVciWmMlDpKO2EiSHtpq
         7dS5LAbHd4AuD0r41NuUDod+be5hS0We4hRPyDVp5GV7OCz8KaAVTYZw2eFm51UmvWZ7
         YbUg==
X-Gm-Message-State: ANhLgQ3x2DYm79AWa3URHLHdUuwL8TDxGsJIoQwRwGFJKFZlyBCEiOJb
        p7N5q1GZOAmVdelv1E5HV+x0Zg==
X-Google-Smtp-Source: ADFU+vsn5N31l1OOjwnpnGaEWO0LewMtT8xvGuAvQ3zFm5/A5YPwx47lqc7VNLvdKkoNJK+uI7hzhg==
X-Received: by 2002:a0c:ebd2:: with SMTP id k18mr6281606qvq.143.1585193085859;
        Wed, 25 Mar 2020 20:24:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:45 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 15/18] arm64: kexec: kexec EL2 vectors
Date:   Wed, 25 Mar 2020 23:24:17 -0400
Message-Id: <20200326032420.27220-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a EL2 mode without VHE, the EL2 vectors are needed in order
to switch to EL2 and jump to new world with hyperivsor privileges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  5 +++++
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kernel/machine_kexec.c   |  5 +++++
 arch/arm64/kernel/relocate_kernel.S | 35 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d944c2e289b2..0f758fd51518 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -95,6 +95,7 @@ static inline void crash_post_resume(void) {}
 extern const unsigned long kexec_relocate_code_size;
 extern const unsigned char kexec_relocate_code_start[];
 extern const unsigned long kexec_kern_reloc_offset;
+extern const unsigned long kexec_el2_vectors_offset;
 #endif
 
 /*
@@ -104,6 +105,9 @@ extern const unsigned long kexec_kern_reloc_offset;
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
  *		arguments are currently unused, and must be set to 0
+ * el2_vector	If present means that relocation routine will go to EL1
+ *		from EL2 to do the copy, and then back to EL2 to do the jump
+ *		to new world.
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -112,6 +116,7 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg1;
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
+	phys_addr_t el2_vector;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 448230684749..ff974b648347 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -136,6 +136,7 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
+  DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index ab571fca9bd1..bd398def7627 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -84,6 +84,11 @@ int machine_kexec_post_load(struct kimage *kimage)
 	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
+	/* Setup vector table only when EL2 is available, but no VHE */
+	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
+		kern_reloc_arg->el2_vector = __pa(reloc_code)
+						+ kexec_el2_vectors_offset;
+	}
 	kexec_image_info(kimage);
 
 	return 0;
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index aa9f2b2cd77c..6fd2fc0ef373 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -89,6 +89,38 @@ ENTRY(arm64_relocate_new_kernel)
 .ltorg
 END(arm64_relocate_new_kernel)
 
+.macro el1_sync_64
+	br	x4			/* Jump to new world from el2 */
+	.fill 31, 4, 0			/* Set other 31 instr to zeroes */
+.endm
+
+.macro invalid_vector label
+\label:
+	b \label
+	.fill 31, 4, 0			/* Set other 31 instr to zeroes */
+.endm
+
+/* el2 vectors - switch el2 here while we restore the memory image. */
+	.align 11
+ENTRY(kexec_el2_vectors)
+	invalid_vector el2_sync_invalid_sp0	/* Synchronous EL2t */
+	invalid_vector el2_irq_invalid_sp0	/* IRQ EL2t */
+	invalid_vector el2_fiq_invalid_sp0	/* FIQ EL2t */
+	invalid_vector el2_error_invalid_sp0	/* Error EL2t */
+	invalid_vector el2_sync_invalid_spx	/* Synchronous EL2h */
+	invalid_vector el2_irq_invalid_spx	/* IRQ EL2h */
+	invalid_vector el2_fiq_invalid_spx	/* FIQ EL2h */
+	invalid_vector el2_error_invalid_spx	/* Error EL2h */
+		el1_sync_64			/* Synchronous 64-bit EL1 */
+	invalid_vector el1_irq_invalid_64	/* IRQ 64-bit EL1 */
+	invalid_vector el1_fiq_invalid_64	/* FIQ 64-bit EL1 */
+	invalid_vector el1_error_invalid_64	/* Error 64-bit EL1 */
+	invalid_vector el1_sync_invalid_32	/* Synchronous 32-bit EL1 */
+	invalid_vector el1_irq_invalid_32	/* IRQ 32-bit EL1 */
+	invalid_vector el1_fiq_invalid_32	/* FIQ 32-bit EL1 */
+	invalid_vector el1_error_invalid_32	/* Error 32-bit EL1 */
+END(kexec_el2_vectors)
+
 .Lkexec_relocate_code_end:
 .org	KEXEC_CONTROL_PAGE_SIZE
 .align 3	/* To keep the 64-bit values below naturally aligned. */
@@ -102,3 +134,6 @@ kexec_relocate_code_size:
 .globl kexec_kern_reloc_offset
 kexec_kern_reloc_offset:
 	.quad	arm64_relocate_new_kernel - kexec_relocate_code_start
+.globl kexec_el2_vectors_offset
+kexec_el2_vectors_offset:
+	.quad	kexec_el2_vectors - kexec_relocate_code_start
-- 
2.17.1

