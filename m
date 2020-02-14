Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1472C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC2B2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgBNCbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:31:10 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbgBNCbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:31:09 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 827C46388C85363FF681;
        Fri, 14 Feb 2020 10:31:06 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Feb 2020
 10:30:56 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH] KVM: x86: don't notify userspace IOAPIC on edge-triggered interrupt EOI
Date:   Fri, 14 Feb 2020 10:32:38 +0800
Message-ID: <1581647558-8216-1-git-send-email-linmiaohe@huawei.com>
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

Commit 13db77347db1 ("KVM: x86: don't notify userspace IOAPIC on edge
EOI") said, edge-triggered interrupts don't set a bit in TMR, which means
that IOAPIC isn't notified on EOI. And var level indicates level-triggered
interrupt.
But commit 3159d36ad799 ("KVM: x86: use generic function for MSI parsing")
replace var level with irq.level by mistake. Fix it by changing irq.level
to irq.trig_mode.

Fixes: 3159d36ad799 ("KVM: x86: use generic function for MSI parsing")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/irq_comm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 79afa0bb5f41..c47d2acec529 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -417,7 +417,7 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
 
 			kvm_set_msi_irq(vcpu->kvm, entry, &irq);
 
-			if (irq.level &&
+			if (irq.trig_mode &&
 			    kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
 						irq.dest_id, irq.dest_mode))
 				__set_bit(irq.vector, ioapic_handled_vectors);
-- 
2.19.1

