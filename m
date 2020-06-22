Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA14C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0ED20720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="swtzTFmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgFVJnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgFVJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E383CC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so15902456wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nC0F5ZT+Ll5OOGkPAd3mIJIStND0frPBkptlTCmDLJg=;
        b=swtzTFmLVIWLX97Ka8BE4T1dWXPt5l1jiTgEty4wbnCrweWQw3HbeTXNza6y2qcCXR
         iIu5WIxWbsQs51WOv19l2MOnnx9biFYV7/MbY0YMlQ/cSE0G+PyDXwmHvUYyHhrnNdUq
         xAHqSoVXMheRLlPuN1KpgliIQIXbuBOHq+PCzME+TGn0K+/URvl99z5NPSrgSbWHtdpH
         2XLpBaTp7Jhs4GFXZGq+gopioO0XNjhy5k4P+p0oSTll4HgmIBiAnRFMRF6aTZi4O2og
         vYAAkHtdQXctioWsdumoNSuMfzhqraPeWT6gTazq92hFSwkJkMSYyr7hlCsjXk1eVqPx
         7WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nC0F5ZT+Ll5OOGkPAd3mIJIStND0frPBkptlTCmDLJg=;
        b=P2ka3VbmpVCMPXzg0vmzpWxuPmMLD/zMGdtLJE+zFIWXXDNLYULY//1gwBWa/hhwFl
         PdpmQVF3r5GB1G6vhEtGhvEjusQHJnP27IoLEIRK1J7ue9eU1soWAp4JNxconb+aVJKB
         CMGSbQM/gWYEZ+xfDWeN7mtox9gCAGRLSZZlrS3OBTyKHakMijAQkST1eW+oqrQ2ueKf
         UkE3qqQj13WhtIEYjxob+8aRjO2FZhOgF+1zJnRG6HvL9RsKbR1qQnJCfV4Mj0J/WfOe
         /efU/DMfa8wto6yttvySlIiToh7il1hGJy/E5KU1hdjDdCL9wFqsPbV9FKT037xg8WPL
         duLg==
X-Gm-Message-State: AOAM530YRgCUpYisfJlKYiUmZbm1JnmFK+6HTIRZnfSj/VZBNR4LNGEN
        fnDfY4jV3foqTumpGlQEVYatYw==
X-Google-Smtp-Source: ABdhPJzxHCym+Ub6CuSXGJUTfH6gp7OLN1NQWcaww2Sg2sQLihShVVzipPqZpx45p1tV4dBze4Q9ew==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr18207943wru.68.1592818892680;
        Mon, 22 Jun 2020 02:41:32 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/15] net: phy: mdio: reset MDIO devices even if probe() is not implemented
Date:   Mon, 22 Jun 2020 11:37:35 +0200
Message-Id: <20200622093744.13685-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200622093744.13685-1-brgl@bgdev.pl>
References: <20200622093744.13685-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Similarily to PHY drivers - there's no reason to require probe() to be
implemented in order to call mdio_device_reset(). MDIO devices can have
resets defined without needing to do anything in probe().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/mdio_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index f60443e48622..be615504b829 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -150,10 +150,10 @@ static int mdio_probe(struct device *dev)
 	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
 	int err = 0;
 
-	if (mdiodrv->probe) {
-		/* Deassert the reset signal */
-		mdio_device_reset(mdiodev, 0);
+	/* Deassert the reset signal */
+	mdio_device_reset(mdiodev, 0);
 
+	if (mdiodrv->probe) {
 		err = mdiodrv->probe(mdiodev);
 		if (err) {
 			/* Assert the reset signal */
@@ -170,12 +170,11 @@ static int mdio_remove(struct device *dev)
 	struct device_driver *drv = mdiodev->dev.driver;
 	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
 
-	if (mdiodrv->remove) {
+	if (mdiodrv->remove)
 		mdiodrv->remove(mdiodev);
 
-		/* Assert the reset signal */
-		mdio_device_reset(mdiodev, 1);
-	}
+	/* Assert the reset signal */
+	mdio_device_reset(mdiodev, 1);
 
 	return 0;
 }
-- 
2.26.1

