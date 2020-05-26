Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2EAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78832204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHtChx2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbgEZRZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:25:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49241 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388848AbgEZRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kbtBU1MOelWIUuUVVYfK0gQzdSdxJbp6qK0Ut7yTAY8=;
        b=WHtChx2yRMbUHm7CDuAnviMmCJbQ2ER0Tg2XJIkIY6h8PkrykQ8KiKybuVXbgxI+/96y+X
        YfiA+vwFwpLx4aJplY9YWjeHbwQbZ32K/Mrzakij+hzM+QNBl/i2vJ4RkxnfBdoAqUFgDi
        L2rcp/9RkznJFpZAOX9/aCG/yF+7E9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-1CkpBpgGOAunrVF5A7XMYg-1; Tue, 26 May 2020 13:23:16 -0400
X-MC-Unique: 1CkpBpgGOAunrVF5A7XMYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5F1464;
        Tue, 26 May 2020 17:23:15 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7652010013DB;
        Tue, 26 May 2020 17:23:14 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 08/28] KVM: nSVM: move map argument out of enter_svm_guest_mode
Date:   Tue, 26 May 2020 13:22:48 -0400
Message-Id: <20200526172308.111575-9-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unmapping the nested VMCB in enter_svm_guest_mode is a bit of a wart,
since the map is not used elsewhere in the function.  There are
just two calls, so move it there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 14 ++++++--------
 arch/x86/kvm/svm/svm.c    |  3 ++-
 arch/x86/kvm/svm/svm.h    |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 81e0fbd5e267..d2fc3c4aa00b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -229,7 +229,7 @@ static bool nested_vmcb_checks(struct vmcb *vmcb)
 }
 
 void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
-			  struct vmcb *nested_vmcb, struct kvm_host_map *map)
+			  struct vmcb *nested_vmcb)
 {
 	bool evaluate_pending_interrupts =
 		is_intercept(svm, INTERCEPT_VINTR) ||
@@ -304,8 +304,6 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	svm->vmcb->control.pause_filter_thresh =
 		nested_vmcb->control.pause_filter_thresh;
 
-	kvm_vcpu_unmap(&svm->vcpu, map, true);
-
 	/* Enter Guest-Mode */
 	enter_guest_mode(&svm->vcpu);
 
@@ -368,10 +366,7 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
 		nested_vmcb->control.exit_code_hi = 0;
 		nested_vmcb->control.exit_info_1  = 0;
 		nested_vmcb->control.exit_info_2  = 0;
-
-		kvm_vcpu_unmap(&svm->vcpu, &map, true);
-
-		return ret;
+		goto out;
 	}
 
 	trace_kvm_nested_vmrun(svm->vmcb->save.rip, vmcb_gpa,
@@ -414,7 +409,7 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
 	copy_vmcb_control_area(hsave, vmcb);
 
 	svm->nested.nested_run_pending = 1;
-	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, &map);
+	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb);
 
 	if (!nested_svm_vmrun_msrpm(svm)) {
 		svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
@@ -425,6 +420,9 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
 		nested_svm_vmexit(svm);
 	}
 
+out:
+	kvm_vcpu_unmap(&svm->vcpu, &map, true);
+
 	return ret;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index abe277a3216b..3321c402a753 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3814,7 +3814,8 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 		if (kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(vmcb), &map) == -EINVAL)
 			return 1;
 		nested_vmcb = map.hva;
-		enter_svm_guest_mode(svm, vmcb, nested_vmcb, &map);
+		enter_svm_guest_mode(svm, vmcb, nested_vmcb);
+		kvm_vcpu_unmap(&svm->vcpu, &map, true);
 	}
 	return 0;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 89fab75dd4f5..33e3f09d7a8e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -395,7 +395,7 @@ static inline bool nested_exit_on_nmi(struct vcpu_svm *svm)
 }
 
 void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
-			  struct vmcb *nested_vmcb, struct kvm_host_map *map);
+			  struct vmcb *nested_vmcb);
 int nested_svm_vmrun(struct vcpu_svm *svm);
 void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb);
 int nested_svm_vmexit(struct vcpu_svm *svm);
-- 
2.26.2


