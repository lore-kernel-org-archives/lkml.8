Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37673C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179E5221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgDQJ5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgDQJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:56:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC527C061A0F;
        Fri, 17 Apr 2020 02:56:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPNjo-0005eN-HR; Fri, 17 Apr 2020 11:56:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 32FF11C0072;
        Fri, 17 Apr 2020 11:56:44 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:56:43 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/meson-gpio: Fix HARDIRQ-safe ->
 HARDIRQ-unsafe lock order
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158711740384.28353.14834476816148421881.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     0a66d6f90cf7d704c6a0f663f7058099eb8c97b0
Gitweb:        https://git.kernel.org/tip/0a66d6f90cf7d704c6a0f663f7058099eb8c97b0
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 06 Apr 2020 08:52:07 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 17 Apr 2020 08:59:29 +01:00

irqchip/meson-gpio: Fix HARDIRQ-safe -> HARDIRQ-unsafe lock order

Running a lockedp-enabled kernel on a vim3l board (Amlogic SM1)
leads to the following splat:

[   13.557138] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[   13.587485] ip/456 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   13.625922] ffff000059908cf0 (&irq_desc_lock_class){-.-.}-{2:2}, at: __setup_irq+0xf8/0x8d8
[   13.632273] which would create a new lock dependency:
[   13.637272]  (&irq_desc_lock_class){-.-.}-{2:2} -> (&ctl->lock){+.+.}-{2:2}
[   13.644209]
[   13.644209] but this new dependency connects a HARDIRQ-irq-safe lock:
[   13.654122]  (&irq_desc_lock_class){-.-.}-{2:2}
[   13.654125]
[   13.654125] ... which became HARDIRQ-irq-safe at:
[   13.664759]   lock_acquire+0xec/0x368
[   13.666926]   _raw_spin_lock+0x60/0x88
[   13.669979]   handle_fasteoi_irq+0x30/0x178
[   13.674082]   generic_handle_irq+0x38/0x50
[   13.678098]   __handle_domain_irq+0x6c/0xc8
[   13.682209]   gic_handle_irq+0x5c/0xb0
[   13.685872]   el1_irq+0xd0/0x180
[   13.689010]   arch_cpu_idle+0x40/0x220
[   13.692732]   default_idle_call+0x54/0x60
[   13.696677]   do_idle+0x23c/0x2e8
[   13.699903]   cpu_startup_entry+0x30/0x50
[   13.703852]   rest_init+0x1e0/0x2b4
[   13.707301]   arch_call_rest_init+0x18/0x24
[   13.711449]   start_kernel+0x4ec/0x51c
[   13.715167]
[   13.715167] to a HARDIRQ-irq-unsafe lock:
[   13.722426]  (&ctl->lock){+.+.}-{2:2}
[   13.722430]
[   13.722430] ... which became HARDIRQ-irq-unsafe at:
[   13.732319] ...
[   13.732324]   lock_acquire+0xec/0x368
[   13.735985]   _raw_spin_lock+0x60/0x88
[   13.739452]   meson_gpio_irq_domain_alloc+0xcc/0x290
[   13.744392]   irq_domain_alloc_irqs_hierarchy+0x24/0x60
[   13.749586]   __irq_domain_alloc_irqs+0x160/0x2f0
[   13.754254]   irq_create_fwspec_mapping+0x118/0x320
[   13.759073]   irq_create_of_mapping+0x78/0xa0
[   13.763360]   of_irq_get+0x6c/0x80
[   13.766701]   of_mdiobus_register_phy+0x10c/0x238 [of_mdio]
[   13.772227]   of_mdiobus_register+0x158/0x380 [of_mdio]
[   13.777388]   mdio_mux_init+0x180/0x2e8 [mdio_mux]
[   13.782128]   g12a_mdio_mux_probe+0x290/0x398 [mdio_mux_meson_g12a]
[   13.788349]   platform_drv_probe+0x5c/0xb0
[   13.792379]   really_probe+0xe4/0x448
[   13.795979]   driver_probe_device+0xe8/0x140
[   13.800189]   __device_attach_driver+0x94/0x120
[   13.804639]   bus_for_each_drv+0x84/0xd8
[   13.808474]   __device_attach+0xe4/0x168
[   13.812361]   device_initial_probe+0x1c/0x28
[   13.816592]   bus_probe_device+0xa4/0xb0
[   13.820430]   deferred_probe_work_func+0xa8/0x100
[   13.825064]   process_one_work+0x264/0x688
[   13.829088]   worker_thread+0x4c/0x458
[   13.832768]   kthread+0x154/0x158
[   13.836018]   ret_from_fork+0x10/0x18
[   13.839612]
[   13.839612] other info that might help us debug this:
[   13.839612]
[   13.850354]  Possible interrupt unsafe locking scenario:
[   13.850354]
[   13.855720]        CPU0                    CPU1
[   13.858774]        ----                    ----
[   13.863242]   lock(&ctl->lock);
[   13.866330]                                local_irq_disable();
[   13.872233]                                lock(&irq_desc_lock_class);
[   13.878705]                                lock(&ctl->lock);
[   13.884297]   <Interrupt>
[   13.886857]     lock(&irq_desc_lock_class);
[   13.891014]
[   13.891014]  *** DEADLOCK ***

