Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C44C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BC124125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgAWC60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:58:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgAWC60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 21:58:26 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ABB2152DA18A987470E2;
        Thu, 23 Jan 2020 10:58:23 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 23 Jan 2020
 10:58:13 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH] KVM: x86: avoid some unnecessary copy in __x86_set_memory_region()
Date:   Thu, 23 Jan 2020 11:00:13 +0800
Message-ID: <1579748413-432-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Only userspace_addr and npages are passed to vm_munmap() when remove a
memory region. So we shouldn't copy the integral kvm_memory_slot struct.

No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/x86.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d1faa74981d9..767f29877938 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9735,9 +9735,9 @@ void kvm_arch_sync_events(struct kvm *kvm)
 int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 {
 	int i, r;
-	unsigned long hva;
+	unsigned long hva, uaddr, npages;
 	struct kvm_memslots *slots = kvm_memslots(kvm);
-	struct kvm_memory_slot *slot, old;
+	struct kvm_memory_slot *slot;
 
 	/* Called with kvm->slots_lock held.  */
 	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
@@ -9761,9 +9761,10 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 			return 0;
 
 		hva = 0;
+		uaddr = slot->userspace_addr;
+		npages = slot->npages;
 	}
 
-	old = *slot;
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
 		struct kvm_userspace_memory_region m;
 
@@ -9778,7 +9779,7 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 	}
 
 	if (!size)
-		vm_munmap(old.userspace_addr, old.npages * PAGE_SIZE);
+		vm_munmap(uaddr, npages * PAGE_SIZE);
 
 	return 0;
 }
-- 
2.19.1

