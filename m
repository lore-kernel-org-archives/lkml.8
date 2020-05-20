Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14583C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECD02075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igLPXI0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgETRWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:22:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22010 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728017AbgETRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589995327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Jil/RFj0RTK+aVNqnSvLRnL3kfX+SWb+xHtGZMZ+Xnk=;
        b=igLPXI0fRUfUtosxZdEsYjS9LVqpwWhUI8LEgXh0VkErLJfR05Y37qzwWvTYY6nbUfw1pm
        C521lEw0bA2e52vGJViHvITTK6+p2QeDClWiP2qr8ynfuAmKHrnJL63BtzpG5yMK80CG1t
        WFyEmokcq7TU+h6oYTA15bCdhX6Y9rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-jDjkQTl3OHaL_WsEyO9qWQ-1; Wed, 20 May 2020 13:22:04 -0400
X-MC-Unique: jDjkQTl3OHaL_WsEyO9qWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8ABF106B21C;
        Wed, 20 May 2020 17:21:57 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 606B160610;
        Wed, 20 May 2020 17:21:57 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 09/24] KVM: nSVM: clean up tsc_offset update
Date:   Wed, 20 May 2020 13:21:30 -0400
Message-Id: <20200520172145.23284-10-pbonzini@redhat.com>
In-Reply-To: <20200520172145.23284-1-pbonzini@redhat.com>
References: <20200520172145.23284-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use l1_tsc_offset to compute svm->vcpu.arch.tsc_offset and
svm->vmcb->control.tsc_offset, instead of relying on hsave.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4f81c2196bf6..2aaa539482ae 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -241,8 +241,6 @@ static void load_nested_vmcb_control(struct vcpu_svm *svm,
 	svm->nested.intercept_dr         = control->intercept_dr;
 	svm->nested.intercept_exceptions = control->intercept_exceptions;
 	svm->nested.intercept            = control->intercept;
-
-	svm->vcpu.arch.tsc_offset += control->tsc_offset;
 }
 
 static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_vmcb)
@@ -292,7 +290,8 @@ static void nested_prepare_vmcb_control(struct vcpu_svm *svm, struct vmcb *neste
 	else
 		svm->vcpu.arch.hflags &= ~HF_VINTR_MASK;
 
-	svm->vmcb->control.tsc_offset = svm->vcpu.arch.tsc_offset;
+	svm->vmcb->control.tsc_offset = svm->vcpu.arch.tsc_offset =
+		svm->vcpu.arch.l1_tsc_offset + nested_vmcb->control.tsc_offset;
 
 	svm->vmcb->control.int_ctl = nested_vmcb->control.int_ctl | V_INTR_MASKING_MASK;
 	svm->vmcb->control.virt_ext = nested_vmcb->control.virt_ext;
@@ -557,7 +556,9 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	/* Restore the original control entries */
 	copy_vmcb_control_area(vmcb, hsave);
 
-	svm->vcpu.arch.tsc_offset = svm->vmcb->control.tsc_offset;
+	svm->vmcb->control.tsc_offset = svm->vcpu.arch.tsc_offset =
+		svm->vcpu.arch.l1_tsc_offset;
+
 	kvm_clear_exception_queue(&svm->vcpu);
 	kvm_clear_interrupt_queue(&svm->vcpu);
 
-- 
2.18.2


