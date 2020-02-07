Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E1AC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828D7246C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGPUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:20:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbgBGPUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:20:34 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D74921C7151530B987DE;
        Fri,  7 Feb 2020 23:20:28 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 23:20:21 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v2] KVM: apic: reuse smp_wmb() in kvm_make_request()
Date:   Fri, 7 Feb 2020 23:22:07 +0800
Message-ID: <1581088927-3269-1-git-send-email-linmiaohe@huawei.com>
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

kvm_make_request() provides smp_wmb() so pending_events changes are
guaranteed to be visible.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
v1->v2:
Collected Vitaly's R-b
Use Vitaly's alternative wording
Drop unnecessary comment as suggested by Sean Christopherson
---
 arch/x86/kvm/lapic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index eafc631d305c..afcd30d44cbb 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1080,9 +1080,6 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 			result = 1;
 			/* assumes that there are only KVM_APIC_INIT/SIPI */
 			apic->pending_events = (1UL << KVM_APIC_INIT);
-			/* make sure pending_events is visible before sending
-			 * the request */
-			smp_wmb();
 			kvm_make_request(KVM_REQ_EVENT, vcpu);
 			kvm_vcpu_kick(vcpu);
 		}
-- 
2.19.1

