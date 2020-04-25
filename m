Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E4C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0E120857
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frFNLOos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgDYHCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:02:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgDYHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587798122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Zhop02cboELmmyjJa4pTw5otGh2YRyzNp42T5e+hcbY=;
        b=frFNLOosZ3/WLMu+46gF/ACiKThla2mt+rUsqZUZkvlENIGWpuBN5rtkphfy1y6umQX++h
        TuU6b1qUR+HnhCy10DN64J8crQq0NeFpto9CSw9X/sHH1m5KLmPiioOYkNaQwXJRXBClYP
        lm4IWetZyjFWF3a1cJ6aGpJylKKRTdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-L3qCV47DNH-5TfaqJEYYqA-1; Sat, 25 Apr 2020 03:01:59 -0400
X-MC-Unique: L3qCV47DNH-5TfaqJEYYqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CED11005510;
        Sat, 25 Apr 2020 07:01:58 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D32835D9C5;
        Sat, 25 Apr 2020 07:01:57 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 13/22] KVM: VMX: Split out architectural interrupt/NMI blocking checks
Date:   Sat, 25 Apr 2020 03:01:45 -0400
Message-Id: <20200425070154.251290-4-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Move the architectural (non-KVM specific) interrupt/NMI blocking checks
to a separate helper so that they can be used in a future patch by
vmx_check_nested_events().

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200423022550.15113-8-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 35 ++++++++++++++++++++++-------------
 arch/x86/kvm/vmx/vmx.h |  2 ++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 37b1986a4e8f..7fb7dcb3d94d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4511,21 +4511,35 @@ void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 	}
 }
 
+bool vmx_nmi_blocked(struct kvm_vcpu *vcpu)
+{
+	if (is_guest_mode(vcpu) && nested_exit_on_nmi(vcpu))
+		return false;
+
+	if (!enable_vnmi && to_vmx(vcpu)->loaded_vmcs->soft_vnmi_blocked)
+		return true;
+
+	return (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
+		(GUEST_INTR_STATE_MOV_SS | GUEST_INTR_STATE_STI |
+		 GUEST_INTR_STATE_NMI));
+}
+
 static bool vmx_nmi_allowed(struct kvm_vcpu *vcpu)
 {
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return false;
 
-	if (is_guest_mode(vcpu) && nested_exit_on_nmi(vcpu))
-		return true;
+	return !vmx_nmi_blocked(vcpu);
+}
 
-	if (!enable_vnmi &&
-	    to_vmx(vcpu)->loaded_vmcs->soft_vnmi_blocked)
+bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
+{
+	if (is_guest_mode(vcpu) && nested_exit_on_intr(vcpu))
 		return false;
 
-	return	!(vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
-		  (GUEST_INTR_STATE_MOV_SS | GUEST_INTR_STATE_STI
-		   | GUEST_INTR_STATE_NMI));
+	return !(vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF) ||
+	       (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
+		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
 }
 
 static bool vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
@@ -4533,12 +4547,7 @@ static bool vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return false;
 
-	if (is_guest_mode(vcpu) && nested_exit_on_intr(vcpu))
-		return true;
-
-	return (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF) &&
-		!(vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
-			(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
+	return !vmx_interrupt_blocked(vcpu);
 }
 
 static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index edfb739e5907..b5e773267abe 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -344,6 +344,8 @@ void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa);
 void update_exception_bitmap(struct kvm_vcpu *vcpu);
 void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
+bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);
+bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
 bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
 void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
-- 
2.18.2


