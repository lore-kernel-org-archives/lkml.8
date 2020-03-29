Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D6C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F6220781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgC2U12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgC2U00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVj-0001SE-FW; Sun, 29 Mar 2020 22:26:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A38E11C04D7;
        Sun, 29 Mar 2020 22:26:18 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:18 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4: Provide irq_retrigger to avoid
 circular locking dependency
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200310184921.23552-5-maz@kernel.org>
References: <20200310184921.23552-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551357816.28353.2761442309865267997.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7809f7011c3bce650e502a98afeb05961470d865
Gitweb:        https://git.kernel.org/tip/7809f7011c3bce650e502a98afeb05961470d865
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 10 Mar 2020 18:49:21 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 16 Mar 2020 15:48:55 

irqchip/gic-v4: Provide irq_retrigger to avoid circular locking dependency

On a very heavily loaded D05 with GICv4, I managed to trigger the
following lockdep splat:

[ 6022.598864] ======================================================
[ 6022.605031] WARNING: possible circular locking dependency detected
[ 6022.611200] 5.6.0-rc4-00026-geee7c7b0f498 #680 Tainted: G            E
[ 6022.618061] ------------------------------------------------------
[ 6022.624227] qemu-system-aar/7569 is trying to acquire lock:
[ 6022.629789] ffff042f97606808 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x54/0x7a0
[ 6022.637102]
[ 6022.637102] but task is already holding lock:
[ 6022.642921] ffff002fae424cf0 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x5c/0x98
[ 6022.651350]
[ 6022.651350] which lock already depends on the new lock.
[ 6022.651350]
[ 6022.659512]
[ 6022.659512] the existing dependency chain (in reverse order) is:
[ 6022.666980]
[ 6022.666980] -> #2 (&irq_desc_lock_class){-.-.}:
[ 6022.672983]        _raw_spin_lock_irqsave+0x50/0x78
[ 6022.677848]        __irq_get_desc_lock+0x5c/0x98
[ 6022.682453]        irq_set_vcpu_affinity+0x40/0xc0
[ 6022.687236]        its_make_vpe_non_resident+0x6c/0xb8
[ 6022.692364]        vgic_v4_put+0x54/0x70
[ 6022.696273]        vgic_v3_put+0x20/0xd8
[ 6022.700183]        kvm_vgic_put+0x30/0x48
[ 6022.704182]        kvm_arch_vcpu_put+0x34/0x50
[ 6022.708614]        kvm_sched_out+0x34/0x50
[ 6022.712700]        __schedule+0x4bc/0x7f8
[ 6022.716697]        schedule+0x50/0xd8
[ 6022.720347]        kvm_arch_vcpu_ioctl_run+0x5f0/0x978
[ 6022.725473]        kvm_vcpu_ioctl+0x3d4/0x8f8
[ 6022.729820]        ksys_ioctl+0x90/0xd0
[ 6022.733642]        __arm64_sys_ioctl+0x24/0x30
[ 6022.738074]        el0_svc_common.constprop.3+0xa8/0x1e8
[ 6022.743373]        do_el0_svc+0x28/0x88
[ 6022.747198]        el0_svc+0x14/0x40
[ 6022.750761]        el0_sync_handler+0x124/0x2b8
[ 6022.755278]        el0_sync+0x140/0x180
[ 6022.759100]
[ 6022.759100] -> #1 (&rq->lock){-.-.}:
[ 6022.764143]        _raw_spin_lock+0x38/0x50
[ 6022.768314]        task_fork_fair+0x40/0x128
[ 6022.772572]        sched_fork+0xe0/0x210
[ 6022.776484]        copy_process+0x8c4/0x18d8
[ 6022.780742]        _do_fork+0x88/0x6d8
[ 6022.784478]        kernel_thread+0x64/0x88
[ 6022.788563]        rest_init+0x30/0x270
[ 6022.792390]        arch_call_rest_init+0x14/0x1c
[ 6022.796995]        start_kernel+0x498/0x4c4
[ 6022.801164]
[ 6022.801164] -> #0 (&p->pi_lock){-.-.}:
[ 6022.806382]        __lock_acquire+0xdd8/0x15c8
[ 6022.810813]        lock_acquire+0xd0/0x218
[ 6022.814896]        _raw_spin_lock_irqsave+0x50/0x78
[ 6022.819761]        try_to_wake_up+0x54/0x7a0
[ 6022.824018]        wake_up_process+0x1c/0x28
[ 6022.828276]        wakeup_softirqd+0x38/0x40
[ 6022.832533]        __tasklet_schedule_common+0xc4/0xf0
[ 6022.837658]        __tasklet_schedule+0x24/0x30
[ 6022.842176]        check_irq_resend+0xc8/0x158
[ 6022.846609]        irq_startup+0x74/0x128
[ 6022.850606]        __enable_irq+0x6c/0x78
[ 6022.854602]        enable_irq+0x54/0xa0
[ 6022.858431]        its_make_vpe_non_resident+0xa4/0xb8
[ 6022.863557]        vgic_v4_put+0x54/0x70
[ 6022.867469]        kvm_arch_vcpu_blocking+0x28/0x38
[ 6022.872336]        kvm_vcpu_block+0x48/0x490
[ 6022.876594]        kvm_handle_wfx+0x18c/0x310
[ 6022.880938]        handle_exit+0x138/0x198
[ 6022.885022]        kvm_arch_vcpu_ioctl_run+0x4d4/0x978
[ 6022.890148]        kvm_vcpu_ioctl+0x3d4/0x8f8
[ 6022.894494]        ksys_ioctl+0x90/0xd0
[ 6022.898317]        __arm64_sys_ioctl+0x24/0x30
[ 6022.902748]        el0_svc_common.constprop.3+0xa8/0x1e8
[ 6022.908046]        do_el0_svc+0x28/0x88
[ 6022.911871]        el0_svc+0x14/0x40
[ 6022.915434]        el0_sync_handler+0x124/0x2b8
[ 6022.919951]        el0_sync+0x140/0x180
[ 6022.923773]
[ 6022.923773] other info that might help us debug this:
[ 6022.923773]
[ 6022.931762] Chain exists of:
[ 6022.931762]   &p->pi_lock --> &rq->lock --> &irq_desc_lock_class
[ 6022.931762]
[ 6022.942101]  Possible unsafe locking scenario:
[ 6022.942101]
[ 6022.948007]        CPU0                    CPU1
[ 6022.952523]        ----                    ----
[ 6022.957039]   lock(&irq_desc_lock_class);
[ 6022.961036]                                lock(&rq->lock);
[ 6022.966595]                                lock(&irq_desc_lock_class);
[ 6022.973109]   lock(&p->pi_lock);
[ 6022.976324]
[ 6022.976324]  *** DEADLOCK ***

This is happening because we have a pending doorbell that requires
retrigger. As SW retriggering is done in a tasklet, we trigger the
circular dependency above.

The easy cop-out is to provide a retrigger callback that doesn't
require acquiring any extra lock.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200310184921.23552-5-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e207fbf..bb80285 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3707,12 +3707,18 @@ static int its_vpe_set_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int its_vpe_retrigger(struct irq_data *d)
+{
+	return !its_vpe_set_irqchip_state(d, IRQCHIP_STATE_PENDING, true);
+}
+
 static struct irq_chip its_vpe_irq_chip = {
 	.name			= "GICv4-vpe",
 	.irq_mask		= its_vpe_mask_irq,
 	.irq_unmask		= its_vpe_unmask_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_vpe_set_affinity,
+	.irq_retrigger		= its_vpe_retrigger,
 	.irq_set_irqchip_state	= its_vpe_set_irqchip_state,
 	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
 };
