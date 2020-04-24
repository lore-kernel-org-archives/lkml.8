Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF362C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EBB20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEbFbFoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgDXRZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:25:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42079 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728768AbgDXRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587749077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ZeuFZxfdtAVz6owO1R3lYelqzSgqD4fbC4lAl+rqvQU=;
        b=jEbFbFoPh+oJQ/meM+zR+Rtx+UP879/qLjCwreEGyB+KhKBj0RP5DHwCEoCcYjYaItl35b
        mbEjM/t1HiFTxS4VhSX1qhqrPh/D0YsF9hl+b7/FF5GKeTRgi2BNVEGjJDIZBxpur9QIma
        8iklfqs7bb9PK1S2+izwdFV8vPUnvo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-KJO5IrLDOgupuVnkAwNMkA-1; Fri, 24 Apr 2020 13:24:34 -0400
X-MC-Unique: KJO5IrLDOgupuVnkAwNMkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4B1D8BE489;
        Fri, 24 Apr 2020 17:24:21 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBCFD1FDE1;
        Fri, 24 Apr 2020 17:24:20 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 03/22] KVM: SVM: immediately inject INTR vmexit
Date:   Fri, 24 Apr 2020 13:23:57 -0400
Message-Id: <20200424172416.243870-4-pbonzini@redhat.com>
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can immediately leave SVM guest mode in svm_check_nested_events
now that we have the nested_run_pending mechanism.  This makes
things easier because we can run the rest of inject_pending_event
with GIF=0, and KVM will naturally end up requesting the next
interrupt window.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index e69e60ac1370..266fde240493 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -778,13 +778,13 @@ int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
 
 static void nested_svm_intr(struct vcpu_svm *svm)
 {
+	trace_kvm_nested_intr_vmexit(svm->vmcb->save.rip);
+
 	svm->vmcb->control.exit_code   = SVM_EXIT_INTR;
 	svm->vmcb->control.exit_info_1 = 0;
 	svm->vmcb->control.exit_info_2 = 0;
 
-	/* nested_svm_vmexit this gets called afterwards from handle_exit */
-	svm->nested.exit_required = true;
-	trace_kvm_nested_intr_vmexit(svm->vmcb->save.rip);
+	nested_svm_vmexit(svm);
 }
 
 static bool nested_exit_on_intr(struct vcpu_svm *svm)
-- 
2.18.2


