Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D47CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3292073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCMJA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:00:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43468 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbgCMJA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:00:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 628A81046C273E8B1C8A;
        Fri, 13 Mar 2020 17:00:23 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Mar 2020
 17:00:19 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <maz@kernel.org>
CC:     <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] KVM: arm: fix missing free_percpu_irq in kvm_timer_hyp_init()
Date:   Fri, 13 Mar 2020 17:03:09 +0800
Message-ID: <1584090189-20301-1-git-send-email-linmiaohe@huawei.com>
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

When host_ptimer_irq request irq resource failed, we forget to release the
host_vtimer_irq resource already requested. Fix this missing irq release
and other similar scenario.

Fixes: 9e01dc76be6a ("KVM: arm/arm64: arch_timer: Assign the phys timer on VHE systems")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 virt/kvm/arm/arch_timer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index e2bb5bd60227..fe958255ae2b 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -935,7 +935,7 @@ int kvm_timer_hyp_init(bool has_gic)
 					    kvm_get_running_vcpus());
 		if (err) {
 			kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
-			goto out_free_irq;
+			goto out_free_vtime_irq;
 		}
 
 		static_branch_enable(&has_gic_active_state);
@@ -960,7 +960,7 @@ int kvm_timer_hyp_init(bool has_gic)
 		if (err) {
 			kvm_err("kvm_arch_timer: can't request ptimer interrupt %d (%d)\n",
 				host_ptimer_irq, err);
-			return err;
+			goto out_free_vtime_irq;
 		}
 
 		if (has_gic) {
@@ -968,7 +968,7 @@ int kvm_timer_hyp_init(bool has_gic)
 						    kvm_get_running_vcpus());
 			if (err) {
 				kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
-				goto out_free_irq;
+				goto out_free_ptime_irq;
 			}
 		}
 
@@ -977,14 +977,17 @@ int kvm_timer_hyp_init(bool has_gic)
 		kvm_err("kvm_arch_timer: invalid physical timer IRQ: %d\n",
 			info->physical_irq);
 		err = -ENODEV;
-		goto out_free_irq;
+		goto out_free_vtime_irq;
 	}
 
 	cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
 			  "kvm/arm/timer:starting", kvm_timer_starting_cpu,
 			  kvm_timer_dying_cpu);
 	return 0;
-out_free_irq:
+
+out_free_ptime_irq:
+	free_percpu_irq(host_ptimer_irq, kvm_get_running_vcpus());
+out_free_vtime_irq:
 	free_percpu_irq(host_vtimer_irq, kvm_get_running_vcpus());
 	return err;
 }
-- 
2.19.1

