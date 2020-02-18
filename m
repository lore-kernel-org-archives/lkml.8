Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE79C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8224F206EF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgBRDPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:15:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbgBRDPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:15:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B052C1E9CC183D1A83D;
        Tue, 18 Feb 2020 11:15:37 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Feb 2020
 11:15:29 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH] KVM: apic: rename apic_lvt_vector and apic_lvt_enabled
Date:   Tue, 18 Feb 2020 11:17:05 +0800
Message-ID: <1581995825-11239-1-git-send-email-linmiaohe@huawei.com>
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

As the func apic_lvt_enabled() is only used once with APIC_LVTT as the
second argument, we can eliminate the argument and hardcode lvt_type as
APIC_LVTT. And also rename apic_lvt_enabled() to apic_lvtt_enabled() to
indicates it's used for APIC_LVTT only. Similar as apic_lvt_vector().

Suggested-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/lapic.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index eafc631d305c..4f14ec7525f6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -289,14 +289,14 @@ static inline void kvm_apic_set_x2apic_id(struct kvm_lapic *apic, u32 id)
 	recalculate_apic_map(apic->vcpu->kvm);
 }
 
-static inline int apic_lvt_enabled(struct kvm_lapic *apic, int lvt_type)
+static inline int apic_lvtt_enabled(struct kvm_lapic *apic)
 {
-	return !(kvm_lapic_get_reg(apic, lvt_type) & APIC_LVT_MASKED);
+	return !(kvm_lapic_get_reg(apic, APIC_LVTT) & APIC_LVT_MASKED);
 }
 
-static inline int apic_lvt_vector(struct kvm_lapic *apic, int lvt_type)
+static inline int apic_lvtt_vector(struct kvm_lapic *apic)
 {
-	return kvm_lapic_get_reg(apic, lvt_type) & APIC_VECTOR_MASK;
+	return kvm_lapic_get_reg(apic, APIC_LVTT) & APIC_VECTOR_MASK;
 }
 
 static inline int apic_lvtt_oneshot(struct kvm_lapic *apic)
@@ -1475,10 +1475,9 @@ static void apic_update_lvtt(struct kvm_lapic *apic)
 static bool lapic_timer_int_injected(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
-	u32 reg = kvm_lapic_get_reg(apic, APIC_LVTT);
 
 	if (kvm_apic_hw_enabled(apic)) {
-		int vec = reg & APIC_VECTOR_MASK;
+		int vec = apic_lvtt_vector(apic);
 		void *bitmap = apic->regs + APIC_ISR;
 
 		if (vcpu->arch.apicv_active)
@@ -2278,7 +2277,7 @@ int apic_has_pending_timer(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (apic_enabled(apic) && apic_lvt_enabled(apic, APIC_LVTT))
+	if (apic_enabled(apic) && apic_lvtt_enabled(apic))
 		return atomic_read(&apic->lapic_timer.pending);
 
 	return 0;
-- 
2.19.1

