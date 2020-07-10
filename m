Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3CC433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65C220725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itWt5k8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGJPs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:48:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32500 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728199AbgGJPsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594396132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ph4T4YDVII3jrJWIHOD3/5mI3kXc9Jt7+WbkEloGPMo=;
        b=itWt5k8SD/6jmpeQKodw9TWt7ddyacGADAWKdW/5iOu2RQoQDr3v2Gd0wN8K2lOergZ5qb
        8L5JSCYWMIEJkuepn8YNRBUbUGkcjgo7YJ6083meYM7IR6f0UQ/E5QUtfuXLPeQkLb29Ff
        SNrsGHzDWcSKfaO/J8h/2hvobKhbx1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-yoUJBosHOyqKK9LKAMCJsw-1; Fri, 10 Jul 2020 11:48:32 -0400
X-MC-Unique: yoUJBosHOyqKK9LKAMCJsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39A6F800FEB;
        Fri, 10 Jul 2020 15:48:30 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-235.ams2.redhat.com [10.36.114.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4902E7EF9B;
        Fri, 10 Jul 2020 15:48:28 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org
Subject: [PATCH v3 4/9] KVM: x86: rename update_bp_intercept to update_exception_bitmap
Date:   Fri, 10 Jul 2020 17:48:06 +0200
Message-Id: <20200710154811.418214-5-mgamal@redhat.com>
In-Reply-To: <20200710154811.418214-1-mgamal@redhat.com>
References: <20200710154811.418214-1-mgamal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

We would like to introduce a callback to update the #PF intercept
when CPUID changes.  Just reuse update_bp_intercept since VMX is
already using update_exception_bitmap instead of a bespoke function.

While at it, remove an unnecessary assignment in the SVM version,
which is already done in the caller (kvm_arch_vcpu_ioctl_set_guest_debug)
and has nothing to do with the exception bitmap.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/svm/svm.c          | 7 +++----
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 arch/x86/kvm/x86.c              | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 62373cc06c72..bb4044ffb7b7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1098,7 +1098,7 @@ struct kvm_x86_ops {
 	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
 
-	void (*update_bp_intercept)(struct kvm_vcpu *vcpu);
+	void (*update_exception_bitmap)(struct kvm_vcpu *vcpu);
 	int (*get_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
 	u64 (*get_segment_base)(struct kvm_vcpu *vcpu, int seg);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c0da4dd78ac5..79c33b3539f0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1627,7 +1627,7 @@ static void svm_set_segment(struct kvm_vcpu *vcpu,
 	mark_dirty(svm->vmcb, VMCB_SEG);
 }
 
-static void update_bp_intercept(struct kvm_vcpu *vcpu)
+static void update_exception_bitmap(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -1636,8 +1636,7 @@ static void update_bp_intercept(struct kvm_vcpu *vcpu)
 	if (vcpu->guest_debug & KVM_GUESTDBG_ENABLE) {
 		if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)
 			set_exception_intercept(svm, BP_VECTOR);
-	} else
-		vcpu->guest_debug = 0;
+	}
 }
 
 static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
@@ -3989,7 +3988,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_blocking = svm_vcpu_blocking,
 	.vcpu_unblocking = svm_vcpu_unblocking,
 
-	.update_bp_intercept = update_bp_intercept,
+	.update_exception_bitmap = update_exception_bitmap,
 	.get_msr_feature = svm_get_msr_feature,
 	.get_msr = svm_get_msr,
 	.set_msr = svm_set_msr,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 13745f2a5ecd..178ee92551a9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7859,7 +7859,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.vcpu_load = vmx_vcpu_load,
 	.vcpu_put = vmx_vcpu_put,
 
-	.update_bp_intercept = update_exception_bitmap,
+	.update_exception_bitmap = update_exception_bitmap,
 	.get_msr_feature = vmx_get_msr_feature,
 	.get_msr = vmx_get_msr,
 	.set_msr = vmx_set_msr,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1f5f4074fc59..03c401963062 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9281,7 +9281,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	 */
 	kvm_set_rflags(vcpu, rflags);
 
-	kvm_x86_ops.update_bp_intercept(vcpu);
+	kvm_x86_ops.update_exception_bitmap(vcpu);
 
 	r = 0;
 
-- 
2.26.2

