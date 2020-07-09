Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D22C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7293620767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdvT0nHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgGIOy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:54:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42377 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728067AbgGIOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594306463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FchqiKTNfD7SANtadf7uzNNvcrA+BUGouO31rgAiwk=;
        b=IdvT0nHh5ZmwYp8dvBK1CFcuBcBRnmIrketf8Qc9IWeC7z0ZJNzMPLN2Ek9G/x7XuKTWQd
        92h7UBqtAsGQm6yAtJ5VQPIxThAZhp2U9+tS4aLwG5+TLc8eZEvNv/RJsADy0VOfu1Naig
        GwrC0YvJFUyL7AX9B6hm52750WrDWUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-RnYV-ryXPp2AvDrNbJrJPg-1; Thu, 09 Jul 2020 10:54:19 -0400
X-MC-Unique: RnYV-ryXPp2AvDrNbJrJPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A381100A8D6;
        Thu,  9 Jul 2020 14:54:18 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F4DA60E1C;
        Thu,  9 Jul 2020 14:54:13 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] KVM: nSVM: prepare to handle errors from enter_svm_guest_mode()
Date:   Thu,  9 Jul 2020 16:53:53 +0200
Message-Id: <20200709145358.1560330-5-vkuznets@redhat.com>
In-Reply-To: <20200709145358.1560330-1-vkuznets@redhat.com>
References: <20200709145358.1560330-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some operations in enter_svm_guest_mode() may fail, e.g. currently
we suppress kvm_set_cr3() return value. Prepare the code to proparate
errors.

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 26 ++++++++++++++++----------
 arch/x86/kvm/svm/svm.c    |  6 ++++--
 arch/x86/kvm/svm/svm.h    |  4 ++--
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1cc8592b1820..5e6c988a4e6b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -379,7 +379,7 @@ static void nested_prepare_vmcb_control(struct vcpu_svm *svm)
 	mark_all_dirty(svm->vmcb);
 }
 
-void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
+int enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 			  struct vmcb *nested_vmcb)
 {
 	svm->nested.vmcb = vmcb_gpa;
@@ -388,6 +388,8 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	nested_prepare_vmcb_control(svm);
 
 	svm_set_gif(svm, true);
+
+	return 0;
 }
 
 int nested_svm_vmrun(struct vcpu_svm *svm)
@@ -465,18 +467,22 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
 	copy_vmcb_control_area(&hsave->control, &vmcb->control);
 
 	svm->nested.nested_run_pending = 1;
-	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb);
 
-	if (!nested_svm_vmrun_msrpm(svm)) {
-		svm->nested.nested_run_pending = 0;
+	if (enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb))
+		goto out_exit_err;
 
-		svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
-		svm->vmcb->control.exit_code_hi = 0;
-		svm->vmcb->control.exit_info_1  = 0;
-		svm->vmcb->control.exit_info_2  = 0;
+	if (nested_svm_vmrun_msrpm(svm))
+		goto out;
 
-		nested_svm_vmexit(svm);
-	}
+out_exit_err:
+	svm->nested.nested_run_pending = 0;
+
+	svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
+	svm->vmcb->control.exit_code_hi = 0;
+	svm->vmcb->control.exit_info_1  = 0;
+	svm->vmcb->control.exit_info_2  = 0;
+
+	nested_svm_vmexit(svm);
 
 out:
 	kvm_vcpu_unmap(&svm->vcpu, &map, true);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c0da4dd78ac5..b8ec56fe5478 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3843,6 +3843,7 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 	struct kvm_host_map map;
 	u64 guest;
 	u64 vmcb;
+	int ret = 0;
 
 	guest = GET_SMSTATE(u64, smstate, 0x7ed8);
 	vmcb = GET_SMSTATE(u64, smstate, 0x7ee0);
@@ -3851,10 +3852,11 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 		if (kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(vmcb), &map) == -EINVAL)
 			return 1;
 		nested_vmcb = map.hva;
-		enter_svm_guest_mode(svm, vmcb, nested_vmcb);
+		ret = enter_svm_guest_mode(svm, vmcb, nested_vmcb);
 		kvm_vcpu_unmap(&svm->vcpu, &map, true);
 	}
-	return 0;
+
+	return ret;
 }
 
 static void enable_smi_window(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6ac4c00a5d82..f98649af11d1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -387,8 +387,8 @@ static inline bool nested_exit_on_nmi(struct vcpu_svm *svm)
 	return (svm->nested.ctl.intercept & (1ULL << INTERCEPT_NMI));
 }
 
-void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
-			  struct vmcb *nested_vmcb);
+int enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
+			 struct vmcb *nested_vmcb);
 void svm_leave_nested(struct vcpu_svm *svm);
 int nested_svm_vmrun(struct vcpu_svm *svm);
 void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb);
-- 
2.25.4

