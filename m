Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F51C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5BD20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GryLZYNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEOPVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbgEOPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:21:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20112C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:21:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z4so1542469wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KntePsrJZ38aKzkA7fo6Gtvi3PLH/oa0OGyHRz0Swos=;
        b=GryLZYNyhp8AzuS9c+B+Fla5RgxNoznfaARAc+BvFqZdeTPhy+4/qMPC4nrBUl9EN3
         OL391QH3tWSy32IaVeN0tLkNc4bTAJjRc8rPd0JdDb06VGw0tVADy6df+OQ3zxvkaPlE
         l/94aMlwdh2EH2Pld8OSdy6KWSY4mkzaheiktwyqSMLpMUiNcSZH9WmBd8tPSAsYlT9E
         taOCiQqdHs4kQhiOlHIgaZynKqM5QJjuCM09qYcuXNntogkawPsmtfAm3Cqh1srwuxsT
         fusGJmI++1YbjwxxgBIGeULct6h5TRgpt2lEN9+OumlSXKR2mjO3nnwKORtvX0bWDQdr
         XGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KntePsrJZ38aKzkA7fo6Gtvi3PLH/oa0OGyHRz0Swos=;
        b=FraUeQgtSvKkCrDO1W7QYHwVpRPpz+olX268SelJpjX204RFWFgpJIWuJH8hbNL8H9
         G2N5pMxzlRBt/wMrDOtHRdgVatexhWLChAqDGQ5AOr8hadu65fRUAO8pcdUAr24FhbXy
         EQDAiLQYmVItAc8I8E62R4J5ewJJ221swB8hBZjEpi3xeSeNoCBr4kziiCQr2EzRYEg8
         OC8H0rKOKsNH/bkysB7avgAfPlWgf6HQjY6qrH0BmwSBP6nKG/rXI3Cx1Y0m44CWC3Bq
         ocs+Rz8HhKdm5DFNUBlrTX6/mD9Zge49+kVrvL5Y6opXJSwkOV9Ow54Hi5zapY5DaBFh
         VtoA==
X-Gm-Message-State: AOAM5315Mc1kQzr6Io4WSIBpRJlYp0bdHc/tqby/y8nGiyDjnPg/CXIg
        uhR/e8me/MDW6LptX/jbR72kjQ==
X-Google-Smtp-Source: ABdhPJzeS1z51N03Nf21V4FTTxjRFhNkpfq9OsfOx5e2wEnllfq0XS/Kck/v3gGLtKn0ZWv3U3HCfw==
X-Received: by 2002:a1c:5fd4:: with SMTP id t203mr4727738wmb.175.1589556070468;
        Fri, 15 May 2020 08:21:10 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id h137sm56341596wme.0.2020.05.15.08.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:21:09 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH] arm64: kvm: Clean up cpu_init_hyp_mode()
Date:   Fri, 15 May 2020 16:20:56 +0100
Message-Id: <20200515152056.83158-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull bits of code to the only place where it is used. Remove empty function
__cpu_init_stage2(). Remove redundant has_vhe() check since this function is
nVHE-only. No functional changes intended.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h  |  2 ++
 arch/arm64/include/asm/kvm_host.h | 35 -------------------------------
 arch/arm64/kvm/arm.c              | 32 +++++++++++++++++++++++-----
 3 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 59e314f38e43..0c9b5fc4ba0a 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -70,6 +70,8 @@ extern int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu);
 
 extern int __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu);
 
+extern void __kvm_enable_ssbs(void);
+
 extern u64 __vgic_v3_get_ich_vtr_el2(void);
 extern u64 __vgic_v3_read_vmcr(void);
 extern void __vgic_v3_write_vmcr(u32 vmcr);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a723f84fab83..69a338a390a6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -533,39 +533,6 @@ static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 	cpu_ctxt->sys_regs[MPIDR_EL1] = read_cpuid_mpidr();
 }
 
-void __kvm_enable_ssbs(void);
-
-static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
-				       unsigned long hyp_stack_ptr,
-				       unsigned long vector_ptr)
-{
-	/*
-	 * Calculate the raw per-cpu offset without a translation from the
-	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
-	 * so that we can use adr_l to access per-cpu variables in EL2.
-	 */
-	u64 tpidr_el2 = ((u64)this_cpu_ptr(&kvm_host_data) -
-			 (u64)kvm_ksym_ref(kvm_host_data));
-
-	/*
-	 * Call initialization code, and switch to the full blown HYP code.
-	 * If the cpucaps haven't been finalized yet, something has gone very
-	 * wrong, and hyp will crash and burn when it uses any
-	 * cpus_have_const_cap() wrapper.
-	 */
-	BUG_ON(!system_capabilities_finalized());
-	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
-
-	/*
-	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
-	 * at EL2.
-	 */
-	if (!has_vhe() && this_cpu_has_cap(ARM64_SSBS) &&
-	    arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
-		kvm_call_hyp(__kvm_enable_ssbs);
-	}
-}
-
 static inline bool kvm_arch_requires_vhe(void)
 {
 	/*
@@ -601,8 +568,6 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
 
-static inline void __cpu_init_stage2(void) {}
-
 /* Guest/host FPSIMD coordination helpers */
 int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e01d44df98df..b0b569f2cdd0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1273,19 +1273,41 @@ static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t pgd_ptr;
 	unsigned long hyp_stack_ptr;
-	unsigned long stack_page;
 	unsigned long vector_ptr;
+	unsigned long tpidr_el2;
 
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors(kvm_get_idmap_vector());
 
+	/*
+	 * Calculate the raw per-cpu offset without a translation from the
+	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
+	 * so that we can use adr_l to access per-cpu variables in EL2.
+	 */
+	tpidr_el2 = ((unsigned long)this_cpu_ptr(&kvm_host_data) -
+		     (unsigned long)kvm_ksym_ref(kvm_host_data));
+
 	pgd_ptr = kvm_mmu_get_httbr();
-	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
-	hyp_stack_ptr = stack_page + PAGE_SIZE;
+	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
 	vector_ptr = (unsigned long)kvm_get_hyp_vector();
 
-	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
-	__cpu_init_stage2();
+	/*
+	 * Call initialization code, and switch to the full blown HYP code.
+	 * If the cpucaps haven't been finalized yet, something has gone very
+	 * wrong, and hyp will crash and burn when it uses any
+	 * cpus_have_const_cap() wrapper.
+	 */
+	BUG_ON(!system_capabilities_finalized());
+	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
+
+	/*
+	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
+	 * at EL2.
+	 */
+	if (this_cpu_has_cap(ARM64_SSBS) &&
+	    arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
+		kvm_call_hyp(__kvm_enable_ssbs);
+	}
 }
 
 static void cpu_hyp_reset(void)
-- 
2.26.2

