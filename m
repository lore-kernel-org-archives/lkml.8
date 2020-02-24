Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39055C35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182A820828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgBXDpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:45:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbgBXDpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:45:11 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CBD40889192361505E60;
        Mon, 24 Feb 2020 11:45:08 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 11:45:02 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v3] KVM: apic: avoid calculating pending eoi from an uninitialized val
Date:   Mon, 24 Feb 2020 11:46:33 +0800
Message-ID: <1582515993-5098-1-git-send-email-linmiaohe@huawei.com>
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

When pv_eoi_get_user() fails, 'val' may remain uninitialized and the return
value of pv_eoi_get_pending() becomes random.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/lapic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4f14ec7525f6..b4aca77efc8e 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -627,9 +627,11 @@ static inline bool pv_eoi_enabled(struct kvm_vcpu *vcpu)
 static bool pv_eoi_get_pending(struct kvm_vcpu *vcpu)
 {
 	u8 val;
-	if (pv_eoi_get_user(vcpu, &val) < 0)
+	if (pv_eoi_get_user(vcpu, &val) < 0) {
 		printk(KERN_WARNING "Can't read EOI MSR value: 0x%llx\n",
 			   (unsigned long long)vcpu->arch.pv_eoi.msr_val);
+		return false;
+	}
 	return val & 0x1;
 }
 
-- 
2.19.1

