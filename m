Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F87C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A53D20656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD1XKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:10:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:60554 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgD1XK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:10:29 -0400
IronPort-SDR: 8pRgyfKvzctGSh9OCOWdCjZD2edCwwS6YIp1KIqGEoCXClsRnXaJv0NzkjFePQji5tBZGMd+jW
 1r5IQ6DZ6RDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 16:10:28 -0700
IronPort-SDR: ymAtfv6Y9u3LU8hUXMd6TBtt2Sy65OH4v6MpsYmBzPPbjIstHFdqkAIYtGI5REHGV1uk52OS1F
 1GcQQINvHTrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="257774905"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2020 16:10:26 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: nVMX: Drop superfluous VMREAD of vmcs02.GUEST_SYSENTER_*
Date:   Tue, 28 Apr 2020 16:10:25 -0700
Message-Id: <20200428231025.12766-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200428231025.12766-1-sean.j.christopherson@intel.com>
References: <20200428231025.12766-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't propagate GUEST_SYSENTER_* from vmcs02 to vmcs12 on nested VM-Exit
as the vmcs12 fields are updated in vmx_set_msr(), and writes to the
corresponding MSRs are always intercepted by KVM when running L2.

Dropping the propagation was intended to be done in the same commit that
added vmcs12 writes in vmx_set_msr()[1], but for reasons unknown was
only shuffled around[2][3].

[1] https://patchwork.kernel.org/patch/10933215
[2] https://patchwork.kernel.org/patch/10933215/#22682289
[3] https://lore.kernel.org/patchwork/patch/1088643

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2c36f3f53108..a54231bac047 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3944,10 +3944,6 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 	vmcs12->guest_cs_ar_bytes = vmcs_read32(GUEST_CS_AR_BYTES);
 	vmcs12->guest_ss_ar_bytes = vmcs_read32(GUEST_SS_AR_BYTES);
 
-	vmcs12->guest_sysenter_cs = vmcs_read32(GUEST_SYSENTER_CS);
-	vmcs12->guest_sysenter_esp = vmcs_readl(GUEST_SYSENTER_ESP);
-	vmcs12->guest_sysenter_eip = vmcs_readl(GUEST_SYSENTER_EIP);
-
 	vmcs12->guest_interruptibility_info =
 		vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
 
-- 
2.26.0

