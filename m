Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E316FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3C12078A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRwZfxnk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vEUF9wx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHYXl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgHYXlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:41:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B55C061574;
        Tue, 25 Aug 2020 16:40:58 -0700 (PDT)
Date:   Tue, 25 Aug 2020 23:40:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAm2gwQBCMN34N1Ft2/JATCpbKr2DkyNkH4oZOWGKxA=;
        b=zRwZfxnkIzuNYnIwENUN7/KNrLBhfWbjBiAgHeY7/SUbFr1jYvQLD1TiQ8ol3dtp3yi2Zh
        mcqE+nR7OUc+y6+aGI7sB+ISavwOyzPJseOm5Mo6ZZbqMwrH0OygepGYWDGeRcAKamJkkF
        vGrYSTOppiP+0hOjOwnAkc/HzNL2V/Pm2/myZ0eQUICvS8ZN3FCiCaoRpBSISOKbOLibyU
        pNOf/iMkj1dP1O50J0+SgKItBOUdITT+hOwAeY3CQq4uDTX8j7lfr3msgEWFUw8T7B+/5o
        kCZsVnrDLQUaRGKbM6esny2mBaciA4NYidyk63YPV/SQMD/BIR2iNqHO4ERXMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAm2gwQBCMN34N1Ft2/JATCpbKr2DkyNkH4oZOWGKxA=;
        b=vEUF9wx6HV3ZTglhSntoJ+E4oSjle0awOQEWUgdIA5jY+Czz/885BwidU4KRWGew03GAOX
        k+fFVTjMRKkKx2AA==
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ti-sci-inta: Add support for INTA directly
 connecting to GIC
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806074826.24607-11-lokeshvutla@ti.com>
References: <20200806074826.24607-11-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <159839885589.389.14204317812329951821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     5c4b585d29102c7e6a6217112bbf1be774795cd7
Gitweb:        https://git.kernel.org/tip/5c4b585d29102c7e6a6217112bbf1be774795cd7
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 06 Aug 2020 13:18:23 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 Aug 2020 22:01:19 +01:00

irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC

Driver assumes that Interrupt parent to Interrupt Aggregator is always
Interrupt router. This is not true always and GIC can be a parent to
Interrupt Aggregator. Update the driver to detect the parent and request
the parent irqs accordingly.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200806074826.24607-11-lokeshvutla@ti.com
---
 drivers/irqchip/irq-ti-sci-inta.c | 87 +++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index fbfa1f4..d4e9760 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
