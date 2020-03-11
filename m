Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F41C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11AE21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgCKFHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:07:31 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:42566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728301AbgCKFHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:07:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 16D8A18224506;
        Wed, 11 Mar 2020 05:07:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need78_23fc56caebe4f
X-Filterd-Recvd-Size: 9517
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:27 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 021/491] KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86): Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:35 -0700
Message-Id: <e5314fc18acfe821da47ea52fa074b4c414f9266.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/x86/kvm/emulate.c  |  2 +-
 arch/x86/kvm/hyperv.c   |  2 +-
 arch/x86/kvm/irq_comm.c |  2 +-
 arch/x86/kvm/lapic.c    |  6 +++---
 arch/x86/kvm/mmu/mmu.c  |  2 +-
 arch/x86/kvm/svm.c      |  2 +-
 arch/x86/kvm/vmx/vmx.c  | 15 +++++++--------
 arch/x86/kvm/x86.c      | 12 ++++--------
 8 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index bc00642..bae4d8 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3025,7 +3025,7 @@ static void string_registers_quirk(struct x86_emulate_ctxt *ctxt)
 	case 0xa4:	/* movsb */
 	case 0xa5:	/* movsd/w */
 		*reg_rmw(ctxt, VCPU_REGS_RSI) &= (u32)-1;
-		/* fall through */
+		fallthrough;
 	case 0xaa:	/* stosb */
 	case 0xab:	/* stosd/w */
 		*reg_rmw(ctxt, VCPU_REGS_RDI) &= (u32)-1;
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index a86fda7..934bfb4 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1652,7 +1652,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_hvcall_signal_event(vcpu, fast, ingpa);
 		if (ret != HV_STATUS_INVALID_PORT_ID)
 			break;
