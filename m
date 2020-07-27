Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96765C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7513C208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SA5Stpoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgG0Nj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:39:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20116 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729005AbgG0Njx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595857191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7lelb29LZtnN6arofL4WhBUdYv4sKzBvkIAGtgybEM=;
        b=SA5StpozZrKOxF4usNp6bOZkfjGW9ffvIhezH0Idth5+/HHYENp/k+FbASvV9bkK6yIKL0
        wjjUvN/B0+QDU0V6v868nTdWeKJOYMYcEs6rBxEo4RGtoDatZzlOXr24d4bsx8ZdXN6XZW
        SQXvslZimv5FuG37b0qETZmQ/VL/BtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-53Ab_tjPNxOoOCq2Wm5IDA-1; Mon, 27 Jul 2020 09:39:49 -0400
X-MC-Unique: 53Ab_tjPNxOoOCq2Wm5IDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F49106B242;
        Mon, 27 Jul 2020 13:39:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 872F65DA33;
        Mon, 27 Jul 2020 13:39:42 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, aaronlewis@google.com
Subject: [PATCH 3/3] KVM: nVMX: check for invalid hdr.vmx.flags
Date:   Mon, 27 Jul 2020 09:39:34 -0400
Message-Id: <20200727133934.25482-4-pbonzini@redhat.com>
In-Reply-To: <20200727133934.25482-1-pbonzini@redhat.com>
References: <20200727133934.25482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdr.vmx.flags is meant for future extensions to the ABI, rejecting
invalid flags is necessary to avoid broken half-loads of the
nVMX state.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c                           |  3 +++
 .../kvm/x86_64/vmx_set_nested_state_test.c          | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6a0e32a7418c..11e4df560018 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6079,6 +6079,9 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	    ~(KVM_STATE_NESTED_SMM_GUEST_MODE | KVM_STATE_NESTED_SMM_VMXON))
 		return -EINVAL;
 
+	if (kvm_state->hdr.vmx.flags & ~KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE)
+		return -EINVAL;
+
 	/*
 	 * SMM temporarily disables VMX, so we cannot be in guest mode,
 	 * nor can VMLAUNCH/VMRESUME be pending.  Outside SMM, SMM flags
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index 94f28a657569..d59f3eb67c8f 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -146,6 +146,11 @@ void test_vmx_nested_state(struct kvm_vm *vm)
 	state->hdr.vmx.smm.flags = 1;
 	test_nested_state_expect_einval(vm, state);
 
+	/* Invalid flags are rejected. */
+	set_default_vmx_state(state, state_sz);
+	state->hdr.vmx.flags = ~0;
+	test_nested_state_expect_einval(vm, state);
+
 	/* It is invalid to have vmxon_pa == -1ull and vmcs_pa != -1ull. */
 	set_default_vmx_state(state, state_sz);
 	state->hdr.vmx.vmxon_pa = -1ull;
@@ -206,6 +211,14 @@ void test_vmx_nested_state(struct kvm_vm *vm)
 	state->flags = 0;
 	test_nested_state(vm, state);
 
+	/* Invalid flags are rejected, even if no VMCS loaded. */
+	set_default_vmx_state(state, state_sz);
+	state->size = sizeof(*state);
+	state->flags = 0;
+	state->hdr.vmx.vmcs12_pa = -1;
+	state->hdr.vmx.flags = ~0;
+	test_nested_state_expect_einval(vm, state);
+
 	/* vmxon_pa cannot be the same address as vmcs_pa. */
 	set_default_vmx_state(state, state_sz);
 	state->hdr.vmx.vmxon_pa = 0;
-- 
2.26.2

