Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C322C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F1520882
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678481;
	bh=XugmzUNp+yDZbPuVILCbUKm0S2q7YDvtvt0tPgBwu04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ski6V7khiyyvfHeoozHIkiMEw4Qd4UL1uRGR0eNw1yqvvr3HTg5T9pQuyJNAf9Ewu
	 oZpHCde9ns5Bt5Bh1V8akDzQ68rNN3DNEiYboeml80qAlhLeVFL9ZwllMyVCbYuEYo
	 w395hOeNNnpzRIq1X4SBAQLjDgZry1Crg6YWlgiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgHQPek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbgHQPaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:30:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95EB423B70;
        Mon, 17 Aug 2020 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678201;
        bh=XugmzUNp+yDZbPuVILCbUKm0S2q7YDvtvt0tPgBwu04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdzAgTKT9X7ZDbX3xao0gD2DPN2lx00lA9NksxiMRLSxSL73JAt5YgQ8Xhn7uXGC6
         6NpWnPaWpLuhI0SE5psYyL6gcnihEXR8ZMYWwwoKRKq9AL7Q4iPO62b13cP2M8Ydp4
         uOl6GbD7fZ3S6xMmKB8JmQD9LN5g2dX/ob3C604o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 222/464] phy: cadence: salvo: fix wrong bit definition
Date:   Mon, 17 Aug 2020 17:12:55 +0200
Message-Id: <20200817143844.431489756@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

[ Upstream commit 270ff6048f45759d31a7b62d3983b084153837f5 ]

It fixes RX detect wakeup using USB3 device, otherwise, the USB3
device can't wakeup USB PHY when the PHY is in 32Khz clock.

Fixes: 50d35aa8c15f ("phy: cadence: salvo: add salvo phy driver")
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Link: https://lore.kernel.org/r/20200703064600.14181-1-peter.chen@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 1ecbb964cd216..016514e4aa549 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -88,7 +88,7 @@
 #define TB_ADDR_TX_RCVDETSC_CTRL	        0x4124
 
 /* TB_ADDR_TX_RCVDETSC_CTRL */
-#define RXDET_IN_P3_32KHZ			BIT(1)
+#define RXDET_IN_P3_32KHZ			BIT(0)
 
 struct cdns_reg_pairs {
 	u16 val;
-- 
2.25.1



