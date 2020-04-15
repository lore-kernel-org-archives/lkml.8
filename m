Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF46AC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88EE20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635278AbgDOHp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:45:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635166AbgDOHo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:44:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FA05A3C4D514F23AA5D;
        Wed, 15 Apr 2020 15:29:14 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Apr 2020 15:29:08 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        "James Morse" <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH RFC] KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset when S2FWB is supported
Date:   Wed, 15 Apr 2020 15:28:35 +0800
Message-ID: <20200415072835.1164-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stage2_unmap_vm() was introduced to unmap user RAM region in the stage2
page table to make the caches coherent. E.g., a guest reboot with stage1
MMU disabled will access memory using non-cacheable attributes. If the
RAM and caches are not coherent at this stage, some evicted dirty cache
line may go and corrupt guest data in RAM.

Since ARMv8.4, S2FWB feature is mandatory and KVM will take advantage
of it to configure the stage2 page table and the attributes of memory
access. So we ensure that guests always access memory using cacheable
attributes and thus, the caches always be coherent.

So on CPUs that support S2FWB, we can safely reset the vcpu without a
heavy stage2 unmapping.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

If this is correct, there should be a great performance improvement on
a guest reboot (or reset) on systems support S2FWB. But I'm afraid that
I've missed some points here, so please comment!

The commit 957db105c997 ("arm/arm64: KVM: Introduce stage2_unmap_vm")
was merged about six years ago and I failed to track its histroy and
intention. Instead of a whole stage2 unmapping, something like
stage2_flush_vm() looks enough to me. But again, I'm unsure...

Thanks for having a look!

 virt/kvm/arm/arm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 48d0ec44ad77..e6378162cdef 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -983,8 +983,11 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	/*
 	 * Ensure a rebooted VM will fault in RAM pages and detect if the
 	 * guest MMU is turned off and flush the caches as needed.
+	 *
+	 * S2FWB enforces all memory accesses to RAM being cacheable, we
+	 * ensure that the cache is always coherent.
 	 */
-	if (vcpu->arch.has_run_once)
+	if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
 		stage2_unmap_vm(vcpu->kvm);
 
 	vcpu_reset_hcr(vcpu);
-- 
2.19.1


