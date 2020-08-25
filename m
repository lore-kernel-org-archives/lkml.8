Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC82C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D16520767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmEmNCJp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cVuANNXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHYXlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:41:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHYXlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:41:03 -0400
Date:   Tue, 25 Aug 2020 23:41:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1D60flZDHTBd1k3w4UXmzsFR+k0Cqj8UhH0pbB1+p8=;
        b=pmEmNCJpKHnWRwVdpAQUOSw5yx+KESTNnIJ4j5zYBChKQ/ARAQ1ZwwmtVeRnB6IED4K1zG
        cFEAKYd7is4gjABN05AKNGS9GOZ6LKVe8pNB5RZ5YBef6mkg8LiR16OO7OavHiqOvQavIa
        MEyLlp03RwrCegNDpZaUErAhfvXOr/O7OwK08Oy1mgPY92RCFHWNI+AviYg2WiJQsz/4gC
        fDqFVaxqHxY6GyaR3mZTTAwXeKnQxCBAAogYXRan9livnKXqy0yWogfcd6aUJxo1bCw+Hi
        eF7irhXoK9QQPlEMf4epKhStoxCxJ0PWVoCjEsfZwUuNSMPu6GZ2VelTK4HemA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1D60flZDHTBd1k3w4UXmzsFR+k0Cqj8UhH0pbB1+p8=;
        b=cVuANNXoz16PIZ/q2IbroGLU2M70fshOO643GPSAbvTJwEZYtEOrbRZMSb+lBi7Pf6wztb
        OEEH9BnkQ1DNZYCg==
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] dt-bindings: irqchip: ti, sci-intr: Update bindings
 to drop the usage of gic as parent
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806074826.24607-5-lokeshvutla@ti.com>
References: <20200806074826.24607-5-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <159839886011.389.16638562925658744191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9a8e2ae71f3553f1b6cd4e3681f04e5d0f147387
Gitweb:        https://git.kernel.org/tip/9a8e2ae71f3553f1b6cd4e3681f04e5d0f147387
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 06 Aug 2020 13:18:17 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 Aug 2020 22:00:23 +01:00

dt-bindings: irqchip: ti, sci-intr: Update bindings to drop the usage of gic as parent

Drop the firmware related dt-bindings and use the hardware specified
interrupt numbers within Interrupt Router. This ensures interrupt router
DT node need not assume any interrupt parent type.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200806074826.24607-5-lokeshvutla@ti.com
---
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
index 178fca0..c7046f3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
@@ -44,15 +44,17 @@ Required Properties:
 			4: If intr supports level triggered interrupts.
 - interrupt-controller:	Identifies the node as an interrupt controller
 - #interrupt-cells:	Specifies the number of cells needed to encode an
-			interrupt source. The value should be 2.
-			First cell should contain the TISCI device ID of source
-			Second cell should contain the interrupt source offset
-			within the device.
+			interrupt source. The value should be 1.
+			First cell should contain interrupt router input number
+			as specified by hardware.
 - ti,sci:		Phandle to TI-SCI compatible System controller node.
-- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
-- ti,sci-rm-range-girq:	Array of TISCI subtype ids representing the host irqs
-			assigned to this interrupt router. Each subtype id
-			corresponds to a range of host irqs.
+- ti,sci-dev-id:	TISCI device id of interrupt controller.
+- ti,interrupt-ranges:	Set of triplets containing ranges that convert
+			the INTR output interrupt numbers to parent's
+			interrupt number. Each triplet has following entries:
+			- First entry specifies the base for intr output irq
+			- Second entry specifies the base for parent irqs
+			- Third entry specifies the limit
 
 For more details on TISCI IRQ resource management refer:
 https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
@@ -62,21 +64,20 @@ Example:
 The following example demonstrates both interrupt router node and the consumer
 node(main gpio) on the AM654 SoC:
 
-main_intr: interrupt-controller0 {
+main_gpio_intr: interrupt-controller0 {
 	compatible = "ti,sci-intr";
 	ti,intr-trigger-type = <1>;
 	interrupt-controller;
 	interrupt-parent = <&gic500>;
-	#interrupt-cells = <2>;
+	#interrupt-cells = <1>;
 	ti,sci = <&dmsc>;
-	ti,sci-dst-id = <56>;
-	ti,sci-rm-range-girq = <0x1>;
+	ti,sci-dev-id = <131>;
+	ti,interrupt-ranges = <0 360 32>;
 };
 
 main_gpio0: gpio@600000 {
 	...
-	interrupt-parent = <&main_intr>;
-	interrupts = <57 256>, <57 257>, <57 258>,
-		     <57 259>, <57 260>, <57 261>;
+	interrupt-parent = <&main_gpio_intr>;
+	interrupts = <192>, <193>, <194>, <195>, <196>, <197>;
 	...
 };
