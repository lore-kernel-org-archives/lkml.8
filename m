Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C9220772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D50CgX7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgGANJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:09:08 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33522 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgGANJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593608942; x=1625144942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=F0v7d59d8CodmqYQV4UE6rEu9k/83Ok33vbIFw5OEbM=;
  b=D50CgX7OIuW/Bio8GIOBhsOAuLPb8VCHufaJzhIRAGeRV4+/OuNzEItq
   vg6Ai86SDc9t2HxTaw255UKTtdu5GX5vjPJE32WUv3TICZNDFFlDBKAn6
   rGzuRggruvFvBf4GtCKRb0pEQLH2DF4MVDj+gEu4qJq9c3kTs+CILpPP0
   QWxiumUWeagLn1SyYGcv749yhQQv1W8IEQhJKRAVneKADaJm97SCPNK2m
   VrKrWhFVK3XHlRK37bMLZv03aYfoBonn0fVwnuqjpOLydvVRbVVrkNUVP
   Ap7SBEfzO2BFbd0b6TzS+Mjhii+7a9Vb/5QW8DVFPPgX7s8CkzJP0vYeu
   A==;
IronPort-SDR: DFW2gmCmg6FYGBod7jc0ouwNHPnGC6wxV22JgWmCNcdqQ6DM7HjxnkWU6NHzyzIVQEtSr8Nnu4
 1CQ+LJMuRgCOUBg+29TC+P2x67H5rP0bcRiSvSHzmCSXSelmKQCh5sIM5OQVAgm4nluEC4owDk
 byvudokhP0v94OlZVIVrsLpQj8Y9C2hiDiRHtSngG/EXC2TyHy6fUiYKUH2EQHM04PsSsPW6is
 TFO0Zo67sMBzNXZvovNNvsVDgw4lUhA+e7CH20/cWookqisFH6I2gp5cfAsDNQAfvyieYUlGuG
 g2E=
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="85819358"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2020 06:09:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 1 Jul 2020 06:08:41 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 1 Jul 2020 06:08:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH net-next 1/4] net: macb: do not set again bit 0 of queue_mask
Date:   Wed, 1 Jul 2020 16:08:48 +0300
Message-ID: <1593608931-3718-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593608931-3718-1-git-send-email-claudiu.beznea@microchip.com>
References: <1593608931-3718-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 0 of queue_mask is set at the beginning of
macb_probe_queues() function. Do not set it again after reading
DGFG6 but instead use "|=" operator.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 52582e8ed90e..1bc2810f3dc4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3497,9 +3497,7 @@ static void macb_probe_queues(void __iomem *mem,
 		return;
 
 	/* bit 0 is never set but queue 0 always exists */
-	*queue_mask = readl_relaxed(mem + GEM_DCFG6) & 0xff;
-
-	*queue_mask |= 0x1;
+	*queue_mask |= readl_relaxed(mem + GEM_DCFG6) & 0xff;
 
 	for (hw_q = 1; hw_q < MACB_MAX_QUEUES; ++hw_q)
 		if (*queue_mask & (1 << hw_q))
-- 
2.7.4