The issue can occur when CPU1 is doing something like irq_set_type()
and CPU0 performing an interrupt allocation, for example. Taking
an interrupt (like the one being reconfigured) would lead to a deadlock.

A solution to this is:

- Reorder the locking so that meson_gpio_irq_update_bits takes the lock
  itself at all times, instead of relying on the caller to lock or not,
  hence making the RMW sequence atomic,

- Rework the critical section in meson_gpio_irq_request_channel to only
  cover the allocation itself, and let the gpio_irq_sel_pin callback
  deal with its own locking if required,

- Take the private spin-lock with interrupts disabled at all times

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-meson-gpio.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index ccc7f82..bc7aebc 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -144,12 +144,17 @@ struct meson_gpio_irq_controller {
 static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
 				       unsigned int reg, u32 mask, u32 val)
 {
+	unsigned long flags;
 	u32 tmp;
 
+	spin_lock_irqsave(&ctl->lock, flags);
+
 	tmp = readl_relaxed(ctl->base + reg);
 	tmp &= ~mask;
 	tmp |= val;
 	writel_relaxed(tmp, ctl->base + reg);
+
+	spin_unlock_irqrestore(&ctl->lock, flags);
 }
 
 static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl)
@@ -196,14 +201,15 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 			       unsigned long  hwirq,
 			       u32 **channel_hwirq)
 {
+	unsigned long flags;
 	unsigned int idx;
 
-	spin_lock(&ctl->lock);
+	spin_lock_irqsave(&ctl->lock, flags);
 
 	/* Find a free channel */
 	idx = find_first_zero_bit(ctl->channel_map, NUM_CHANNEL);
 	if (idx >= NUM_CHANNEL) {
-		spin_unlock(&ctl->lock);
+		spin_unlock_irqrestore(&ctl->lock, flags);
 		pr_err("No channel available\n");
 		return -ENOSPC;
 	}
@@ -211,6 +217,8 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	/* Mark the channel as used */
 	set_bit(idx, ctl->channel_map);
 
+	spin_unlock_irqrestore(&ctl->lock, flags);
+
 	/*
 	 * Setup the mux of the channel to route the signal of the pad
 	 * to the appropriate input of the GIC
@@ -225,8 +233,6 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	 */
 	*channel_hwirq = &(ctl->channel_irqs[idx]);
 
-	spin_unlock(&ctl->lock);
-
 	pr_debug("hwirq %lu assigned to channel %d - irq %u\n",
 		 hwirq, idx, **channel_hwirq);
 
@@ -287,13 +293,9 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 			val |= REG_EDGE_POL_LOW(params, idx);
 	}
 
-	spin_lock(&ctl->lock);
-
 	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
 				   REG_EDGE_POL_MASK(params, idx), val);
 
-	spin_unlock(&ctl->lock);
-
 	return 0;
 }
 
