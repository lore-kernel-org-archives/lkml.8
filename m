Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A7EC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECD820767
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHAr9rek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgDYHCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:02:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgDYHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587798121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=uDA/5O80YM9gdD8DpCNbEwP3+qoIae/OzT4ByYwbY3s=;
        b=bHAr9rek2v8DEDoWk9Y3RAyR7MW7s8TnliemQWaW8QejN2SiTkz0R+J9f60nuygoBUiGWE
        JityEX+HhC7iSLGLEBNtEtq446g9nSejDnSEf+nRjeHfQlvUrlwl+zCm2931yWlDWtFGU9
        FakvuUcRwMFm7qWefjqqu32yC0nmZbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-aKNp2ORpO_2557YZJpUQ7A-1; Sat, 25 Apr 2020 03:01:57 -0400
X-MC-Unique: aKNp2ORpO_2557YZJpUQ7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12296800580;
        Sat, 25 Apr 2020 07:01:56 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F01CF5D9C5;
        Sat, 25 Apr 2020 07:01:54 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 10/22] KVM: nVMX: Report NMIs as allowed when in L2 and Exit-on-NMI is set
Date:   Sat, 25 Apr 2020 03:01:42 -0400
Message-Id: <20200425070154.251290-1-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Report NMIs as allowed when the vCPU is in L2 and L2 is being run with
Exit-on-NMI enabled, as NMIs are always unblocked from L1's perspective
in this case.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200423022550.15113-7-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 5 -----
 arch/x86/kvm/vmx/nested.h | 5 +++++
 arch/x86/kvm/vmx/vmx.c    | 3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 182e5209a1f6..9edd9464fedf 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -698,11 +698,6 @@ static bool nested_exit_intr_ack_set(struct kvm_vcpu *vcpu)
 		VM_EXIT_ACK_INTR_ON_EXIT;
 }
 
-static bool nested_exit_on_nmi(struct kvm_vcpu *vcpu)
-{
-	return nested_cpu_has_nmi_exiting(get_vmcs12(vcpu));
-}
-
 static int nested_vmx_check_apic_access_controls(struct kvm_vcpu *vcpu,
 					  struct vmcs12 *vmcs12)
 {
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 7ce9572c3d3a..5cc72ae0e277 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -225,6 +225,11 @@ static inline bool nested_cpu_has_save_preemption_timer(struct vmcs12 *vmcs12)
 	    VM_EXIT_SAVE_VMX_PREEMPTION_TIMER;
 }
 
+static inline bool nested_exit_on_nmi(struct kvm_vcpu *vcpu)
+{
+	return nested_cpu_has_nmi_exiting(get_vmcs12(vcpu));
+}
+
 /*
  * In nested virtualization, check if L1 asked to exit on external interrupts.
  * For most existing hypervisors, this will always return true.
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c33317bfc1cf..37b1986a4e8f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4516,6 +4516,9 @@ static bool vmx_nmi_allowed(struct kvm_vcpu *vcpu)
 	if (to_vmx(vcpu)->nested.nested_run_pending)
 		return false;
 
+	if (is_guest_mode(vcpu) && nested_exit_on_nmi(vcpu))
+		return true;
+
 	if (!enable_vnmi &&
 	    to_vmx(vcpu)->loaded_vmcs->soft_vnmi_blocked)
 		return false;
-- 
2.18.2


