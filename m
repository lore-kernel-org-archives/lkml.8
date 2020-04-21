Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5222CC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3166B206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evO56PU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgDUQ4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:56:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41957 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729576AbgDUQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587488202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=OO6OowO7xy8Rs3mr+i17wCMk9IZgrscuaH75BkfSh7g=;
        b=evO56PU5j2loLZHGyQ/1Sn62iGCY+pDdY+JPEW/Smx9oekmvv3j+MBtS0rTYTzyJI/8/Jj
        JXXUOBR2yGnqD/MxQaieTHPB7+jgyxdv4Qo6bhYBTh998BwAWRjdenFzV0yd6ynU+1n+9p
        GqruNFVeRXAIe8hrGLHpfCyQzHCS1X8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-QyPeJtrpOIKWuzMpxC-Hhw-1; Tue, 21 Apr 2020 12:56:39 -0400
X-MC-Unique: QyPeJtrpOIKWuzMpxC-Hhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA141034AE5;
        Tue, 21 Apr 2020 16:56:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 917D99DD78;
        Tue, 21 Apr 2020 16:56:37 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2 2/3] KVM: eVMCS: check if nesting is enabled
Date:   Tue, 21 Apr 2020 12:56:31 -0400
Message-Id: <20200421165632.20157-3-pbonzini@redhat.com>
In-Reply-To: <20200421165632.20157-1-pbonzini@redhat.com>
References: <20200421165632.20157-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next patch nested_get_evmcs_version will be always set in kvm_x86_ops for
VMX, even if nesting is disabled.  Therefore, check whether VMX (aka nesting)
is available in the function, the caller will not do the check anymore.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 73f3e07c1852..e5325bd0f304 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 
 #include "../hyperv.h"
+#include "../cpuid.h"
 #include "evmcs.h"
 #include "vmcs.h"
 #include "vmx.h"
@@ -326,17 +327,18 @@ bool nested_enlightened_vmentry(struct kvm_vcpu *vcpu, u64 *evmcs_gpa)
 
 uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
 {
-       struct vcpu_vmx *vmx = to_vmx(vcpu);
-       /*
-        * vmcs_version represents the range of supported Enlightened VMCS
-        * versions: lower 8 bits is the minimal version, higher 8 bits is the
-        * maximum supported version. KVM supports versions from 1 to
-        * KVM_EVMCS_VERSION.
-        */
-       if (vmx->nested.enlightened_vmcs_enabled)
-               return (KVM_EVMCS_VERSION << 8) | 1;
-
-       return 0;
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	/*
+	 * vmcs_version represents the range of supported Enlightened VMCS
+	 * versions: lower 8 bits is the minimal version, higher 8 bits is the
+	 * maximum supported version. KVM supports versions from 1 to
+	 * KVM_EVMCS_VERSION.
+	 */
+	if (kvm_cpu_cap_get(X86_FEATURE_VMX) &&
+	    vmx->nested.enlightened_vmcs_enabled)
+		return (KVM_EVMCS_VERSION << 8) | 1;
+
+	return 0;
 }
 
 void nested_evmcs_filter_control_msr(u32 msr_index, u64 *pdata)
-- 
2.18.2


