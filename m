Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C1EC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392D020736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cue+9hPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgDXRZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:25:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728850AbgDXRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=UmAA9/+IHhfnv934e38JcU8oC7FPZN3AvIwnCiympQ4=;
        b=Cue+9hPcQhEf9VbbR4SkWY0C+lyGe3mXiO8EQx2PoQhSKsxPBaTkrz/LIStZtd0Wh4GxTR
        MDGpZBMiVVT32f1bzWu/HO4Gk167WuuCUNPeiyPrhkyLVceXy4RgpmGt9XUNg67ZnxgX1P
        Vdfi+jpI9PJDmUYvYFi3Rd683keNXyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-4DmxmMS2NQWsZlywIa1Pcg-1; Fri, 24 Apr 2020 13:24:34 -0400
X-MC-Unique: 4DmxmMS2NQWsZlywIa1Pcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0383F18B641F;
        Fri, 24 Apr 2020 17:24:24 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0383625277;
        Fri, 24 Apr 2020 17:24:22 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
Subject: [PATCH v2 05/22] KVM: nVMX: Preserve exception priority irrespective of exiting behavior
Date:   Fri, 24 Apr 2020 13:23:59 -0400
Message-Id: <20200424172416.243870-6-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Short circuit vmx_check_nested_events() if an exception is pending and
needs to be injected into L2, priority between coincident events is not
dependent on exiting behavior.  This fixes a bug where a single-step #DB
that is not intercepted by L1 is incorrectly dropped due to servicing a
VMX Preemption Timer VM-Exit.

Injected exceptions also need to be blocked if nested VM-Enter is
pending or an exception was already injected, otherwise injecting the
exception could overwrite an existing event injection from L1.
Technically, this scenario should be impossible, i.e. KVM shouldn't
inject its own exception during nested VM-Enter.  This will be addressed
in a future patch.

Note, event priority between SMI, NMI and INTR is incorrect for L2, e.g.
SMI should take priority over VM-Exit on NMI/INTR, and NMI that is
injected into L2 should take priority over VM-Exit INTR.  This will also
be addressed in a future patch.

Fixes: b6b8a1451fc4 ("KVM: nVMX: Rework interception of IRQs and NMIs")
Reported-by: Jim Mattson <jmattson@google.com>
Cc: Oliver Upton <oupton@google.com>
Cc: Peter Shier <pshier@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200423022550.15113-2-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b516c24494e3..490dba7d0504 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3716,11 +3716,11 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	/*
 	 * Process any exceptions that are not debug traps before MTF.
 	 */
-	if (vcpu->arch.exception.pending &&
-	    !vmx_pending_dbg_trap(vcpu) &&
-	    nested_vmx_check_exception(vcpu, &exit_qual)) {
+	if (vcpu->arch.exception.pending && !vmx_pending_dbg_trap(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
+		if (!nested_vmx_check_exception(vcpu, &exit_qual))
+			goto no_vmexit;
 		nested_vmx_inject_exception_vmexit(vcpu, exit_qual);
 		return 0;
 	}
@@ -3733,10 +3733,11 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	if (vcpu->arch.exception.pending &&
-	    nested_vmx_check_exception(vcpu, &exit_qual)) {
+	if (vcpu->arch.exception.pending) {
 		if (block_nested_events)
 			return -EBUSY;
+		if (!nested_vmx_check_exception(vcpu, &exit_qual))
+			goto no_vmexit;
 		nested_vmx_inject_exception_vmexit(vcpu, exit_qual);
 		return 0;
 	}
@@ -3771,6 +3772,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
+no_vmexit:
 	vmx_complete_nested_posted_interrupt(vcpu);
 	return 0;
 }
-- 
2.18.2


