Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB7C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1FB208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7SM65mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgG0Njt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:39:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33202 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729110AbgG0Njq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595857185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IXS0lkSpu6Sgs9lUnBVrdmTtxQyF0fd0pmeFbgzfAyE=;
        b=E7SM65mZpPI02pMCu9WG6QWfNU2UKOdbm3FuYEXFVHsY9u/NjnIs7n91rH6uS3JIptr5n7
        tykgagoOU3Wt0myLEaFSh2OyUix8vBjiSry9pYt86q9RIjFk+v4w7B5KClwH8i0XfwncPi
        zFaJA4T/Link9ZSrKVBLeLCpL9lkcQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-EpdeGXJJPVWS2VuQk2p9ZA-1; Mon, 27 Jul 2020 09:39:43 -0400
X-MC-Unique: EpdeGXJJPVWS2VuQk2p9ZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CA0C106B245;
        Mon, 27 Jul 2020 13:39:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5D265D9F3;
        Mon, 27 Jul 2020 13:39:39 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, aaronlewis@google.com
Subject: [PATCH 2/3] KVM: nVMX: check for required but missing VMCS12 in KVM_SET_NESTED_STATE
Date:   Mon, 27 Jul 2020 09:39:33 -0400
Message-Id: <20200727133934.25482-3-pbonzini@redhat.com>
In-Reply-To: <20200727133934.25482-1-pbonzini@redhat.com>
References: <20200727133934.25482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A missing VMCS12 was not causing -EINVAL (it was just read with
copy_from_user, so it is not a security issue, but it is still
wrong).  Test for VMCS12 validity and reject the nested state
if a VMCS12 is required but not present.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c                           | 13 ++++++++++---
 arch/x86/kvm/vmx/nested.h                           |  5 +++++
 .../kvm/x86_64/vmx_set_nested_state_test.c          | 12 +++++++++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d4a4cec034d0..6a0e32a7418c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6108,9 +6108,16 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (ret)
 		return ret;
 
-	/* Empty 'VMXON' state is permitted */
-	if (kvm_state->size < sizeof(*kvm_state) + sizeof(*vmcs12))
-		return 0;
+	/* Empty VMX data is permitted if no VMCS loaded */
+	if (kvm_state->size < sizeof(*kvm_state) + sizeof(*vmcs12)) {
+		/* See vmx_has_valid_vmcs12.  */
+		if ((kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE) ||
+		    (kvm_state->flags & KVM_STATE_NESTED_EVMCS) ||
+		    (kvm_state->hdr.vmx.vmcs12_pa != -1ull))
+			return -EINVAL;
+		else
+			return 0;
+	}
 
 	if (kvm_state->hdr.vmx.vmcs12_pa != -1ull) {
 		if (kvm_state->hdr.vmx.vmcs12_pa == kvm_state->hdr.vmx.vmxon_pa ||
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 758bccc26cf9..197148d76b8f 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -47,6 +47,11 @@ static inline struct vmcs12 *get_shadow_vmcs12(struct kvm_vcpu *vcpu)
 	return to_vmx(vcpu)->nested.cached_shadow_vmcs12;
 }
 
+/*
+ * Note: the same condition is checked against the state provided by userspace
+ * in vmx_set_nested_state; if it is satisfied, the nested state must include
+ * the VMCS12.
+ */
 static inline int vmx_has_valid_vmcs12(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index d14a34f1b018..94f28a657569 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -183,9 +183,19 @@ void test_vmx_nested_state(struct kvm_vm *vm)
 	state->hdr.vmx.smm.flags = KVM_STATE_NESTED_SMM_GUEST_MODE;
 	test_nested_state_expect_einval(vm, state);
 
-	/* Size must be large enough to fit kvm_nested_state and vmcs12. */
+	/*
+	 * Size must be large enough to fit kvm_nested_state and vmcs12
+	 * if VMCS12 physical address is set
+	 */
+	set_default_vmx_state(state, state_sz);
+	state->size = sizeof(*state);
+	state->flags = 0;
+	test_nested_state_expect_einval(vm, state);
+
 	set_default_vmx_state(state, state_sz);
 	state->size = sizeof(*state);
+	state->flags = 0;
+	state->hdr.vmx.vmcs12_pa = -1;
 	test_nested_state(vm, state);
 
 	/*
-- 
2.26.2


