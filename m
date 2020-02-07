Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F8C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8914D20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBGRiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:38:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:53094 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbgBGRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:37:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 09:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; 
   d="scan'208";a="346067552"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2020 09:37:51 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] KVM: nVMX: Drop unnecessary check on ept caps for execute-only
Date:   Fri,  7 Feb 2020 09:37:47 -0800
Message-Id: <20200207173747.6243-8-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207173747.6243-1-sean.j.christopherson@intel.com>
References: <20200207173747.6243-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the call to cpu_has_vmx_ept_execute_only() when calculating which
EPT capabilities will be exposed to L1 for nested EPT.  The resulting
configuration is immediately sanitized by the passed in @ept_caps, and
except for the call from vmx_check_processor_compat(), @ept_caps is the
capabilities that are queried by cpu_has_vmx_ept_execute_only().  For
vmx_check_processor_compat(), KVM *wants* to ignore vmx_capability.ept
so that a divergence in EPT capabilities between CPUs is detected.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2d7b87b532f5..fe7da5e2fc59 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6071,10 +6071,9 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps,
 			VMX_EPT_PAGE_WALK_4_BIT |
 			VMX_EPT_PAGE_WALK_5_BIT |
 			VMX_EPTP_WB_BIT |
-			VMX_EPT_INVEPT_BIT;
-		if (cpu_has_vmx_ept_execute_only())
-			msrs->ept_caps |=
-				VMX_EPT_EXECUTE_ONLY_BIT;
+			VMX_EPT_INVEPT_BIT |
+			VMX_EPT_EXECUTE_ONLY_BIT;
+
 		msrs->ept_caps &= ept_caps;
 		msrs->ept_caps |= VMX_EPT_EXTENT_GLOBAL_BIT |
 			VMX_EPT_EXTENT_CONTEXT_BIT | VMX_EPT_2MB_PAGE_BIT |
-- 
2.24.1

