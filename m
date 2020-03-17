Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D867C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A102073C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442974;
	bh=aV1Z3DLMqttPDw4STbAY8xwYfR9ZcIogrCRPvIl+k6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D0VQTu/Q+WHrJRF5lcLOd/4q4Ci3xx6om88kj+gfU0YnC1UCBFu52sJthMn8BdJp6
	 4XQlapx2u5P6BgpJUDuBiFw9nn/8EGJ6cmDOjjGepfu3VDO4xvQx9ArRHsvhQ/46vk
	 EyL472vOmpIHzAMZ5Tln4Wq19HRmKobsgwKkApBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgCQLCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgCQLCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:02:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C807620735;
        Tue, 17 Mar 2020 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442969;
        bh=aV1Z3DLMqttPDw4STbAY8xwYfR9ZcIogrCRPvIl+k6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1uKAyfAJWY4V8oCtSIzYCA+MNUnAr3e8pDvljiFbD5XTHeGw0qK+tEMMVuldU+kQt
         v9H5TJgxjgR4ZSquVtVzJ906wyDOn8Q/3SIDrN6C1QUcWdhhsBXXFrdwrpSr5ZcZP3
         89GULzp2fI2yg9GJDvYbgwWr0hGV20tabkqwPNic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 051/123] net: phy: avoid clearing PHY interrupts twice in irq handler
Date:   Tue, 17 Mar 2020 11:54:38 +0100
Message-Id: <20200317103312.932195839@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 249bc9744e165abe74ae326f43e9d70bad54c3b7 ]

On all PHY drivers that implement did_interrupt() reading the interrupt
status bits clears them. This means we may loose an interrupt that
is triggered between calling did_interrupt() and phy_clear_interrupt().
As part of the fix make it a requirement that did_interrupt() clears
the interrupt.

The Fixes tag refers to the first commit where the patch applies
cleanly.

Fixes: 49644e68f472 ("net: phy: add callback for custom interrupt handler to struct phy_driver")
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy.c |    3 ++-
 include/linux/phy.h   |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -761,7 +761,8 @@ static irqreturn_t phy_interrupt(int irq
 		phy_trigger_machine(phydev);
 	}
 
-	if (phy_clear_interrupt(phydev))
+	/* did_interrupt() may have cleared the interrupt already */
+	if (!phydev->drv->did_interrupt && phy_clear_interrupt(phydev))
 		goto phy_err;
 	return IRQ_HANDLED;
 
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -524,6 +524,7 @@ struct phy_driver {
 	/*
 	 * Checks if the PHY generated an interrupt.
 	 * For multi-PHY devices with shared PHY interrupt pin
+	 * Set interrupt bits have to be cleared.
 	 */
 	int (*did_interrupt)(struct phy_device *phydev);
 


