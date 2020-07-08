Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FA9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D70E2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgGHGvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:51:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:5308 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbgGHGvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:51:21 -0400
IronPort-SDR: QRIqhpKaGVjxAGd8357chTDiFaSfMq0YmgIG11UKehHOBCZd0O2lJJxNIhX3PNMH2n7Hin3lF2
 dPL/cY5ygcBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145852099"
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="145852099"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 23:51:20 -0700
IronPort-SDR: SOCrTfYK6kkaZ6/TuBcf5t3/KJRRLZdNrGXqq84qlvmqI6o678plZU3On5D93+LQGdj4V5eZq5
 192OmVpu/4/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="457399244"
Received: from lxy-dell.sh.intel.com ([10.239.159.21])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2020 23:51:17 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v3 7/8] KVM: lapic: Use guest_cpuid_has() in kvm_apic_set_version()
Date:   Wed,  8 Jul 2020 14:50:53 +0800
Message-Id: <20200708065054.19713-8-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200708065054.19713-1-xiaoyao.li@intel.com>
References: <20200708065054.19713-1-xiaoyao.li@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only code cleanup and no functional change.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/kvm/lapic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5bf72fc86a8e..e5dbb7ebae78 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -354,7 +354,6 @@ static inline int apic_lvt_nmi_mode(u32 lvt_val)
 void kvm_apic_set_version(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
-	struct kvm_cpuid_entry2 *feat;
 	u32 v = APIC_VERSION;
 
 	if (!lapic_in_kernel(vcpu))
@@ -367,8 +366,7 @@ void kvm_apic_set_version(struct kvm_vcpu *vcpu)
 	 * version first and level-triggered interrupts never get EOIed in
 	 * IOAPIC.
 	 */
-	feat = kvm_find_cpuid_entry(apic->vcpu, 0x1, 0);
-	if (feat && (feat->ecx & (1 << (X86_FEATURE_X2APIC & 31))) &&
+	if (guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) &&
 	    !ioapic_in_kernel(vcpu->kvm))
 		v |= APIC_LVR_DIRECTED_EOI;
 	kvm_lapic_set_reg(apic, APIC_LVR, v);
-- 
2.18.4

