Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DBC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FBD20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH8QSmH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgDXRYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:24:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726849AbgDXRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=n/v+GecTrEwyyLbsd1WvGrx2OwR9+bmxfRFtapBWds8=;
        b=HH8QSmH0cHNQwf8PBeYFmYzB1DFrYqqWqWo+HhzxED8ccbdlpivnCPxpeZ0ffJP6XLzNxp
        ctpnuNDjKZCkHi8P+qFObtKFNJRxCddpDGKqMc+FOYZ6Tu9zdXuE1BEUVPOWQd8CDNn7dI
        jGijwMiKXb1CJ1Icude3jS/V44MPcOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-V_LEgpmoPRuvE8EGmhtFdQ-1; Fri, 24 Apr 2020 13:24:33 -0400
X-MC-Unique: V_LEgpmoPRuvE8EGmhtFdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28603A73A7;
        Fri, 24 Apr 2020 17:24:25 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 280D91FDE1;
        Fri, 24 Apr 2020 17:24:24 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
Subject: [PATCH v2 06/22] KVM: nVMX: Open a window for pending nested VMX preemption timer
Date:   Fri, 24 Apr 2020 13:24:00 -0400
Message-Id: <20200424172416.243870-7-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add a kvm_x86_ops hook to detect a nested pending "hypervisor timer" and
use it to effectively open a window for servicing the expired timer.
Like pending SMIs on VMX, opening a window simply means requesting an
immediate exit.

This fixes a bug where an expired VMX preemption timer (for L2) will be
delayed and/or lost if a pending exception is injected into L2.  The
pending exception is rightly prioritized by vmx_check_nested_events()
and injected into L2, with the preemption timer left pending.  Because
no window opened, L2 is free to run uninterrupted.

Fixes: f4124500c2c13 ("KVM: nVMX: Fully emulate preemption timer")
Reported-by: Jim Mattson <jmattson@google.com>
Cc: Oliver Upton <oupton@google.com>
Cc: Peter Shier <pshier@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200423022550.15113-3-sean.j.christopherson@intel.com>
[Check it in kvm_vcpu_has_events too, to ensure that the preemption
 timer is serviced promptly even if the vCPU is halted and L1 is not
 intercepting HLT. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx/nested.c       | 10 ++++++++--
 arch/x86/kvm/x86.c              |  9 +++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a239a297be33..372e6ea4af32 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1257,6 +1257,7 @@ struct kvm_x86_ops {
 
 struct kvm_x86_nested_ops {
 	int (*check_events)(struct kvm_vcpu *vcpu);
+	bool (*hv_timer_pending)(struct kvm_vcpu *vcpu);
 	int (*get_state)(struct kvm_vcpu *vcpu,
 			 struct kvm_nested_state __user *user_kvm_nested_state,
 			 unsigned user_data_size);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 490dba7d0504..182e5209a1f6 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3687,6 +3687,12 @@ static void nested_vmx_update_pending_dbg(struct kvm_vcpu *vcpu)
 			    vcpu->arch.exception.payload);
 }
 
+static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
+{
+	return nested_cpu_has_preemption_timer(get_vmcs12(vcpu)) &&
+	       to_vmx(vcpu)->nested.preemption_timer_expired;
+}
+
 static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3742,8 +3748,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	if (nested_cpu_has_preemption_timer(get_vmcs12(vcpu)) &&
-	    vmx->nested.preemption_timer_expired) {
+	if (nested_vmx_preemption_timer_pending(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
 		nested_vmx_vmexit(vcpu, EXIT_REASON_PREEMPTION_TIMER, 0, 0);
@@ -6448,6 +6453,7 @@ __init int nested_vmx_hardware_setup(struct kvm_x86_ops *ops,
 
 struct kvm_x86_nested_ops vmx_nested_ops = {
 	.check_events = vmx_check_nested_events,
+	.hv_timer_pending = nested_vmx_preemption_timer_pending,
 	.get_state = vmx_get_nested_state,
 	.set_state = vmx_set_nested_state,
 	.get_vmcs12_pages = nested_get_vmcs12_pages,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8c0b77ac8dc6..ee934a88a267 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8324,6 +8324,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 				kvm_x86_ops.enable_nmi_window(vcpu);
 			if (kvm_cpu_has_injectable_intr(vcpu) || req_int_win)
 				kvm_x86_ops.enable_irq_window(vcpu);
+			if (is_guest_mode(vcpu) &&
+			    kvm_x86_ops.nested_ops->hv_timer_pending &&
+			    kvm_x86_ops.nested_ops->hv_timer_pending(vcpu))
+				req_immediate_exit = true;
 			WARN_ON(vcpu->arch.exception.pending);
 		}
 
@@ -10179,6 +10183,11 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_hv_has_stimer_pending(vcpu))
 		return true;
 
+	if (is_guest_mode(vcpu) &&
+	    kvm_x86_ops.nested_ops->hv_timer_pending &&
+	    kvm_x86_ops.nested_ops->hv_timer_pending(vcpu))
+		return true;
+
 	return false;
 }
 
-- 
2.18.2