-		/* fall through - maybe userspace knows this conn_id. */
+		fallthrough;	/* maybe userspace knows this conn_id */
 	case HVCALL_POST_MESSAGE:
 		/* don't bother userspace if it has no way to handle it */
 		if (unlikely(rep || !vcpu_to_synic(vcpu)->active)) {
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index c47d2a..4aa1c2e 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -285,7 +285,7 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		switch (ue->u.irqchip.irqchip) {
 		case KVM_IRQCHIP_PIC_SLAVE:
 			e->irqchip.pin += PIC_NUM_PINS / 2;
-			/* fall through */
+			fallthrough;
 		case KVM_IRQCHIP_PIC_MASTER:
 			if (ue->u.irqchip.pin >= PIC_NUM_PINS / 2)
 				return -EINVAL;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e3099c..64b7a9c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1023,7 +1023,7 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 	switch (delivery_mode) {
 	case APIC_DM_LOWEST:
 		vcpu->arch.apic_arb_prio++;
-		/* fall through */
+		fallthrough;
 	case APIC_DM_FIXED:
 		if (unlikely(trig_mode && !level))
 			break;
@@ -1311,7 +1311,7 @@ static u32 __apic_read(struct kvm_lapic *apic, unsigned int offset)
 		break;
 	case APIC_TASKPRI:
 		report_tpr_access(apic, false);
-		/* fall thru */
+		fallthrough;
 	default:
 		val = kvm_lapic_get_reg(apic, offset);
 		break;
@@ -1952,7 +1952,7 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 
 	case APIC_LVT0:
 		apic_manage_nmi_watchdog(apic, val);
-		/* fall through */
+		fallthrough;
 	case APIC_LVTTHMR:
 	case APIC_LVTPC:
 	case APIC_LVT1:
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 87e9ba..8593cd 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4475,7 +4475,7 @@ __reset_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 			rsvd_bits(maxphyaddr, 51);
 		rsvd_check->rsvd_bits_mask[1][4] =
 			rsvd_check->rsvd_bits_mask[0][4];
-		/* fall through */
+		fallthrough;
 	case PT64_ROOT_4LEVEL:
 		rsvd_check->rsvd_bits_mask[0][3] = exb_bit_rsvd |
 			nonleaf_bit8_rsvd | rsvd_bits(7, 7) |
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 910005..73fa903 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4449,7 +4449,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_IA32_APICBASE:
 		if (kvm_vcpu_apicv_active(vcpu))
 			avic_update_vapic_bar(to_svm(vcpu), data);
-		/* Fall through */
+		fallthrough;
 	default:
 		return kvm_set_msr_common(vcpu, msr);
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 69c5bd..1577cd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4538,12 +4538,12 @@ static bool rmode_exception(struct kvm_vcpu *vcpu, int vec)
 			vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
 		if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)
 			return false;
-		/* fall through */
+		fallthrough;
 	case DB_VECTOR:
 		if (vcpu->guest_debug &
 			(KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))
 			return false;
-		/* fall through */
+		fallthrough;
 	case DE_VECTOR:
 	case OF_VECTOR:
 	case BR_VECTOR:
@@ -4692,7 +4692,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 		}
 		kvm_run->debug.arch.dr6 = dr6 | DR6_FIXED_1;
 		kvm_run->debug.arch.dr7 = vmcs_readl(GUEST_DR7);
-		/* fall through */
+		fallthrough;
 	case BP_VECTOR:
 		/*
 		 * Update instruction length as we may reinject #BP from
@@ -5119,7 +5119,7 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
 				error_code =
 					vmcs_read32(IDT_VECTORING_ERROR_CODE);
 			}
-			/* fall through */
+			fallthrough;
 		case INTR_TYPE_SOFT_EXCEPTION:
 			kvm_clear_exception_queue(vcpu);
 			break;
@@ -5469,8 +5469,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 		 * global flush. If needed, we could optimize this later by
 		 * keeping track of global entries in shadow page tables.
 		 */
-
-		/* fall-through */
+		fallthrough;
 	case INVPCID_TYPE_ALL_INCL_GLOBAL:
 		kvm_mmu_unload(vcpu);
 		return kvm_skip_emulated_instruction(vcpu);
@@ -6401,7 +6400,7 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 		break;
 	case INTR_TYPE_SOFT_EXCEPTION:
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
-		/* fall through */
+		fallthrough;
 	case INTR_TYPE_HARD_EXCEPTION:
 		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK) {
 			u32 err = vmcs_read32(error_code_field);
@@ -6411,7 +6410,7 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 		break;
 	case INTR_TYPE_SOFT_INTR:
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
-		/* fall through */
+		fallthrough;
 	case INTR_TYPE_EXT_INTR:
 		kvm_queue_interrupt(vcpu, vector, type == INTR_TYPE_SOFT_INTR);
 		break;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2bbc0e0..e6280e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1071,7 +1071,6 @@ static int __kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 			vcpu->arch.eff_db[dr] = val;
 		break;
 	case 4:
-		/* fall through */
 	case 6:
 		if (val & 0xffffffff00000000ULL)
 			return -1; /* #GP */
@@ -1079,7 +1078,6 @@ static int __kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 		kvm_update_dr6(vcpu);
 		break;
 	case 5:
-		/* fall through */
 	default: /* 7 */
 		if (!kvm_dr7_valid(val))
 			return -1; /* #GP */
@@ -1110,7 +1108,6 @@ int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
 		*val = vcpu->arch.db[array_index_nospec(dr, size)];
 		break;
 	case 4:
-		/* fall through */
 	case 6:
 		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP)
 			*val = vcpu->arch.dr6;
@@ -1118,7 +1115,6 @@ int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
 			*val = kvm_x86_ops->get_dr6(vcpu);
 		break;
 	case 5:
-		/* fall through */
 	default: /* 7 */
 		*val = vcpu->arch.dr7;
 		break;
@@ -2885,7 +2881,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
 	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
-		pr = true; /* fall through */
+		pr = true;
+		fallthrough;
 	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
 	case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL1:
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
@@ -4181,8 +4178,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	case KVM_CAP_HYPERV_SYNIC2:
 		if (cap->args[0])
 			return -EINVAL;
-		/* fall through */
-
+		fallthrough;
 	case KVM_CAP_HYPERV_SYNIC:
 		if (!irqchip_in_kernel(vcpu->kvm))
 			return -EINVAL;
@@ -8478,7 +8474,7 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 		vcpu->arch.pv.pv_unhalted = false;
 		vcpu->arch.mp_state =
 			KVM_MP_STATE_RUNNABLE;
-		/* fall through */
+		fallthrough;
 	case KVM_MP_STATE_RUNNABLE:
 		vcpu->arch.apf.halted = false;
 		break;
-- 
2.24.0

