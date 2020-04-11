Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67225C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404E8206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDKMQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:16:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbgDKMQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:16:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2AAC2DD93474802C528B;
        Sat, 11 Apr 2020 20:16:30 +0800 (CST)
Received: from huawei.com (10.151.151.243) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 11 Apr 2020
 20:16:20 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <zhengxiang9@huawei.com>, <tanxiaofei@huawei.com>,
        <gengdongjiu@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH] KVM: handle the right RAS SEA(Synchronous External Abort) type
Date:   Sat, 11 Apr 2020 20:17:40 +0800
Message-ID: <20200411121740.37615-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.243]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the RAS Extension is implemented, b0b011000, 0b011100,
0b011101, 0b011110, and 0b011111, are not used and reserved
to the DFSC[5:0] of ESR_ELx, but the code still checks these
unused bits, so remove them.

If the handling of guest ras data error fails, it should
inject data instead of SError to let the guest recover as
much as possible.

CC: Xiang Zheng <zhengxiang9@huawei.com>
CC: Xiaofei Tan <tanxiaofei@huawei.com>
CC: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
Abort DFSC of ESR_EL2, below web site[1] has clarified:
"When the RAS Extension is implemented, 0b011000, 0b011100, 0b011101, 0b011110, and 0b011111, are reserved."

[1]: https://developer.arm.com/docs/ddi0595/b/aarch64-system-registers/esr_el2
---
 arch/arm64/include/asm/kvm_emulate.h | 5 -----
 virt/kvm/arm/mmu.c                   | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index a30b4eec7cb4..857fbc79d678 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -380,11 +380,6 @@ static __always_inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
 	case FSC_SEA_TTW1:
 	case FSC_SEA_TTW2:
 	case FSC_SEA_TTW3:
-	case FSC_SECC:
-	case FSC_SECC_TTW0:
-	case FSC_SECC_TTW1:
-	case FSC_SECC_TTW2:
-	case FSC_SECC_TTW3:
 		return true;
 	default:
 		return false;
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e3b9ee268823..3c7972ed7fc5 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1926,7 +1926,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			return 1;
 
 		if (unlikely(!is_iabt)) {
-			kvm_inject_vabt(vcpu);
+			kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 			return 1;
 		}
 	}
-- 
2.18.0.huawei.25

