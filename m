Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F18CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F710207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692176;
	bh=UVJYsnp9VrZ2KU6bKTwSieMy9VbS55d1Zju82t79cPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ywkp1eL7+74ZhF3hXlEcLC8v6anz8n/AKOj0T1UZBcn8mqyYqwA0hCu9kFE5ILSv+
	 IW0nC8dQX1tQJOvXdtAT7QkLx6Td9VaftGmKTWq6zPJVSbc5coVquIMB0gYl719iTi
	 Dmixecgn7EHNvWdYWyBK2PH1eccl1x8T0m4Vb02I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgHQTWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730465AbgHQPfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:35:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBFE32078D;
        Mon, 17 Aug 2020 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678530;
        bh=UVJYsnp9VrZ2KU6bKTwSieMy9VbS55d1Zju82t79cPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSZkbEGbv4XVEQg1KAdHpovYNyEiu5RnCJs6IAsMoyk1fNZn6SXcD7SLk3Twfb+o1
         fyRRTyR6LrS9tOcq1NFeSPdS+0/Sr66olj08s0OGhVp9tnPaZY83PeHKElXNkY/+C4
         tyReMMCMak1Yca+6k6IIU83nrcC5NUl6sVBO9loY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 367/464] net: macb: Properly handle phylink on at91sam9x
Date:   Mon, 17 Aug 2020 17:15:20 +0200
Message-Id: <20200817143851.352979099@linuxfoundation.org>
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

From: Stefan Roese <sr@denx.de>

[ Upstream commit f7ba7dbf4f7af67b5936ff1cbd40a3254b409ebf ]

I just recently noticed that ethernet does not work anymore since v5.5
on the GARDENA smart Gateway, which is based on the AT91SAM9G25.
Debugging showed that the "GEM bits" in the NCFGR register are now
unconditionally accessed, which is incorrect for the !macb_is_gem()
case.

This patch adds the macb_is_gem() checks back to the code
(in macb_mac_config() & macb_mac_link_up()), so that the GEM register
bits are not accessed in this case any more.

Fixes: 7897b071ac3b ("net: macb: convert to phylink")
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Reto Schneider <reto.schneider@husqvarnagroup.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2213e6ab81512..4b1b5928b1043 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -578,7 +578,7 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	if (bp->caps & MACB_CAPS_MACB_IS_EMAC) {
 		if (state->interface == PHY_INTERFACE_MODE_RMII)
 			ctrl |= MACB_BIT(RM9200_RMII);
-	} else {
+	} else if (macb_is_gem(bp)) {
 		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
 
 		if (state->interface == PHY_INTERFACE_MODE_SGMII)
@@ -639,10 +639,13 @@ static void macb_mac_link_up(struct phylink_config *config,
 		ctrl |= MACB_BIT(FD);
 
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
-		ctrl &= ~(GEM_BIT(GBE) | MACB_BIT(PAE));
+		ctrl &= ~MACB_BIT(PAE);
+		if (macb_is_gem(bp)) {
+			ctrl &= ~GEM_BIT(GBE);
 
-		if (speed == SPEED_1000)
-			ctrl |= GEM_BIT(GBE);
+			if (speed == SPEED_1000)
+				ctrl |= GEM_BIT(GBE);
+		}
 
 		/* We do not support MLO_PAUSE_RX yet */
 		if (tx_pause)
-- 
2.25.1



