Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F01FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD3D2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323569;
	bh=c8FPKtKGsiW0bgNFC/qpG1K4VgQa8dRthdNncmZDIVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m2hoFbEgjOSoRnZsmyCejxo2tt/QqmYaAJuq/Dtw6eckd123dE3HqOnMUWpNTJ+ME
	 xSxmOiapZDLjEtBGsSg+mzjg8EABNdANsKF2N36egB7/JTCVKY8Zk7dg8FVoPIzmwU
	 6+HOwxkyrTNQQSwum4db/ypdRm3ikf7W0U6BkF80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbgFPQGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbgFPPse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:48:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADB42071A;
        Tue, 16 Jun 2020 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322514;
        bh=c8FPKtKGsiW0bgNFC/qpG1K4VgQa8dRthdNncmZDIVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkGvuK5ZvMIFU3A56oOiea/y1nwU1VTYeJkhjE4QJrT2rVLN4Zuc9Jcjxnf1MXOg9
         TMIcPooCR2lY7f/ZtBTfWCZRwxf2xSNhfZIbVf1GRVXKKE46nAWv35dclB1AJXR18Q
         C9w1erGsvVSrYVNcqEVk3mhvlM+L+umeITqAT8rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.7 162/163] KVM: arm64: Save the hosts PtrAuth keys in non-preemptible context
Date:   Tue, 16 Jun 2020 17:35:36 +0200
Message-Id: <20200616153114.566088892@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

commit ef3e40a7ea8dbe2abd0a345032cd7d5023b9684f upstream.

When using the PtrAuth feature in a guest, we need to save the host's
keys before allowing the guest to program them. For that, we dump
them in a per-CPU data structure (the so called host context).

But both call sites that do this are in preemptible context,
which may end up in disaster should the vcpu thread get preempted
before reentering the guest.

Instead, save the keys eagerly on each vcpu_load(). This has an
increased overhead, but is at least safe.

Cc: stable@vger.kernel.org
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/kvm_emulate.h |    6 ------
 arch/arm64/kvm/handle_exit.c         |   19 ++-----------------
 virt/kvm/arm/arm.c                   |   18 +++++++++++++++++-
 3 files changed, 19 insertions(+), 24 deletions(-)

--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -112,12 +112,6 @@ static inline void vcpu_ptrauth_disable(
 	vcpu->arch.hcr_el2 &= ~(HCR_API | HCR_APK);
 }
 
-static inline void vcpu_ptrauth_setup_lazy(struct kvm_vcpu *vcpu)
-{
-	if (vcpu_has_ptrauth(vcpu))
-		vcpu_ptrauth_disable(vcpu);
-}
-
 static inline unsigned long vcpu_get_vsesr(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.vsesr_el2;
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -162,31 +162,16 @@ static int handle_sve(struct kvm_vcpu *v
 	return 1;
 }
 
-#define __ptrauth_save_key(regs, key)						\
-({										\
-	regs[key ## KEYLO_EL1] = read_sysreg_s(SYS_ ## key ## KEYLO_EL1);	\
-	regs[key ## KEYHI_EL1] = read_sysreg_s(SYS_ ## key ## KEYHI_EL1);	\
-})
-
 /*
  * Handle the guest trying to use a ptrauth instruction, or trying to access a
  * ptrauth register.
  */
 void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu)
 {
-	struct kvm_cpu_context *ctxt;
-
-	if (vcpu_has_ptrauth(vcpu)) {
+	if (vcpu_has_ptrauth(vcpu))
 		vcpu_ptrauth_enable(vcpu);
-		ctxt = vcpu->arch.host_cpu_context;
-		__ptrauth_save_key(ctxt->sys_regs, APIA);
-		__ptrauth_save_key(ctxt->sys_regs, APIB);
-		__ptrauth_save_key(ctxt->sys_regs, APDA);
-		__ptrauth_save_key(ctxt->sys_regs, APDB);
-		__ptrauth_save_key(ctxt->sys_regs, APGA);
-	} else {
+	else
 		kvm_inject_undefined(vcpu);
-	}
 }
 
 /*
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -332,6 +332,12 @@ void kvm_arch_vcpu_unblocking(struct kvm
 	preempt_enable();
 }
 
+#define __ptrauth_save_key(regs, key)						\
+({										\
+	regs[key ## KEYLO_EL1] = read_sysreg_s(SYS_ ## key ## KEYLO_EL1);	\
+	regs[key ## KEYHI_EL1] = read_sysreg_s(SYS_ ## key ## KEYHI_EL1);	\
+})
+
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	int *last_ran;
@@ -365,7 +371,17 @@ void kvm_arch_vcpu_load(struct kvm_vcpu
 	else
 		vcpu_set_wfx_traps(vcpu);
 
-	vcpu_ptrauth_setup_lazy(vcpu);
+	if (vcpu_has_ptrauth(vcpu)) {
+		struct kvm_cpu_context *ctxt = vcpu->arch.host_cpu_context;
+
+		__ptrauth_save_key(ctxt->sys_regs, APIA);
+		__ptrauth_save_key(ctxt->sys_regs, APIB);
+		__ptrauth_save_key(ctxt->sys_regs, APDA);
+		__ptrauth_save_key(ctxt->sys_regs, APDB);
+		__ptrauth_save_key(ctxt->sys_regs, APGA);
+
+		vcpu_ptrauth_disable(vcpu);
+	}
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)


