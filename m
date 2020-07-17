Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D297CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A797F20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQ5m7Vc7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A+TLcROV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgGQNOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgGQNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:14:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70686C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:14:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594991669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9uDLabn6i6L/ERtUaroeRq4hoxdB4wMksislAitI2VU=;
        b=yQ5m7Vc77oPRg/wbXxg0i2cXHrcLMICltUjTrbYD2uCAqaf6TKq4KowYzyIglhBBowA++p
        +rOg3HeKYRHgpy2ufM1ppoDB8a4DHhFQB6gzh06HcPFm2cDX7Ttf5mpu93KyIUXkadGLfg
        wCkkOOUHNoWpabi50T6UmAnDv7+sA7oGXZCTzavCK5I48Uhd67KbIEKSoQYew7xx3CXsNj
        ng/Rt896cfs2zWR0/dJA6yRQMa9tzIQLR0OET0GYxZmuaVnFj04ERbtER9/YUYElHGFpgT
        LWZRSAPbUDw84kR5QT0kOOobr0MvJSDasZi0tIrYl6FAJnZl/2rBNsF1LHxcpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594991669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9uDLabn6i6L/ERtUaroeRq4hoxdB4wMksislAitI2VU=;
        b=A+TLcROV5F65zEmzU7q9Q9TZ+FgXAByJtGuXh0Gt0Qw2h7mgd/VU0iN6JA3PTRPZbUQ1Pu
        FoweWT/awhuv3YDw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ben Herrenschmidt <benh@amazon.com>,
        Ali Saidi <aliaidi@amazon.com>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] genirq/affinity: Handle affinity setting on inactive interrupts correctly
Date:   Fri, 17 Jul 2020 15:14:28 +0200
Message-ID: <87k0z2s2q3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting interrupt affinity on inactive interrupts is inconsistent when
hierarchical irq domains are enabled. The core code should just store the
affinity and not call into the irq chip driver for inactive interrupts
because the chip drivers may not be in a state to handle such requests.

X86 has a hacky workaround for that but all other irq chips have not which
causes problems e.g. on GIC V3 ITS.

Instead of adding more ugly hacks all over the place, solve the problem in
the core code. If the affinity is set on an inactive interrupt then:

    - Store it in the irq descriptors affinity mask
    - Update the effective affinity to reflect that so user space has
      a consistent view
    - Don't call into the irq chip driver

This is the core equivalent of the X86 workaround and works correctly
because the affinity setting is established in the irq chip when the
interrupt is activated later on.

Note, that this is only effective when hierarchical irq domains are enabled
by the architecture. Doing it unconditionally would break legacy irq chip
implementations.

For hierarchial irq domains this works correctly as none of the drivers can
have a dependency on affinity setting in inactive state by design.

Remove the X86 workaround as it is not longer required.

Fixes: 02edee152d6e ("x86/apic/vector: Ignore set_affinity call for inactive interrupts")
Reported-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200529015501.15771-1-alisaidi@amazon.com
---
---
 arch/x86/kernel/apic/vector.c |   22 +++++-----------------
 kernel/irq/manage.c           |   37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -446,12 +446,10 @@ static int x86_vector_activate(struct ir
 	trace_vector_activate(irqd->irq, apicd->is_managed,
 			      apicd->can_reserve, reserve);
 
-	/* Nothing to do for fixed assigned vectors */
-	if (!apicd->can_reserve && !apicd->is_managed)
-		return 0;
-
 	raw_spin_lock_irqsave(&vector_lock, flags);
-	if (reserve || irqd_is_managed_and_shutdown(irqd))
+	if (!apicd->can_reserve && !apicd->is_managed)
+		assign_irq_vector_any_locked(irqd);
+	else if (reserve || irqd_is_managed_and_shutdown(irqd))
 		vector_assign_managed_shutdown(irqd);
 	else if (apicd->is_managed)
 		ret = activate_managed(irqd);
@@ -775,20 +773,10 @@ void lapic_offline(void)
 static int apic_set_affinity(struct irq_data *irqd,
 			     const struct cpumask *dest, bool force)
 {
-	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	int err;
 
-	/*
-	 * Core code can call here for inactive interrupts. For inactive
-	 * interrupts which use managed or reservation mode there is no
-	 * point in going through the vector assignment right now as the
-	 * activation will assign a vector which fits the destination
-	 * cpumask. Let the core code store the destination mask and be
-	 * done with it.
-	 */
-	if (!irqd_is_activated(irqd) &&
-	    (apicd->is_managed || apicd->can_reserve))
-		return IRQ_SET_MASK_OK;
+	if (WARN_ON_ONCE(!irqd_is_activated(irqd)))
+		return -EIO;
 
 	raw_spin_lock(&vector_lock);
 	cpumask_and(vector_searchmask, dest, cpu_online_mask);
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -195,9 +195,9 @@ void irq_set_thread_affinity(struct irq_
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
 }
 
+#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 static void irq_validate_effective_affinity(struct irq_data *data)
 {
-#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	const struct cpumask *m = irq_data_get_effective_affinity_mask(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 
@@ -205,9 +205,19 @@ static void irq_validate_effective_affin
 		return;
 	pr_warn_once("irq_chip %s did not update eff. affinity mask of irq %u\n",
 		     chip->name, data->irq);
-#endif
 }
 
+static inline void irq_init_effective_affinity(struct irq_data *data,
+					       const struct cpumask *mask)
+{
+	cpumask_copy(irq_data_get_effective_affinity_mask(data), mask);
+}
+#else
+static inline void irq_validate_effective_affinity(struct irq_data *data) { }
+static inline boot irq_init_effective_affinity(struct irq_data *data,
+					       const struct cpumask *mask) { }
+#endif
+
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			bool force)
 {
@@ -304,6 +314,26 @@ static int irq_try_set_affinity(struct i
 	return ret;
 }
 
+static bool irq_set_affinity_deactivated(struct irq_data *data,
+					 const struct cpumask *mask, bool force)
+{
+	struct irq_desc *desc = irq_data_to_desc(data);
+
+	/*
+	 * If the interrupt is not yet activated, just store the affinity
+	 * mask and do not call the chip driver at all. On activation the
+	 * driver has to make sure anyway that the interrupt is in a
+	 * useable state so startup works.
+	 */
+	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) || irqd_is_activated(data))
+		return false;
+
+	cpumask_copy(desc->irq_common_data.affinity, mask);
+	irq_init_effective_affinity(data, mask);
+	irqd_set(data, IRQD_AFFINITY_SET);
+	return true;
+}
+
 int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 			    bool force)
 {
@@ -314,6 +344,9 @@ int irq_set_affinity_locked(struct irq_d
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
+	if (irq_set_affinity_deactivated(data, mask, force))
+		return 0;
+
 	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
 		ret = irq_try_set_affinity(data, mask, force);
 	} else {
