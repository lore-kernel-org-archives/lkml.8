Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D947720719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="owJBZ9DR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgDGM3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:29:34 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:26852 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586262573; x=1617798573;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=mwrqDeZZFPwdOZQAzDue552yl4u2PTg8dL3CuhCIRD0=;
  b=owJBZ9DRTFviDU9Srbi89NboTVl0OpygGIXQj3H2SZhl2hKZYDRfut4T
   B3mCc2N0pfAfMg8ayQyBswe5ZZ3zbg7hk4DpXYvSO2J8vI/rxXgH2VIlv
   dC2PJZPlNas8DMf+nxBQZN4YconHzRhlJSejXVOmrDI0bpE7Ta6asmkce
   48Nbl06HTEPp1cjOWpKdJNPUfeIU/r+QCWEqNOKA+hpPm8C6cV6tOoJBz
   nJRWGWN+ZWTL0UcBKRssWr4b4ZEi+BaNxMundtJ/OzrcAnUvhtpTefIMN
   di5uleXWqRzWqbSxgz6dgpdlN2nswbAB3pkO8L7mJTyQku6H0D+kSgtbd
   g==;
IronPort-SDR: eHcVGlQPapM0erpoDIa3ogDoNhu9Y1m7vz119BJjbiF1QmLcmp/aHB+3LjwuNjS5U+NicQJtje
 SaL7FbFUUz2CY2TsnwHYNB6drmR/GxR+7zKKT26XdkmhoY/toNxYdftDJefmB3hqSHhnrWat7V
 GE3vtzT7ofkQ3Rm+lfAvYXN1a6stvjO2MAtoa7sEDyawq6bxbOmUWi0XWMhJmSEVU2tJ54vGeS
 sFz0+mihLtjW9nTooH19R8c0QflvKZfjLSYGeSc4WbYovxLxZNKpdzT1oRPdbaIyNsW1L7N6WI
 Yok=
X-IronPort-AV: E=Sophos;i="5.72,354,1580799600"; 
   d="scan'208";a="75013395"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2020 05:29:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Apr 2020 05:29:43 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 7 Apr 2020 05:29:29 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 0/7] usb: gadget: udc: atmel: add usb device support for SAM9x60 SoC
Date:   Tue, 7 Apr 2020 15:28:45 +0300
Message-ID: <20200407122852.19422-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

This patch set adds usb device support for SAM9x60 SoC.
The DPRAM memory for the USB High Speed Device Port (UDPHS) hardware
block was increased and the allocation method is changed. This patch
series simplifies the endpoint allocation scheme to acomodate this SoC
and the old ones.

Claudiu Beznea (2):
  usb: gadget: udc: atmel: use of_find_matching_node_and_match
  usb: gadget: udc: atmel: add compatible for SAM9X60's PMC

Cristian Birsan (5):
  usb: gadget: at91_udc: Update DT binding documentation
  usb: gadget: udc: atmel: simplify endpoint allocation
  usb: gadget: udc: atmel: use 1 bank endpoints for control transfers
  usb: gadget: udc: atmel: rename errata into caps
  usb: gadget: udc: atmel: update endpoint allocation for sam9x60

 .../devicetree/bindings/usb/atmel-usb.txt     |  1 +
 drivers/usb/gadget/udc/atmel_usba_udc.c       | 87 ++++++++++++-------
 drivers/usb/gadget/udc/atmel_usba_udc.h       |  6 +-
 3 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.17.1

