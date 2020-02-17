Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161DFC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E491F227BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgBQPBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:01:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729315AbgBQPBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:01:07 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A2B23B6A8D864C6AB5DD;
        Mon, 17 Feb 2020 23:01:01 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 23:00:53 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v2] KVM: VMX: Add 'else' to split mutually exclusive case
Date:   Mon, 17 Feb 2020 23:02:30 +0800
Message-ID: <1581951750-17854-1-git-send-email-linmiaohe@huawei.com>
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

Each if branch in handle_external_interrupt_irqoff() is mutually
exclusive. Add 'else' to make it clear and also avoid some unnecessary
check.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v1->v2:
add braces to all if branches
---
 arch/x86/kvm/vmx/vmx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9a6664886f2e..a13368b2719c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6176,15 +6176,13 @@ static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
 	vmx->exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
 
 	/* if exit due to PF check for async PF */
-	if (is_page_fault(vmx->exit_intr_info))
+	if (is_page_fault(vmx->exit_intr_info)) {
 		vmx->vcpu.arch.apf.host_apf_reason = kvm_read_and_reset_pf_reason();
-
 	/* Handle machine checks before interrupts are enabled */
-	if (is_machine_check(vmx->exit_intr_info))
+	} else if (is_machine_check(vmx->exit_intr_info)) {
 		kvm_machine_check();
-
 	/* We need to handle NMIs before interrupts are enabled */
-	if (is_nmi(vmx->exit_intr_info)) {
+	} else if (is_nmi(vmx->exit_intr_info)) {
 		kvm_before_interrupt(&vmx->vcpu);
 		asm("int $2");
 		kvm_after_interrupt(&vmx->vcpu);
-- 
2.19.1

