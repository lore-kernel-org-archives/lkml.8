Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F6CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183372071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgFa/tmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403954AbgEYOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:41:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391007AbgEYOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590417700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tW/ADyX9zwrjBKIKvd0UbIE8BCH3HnzV4Z5WBcx4X0=;
        b=FgFa/tmjJjqfzKv3CaLsjW00YI7es5K4BAUcrhFEZlyQdzPdq9nO+TzgpCrRDnxs94qIgu
        ryCsc8eo9/IkWhX3ig4YDv2F16+1VXurpH5EQalr7MHCWpXjdm9dICxsGjnqoeTcBPX6SY
        gqf+rwSCSd2H0IjPoRAzESDTp2xSBfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-nIPtE7cxPyiXF7F5II2QMw-1; Mon, 25 May 2020 10:41:35 -0400
X-MC-Unique: nIPtE7cxPyiXF7F5II2QMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F3C31005510;
        Mon, 25 May 2020 14:41:33 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E6645D9C5;
        Mon, 25 May 2020 14:41:30 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] Revert "KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Ready" exceptions simultaneously"
Date:   Mon, 25 May 2020 16:41:16 +0200
Message-Id: <20200525144125.143875-2-vkuznets@redhat.com>
In-Reply-To: <20200525144125.143875-1-vkuznets@redhat.com>
References: <20200525144125.143875-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9a6e7c39810e (""KVM: async_pf: Fix #DF due to inject "Page not
Present" and "Page Ready" exceptions simultaneously") added a protection
against 'page ready' notification coming before 'page not present' is
delivered. This situation seems to be impossible since commit 2a266f23550b
("KVM MMU: check pending exception before injecting APF) which added
'vcpu->arch.exception.pending' check to kvm_can_do_async_pf.

On x86, kvm_arch_async_page_present() has only one call site:
kvm_check_async_pf_completion() loop and we only enter the loop when
kvm_arch_can_inject_async_page_present(vcpu) which when async pf msr
is enabled, translates into kvm_can_do_async_pf().

There is also one problem with the cancellation mechanism. We don't seem
to check that the 'page not present' notification we're canceling matches
the 'page ready' notification so in theory, we may erroneously drop two
valid events.

Revert the commit.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/x86.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c17e6eb9ad43..8e0bbe4f0d5b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10364,13 +10364,6 @@ static int apf_put_user(struct kvm_vcpu *vcpu, u32 val)
 				      sizeof(val));
 }
 
-static int apf_get_user(struct kvm_vcpu *vcpu, u32 *val)
-{
-
-	return kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.apf.data, val,
-				      sizeof(u32));
-}
-
 static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
 {
 	if (!vcpu->arch.apf.delivery_as_pf_vmexit && is_guest_mode(vcpu))
@@ -10435,7 +10428,6 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 				 struct kvm_async_pf *work)
 {
 	struct x86_exception fault;
-	u32 val;
 
 	if (work->wakeup_all)
 		work->arch.token = ~0; /* broadcast wakeup */
@@ -10444,19 +10436,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 	trace_kvm_async_pf_ready(work->arch.token, work->cr2_or_gpa);
 
 	if (vcpu->arch.apf.msr_val & KVM_ASYNC_PF_ENABLED &&
-	    !apf_get_user(vcpu, &val)) {
-		if (val == KVM_PV_REASON_PAGE_NOT_PRESENT &&
-		    vcpu->arch.exception.pending &&
-		    vcpu->arch.exception.nr == PF_VECTOR &&
-		    !apf_put_user(vcpu, 0)) {
-			vcpu->arch.exception.injected = false;
-			vcpu->arch.exception.pending = false;
-			vcpu->arch.exception.nr = 0;
-			vcpu->arch.exception.has_error_code = false;
-			vcpu->arch.exception.error_code = 0;
-			vcpu->arch.exception.has_payload = false;
-			vcpu->arch.exception.payload = 0;
-		} else if (!apf_put_user(vcpu, KVM_PV_REASON_PAGE_READY)) {
+	    !apf_put_user(vcpu, KVM_PV_REASON_PAGE_READY)) {
 			fault.vector = PF_VECTOR;
 			fault.error_code_valid = true;
 			fault.error_code = 0;
@@ -10464,7 +10444,6 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 			fault.address = work->arch.token;
 			fault.async_page_fault = true;
 			kvm_inject_page_fault(vcpu, &fault);
-		}
 	}
 	vcpu->arch.apf.halted = false;
 	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
-- 
2.25.4

