Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711D1C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E0821927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047850;
	bh=EK/Cuxjn3w46ZMpO2v2XOHxAZrlG7GWtQElkScPysAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ShC3boE9ZmHYhjQb5f9w8rciy+wo74Ng6fbGGrQItmPPCgqwNxuyqM9c5DeqlJLDD
	 e1g+J3TAB5mo1EtC3h+eqq1expwbl5DNZTOuWM59Vyl5pKmIHdzJrwMdZ2J8lKUV3r
	 c4SsdBDSMLDxoznNMl3mpJp58SpccedK7nEZRHJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393537AbgDPOK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:10:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898629AbgDPNqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:46:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F9121734;
        Thu, 16 Apr 2020 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044811;
        bh=EK/Cuxjn3w46ZMpO2v2XOHxAZrlG7GWtQElkScPysAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2JUJ0VF0GUC8YNTl63elFnsOVMxm9rPv79FGlx7zVYUwAvf9z9vmA5muTqlhCD6r
         YkdGQm27OLIb/YNrOw2QfP71jZbk/w6B0GeTr+zEIhJjRjuJ+UckGweoNzkcLtc1ku
         9AdDYeWgnVj71XRrtLmVJCCYON8Lk6POfJk/py9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sungbo Eo <mans0n@gorani.run>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.4 111/232] irqchip/versatile-fpga: Apply clear-mask earlier
Date:   Thu, 16 Apr 2020 15:23:25 +0200
Message-Id: <20200416131329.017834513@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sungbo Eo <mans0n@gorani.run>

commit 6a214a28132f19ace3d835a6d8f6422ec80ad200 upstream.

Clear its own IRQs before the parent IRQ get enabled, so that the
remaining IRQs do not accidentally interrupt the parent IRQ controller.

This patch also fixes a reboot bug on OX820 SoC, where the remaining
rps-timer IRQ raises a GIC interrupt that is left pending. After that,
the rps-timer IRQ is cleared during driver initialization, and there's
no IRQ left in rps-irq when local_irq_enable() is called, which evokes
an error message "unexpected IRQ trap".

Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded interrupts from DT")
Signed-off-by: Sungbo Eo <mans0n@gorani.run>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200321133842.2408823-1-mans0n@gorani.run
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-versatile-fpga.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -212,6 +212,9 @@ int __init fpga_irq_of_init(struct devic
 	if (of_property_read_u32(node, "valid-mask", &valid_mask))
 		valid_mask = 0;
 
+	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
+	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
+
 	/* Some chips are cascaded from a parent IRQ */
 	parent_irq = irq_of_parse_and_map(node, 0);
 	if (!parent_irq) {
@@ -221,9 +224,6 @@ int __init fpga_irq_of_init(struct devic
 
 	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
 
-	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
-	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
-
 	/*
 	 * On Versatile AB/PB, some secondary interrupts have a direct
 	 * pass-thru to the primary controller for IRQs 20 and 22-31 which need


