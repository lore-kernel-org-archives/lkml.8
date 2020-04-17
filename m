Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FB7C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A191A22202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FumVa4F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgDQQo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:44:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23832 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726498AbgDQQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587141858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=mo6kqk8iRR5fLsX8TuHV3ea9vrSXOtPQczBvHcytPmM=;
        b=FumVa4F1LxMRXCzLGFoJwaZmZfqkhoiI26Y1er4P+SA2u3iXGjXGr/u/T1/drECf1Ls2i1
        x0v/wJwHeTZFqx9RJFQh00feqt4ulidZVr0+Vk+ePkHzOJqEUN2cbXUOnpsj6FEYWIJmgm
        f+kI8/eMYm4xDbIhHIpVWrUcIg9JhXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-IhvoFzFPO8-nI-zPTJtZZQ-1; Fri, 17 Apr 2020 12:44:16 -0400
X-MC-Unique: IhvoFzFPO8-nI-zPTJtZZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFC0B801A00;
        Fri, 17 Apr 2020 16:44:15 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65A291001920;
        Fri, 17 Apr 2020 16:44:15 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 2/3] KVM: eVMCS: check if nesting is enabled
Date:   Fri, 17 Apr 2020 12:44:12 -0400
Message-Id: <20200417164413.71885-3-pbonzini@redhat.com>
In-Reply-To: <20200417164413.71885-1-pbonzini@redhat.com>
References: <20200417164413.71885-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next patch nested_get_evmcs_version will be always set in kvm_x86_ops for
VMX, even if nesting is disabled.  Therefore, check whether VMX (aka nesting)
is available in the function, the caller will not do the check anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 73f3e07c1852..48dc77de9337 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 
 #include "../hyperv.h"
+#include "../cpuid.h"
 #include "evmcs.h"
 #include "vmcs.h"
 #include "vmx.h"
@@ -333,7 +334,8 @@ uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
         * maximum supported version. KVM supports versions from 1 to
         * KVM_EVMCS_VERSION.
         */
-       if (vmx->nested.enlightened_vmcs_enabled)
+       if (kvm_cpu_cap_get(X86_FEATURE_VMX) &&
+	   vmx->nested.enlightened_vmcs_enabled)
                return (KVM_EVMCS_VERSION << 8) | 1;
 
        return 0;
-- 
2.18.2


