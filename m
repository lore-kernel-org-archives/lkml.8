Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2401C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9C622522
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583866174;
	bh=mVigAUPV7N3JpqkRJd3O7JGX44qd+U5SoxrkIaSZrZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KldL8InoA84Y7ZHDFVmWvBFBMjlWo4KD2P7mIYiyO47nmrq0MgTP+uW0rdf67MlrK
	 CovUYw/C2oVbk1eKgpimhsKGjKug2E2VnZfFTt76/4Hvi09S3pLolkgQhQkG9jlgZ7
	 ge+8kdOSCjeLpqJiSMEwyZFRYCTUx39IReqrCeMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCJStd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbgCJStc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:49:32 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD57222D9;
        Tue, 10 Mar 2020 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583866171;
        bh=mVigAUPV7N3JpqkRJd3O7JGX44qd+U5SoxrkIaSZrZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYkXf90v0xqddaFNboAyMOcZL1O2pkLvMBmCe//lAbP4ncRixcswykAioOcB8OmKr
         MDXFgLqyzAVWR+SY9KQvupDfhwsvwIIM+a3qqrHT3Y5WgxEAxbV/i9wgKz5x5ZkIrh
         xrrYdotus8O4UDUJDPG+suvDN/gcO3AWjHeJFzIU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBjwY-00Bi6k-2w; Tue, 10 Mar 2020 18:49:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@arm.linux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 4/4] irqchip/gic-v4: Provide irq_retrigger to avoid circular locking dependency
Date:   Tue, 10 Mar 2020 18:49:21 +0000
Message-Id: <20200310184921.23552-5-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310184921.23552-1-maz@kernel.org>
References: <20200310184921.23552-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, linux@arm.linux.org.uk, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 83b1186ffcad..fd0758a29b5f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3675,12 +3675,18 @@ static int its_vpe_set_irqchip_state(struct irq_data *d,
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
-- 
2.20.1

