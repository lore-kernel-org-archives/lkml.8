Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860C4C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6405220767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgCTVbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:31:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:59216 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbgCTV2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:28:50 -0400
IronPort-SDR: T/7YYXZ5f24XOrX5NFPIMx7cgLv10UkrvbzbUO7/oow8yQrn32e+OvpH7rYv3bfN+eyu4HWHzQ
 uCP3w+x56D1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 14:28:49 -0700
IronPort-SDR: ld1QuJl/kpdRhRsoLhk2AnqUpxP3ebWGd2nhfoXlZ+0u1xRJMbF9L7rUnFra2POYjghZnqqd4t
 bxmxO5K9vNxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="269224447"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2020 14:28:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 12/37] KVM: VMX: Drop redundant capability checks in low level INVVPID helpers
Date:   Fri, 20 Mar 2020 14:28:08 -0700
Message-Id: <20200320212833.3507-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320212833.3507-1-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the INVVPID capabilities checks from vpid_sync_vcpu_single() and
vpid_sync_vcpu_global() now that all callers ensure the INVVPID variant
is supported.  Note, in some cases the guarantee is provided in concert
with hardware_setup(), which enables VPID if and only if at least of
invvpid_single() or invvpid_global() is supported.

Drop the WARN_ON_ONCE() from vmx_flush_tlb() as vpid_sync_vcpu_single()
will trigger a WARN() on INVVPID failure, i.e. if SINGLE_CONTEXT isn't
supported.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/ops.h | 6 ++----
 arch/x86/kvm/vmx/vmx.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
index 39122699cfeb..aa1aab52971a 100644
--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -258,14 +258,12 @@ static inline void vpid_sync_vcpu_single(int vpid)
 	if (vpid == 0)
 		return;
 
-	if (cpu_has_vmx_invvpid_single())
-		__invvpid(VMX_VPID_EXTENT_SINGLE_CONTEXT, vpid, 0);
+	__invvpid(VMX_VPID_EXTENT_SINGLE_CONTEXT, vpid, 0);
 }
 
 static inline void vpid_sync_vcpu_global(void)
 {
-	if (cpu_has_vmx_invvpid_global())
-		__invvpid(VMX_VPID_EXTENT_ALL_CONTEXT, 0, 0);
+	__invvpid(VMX_VPID_EXTENT_ALL_CONTEXT, 0, 0);
 }
 
 static inline void vpid_sync_context(int vpid)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d6d67b816ebe..3770ae111e6a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -537,7 +537,6 @@ static inline void vmx_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 			if (cpu_has_vmx_invvpid_global()) {
 				vpid_sync_vcpu_global();
 			} else {
-				WARN_ON_ONCE(!cpu_has_vmx_invvpid_single());
 				vpid_sync_vcpu_single(vmx->vpid);
 				vpid_sync_vcpu_single(vmx->nested.vpid02);
 			}
-- 
2.24.1

