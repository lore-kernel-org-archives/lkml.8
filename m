Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89D3C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973652098B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2Me8a22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDYHCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:02:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56442 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726348AbgDYHCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587798140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=F5d2hZyoWLkLFhOgbvoh0l9Xmnu5vZ/wvjbqCedo71Y=;
        b=K2Me8a22s14h/7eo3M7XthuKq5ROVLbpMaBTNiqWD4EwOubzNGmpVnYOOWhaC6tIpfJqUW
        Tc58XynmNDBggrL0Xk7cBOmLZ5aew9hNB2DL2oqR6jS/p4wVsL8jjUc6JyPK8ViZSTos0p
        nRG81JpIVY9mvVEyxZLXIYAkO9b5PJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-hhz45wqyOoOewXgRnfFx9g-1; Sat, 25 Apr 2020 03:02:17 -0400
X-MC-Unique: hhz45wqyOoOewXgRnfFx9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1E3C462;
        Sat, 25 Apr 2020 07:02:16 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3918600E8;
        Sat, 25 Apr 2020 07:02:15 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 20/22] KVM: VMX: Use vmx_interrupt_blocked() directly from vmx_handle_exit()
Date:   Sat, 25 Apr 2020 03:02:13 -0400
Message-Id: <20200425070215.251397-1-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Use vmx_interrupt_blocked() instead of bouncing through
vmx_interrupt_allowed() when handling edge cases in vmx_handle_exit().
The nested_run_pending check in vmx_interrupt_allowed() should never
evaluate true in the VM-Exit path.

Hoist the WARN in handle_invalid_guest_state() up to vmx_handle_exit()
to enforce the above assumption for the !enable_vnmi case, and to detect
any other potential bugs with nested VM-Enter.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200423022550.15113-12-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7fb7dcb3d94d..0e5eacd6f911 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5268,18 +5268,11 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	bool intr_window_requested;
 	unsigned count = 130;
 
-	/*
-	 * We should never reach the point where we are emulating L2
-	 * due to invalid guest state as that means we incorrectly
-	 * allowed a nested VMEntry with an invalid vmcs12.
-	 */
-	WARN_ON_ONCE(vmx->emulation_required && vmx->nested.nested_run_pending);
-
 	intr_window_requested = exec_controls_get(vmx) &
 				CPU_BASED_INTR_WINDOW_EXITING;
 
 	while (vmx->emulation_required && count-- != 0) {
-		if (intr_window_requested && vmx_interrupt_allowed(vcpu))
+		if (intr_window_requested && !vmx_interrupt_blocked(vcpu))
 			return handle_interrupt_window(&vmx->vcpu);
 
 		if (kvm_test_request(KVM_REQ_EVENT, vcpu))
@@ -5896,6 +5889,14 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
 	if (enable_pml)
 		vmx_flush_pml_buffer(vcpu);
 
+	/*
+	 * We should never reach this point with a pending nested VM-Enter, and
+	 * more specifically emulation of L2 due to invalid guest state (see
+	 * below) should never happen as that means we incorrectly allowed a
+	 * nested VM-Enter with an invalid vmcs12.
+	 */
+	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+
 	/* If guest state is invalid, start emulating */
 	if (vmx->emulation_required)
 		return handle_invalid_guest_state(vcpu);
@@ -5962,7 +5963,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
 
 	if (unlikely(!enable_vnmi &&
 		     vmx->loaded_vmcs->soft_vnmi_blocked)) {
-		if (vmx_interrupt_allowed(vcpu)) {
+		if (!vmx_interrupt_blocked(vcpu)) {
 			vmx->loaded_vmcs->soft_vnmi_blocked = 0;
 		} else if (vmx->loaded_vmcs->vnmi_blocked_time > 1000000000LL &&
 			   vcpu->arch.nmi_pending) {
-- 
2.18.2


