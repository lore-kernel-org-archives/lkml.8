Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1B5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6BB2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263273;
	bh=DLzUlWLcdovNYaTfAImL2JYNyT91aDYwHaEMaNIKqeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffDZcf5nkB+E1IkHUF+tG67tl+Yo1cTZp6Zw9VDx1slp0jfYOm5Pkh0D27azZyOMQ
	 6vx9LgKCqW9CPrNUUJlt/LfPpUnWQDBjHHGijfu5CafGCLxta4Z0hOES4P0PSiW9OQ
	 broibxxIb60T/zb07xOTFaWMJUxRHo4egsrDg/Sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgGTQlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbgGTPp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:45:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214782064B;
        Mon, 20 Jul 2020 15:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259958;
        bh=DLzUlWLcdovNYaTfAImL2JYNyT91aDYwHaEMaNIKqeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8d82i842S4PYh+fOcKknowxH+MnGxr84/AGbVMH2kdkeyWjdcUloTJ8rXCp8Irt+
         k0H4FDqER+bCcKy4xqZoZKS/N0aY2tLLzpe47i9DPtiE1Qho6iUFlyYof4Y9+ZP2pb
         LjkRYSTIZb95MeCu6Bognmnn1VwWDwk5M3mGWWqU=
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
Subject: [PATCH 4.14 024/125] net: macb: mark device wake capable when "magic-packet" property present
Date:   Mon, 20 Jul 2020 17:36:03 +0200
Message-Id: <20200720152804.160386019@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
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
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b01b242c2bf00..4d2a996ba4460 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3516,7 +3516,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->wol = 0;
 	if (of_get_property(np, "magic-packet", NULL))
 		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
-	device_init_wakeup(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
+	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
 
 	spin_lock_init(&bp->lock);
 
-- 
2.25.1



