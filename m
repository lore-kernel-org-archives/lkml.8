Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E5C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D53620714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbgDANGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:06:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732252AbgDANGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:06:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C553B6E1EE230E43A9BA;
        Wed,  1 Apr 2020 21:06:37 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Apr 2020 21:06:26 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <paulus@ozlabs.org>, <benh@kernel.crashing.org>,
        <mpe@ellerman.id.au>
CC:     <kvm-ppc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] KVM: PPC: Book3S HV: remove redundant NULL check
Date:   Wed, 1 Apr 2020 21:09:03 +0800
Message-ID: <20200401130903.6576-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free function kfree() already does NULL check, so the additional
check is unnecessary, just remove it.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index dc97e5b..cad3243 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1416,8 +1416,7 @@ static long int __kvmhv_nested_page_fault(struct kvm_run *run,
 	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
 	ret = kvmppc_create_pte(kvm, gp->shadow_pgtable, pte, n_gpa, level,
 				mmu_seq, gp->shadow_lpid, rmapp, &n_rmap);
-	if (n_rmap)
-		kfree(n_rmap);
+	kfree(n_rmap);
 	if (ret == -EAGAIN)
 		ret = RESUME_GUEST;	/* Let the guest try again */
 
-- 
2.7.4

