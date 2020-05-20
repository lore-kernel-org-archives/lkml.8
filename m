Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60700C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD662075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0np6wV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgETRW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:22:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728159AbgETRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589995340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=lZ6+W3bZGAYBVzQ44Q5AecbK6sCDrUFzmYj52X2emww=;
        b=A0np6wV35ZVlc4DEJKyOzBZ9fLEkg+/zFwnIYMtqpbbYeQuf+BtxzHKJtJGJtRMJIZ1wqy
        Inz/7IPh916eb9hl1HcTbcvh4xJoIQ2JlaJUoAfmPlhiFxxYEQxaRMbZXef7L3HAFs+Pe0
        jy+n0E8wsXZyz/w/ti1cayvBsuFAH8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-l6M-og0uPU2_iDDsCdYagA-1; Wed, 20 May 2020 13:22:19 -0400
X-MC-Unique: l6M-og0uPU2_iDDsCdYagA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0F7F18FF696;
        Wed, 20 May 2020 17:22:05 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 180B879589;
        Wed, 20 May 2020 17:22:05 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 16/24] KVM: nSVM: split nested_vmcb_check_controls
Date:   Wed, 20 May 2020 13:21:37 -0400
Message-Id: <20200520172145.23284-17-pbonzini@redhat.com>
In-Reply-To: <20200520172145.23284-1-pbonzini@redhat.com>
References: <20200520172145.23284-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The authoritative state does not come from the VMCB once in guest mode,
but KVM_SET_NESTED_STATE can still perform checks on L1's provided SVM
controls because we get them from userspace.

Therefore, split out a function to do them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index cbe96a08b080..024e27bebba3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -203,26 +203,31 @@ static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
 	return true;
 }
 
-static bool nested_vmcb_checks(struct vmcb *vmcb)
+static bool nested_vmcb_check_controls(struct vmcb_control_area *control)
 {
-	if ((vmcb->save.efer & EFER_SVME) == 0)
+	if ((control->intercept & (1ULL << INTERCEPT_VMRUN)) == 0)
 		return false;
 
-	if (((vmcb->save.cr0 & X86_CR0_CD) == 0) &&
-	    (vmcb->save.cr0 & X86_CR0_NW))
+	if (control->asid == 0)
 		return false;
 
-	if ((vmcb->control.intercept & (1ULL << INTERCEPT_VMRUN)) == 0)
+	if ((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) &&
+	    !npt_enabled)
 		return false;
 
-	if (vmcb->control.asid == 0)
+	return true;
+}
+
+static bool nested_vmcb_checks(struct vmcb *vmcb)
+{
+	if ((vmcb->save.efer & EFER_SVME) == 0)
 		return false;
 
-	if ((vmcb->control.nested_ctl & SVM_NESTED_CTL_NP_ENABLE) &&
-	    !npt_enabled)
+	if (((vmcb->save.cr0 & X86_CR0_CD) == 0) &&
+	    (vmcb->save.cr0 & X86_CR0_NW))
 		return false;
 
-	return true;
+	return nested_vmcb_check_controls(&vmcb->control);
 }
 
 static void load_nested_vmcb_control(struct vcpu_svm *svm,
-- 
2.18.2


