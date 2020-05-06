Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EDBC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1052070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIfOLto7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgEFJon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:44:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729164AbgEFJon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588758282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=U3jHrb3ElqPyuqAafMEzJZ29hoRVGrLR/TI1FtwisFA=;
        b=XIfOLto7rY4p2S3jQljgehGZZaCa9Q4i2G8PxNIW3mADzgd9G6xhIyROZckGJQxZP+wax0
        6fA6FpIClURfVGM1M7JkuWHaAPVwdhZTRAOVtfEX3dSYf0kssByznPHV07ReEAawvKoZCj
        Sn730D2konMBW6kXVvkpaQ6M9p4E3LA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-b6TwxCKoNd2qSp1btsNAgg-1; Wed, 06 May 2020 05:44:38 -0400
X-MC-Unique: b6TwxCKoNd2qSp1btsNAgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 918001005510;
        Wed,  6 May 2020 09:44:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C24060C18;
        Wed,  6 May 2020 09:44:36 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     jmattson@google.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH] kvm: x86: Use KVM CPU capabilities to determine CR4 reserved bits
Date:   Wed,  6 May 2020 05:44:36 -0400
Message-Id: <20200506094436.3202-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using CPUID data can be useful for the processor compatibility
check, but that's it.  Using it to compute guest-reserved bits
can have both false positives (such as LA57 and UMIP which we
are already handling) and false negatives: in particular, with
this patch we don't allow anymore a KVM guest to set CR4.PKE
when CR4.PKE is clear on the host.

Fixes: b9dd21e104bc ("KVM: x86: simplify handling of PKRU")
Reported-by: Jim Mattson <jmattson@google.com>
Tested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 45688d075044..e0639b2c332e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -929,19 +929,6 @@ EXPORT_SYMBOL_GPL(kvm_set_xcr);
 	__reserved_bits;				\
 })
 
-static u64 kvm_host_cr4_reserved_bits(struct cpuinfo_x86 *c)
-{
-	u64 reserved_bits = __cr4_reserved_bits(cpu_has, c);
-
-	if (kvm_cpu_cap_has(X86_FEATURE_LA57))
-		reserved_bits &= ~X86_CR4_LA57;
-
-	if (kvm_cpu_cap_has(X86_FEATURE_UMIP))
-		reserved_bits &= ~X86_CR4_UMIP;
-
-	return reserved_bits;
-}
-
 static int kvm_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	if (cr4 & cr4_reserved_bits)
@@ -9674,7 +9661,9 @@ int kvm_arch_hardware_setup(void *opaque)
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		supported_xss = 0;
 
-	cr4_reserved_bits = kvm_host_cr4_reserved_bits(&boot_cpu_data);
+#define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
+	cr4_reserved_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_);
+#undef __kvm_cpu_cap_has
 
 	if (kvm_has_tsc_control) {
 		/*
@@ -9706,7 +9695,8 @@ int kvm_arch_check_processor_compat(void *opaque)
 
 	WARN_ON(!irqs_disabled());
 
-	if (kvm_host_cr4_reserved_bits(c) != cr4_reserved_bits)
+	if (__cr4_reserved_bits(cpu_has, c) !=
+	    __cr4_reserved_bits(cpu_has, &boot_cpu_data))
 		return -EIO;
 
 	return ops->check_processor_compatibility();
-- 
2.18.2

