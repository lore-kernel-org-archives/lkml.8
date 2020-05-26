Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F85C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E5120723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNUbGMD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbgEZRYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:24:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389328AbgEZRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QATNBAlNqgPgKFpxZu85aWV0J1Km94CChkhQ5CPCspU=;
        b=LNUbGMD/AtEDV+HGJ/lF4mzc+odUpjs45Tu469PrlyfBisCGSzEJGWteyqAnGcgN3ZThNM
        IPjOPf2NGY5sCl7IgZmUf96yT/DNMVZxyTxBfzPOXN0GFYMYB/n9QmE6VCla9zPjnSVj7i
        5XKedyBY0XUexKxRoDF0JR4bCm/1MXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-nvbmV7NmPUq9YqZKtwWagw-1; Tue, 26 May 2020 13:23:54 -0400
X-MC-Unique: nvbmV7NmPUq9YqZKtwWagw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23B4E800688;
        Tue, 26 May 2020 17:23:53 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19AF65D9E5;
        Tue, 26 May 2020 17:23:50 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 24/28] KVM: nSVM: split nested_vmcb_check_controls
Date:   Tue, 26 May 2020 13:23:04 -0400
Message-Id: <20200526172308.111575-25-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index f3e70aee18cd..a504963ef532 100644
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
2.26.2


