Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634B5C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDF620767
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCyq92si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgDYHCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:02:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbgDYHCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587798126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=AgRaTvlZ0YOO3h0VcTooJDKwBeBo3GSedwNk5gifeLI=;
        b=gCyq92siVlqdXonb7WczN0CjEo4dLZPRaHd7wm9QRLDOHx9FBb9u40M6hmFGWfHEGD53R1
        evDZ1rCHJ/ALoaPVYBlfc1llSRLrIFfqaMiuXrQVdB8AAzsgXPSYKeR3rLY0Il/9QtssXE
        nOiAPfObOIC9uZu/59Q5PMJLPPGC1uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-SxHZjiXmPK-3axcf6CAamQ-1; Sat, 25 Apr 2020 03:02:01 -0400
X-MC-Unique: SxHZjiXmPK-3axcf6CAamQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35124460;
        Sat, 25 Apr 2020 07:02:00 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BB9F5D9C5;
        Sat, 25 Apr 2020 07:01:59 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 15/22] KVM: nVMX: Preserve IRQ/NMI priority irrespective of exiting behavior
Date:   Sat, 25 Apr 2020 03:01:47 -0400
Message-Id: <20200425070154.251290-6-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Short circuit vmx_check_nested_events() if an unblocked IRQ/NMI is
pending and needs to be injected into L2, priority between coincident
events is not dependent on exiting behavior.

Fixes: b6b8a1451fc4 ("KVM: nVMX: Rework interception of IRQs and NMIs")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200423022550.15113-9-sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9edd9464fedf..188ff4cfdbaf 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3750,9 +3750,12 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	if (vcpu->arch.nmi_pending && nested_exit_on_nmi(vcpu)) {
+	if (vcpu->arch.nmi_pending && !vmx_nmi_blocked(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
+		if (!nested_exit_on_nmi(vcpu))
+			goto no_vmexit;
+
 		nested_vmx_vmexit(vcpu, EXIT_REASON_EXCEPTION_NMI,
 				  NMI_VECTOR | INTR_TYPE_NMI_INTR |
 				  INTR_INFO_VALID_MASK, 0);
@@ -3765,9 +3768,11 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	if (kvm_cpu_has_interrupt(vcpu) && nested_exit_on_intr(vcpu)) {
+	if (kvm_cpu_has_interrupt(vcpu) && !vmx_interrupt_blocked(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
+		if (!nested_exit_on_intr(vcpu))
+			goto no_vmexit;
 		nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT, 0, 0);
 		return 0;
 	}
-- 
2.18.2