@@ -131,6 +132,37 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 }
 
 /**
+ * ti_sci_inta_xlate_irq() - Translate hwirq to parent's hwirq.
+ * @inta:	IRQ domain corresponding to Interrupt Aggregator
+ * @irq:	Hardware irq corresponding to the above irq domain
+ *
+ * Return parent irq number if translation is available else -ENOENT.
+ */
+static int ti_sci_inta_xlate_irq(struct ti_sci_inta_irq_domain *inta,
+				 u16 vint_id)
+{
+	struct device_node *np = dev_of_node(&inta->pdev->dev);
+	u32 base, parent_base, size;
+	const __be32 *range;
+	int len;
+
+	range = of_get_property(np, "ti,interrupt-ranges", &len);
+	if (!range)
+		return vint_id;
+
+	for (len /= sizeof(*range); len >= 3; len -= 3) {
+		base = be32_to_cpu(*range++);
+		parent_base = be32_to_cpu(*range++);
+		size = be32_to_cpu(*range++);
+
+		if (base <= vint_id && vint_id < base + size)
+			return vint_id - base + parent_base;
+	}
+
+	return -ENOENT;
+}
+
+/**
  * ti_sci_inta_alloc_parent_irq() - Allocate parent irq to Interrupt aggregator
  * @domain:	IRQ domain corresponding to Interrupt Aggregator
  *
@@ -141,30 +173,52 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	struct ti_sci_inta_irq_domain *inta = domain->host_data;
 	struct ti_sci_inta_vint_desc *vint_desc;
 	struct irq_fwspec parent_fwspec;
+	struct device_node *parent_node;
 	unsigned int parent_virq;
-	u16 vint_id;
+	u16 vint_id, p_hwirq;
+	int ret;
 
 	vint_id = ti_sci_get_free_resource(inta->vint);
 	if (vint_id == TI_SCI_RESOURCE_NULL)
 		return ERR_PTR(-EINVAL);
 
+	p_hwirq = ti_sci_inta_xlate_irq(inta, vint_id);
+	if (p_hwirq < 0) {
+		ret = p_hwirq;
+		goto free_vint;
+	}
+
 	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
-	if (!vint_desc)
-		return ERR_PTR(-ENOMEM);
+	if (!vint_desc) {
+		ret = -ENOMEM;
+		goto free_vint;
+	}
 
 	vint_desc->domain = domain;
 	vint_desc->vint_id = vint_id;
 	INIT_LIST_HEAD(&vint_desc->list);
 
-	parent_fwspec.fwnode = of_node_to_fwnode(of_irq_find_parent(dev_of_node(&inta->pdev->dev)));
-	parent_fwspec.param_count = 2;
-	parent_fwspec.param[0] = inta->ti_sci_id;
-	parent_fwspec.param[1] = vint_desc->vint_id;
+	parent_node = of_irq_find_parent(dev_of_node(&inta->pdev->dev));
+	parent_fwspec.fwnode = of_node_to_fwnode(parent_node);
+
+	if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
+		/* Parent is GIC */
+		parent_fwspec.param_count = 3;
+		parent_fwspec.param[0] = 0;
+		parent_fwspec.param[1] = p_hwirq - 32;
+		parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+	} else {
+		/* Parent is Interrupt Router */
+		parent_fwspec.param_count = 1;
+		parent_fwspec.param[0] = p_hwirq;
+	}
 
 	parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
 	if (parent_virq == 0) {
-		kfree(vint_desc);
-		return ERR_PTR(-EINVAL);
+		dev_err(&inta->pdev->dev, "Parent IRQ allocation failed\n");
+		ret = -EINVAL;
+		goto free_vint_desc;
+
 	}
 	vint_desc->parent_virq = parent_virq;
 
@@ -173,6 +227,11 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 					 ti_sci_inta_irq_handler, vint_desc);
 
 	return vint_desc;
+free_vint_desc:
+	kfree(vint_desc);
+free_vint:
+	ti_sci_release_resource(inta->vint, vint_id);
+	return ERR_PTR(ret);
 }
 
 /**
@@ -555,15 +614,15 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev, inta->ti_sci_id,
-						 "ti,sci-rm-range-vint");
+	inta->vint = devm_ti_sci_get_resource(inta->sci, dev, inta->ti_sci_id,
+					      TI_SCI_RESASG_SUBTYPE_IA_VINT);
 	if (IS_ERR(inta->vint)) {
 		dev_err(dev, "VINT resource allocation failed\n");
 		return PTR_ERR(inta->vint);
 	}
 
-	inta->global_event = devm_ti_sci_get_of_resource(inta->sci, dev, inta->ti_sci_id,
-							 "ti,sci-rm-range-global-event");
+	inta->global_event = devm_ti_sci_get_resource(inta->sci, dev, inta->ti_sci_id,
+						      TI_SCI_RESASG_SUBTYPE_GLOBAL_EVENT_SEVT);
 	if (IS_ERR(inta->global_event)) {
 		dev_err(dev, "Global event resource allocation failed\n");
 		return PTR_ERR(inta->global_event);
@@ -594,6 +653,8 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&inta->vint_list);
 	mutex_init(&inta->vint_mutex);
 
+	dev_info(dev, "Interrupt Aggregator domain %d created\n", pdev->id);
+
 	return 0;
 }
 
