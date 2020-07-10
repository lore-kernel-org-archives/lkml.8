Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416412075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGJTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:18:52 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:60780 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgGJTSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:18:51 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 12DB7BC071;
        Fri, 10 Jul 2020 19:18:48 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] usb: phy: Replace HTTP links with HTTPS ones
Date:   Fri, 10 Jul 2020 21:18:42 +0200
Message-Id: <20200710191842.32561-1-grandmaster@al2klimov.de>
In-Reply-To: <20200710074358.GB1179998@kroah.com>
References: <20200710074358.GB1179998@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Now better?

 drivers/usb/phy/phy-keystone.c    | 2 +-
 drivers/usb/phy/phy-twl6030-usb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-keystone.c b/drivers/usb/phy/phy-keystone.c
index 9c226b57153b..358d05cb643d 100644
--- a/drivers/usb/phy/phy-keystone.c
+++ b/drivers/usb/phy/phy-keystone.c
@@ -2,7 +2,7 @@
 /*
  * phy-keystone - USB PHY, talking to dwc3 controller in Keystone.
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: WingMan Kwok <w-kwok2@ti.com>
  */
diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 9a7e655d5280..8ba6c5a91557 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -2,7 +2,7 @@
 /*
  * twl6030_usb - TWL6030 USB transceiver, talking to OMAP OTG driver.
  *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Hema HK <hemahk@ti.com>
  */
-- 
2.27.0

