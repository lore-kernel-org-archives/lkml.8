Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356D7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABB7206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1BrCxU6N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nnvWU/rN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXUop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgGXUop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:44:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEC2C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:44:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595623481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOMANSmPa59euwywHw4b4bqf0Bzh61n1kQhVI7hDeSA=;
        b=1BrCxU6NWMdI4yfFwZA9FTs3goe4aWu5PJssMkGJYJT2wtlYA32ziE7AGWc+XVIT3pDpMg
        WX1lYRr/FXWn2cdQ6Qy/F/Mwkd38BKmaAxYyvuJGuzddjQhCTP5F5EaCDL/E8K9lEbUM2n
        ppf/ankD5bliy6nXFHy2zfrL2r3MslF0jEbhE/4+LnrIn4hCDapw4yFX4DR/Bj9dNL5Gsh
        S+Csc9r9kqEiyH0/qOcqt/ZUEF3wuH4NnrwcsLPiX0YZfI88ksZ/bRdXkxShRfmCmJQPfn
        LUN3vOhTKzKgS1PxmvR0OOHfyznM4q83bHUuhmHVa604OFCAAbJP+mi8A8hDig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595623481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOMANSmPa59euwywHw4b4bqf0Bzh61n1kQhVI7hDeSA=;
        b=nnvWU/rNA6MxWmxauQsnZAB5vvMR6mpsb4pdMy0Oc/fldCT3nwN2h8rqKDtE7IaQZ/7pz1
        XKvb56pHs3qZ/vAg==
To:     John Keeping <john@metanate.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ben Herrenschmidt <benh@amazon.com>,
        Ali Saidi <alisaidi@amazon.com>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] genirq/affinity: Handle affinity setting on inactive interrupts correctly
In-Reply-To: <87h7twu1cp.fsf@nanos.tec.linutronix.de>
References: <87k0z2s2q3.fsf@nanos.tec.linutronix.de> <877dv2rv25.fsf@nanos.tec.linutronix.de> <20200724182422.27ddced6.john@metanate.com> <87h7twu1cp.fsf@nanos.tec.linutronix.de>
Date:   Fri, 24 Jul 2020 22:44:41 +0200
Message-ID: <87blk4tzgm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

Thomas Gleixner <tglx@linutronix.de> writes:
> I have some ideas for a trivial generic way to solve this without
> undoing the commit in question and without going through all the irq
> chip drivers. So far everything I came up with is butt ugly. Maybe Marc
> has some brilliant idea.
>
> Sorry for the wreckage and thanks for the excellent problem
> description. I'll come back to you in the next days.

couldn't give up :)

So after staring in too many drivers, I resorted to make this mode
opt-in and mark the interrupts accordingly for the two drivers which are
known to want this. Not that I love it, but it's the least dangerous
option. Completely untested patch below.

Thanks,

        tglx
---
 arch/x86/kernel/apic/vector.c    |    4 ++++
 drivers/irqchip/irq-gic-v3-its.c |    5 ++++-
 include/linux/irq.h              |   13 +++++++++++++
 kernel/irq/manage.c              |    6 +++++-
 4 files changed, 26 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -560,6 +560,10 @@ static int x86_vector_alloc_irqs(struct
 		 * as that can corrupt the affinity move state.
 		 */
 		irqd_set_handle_enforce_irqctx(irqd);
+
+		/* Don't invoke affinity setter on deactivated interrupts */
+		irqd_set_affinity_on_activate(irqd);
+
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3523,6 +3523,7 @@ static int its_irq_domain_alloc(struct i
 	msi_alloc_info_t *info = args;
 	struct its_device *its_dev = info->scratchpad[0].ptr;
 	struct its_node *its = its_dev->its;
+	struct irq_data *irqd;
 	irq_hw_number_t hwirq;
 	int err;
 	int i;
@@ -3542,7 +3543,9 @@ static int its_irq_domain_alloc(struct i
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i,
 					      hwirq + i, &its_irq_chip, its_dev);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq + i)));
+		irqd = irq_get_irq_data(virq + i);
+		irqd_set_single_target(irqd);
+		irqd_set_affinity_on_activate(irqd);
 		pr_debug("ID:%d pID:%d vID:%d\n",
 			 (int)(hwirq + i - its_dev->event_map.lpi_base),
 			 (int)(hwirq + i), virq + i);
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -213,6 +213,8 @@ struct irq_data {
  *				  required
  * IRQD_HANDLE_ENFORCE_IRQCTX	- Enforce that handle_irq_*() is only invoked
  *				  from actual interrupt context.
+ * IRQD_AFFINITY_ON_ACTIVATE	- Affinity is set on activation. Don't call
+ *				  irq_chip::irq_set_affinity() when deactivated.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -237,6 +239,7 @@ enum {
 	IRQD_CAN_RESERVE		= (1 << 26),
 	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
 	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
+	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -421,6 +424,16 @@ static inline bool irqd_msi_nomask_quirk
 	return __irqd_to_state(d) & IRQD_MSI_NOMASK_QUIRK;
 }
 
+static inline void irqd_set_affinity_on_activate(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_AFFINITY_ON_ACTIVATE;
+}
+
+static inline bool irqd_affinity_on_activate(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_AFFINITY_ON_ACTIVATE;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -320,12 +320,16 @@ static bool irq_set_affinity_deactivated
 	struct irq_desc *desc = irq_data_to_desc(data);
 
 	/*
+	 * Handle irq chips which can handle affinity only in activated
+	 * state correctly
+	 *
 	 * If the interrupt is not yet activated, just store the affinity
 	 * mask and do not call the chip driver at all. On activation the
 	 * driver has to make sure anyway that the interrupt is in a
 	 * useable state so startup works.
 	 */
-	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) || irqd_is_activated(data))
+	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) ||
+	    irqd_is_activated(data) || !irqd_affinity_on_activate(data))
 		return false;
 
 	cpumask_copy(desc->irq_common_data.affinity, mask);


