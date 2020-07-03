Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80B5207CD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGCChI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:37:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:3199 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGCCgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:12 -0400
IronPort-SDR: ofqg/agq6OVrXa9brCiN0bJt0SzGcvdtDPJlZEU9SJ2dffqq52Cb+OGiPlaKLak3QkljjvmODV
 ra1hDoqEG0XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148599906"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="148599906"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:36:05 -0700
IronPort-SDR: OqHR0HSbM7yCkOBKSIP1TGkeM23HjWL4lGC182DvqArvmODs4cedh/r4bTEtYKA/Lpl8ZV4NiE
 fXkyUXDrZVpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="278295731"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 19:36:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH v3 05/21] KVM: x86/mmu: Try to avoid crashing KVM if a MMU memory cache is empty
Date:   Thu,  2 Jul 2020 19:35:29 -0700
Message-Id: <20200703023545.8771-6-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to allocate a new object instead of crashing KVM (and likely the
kernel) if a memory cache is unexpectedly empty.  Use GFP_ATOMIC for the
allocation as the caches are used while holding mmu_lock.  The immediate
BUG_ON() makes the code unnecessarily explosive and led to confusing
minimums being used in the past, e.g. allocating 4 objects where 1 would
suffice.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 94b27adab6ba..748235877def 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1060,6 +1060,15 @@ static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 	local_irq_enable();
 }
 
+static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
+					       gfp_t gfp_flags)
+{
+	if (mc->kmem_cache)
+		return kmem_cache_zalloc(mc->kmem_cache, gfp_flags);
+	else
+		return (void *)__get_free_page(gfp_flags);
+}
+
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
 {
 	void *obj;
@@ -1067,10 +1076,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
 	if (mc->nobjs >= min)
 		return 0;
 	while (mc->nobjs < ARRAY_SIZE(mc->objects)) {
-		if (mc->kmem_cache)
-			obj = kmem_cache_zalloc(mc->kmem_cache, GFP_KERNEL_ACCOUNT);
-		else
-			obj = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+		obj = mmu_memory_cache_alloc_obj(mc, GFP_KERNEL_ACCOUNT);
 		if (!obj)
 			return mc->nobjs >= min ? 0 : -ENOMEM;
 		mc->objects[mc->nobjs++] = obj;
@@ -1118,8 +1124,11 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
 {
 	void *p;
 
-	BUG_ON(!mc->nobjs);
-	p = mc->objects[--mc->nobjs];
+	if (WARN_ON(!mc->nobjs))
+		p = mmu_memory_cache_alloc_obj(mc, GFP_ATOMIC | __GFP_ACCOUNT);
+	else
+		p = mc->objects[--mc->nobjs];
+	BUG_ON(!p);
 	return p;
 }
 
-- 
2.26.0

