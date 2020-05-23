Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA10CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 16:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25AD20884
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 16:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwTopeKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgEWQPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 12:15:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48202 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728025AbgEWQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 12:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590250519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytf9W2kex3b56H4BEKOUukloGENtrEZz4KuH9AmMNpQ=;
        b=UwTopeKnbUkabq7R4yzTEcU2bfYqmy5PBingBqsR+uqm1OGbOZeOSgfFoa5tzH+frYq6T7
        6pM4AzSH8xA6Ig58Dfb/QLl+BXH2M/dRbiaqnnu2mld0i6Y+PWANiFh5ldaP2hdj5PDNSC
        A371EVFfbJvL58n4dHt2p5Y4fpp55ng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-3rESmGjfPumnQqjegbACfQ-1; Sat, 23 May 2020 12:15:17 -0400
X-MC-Unique: 3rESmGjfPumnQqjegbACfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EBCF107ACCA;
        Sat, 23 May 2020 16:15:15 +0000 (UTC)
Received: from starship.f32vm (unknown [10.35.206.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD6B600E5;
        Sat, 23 May 2020 16:15:01 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tao Xu <tao3.xu@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jingqi Liu <jingqi.liu@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/2] kvm/x86/vmx: enable X86_FEATURE_WAITPKG in KVM capabilities
Date:   Sat, 23 May 2020 19:14:54 +0300
Message-Id: <20200523161455.3940-2-mlevitsk@redhat.com>
In-Reply-To: <20200523161455.3940-1-mlevitsk@redhat.com>
References: <20200523161455.3940-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though we might not allow the guest to use
WAITPKG's new instructions, we should tell KVM
that the feature is supported by the host CPU.

Note that vmx_waitpkg_supported checks that WAITPKG
_can_ be set in secondary execution controls as specified
by VMX capability MSR, rather that we actually enable it for a guest.

Fixes: e69e72faa3a0 KVM: x86: Add support for user wait instructions

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 55712dd86bafa..fca493d4517c5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7298,6 +7298,9 @@ static __init void vmx_set_cpu_caps(void)
 	/* CPUID 0x80000001 */
 	if (!cpu_has_vmx_rdtscp())
 		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP);
+
+	if (vmx_waitpkg_supported())
+		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
 }
 
 static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
-- 
2.26.2

