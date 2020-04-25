Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3315BC55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41CC20857
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2c5lcyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDYHCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:02:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54547 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgDYHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587798126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=qRicctAkr3eINW616/AMpnm0J0Vm/B504ODY+T3FuoI=;
        b=F2c5lcyfu/r9lsyvS4GGGIhD6m1M3sYBjGxkZmDpA1flAwDDoWz1Hx7ithobAdbqJAy3ds
        lbQoFHOnMVgiJijtZ2Xr9k7b+gon9Xamtf/IEM8vlPaUZETAzF65npHaIHd2ndAXYhpORI
        XipuOhm3/6nEXfSo33CEEg4ARGYU8dw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-V6c31jCOM6e6KeYImgCBEg-1; Sat, 25 Apr 2020 03:02:04 -0400
X-MC-Unique: V6c31jCOM6e6KeYImgCBEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0423462;
        Sat, 25 Apr 2020 07:02:02 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0EB05D9C5;
        Sat, 25 Apr 2020 07:02:01 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 18/22] KVM: nSVM: Preserve IRQ/NMI/SMI priority irrespective of exiting behavior
Date:   Sat, 25 Apr 2020 03:01:50 -0400
Message-Id: <20200425070154.251290-9-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short circuit vmx_check_nested_events() if an unblocked IRQ/NMI/SMI is
pending and needs to be injected into L2, priority between coincident
events is not dependent on exiting behavior.

Fixes: b518ba9fa691 ("KVM: nSVM: implement check_nested_events for interrupts")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a7a3d695405e..7c86ccb0e939 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -811,23 +811,29 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 		kvm_event_needs_reinjection(vcpu) || svm->nested.exit_required ||
 		svm->nested.nested_run_pending;
 
-	if (vcpu->arch.smi_pending && nested_exit_on_smi(svm)) {
+	if (vcpu->arch.smi_pending && !svm_smi_blocked(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
+		if (!nested_exit_on_smi(svm))
+			return 0;
 		nested_svm_smi(svm);
 		return 0;
 	}
 
-	if (vcpu->arch.nmi_pending && nested_exit_on_nmi(svm)) {
+	if (vcpu->arch.nmi_pending && !svm_nmi_blocked(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
+		if (!nested_exit_on_nmi(svm))
+			return 0;
 		nested_svm_nmi(svm);
 		return 0;
 	}
 
-	if (kvm_cpu_has_interrupt(vcpu) && nested_exit_on_intr(svm)) {
+	if (kvm_cpu_has_interrupt(vcpu) && !svm_interrupt_blocked(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
+		if (!nested_exit_on_intr(svm))
+			return 0;
 		nested_svm_intr(svm);
 		return 0;
 	}
-- 
2.18.2


