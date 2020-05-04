Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B7CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896FA20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615469;
	bh=YkAKodN6UufF5X2rzXlFeZr6xUI5WiB5/Lb6gaqDR/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ep9MK7KH0HdvCt9eY+UuoxK8+nP5EAf3Id9mt+dTMQG7FwZjeED9tRo6O1zqNp4s4
	 uALGGzMNqD1774NE2+7vvEaQtaP4vvcZEFc9540CeVFTXYoYDiXnE3WfgId/EAVlx7
	 wzzznosEeqT7p6cpIYyfCrRc/JLYYhffOHb1adrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgEDSE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731670AbgEDSEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:04:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE680205ED;
        Mon,  4 May 2020 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615464;
        bh=YkAKodN6UufF5X2rzXlFeZr6xUI5WiB5/Lb6gaqDR/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERJFvegprR+5K+vwLN71VhJ3lL0MFNSEYI5DGpu/pIRIkDStmEE0Zr+nzrzSjT5hP
         4sk6fLdGYtIYeghBES3jTCaK9XtrcoaDDp5ReZwDsWUBH5ch79VuEC0v7GvnYeK7gV
         0BB0Xx6vB3rn8hw2vuTTDjdjDsLIY8eB7tGXuSjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.4 49/57] i2c: aspeed: Avoid i2c interrupt status clear race condition.
Date:   Mon,  4 May 2020 19:57:53 +0200
Message-Id: <20200504165500.835261420@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ryan_chen <ryan_chen@aspeedtech.com>

commit c926c87b8e36dcc0ea5c2a0a0227ed4f32d0516a upstream.

In AST2600 there have a slow peripheral bus between CPU and i2c
controller. Therefore GIC i2c interrupt status clear have delay timing,
when CPU issue write clear i2c controller interrupt status. To avoid
this issue, the driver need have read after write clear at i2c ISR.

Fixes: f327c686d3ba ("i2c: aspeed: added driver for Aspeed I2C")
Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[wsa: added Fixes tag]
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-aspeed.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -603,6 +603,7 @@ static irqreturn_t aspeed_i2c_bus_irq(in
 	/* Ack all interrupts except for Rx done */
 	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
 	       bus->base + ASPEED_I2C_INTR_STS_REG);
+	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	irq_remaining = irq_received;
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
@@ -645,9 +646,11 @@ static irqreturn_t aspeed_i2c_bus_irq(in
 			irq_received, irq_handled);
 
 	/* Ack Rx done */
-	if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
+	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
 		writel(ASPEED_I2CD_INTR_RX_DONE,
 		       bus->base + ASPEED_I2C_INTR_STS_REG);
+		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	}
 	spin_unlock(&bus->lock);
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }


