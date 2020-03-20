Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D8C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACD920658
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCTVaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:30:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:37248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgCTV27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:28:59 -0400
IronPort-SDR: bAUz1lmTYRIaUZ7acz1xFRqpQCs0qLmlZOjqY8sIfyQrQ2qQo0S1DK3r9k+NZu0YIzbMqenvmk
 jbQIEJA+Rg5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 14:28:59 -0700
IronPort-SDR: uY8gHHOhXase0nA2Gow8VeiweRlWGfUrIL7CsMroiMPU971b42zejyn/uJGAsahYm+aX4sMHZM
 pRuOZH03b4Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="269224520"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2020 14:28:59 -0700
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
Subject: [PATCH v3 32/37] KVM: x86/mmu: Add module param to force TLB flush on root reuse
Date:   Fri, 20 Mar 2020 14:28:28 -0700
Message-Id: <20200320212833.3507-33-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320212833.3507-1-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a module param, flush_on_reuse, to override skip_tlb_flush and
skip_mmu_sync when performing a so called "fast cr3 switch", i.e. when
reusing a cached root.  The primary motiviation for the control is to
provide a fallback mechanism in the event that TLB flushing and/or MMU
sync bugs are exposed/introduced by upcoming changes to stop
unconditionally flushing on nested VMX transitions.

Suggested-by: Jim Mattson <jmattson@google.com>
Suggested-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 06e94ca59a2d..6a986b66c867 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -78,6 +78,9 @@ module_param_cb(nx_huge_pages_recovery_ratio, &nx_huge_pages_recovery_ratio_ops,
 		&nx_huge_pages_recovery_ratio, 0644);
 __MODULE_PARM_TYPE(nx_huge_pages_recovery_ratio, "uint");
 
+static bool __read_mostly force_flush_and_sync_on_reuse;
+module_param_named(flush_on_reuse, force_flush_and_sync_on_reuse, bool, 0644);
+
 /*
  * When setting this variable to true it enables Two-Dimensional-Paging
  * where the hardware walks 2 page tables:
@@ -4322,9 +4325,9 @@ static void __kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3,
 	 */
 	kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
 
-	if (!skip_mmu_sync)
+	if (!skip_mmu_sync || force_flush_and_sync_on_reuse)
 		kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-	if (!skip_tlb_flush)
+	if (!skip_tlb_flush || force_flush_and_sync_on_reuse)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 
 	/*
-- 
2.24.1

