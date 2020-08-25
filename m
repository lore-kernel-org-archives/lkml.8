Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4963C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7A62075E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGjyw3JD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubmg2BbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHYXl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:41:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHYXk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:40:59 -0400
Date:   Tue, 25 Aug 2020 23:40:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/wgT7sWI+kblw/TJppQBQS/eyUclEkSqOfP55bJVqJs=;
        b=cGjyw3JDDnIS+xjJ3uJaxNsSD8Ojg9pDVdz40YcMPW3qbDjI9c1aX/knlDSEITeB3UStps
        MdvFm0Qz9PAQ7KV8BTGAV52Qhsy3M4gE/C9a9QTZFEQFbXfvEhL3y47SxbC82t1qd28tJ8
        852pbWng5jDTVC+/GPSXBh6MaayKQj6cRaMxJZyaFmU+kdiIxfE498ByLJ1JCTTyaJWn5W
        Rg0oyLplZGZzVWIi1iUZqNWbKb9fg4q4w+cU1T7CdYsHI27q5gJyr+4r97pjCKM2boN1fs
        JzyQ/Vp1CI1Ys3XcTEaN0EQM/j3BNSV8/PIozaMqBxhlVf2S+aU0G0lfdi1DeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/wgT7sWI+kblw/TJppQBQS/eyUclEkSqOfP55bJVqJs=;
        b=ubmg2BbGzoBNVZeNVxBQz+qZF8pW3xgl4svggE8lNbRPWz/VacO19V7YdVBVVcPjJCu/Hq
        Ssf0tBQlnpobqtCA==
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ti-sci-inta: Do not store TISCI device id
 in platform device id field
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806074826.24607-10-lokeshvutla@ti.com>
References: <20200806074826.24607-10-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <159839885665.389.10495380781960966811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     7206f3149b8198c65a0ca8c01bfa1d8ace27bf91
Gitweb:        https://git.kernel.org/tip/7206f3149b8198c65a0ca8c01bfa1d8ace27bf91
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 06 Aug 2020 13:18:22 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 Aug 2020 22:01:19 +01:00

irqchip/ti-sci-inta: Do not store TISCI device id in platform device id field

Even though DT doesn't make active use of id field in platform_device, we cannot
hijack it to store TISCI device id. So create a field in struct ti_sci_inta
for storing TISCI id and drop usage of id field in platform_device.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200806074826.24607-10-lokeshvutla@ti.com
---
 drivers/irqchip/irq-ti-sci-inta.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index b7cc5d6..fbfa1f4 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -83,6 +83,7 @@ struct ti_sci_inta_vint_desc {
  * @vint_mutex:		Mutex to protect vint_list
  * @base:		Base address of the memory mapped IO registers
  * @pdev:		Pointer to platform device.
+ * @ti_sci_id:		TI-SCI device identifier
  */
 struct ti_sci_inta_irq_domain {
 	const struct ti_sci_handle *sci;
@@ -93,6 +94,7 @@ struct ti_sci_inta_irq_domain {
 	struct mutex vint_mutex;
 	void __iomem *base;
 	struct platform_device *pdev;
+	u32 ti_sci_id;
 };
 
 #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
@@ -156,7 +158,7 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 
 	parent_fwspec.fwnode = of_node_to_fwnode(of_irq_find_parent(dev_of_node(&inta->pdev->dev)));
 	parent_fwspec.param_count = 2;
-	parent_fwspec.param[0] = inta->pdev->id;
+	parent_fwspec.param[0] = inta->ti_sci_id;
 	parent_fwspec.param[1] = vint_desc->vint_id;
 
 	parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
@@ -202,7 +204,7 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_event(struct ti_sci_inta
 
 	err = inta->sci->ops.rm_irq_ops.set_event_map(inta->sci,
 						      dev_id, dev_index,
-						      inta->pdev->id,
+						      inta->ti_sci_id,
 						      vint_desc->vint_id,
 						      event_desc->global_event,
 						      free_bit);
@@ -299,7 +301,7 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
 	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
 						 HWIRQ_TO_DEVID(hwirq),
 						 HWIRQ_TO_IRQID(hwirq),
-						 inta->pdev->id,
+						 inta->ti_sci_id,
 						 vint_desc->vint_id,
 						 event_desc->global_event,
 						 event_desc->vint_bit);
@@ -547,21 +549,21 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &pdev->id);
+	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &inta->ti_sci_id);
 	if (ret) {
 		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
 		return -EINVAL;
 	}
 
-	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev, pdev->id,
+	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev, inta->ti_sci_id,
 						 "ti,sci-rm-range-vint");
 	if (IS_ERR(inta->vint)) {
 		dev_err(dev, "VINT resource allocation failed\n");
 		return PTR_ERR(inta->vint);
 	}
 
-	inta->global_event = devm_ti_sci_get_of_resource(inta->sci, dev, pdev->id,
-						"ti,sci-rm-range-global-event");
+	inta->global_event = devm_ti_sci_get_of_resource(inta->sci, dev, inta->ti_sci_id,
+							 "ti,sci-rm-range-global-event");
 	if (IS_ERR(inta->global_event)) {
 		dev_err(dev, "Global event resource allocation failed\n");
 		return PTR_ERR(inta->global_event);
