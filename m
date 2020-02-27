Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C02CC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C71D24672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgB0DTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 22:19:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbgB0DTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 22:19:38 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66B70344DEC26ED07C0F;
        Thu, 27 Feb 2020 11:19:35 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 27 Feb 2020
 11:19:25 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v2] KVM: Fix some obsolete comments
Date:   Thu, 27 Feb 2020 11:20:54 +0800
Message-ID: <1582773654-4911-1-git-send-email-linmiaohe@huawei.com>
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

Remove some obsolete comments, fix wrong function name and description.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v1->v2:
Use Oxford comma
Collect Vitaly's R-b
---
 arch/x86/kvm/vmx/nested.c | 4 ++--
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0946122a8d3b..966a5c394c06 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2960,7 +2960,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
 	/*
 	 * Induce a consistency check VMExit by clearing bit 1 in GUEST_RFLAGS,
 	 * which is reserved to '1' by hardware.  GUEST_RFLAGS is guaranteed to
-	 * be written (by preparve_vmcs02()) before the "real" VMEnter, i.e.
+	 * be written (by prepare_vmcs02()) before the "real" VMEnter, i.e.
 	 * there is no need to preserve other bits or save/restore the field.
 	 */
 	vmcs_writel(GUEST_RFLAGS, 0);
@@ -4382,7 +4382,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
  * Decode the memory-address operand of a vmx instruction, as recorded on an
  * exit caused by such an instruction (run by a guest hypervisor).
  * On success, returns 0. When the operand is invalid, returns 1 and throws
- * #UD or #GP.
+ * #UD, #GP, or #SS.
  */
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 			u32 vmx_instruction_info, bool wr, int len, gva_t *ret)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a04017bdae05..efc509a7945a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -808,7 +808,7 @@ void update_exception_bitmap(struct kvm_vcpu *vcpu)
 	if (to_vmx(vcpu)->rmode.vm86_active)
 		eb = ~0;
 	if (enable_ept)
-		eb &= ~(1u << PF_VECTOR); /* bypass_guest_pf = 0 */
+		eb &= ~(1u << PF_VECTOR);
 
 	/* When we are running a nested L2 guest and L1 specified for it a
 	 * certain exception bitmap, we must trap the same exceptions and pass
-- 
2.19.1

