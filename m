Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF25C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E2321841
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEGMgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:36:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbgEGMgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:36:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 920F063535DED5715A9D;
        Thu,  7 May 2020 20:36:31 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:36:23 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>, <suzuki.poulose@arm.com>
CC:     <maz@kernel.org>, <christoffer.dall@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        <zhengxiang9@huawei.com>, <amurray@thegoodpenguin.co.uk>,
        <eric.auger@redhat.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH resend 1/2] KVM: arm64: Clean up the checking for huge mapping
Date:   Thu, 7 May 2020 20:35:45 +0800
Message-ID: <20200507123546.1875-2-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200507123546.1875-1-yuzenghui@huawei.com>
References: <20200507123546.1875-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

If we are checking whether the stage2 can map PAGE_SIZE,
we don't have to do the boundary checks as both the host
VMA and the guest memslots are page aligned. Bail the case
easily.

While we're at it, fixup a typo in the comment below.

Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e3b9ee268823..557f36866d1c 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1607,6 +1607,10 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
 	hva_t uaddr_start, uaddr_end;
 	size_t size;
 
+	/* The memslot and the VMA are guaranteed to be aligned to PAGE_SIZE */
+	if (map_size == PAGE_SIZE)
+		return true;
+
 	size = memslot->npages * PAGE_SIZE;
 
 	gpa_start = memslot->base_gfn << PAGE_SHIFT;
@@ -1626,7 +1630,7 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
 	 *    |abcde|fgh  Stage-1 block  |    Stage-1 block tv|xyz|
 	 *    +-----+--------------------+--------------------+---+
 	 *
-	 *    memslot->base_gfn << PAGE_SIZE:
+	 *    memslot->base_gfn << PAGE_SHIFT:
 	 *      +---+--------------------+--------------------+-----+
 	 *      |abc|def  Stage-2 block  |    Stage-2 block   |tvxyz|
 	 *      +---+--------------------+--------------------+-----+
-- 
2.19.1


