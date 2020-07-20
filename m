Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEA3C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073972064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259618;
	bh=aeMxZjdu4DejQwRV96M4aAXeUviOoWGXvLjkf2/JLx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OeWfpF0Bd/wYXrhC/g32VYqk3C/PgaeFX7io9cKTw2EEpCPmomSzhGwE/KYDA3Yx/
	 a4rPEm/1NtbtWd5c2svJ5GXeNDoMC96sdIq2JdYqxgYS7jU7wIXtdSdq0F7yMPSAvz
	 HVAm8lhmeLsP/MHHtRpQGEA3M/6+DiDKzplH0ujE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgGTPkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbgGTPkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:40:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6566522CB2;
        Mon, 20 Jul 2020 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259612;
        bh=aeMxZjdu4DejQwRV96M4aAXeUviOoWGXvLjkf2/JLx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIglto62lYH1QnmmBiAmWQCsuLrr4fDf3Tr9ixsGZW58keTcrZTVxtRKSYSDBIsEH
         2nTUs7eg9tpaAOcIFnJqZwormW4QD7yBqxy5Lw0338FpG+UMbLwHr+88KUHz2hdgDt
         P01jw/WVp0ytse7Kz1jzg1MC5gXuBYuNz4BtSv3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Sergio Prado <sergio.prado@e-labworks.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 15/86] net: macb: mark device wake capable when "magic-packet" property present
Date:   Mon, 20 Jul 2020 17:36:11 +0200
Message-Id: <20200720152753.892551167@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

[ Upstream commit ced4799d06375929e013eea04ba6908207afabbe ]

Change the way the "magic-packet" DT property is handled in the
macb_probe() function, matching DT binding documentation.
Now we mark the device as "wakeup capable" instead of calling the
device_init_wakeup() function that would enable the wakeup source.

For Ethernet WoL, enabling the wakeup_source is done by
using ethtool and associated macb_set_wol() function that
already calls device_set_wakeup_enable() for this purpose.

That would reduce power consumption by cutting more clocks if
"magic-packet" property is set but WoL is not configured by ethtool.

Fixes: 3e2a5e153906 ("net: macb: add wake-on-lan support via magic packet")
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Harini Katakam <harini.katakam@xilinx.com>
Cc: Sergio Prado <sergio.prado@e-labworks.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index 30e93041bf835..f20718b730e5b 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -3024,7 +3024,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->wol = 0;
 	if (of_get_property(np, "magic-packet", NULL))
 		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
-	device_init_wakeup(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
+	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	if (GEM_BFEXT(DBWDEF, gem_readl(bp, DCFG1)) > GEM_DBW32)
-- 
2.25.1



