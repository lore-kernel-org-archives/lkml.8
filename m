Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD49C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCEC20679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AZpdfbWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgDUKl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:41:27 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:19702 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgDUKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587465685; x=1619001685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lz3omuwZBzVsZksmCiDjrMvHtgtfWs9axYmIPw0sTvU=;
  b=AZpdfbWCLXf0GjCcj/7/v5WdIgAYZ6gBSt7sePL8Ie/eCR+M3D5FQyNn
   0LrjadGswvyepyczeFKMOZFk/AlEcPeB+pS9UCm724nuxZ6r9PB1RZTTL
   S4QGILKLgAbAnI/4W2vPG2YqsZaKQ1fsuYmdJ7EcMdej90ep6z8+0vb65
   AK+GSmMBQHGQVY2lgErn5HPoujS73VVnQCmCb6dfecsOk8dspFGfYowNy
   fm+hMSr3y3xAy8Ql9shdq0Vmseyw3dxUxaCRDwsaYAJ0DMJchGZQ8D4rT
   EwGUke1AD3XcZzhzcqNmSZFq8JDDjCRvUBwkCd8VSFKphcrutXiFkAMjB
   w==;
IronPort-SDR: GZiOVziMewu9EEaeIzLMrl9xvhvUHoWUpkY6wOL8xhWqs+iLoPCfMn9875DjJ0rBxKo4o+3A2u
 +K9LGsydlVRkJXVa25ChDbQrGhJ3JqL4SZPRnA17g5omE6qsbT+WHUog8bA8dUHNAQeTvd0+/8
 VWy4CNH3ZDsDLGdwJsHvsqSQfOKROI2NhIE9Y1RpUTnHUf4IDQn/KoAfrmmgp9r0UcTHnFg9zN
 /J29ZhowCqH5/LzbQKwlHWmi7UeBZLknV57wpN8OVRaIba/wnefy472xnCrpCNslJjMOMO7M47
 2dA=
X-IronPort-AV: E=Sophos;i="5.72,410,1580799600"; 
   d="scan'208";a="9886768"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2020 03:41:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Apr 2020 03:40:55 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Apr 2020 03:41:22 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        <harini.katakam@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <sergio.prado@e-labworks.com>, <antoine.tenart@bootlin.com>,
        <f.fainelli@gmail.com>, <linux@armlinux.org.uk>, <andrew@lunn.ch>,
        <michal.simek@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2 0/7] net: macb: Wake-on-Lan magic packet fixes and GEM handling
Date:   Tue, 21 Apr 2020 12:40:57 +0200
Message-ID: <cover.1587463802.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Hi,
Here is the 2nd serries to fix WoL magic-packet on the current macb driver.
I also add, in the second part of this series the feature to GEM types of IPs.
Please tell me if they should be separated; but the two last patches cannot go
without the 5 fixes first ones.

MACB and GEM code must co-exist and as they don't share exactly the same
register layout, I had to specialize a bit the suspend/resume paths and plug a
specific IRQ handler in order to avoid overloading the "normal" IRQ hot path.

The use of dumb buffers for RX that Harini implemented in [1] might
need to be considered for a follow-up patch series in order to address
lower-power modes on some of the platforms.
For instance, I didn't have to implement dumb buffers for some of the simpler
ARM9 platforms using MACB+FIFO types of controllers.

Please give feedback. Best regards,
  Nicolas

[1]:
https://github.com/Xilinx/linux-xlnx/commit/e9648006e8d9132db2594e50e700af362b3c9226#diff-41909d180431659ccc1229aa30fd4e5a
https://github.com/Xilinx/linux-xlnx/commit/60a21c686f7e4e50489ae04b9bb1980b145e52ef


Changes in v2:
- Add patch 4/7 ("net: macb: fix macb_suspend() by removing call to netif_carrier_off()")
  needed for keeping phy state consistent
- Add patch 5/7 ("net: macb: fix call to pm_runtime in the suspend/resume functions") that prevent
  putting the macb in runtime pm suspend mode when WoL is used
- Collect review tags on 3 first patches from Florian: Thanks!
- Review of macb_resume() function
- Addition of pm_wakeup_event() in both MACB and GEM WoL IRQ handlers


Nicolas Ferre (7):
  net: macb: fix wakeup test in runtime suspend/resume routines
  net: macb: mark device wake capable when "magic-packet" property
    present
  net: macb: fix macb_get/set_wol() when moving to phylink
  net: macb: fix macb_suspend() by removing call to netif_carrier_off()
  net: macb: fix call to pm_runtime in the suspend/resume functions
  net: macb: WoL support for GEM type of Ethernet controller
  net: macb: Add WoL interrupt support for MACB type of Ethernet
    controller

 drivers/net/ethernet/cadence/macb.h      |   3 +
 drivers/net/ethernet/cadence/macb_main.c | 202 +++++++++++++++++++----
 2 files changed, 173 insertions(+), 32 deletions(-)

-- 
2.20.1

