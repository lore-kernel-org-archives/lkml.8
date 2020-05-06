Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304AFC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8F920736
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Dk7ML7eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgEFLmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:42:13 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:59009 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgEFLmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588765330; x=1620301330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LT3J9ik/ZJWvrD8XpOG7/NwP2Lq90M4T+y17p4Ln3ps=;
  b=Dk7ML7eYvcCH9r+APLMp/CA7rBfl13bn+nlOhUO2WvW6Ts5JVU3jXIEW
   59LjzvpdLF5xrCSBhTYP/eB51MKvwPmQ97Bf4aWFWN+TUsquxHAQycUz8
   Q+ZIaSRX1j4HFrAxHISSGxSRAOrkaBSrpkREdXMVjhMm+U6ay00+Xt7kb
   nLSEos0RixS18JOWpo5E9UgPPNhkHG599lQpz1e707hrHHHJVlbhRQmg9
   GkWLuLoDBGVC+lVrLExji6rf9+twmyELMgm36o1PVMmc9D8SF3uoF3xS/
   Oxlf1zAu/1MMFSYU8tfE60mgMWs5ICBhfqVBMh+q9TDOsPGDGnCyX7nsu
   A==;
IronPort-SDR: 8jR4LZbj5arbqc3uRsmUnFtBhO6LM2wTSSc5CvwjxaTWnCWZ7EsuskT0ES9jPfAKp5/xq9jPRc
 rYgsuPn3306qJ5wyirMwv9AWA8h04OOrzce0CJphmKvTAwWG2nt4sSJrhlbqE5EM+GG5M8Si/r
 N6km9gWoNpKSCShyPPSVm3G0aFaLZeNnni8cvBrhVyLx61tef7HcOx2JQrtbCw/q1xm8XoLVP0
 ObFKwbFPAMCWAef+0k9rjxJ/x7ze33uYDmIyBBS4kIjutTQ+k2e6d9ZwfZxKW5WKuxsEJWBXl6
 p+Q=
X-IronPort-AV: E=Sophos;i="5.73,358,1583218800"; 
   d="scan'208";a="72599442"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 May 2020 04:42:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 May 2020 04:42:08 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 6 May 2020 04:42:04 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        <harini.katakam@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <antoine.tenart@bootlin.com>, <f.fainelli@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v4 4/5] net: macb: fix macb_suspend() by removing call to netif_carrier_off()
Date:   Wed, 6 May 2020 13:37:40 +0200
Message-ID: <cf81b45a07d1063f6632deebbb869c3974ded00c.1588763703.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588763703.git.nicolas.ferre@microchip.com>
References: <cover.1588763703.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

As we now use the phylink call to phylink_stop() in the non-WoL path,
there is no need for this call to netif_carrier_off() anymore. It can
disturb the underlying phylink FSM.

Fixes: 7897b071ac3b ("net: macb: convert to phylink")
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Harini Katakam <harini.katakam@xilinx.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>
---
Changes in v2:
- new in v2 serries

 drivers/net/ethernet/cadence/macb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 24c044dc7fa0..ebc57cd5d286 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4562,7 +4562,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			bp->pm_data.scrt2 = gem_readl_n(bp, ETHT, SCRT2_ETHT);
 	}
 
-	netif_carrier_off(netdev);
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(netdev);
 	pm_runtime_force_suspend(dev);
-- 
2.26.2

