Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5AE2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="16VBF2La"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgFVJmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgFVJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01CC061798
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g18so6882555wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUydfUf825zuTrP/3rZhTozCzOm5XJhrM7EVYTY3Zy4=;
        b=16VBF2LawpzpJUoGplW1VMeRQBY+6kIReg/qh3Of8JJozgK7KV3a/y36LFnx7JJaGG
         +hsOoIVXR9n9Bwou+9lQTjVGf6VkErBZk56xecuHPO9LNdA3N6A87+7oJpGaJZr91+Ep
         BI6yveOiwM810Bvvg/LZCi0sL3+aPo8rBLYFEgvj1FYJqgvMM+hLxuy3zExLOJZWyH7g
         i9vpiSlC5Y0qhPNWicv+/56I51GI/LMpey2/OgWMvENvikCSExdgLe04MjH5nquwHbgt
         vxVipAPH8T2Nok3B4y9B9ucBQNKyRuG9bYn8DcPmhCNY+VwarjwpEe+1IYtpzERMpzWD
         8lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUydfUf825zuTrP/3rZhTozCzOm5XJhrM7EVYTY3Zy4=;
        b=ax9gStpxW5N9gqQpSuKnJb6SsHnGyORfYhx1LZfijIO/feF4vTOeZu8Btaa5eWH5ci
         oG90DhLe3WrSHwjCYjesC3PbrMipYdANrXBlrywOT9e1AGw5h2wxbjfHZKmgvHfaQRjp
         RfitQbyi8Q86rE2YmJfuRMh2GaGHs4DixFu2+wX80NQxFLITi4vDc70/MIwA8WB266qZ
         dRl0/AlttT1qtJ0pUmk7ftIpakPPnOoMjioiDL5tvciSYPEl4rnfRwozfeuyTzmFNxyn
         1hc07W6+uy81uvUsT1zL7s5O2TEbuAbP0Sw/Z9QAh82wUnK1/WJJc6sEqCcgWjDOzn26
         SyuQ==
X-Gm-Message-State: AOAM533IJMQZwwbfKU5/QExeifD21+LUE9WeNIkaKOaPM1neaDbJvMoO
        1jD3XvQwlZ2BNHZn7xbUuqk/dg==
X-Google-Smtp-Source: ABdhPJw/YDc8BRLdz6R7EQpjrH3iix+fo/75QLcqChmbsRSUxGbc0J2kOfOhJKAo3W+XevgouG/a8A==
X-Received: by 2002:adf:8168:: with SMTP id 95mr17445453wrm.104.1592818898066;
        Mon, 22 Jun 2020 02:41:38 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:37 -0700 (PDT)
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
Subject: [PATCH 09/15] net: phy: delay PHY driver probe until PHY registration
Date:   Mon, 22 Jun 2020 11:37:38 +0200
Message-Id: <20200622093744.13685-10-brgl@bgdev.pl>
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

Currently the PHY ID is read without taking the PHY out of reset. This
can only work if no resets are defined. This change delays the ID read
until we're actually registering the PHY device - this is needed because
earlier (when creating the device) we don't have a struct device yet
with resets already configured.

While we could use the of_ helpers for GPIO and resets, we will be adding
PHY regulator support layer on and there are no regulator APIs that work
without struct device.

This means that phy_device_create() now only instantiates the device but
doesn't request the relevant driver. If no phy_id is passed to
phy_device_create() (for that we introduce a new define: PHY_ID_NONE)
then the ID will be read inside phy_device_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/phy_device.c | 47 +++++++++++++++++++-----------------
 include/linux/phy.h          |  1 +
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index eccbf6aea63d..94944fffa9bb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -658,12 +658,6 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
 	device_initialize(&mdiodev->dev);
 
-	ret = phy_request_driver_module(dev);
-	if (ret) {
-		phy_device_free(dev);
-		dev = ERR_PTR(ret);
-	}
-
 	return dev;
 }
 EXPORT_SYMBOL(phy_device_create);
@@ -813,30 +807,29 @@ static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id,
 	return 0;
 }
 
+static int phy_device_read_id(struct phy_device *phydev)
+{
+	struct mdio_device *mdiodev = &phydev->mdio;
+
+	phydev->c45_ids.devices_in_package = 0;
+	memset(phydev->c45_ids.device_ids, 0xff,
+	       sizeof(phydev->c45_ids.device_ids));
+
+	return get_phy_id(mdiodev->bus, mdiodev->addr, &phydev->phy_id,
+			  phydev->is_c45, &phydev->c45_ids);
+}
+
 /**
- * get_phy_device - reads the specified PHY device and returns its @phy_device
- *		    struct
+ * get_phy_device - create a phy_device withoug PHY ID
  * @bus: the target MII bus
  * @addr: PHY address on the MII bus
  * @is_c45: If true the PHY uses the 802.3 clause 45 protocol
  *
- * Description: Reads the ID registers of the PHY at @addr on the
- *   @bus, then allocates and returns the phy_device to represent it.
+ * Allocates a new phy_device for @addr on the @bus.
  */
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 {
-	struct phy_c45_device_ids c45_ids;
-	u32 phy_id = 0;
-	int r;
-
-	c45_ids.devices_in_package = 0;
-	memset(c45_ids.device_ids, 0xff, sizeof(c45_ids.device_ids));
-
-	r = get_phy_id(bus, addr, &phy_id, is_c45, &c45_ids);
-	if (r)
-		return ERR_PTR(r);
-
-	return phy_device_create(bus, addr, phy_id, is_c45, &c45_ids);
+	return phy_device_create(bus, addr, PHY_ID_NONE, is_c45, NULL);
 }
 EXPORT_SYMBOL(get_phy_device);
 
@@ -855,6 +848,16 @@ int phy_device_register(struct phy_device *phydev)
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
 
+	if (phydev->phy_id == PHY_ID_NONE) {
+		err = phy_device_read_id(phydev);
+		if (err)
+			goto err_unregister_mdio;
+	}
+
+	err = phy_request_driver_module(phydev);
+	if (err)
+		goto err_unregister_mdio;
+
 	/* Run all of the fixups for this PHY */
 	err = phy_scan_fixups(phydev);
 	if (err) {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 8c05d0fb5c00..2a695cd90c7c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -742,6 +742,7 @@ struct phy_driver {
 
 #define PHY_ANY_ID "MATCH ANY PHY"
 #define PHY_ANY_UID 0xffffffff
+#define PHY_ID_NONE 0
 
 #define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 0)
 #define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 4)
-- 
2.26.1

