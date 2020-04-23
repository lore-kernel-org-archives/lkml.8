Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB99AC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1172077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDWC0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:26:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:33067 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgDWCZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 22:25:59 -0400
IronPort-SDR: +nBxMxcXqWWx39b15NuvTH0UJG7KCKtBAyuyRdi2WfqI7bzD6at7Mbl9YSoHab3ifDPBt7AI9M
 BccvzRKMF+EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 19:25:55 -0700
IronPort-SDR: GP1MlK79NuNQBiJH1vB+o7Gny4E38M0BKWoSiowH0vr7O/PvyqUKi5hWRgXOJyAzoeKnFstH+T
 4TEzb4JKsuzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="259273958"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2020 19:25:54 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Subject: [PATCH 09/13] KVM: nVMX: Prioritize SMI over nested IRQ/NMI
Date:   Wed, 22 Apr 2020 19:25:46 -0700
Message-Id: <20200423022550.15113-10-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200423022550.15113-1-sean.j.christopherson@intel.com>
References: <20200423022550.15113-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for an unblocked SMI in vmx_check_nested_events() so that pending
SMIs are correctly prioritized over IRQs and NMIs when the latter events
will trigger VM-Exit.  This also fixes an issue where an SMI that was
marked pending while processing a nested VM-Enter wouldn't trigger an
immediate exit, i.e. would be incorrectly delayed until L2 happened to
take a VM-Exit.

Fixes: 64d6067057d96 ("KVM: x86: stubs for SMM support")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1fdaca5fd93d..8c16b190816b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3750,6 +3750,12 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
+	if (vcpu->arch.smi_pending && !is_smm(vcpu)) {
+		if (block_nested_events)
+			return -EBUSY;
+		goto no_vmexit;
+	}
+
 	if (vcpu->arch.nmi_pending && !vmx_nmi_blocked(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
-- 
2.26.0

