Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD218C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820B722AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753409;
	bh=OWIHnKV5MZ12VsrvwuY3Yra7e3O5eMMUe1kObuHO6Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n2X5gftM7TpIZnlWCJZvqstDjqtiy6oz2Xz7O4aJHgeBtUZZvQwqckOfUPU3S9Cg+
	 eI5T1mqWBQR5mDNQZSxRfEIJTHSgBVQMm9Ur/C9cDhd3it8duCprlWC0zUCoestGYa
	 /ZF0q0N7Iaxe5z/ToWbfbhFgLnD4SEedZrKAG+gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgGNTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730687AbgGNS5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:57:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94F7207F5;
        Tue, 14 Jul 2020 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753050;
        bh=OWIHnKV5MZ12VsrvwuY3Yra7e3O5eMMUe1kObuHO6Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+1BSP6K1c5sn3THwe/w0RnNwYdHRwnmkZJ6qCldePhHFRU7Xldja7r8k+fvTEFZy
         XADuLmqPGfyzziyZoum0U2SiDs2PZsBenIHs5Q/MKPQLuH5GApapFX6N1SuqxKMZdM
         y6ritvof3o2BSFuZMZo3nNdrL7QgVBAZasPdkqvY=
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
Subject: [PATCH 5.7 101/166] net: macb: mark device wake capable when "magic-packet" property present
Date:   Tue, 14 Jul 2020 20:44:26 +0200
Message-Id: <20200714184120.679280878@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
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
index 55e680f350222..4cafe343c0a27 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4422,7 +4422,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->wol = 0;
 	if (of_get_property(np, "magic-packet", NULL))
 		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
-	device_init_wakeup(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
+	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
 
 	spin_lock_init(&bp->lock);
 
-- 
2.25.1



