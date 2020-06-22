Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FCBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6123320732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="A2nZUOgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgFVJlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgFVJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2259CC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so13983894wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfUc+TkUAgqz9MdoL32AGr8CBlEvrLInm5v62775Pps=;
        b=A2nZUOgnmx1UP+ORv6aiykQQt+lLSQ1KO7Odnx9nMWmPGWBB/9zwG2qDldAgXJmqFF
         xP5a4eGOadOLgU5l8x7N7j9+z2XQcTH/rFKkU1WWhZmJmVhXF2hTLLfHyQ5etAtMHKmX
         GzjJGiUtKBqAj3ZO+9U33Aqe6H7sc3uFms0oEry7uZGxugnSgJBjckjsDuq2/0a7BeEq
         I4qul8QuxKe+CEztgYEFZDIF1pwVYkuHKS4ZkApg+YQ/TcNclWYBEankibn6cVK3MPY7
         ZU+9DUlAqUZCkiO9dP4Q1H37N9frUcXcUiOti5AX0YjukaK8I91Rvini9mJsIrmoYDWK
         Og9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfUc+TkUAgqz9MdoL32AGr8CBlEvrLInm5v62775Pps=;
        b=BswNjuFz2ZIYLgc78pNLBlJgRO13rIOkEJ44gCgak/rP6aQZt7Kz7p974CBDJwmYuu
         R7f99qUWI/c2BtE4dlbbnjf3LA6Mr+UsTQyk+WpUQyXYnzjGMHZn0moGPbptIwFndKQb
         hYu/arsqodCaHfYlqqjDcsr+OUhES2B/IS1+1vrlfMdZEYKWroO/q4W20Yly7AOKZlDd
         nmiZEa//IV7cxpe54NrfILeaB6OBPkiOwAcZyWlfiMBW+gPoEqlzBB7n+AjJ3A3K7Kfo
         4dGnzXTo4qCTniVlHmYFsrM8wvQc0R4+D9WtnczxOKeV1hZNJgeQCiMbnZQxmTr1oBnP
         BEeA==
X-Gm-Message-State: AOAM531YIoQ+cSokS23Lm6ye3utfJPr7cpxaA1hk7zPi7FdibnPVllVH
        J3k0AxkhL4HNQwSrcJyPJsP5yg==
X-Google-Smtp-Source: ABdhPJzkmYuQpu0uNoygH8mU35nl1Z6nB3WJ2gtz2NCWG24AiJQNaa6UhDtUjU6DEUC2R04sQUctyQ==
X-Received: by 2002:a5d:470a:: with SMTP id y10mr5777035wrq.405.1592818890889;
        Mon, 22 Jun 2020 02:41:30 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:30 -0700 (PDT)
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
Subject: [PATCH 05/15] net: phy: reset the PHY even if probe() is not implemented
Date:   Mon, 22 Jun 2020 11:37:34 +0200
Message-Id: <20200622093744.13685-6-brgl@bgdev.pl>
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

Currently we only call phy_device_reset() if the PHY driver implements
the probe() callback. This is not mandatory and many drivers (e.g.
realtek) don't need probe() for most devices but still can have reset
GPIOs defined. There's no reason to depend on the presence of probe()
here so pull the reset code out of the if clause.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/phy_device.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1b4df12c70ad..f6985db08340 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2690,16 +2690,13 @@ static int phy_probe(struct device *dev)
 
 	mutex_lock(&phydev->lock);
 
-	if (phydev->drv->probe) {
-		/* Deassert the reset signal */
-		phy_device_reset(phydev, 0);
+	/* Deassert the reset signal */
+	phy_device_reset(phydev, 0);
 
+	if (phydev->drv->probe) {
 		err = phydev->drv->probe(phydev);
-		if (err) {
-			/* Assert the reset signal */
-			phy_device_reset(phydev, 1);
+		if (err)
 			goto out;
-		}
 	}
 
 	/* Start out supporting everything. Eventually,
@@ -2761,6 +2758,10 @@ static int phy_probe(struct device *dev)
 	phydev->state = PHY_READY;
 
 out:
+	/* Assert the reset signal */
+	if (err)
+		phy_device_reset(phydev, 1);
+
 	mutex_unlock(&phydev->lock);
 
 	return err;
@@ -2779,12 +2780,12 @@ static int phy_remove(struct device *dev)
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
 
-	if (phydev->drv && phydev->drv->remove) {
+	if (phydev->drv && phydev->drv->remove)
 		phydev->drv->remove(phydev);
 
-		/* Assert the reset signal */
-		phy_device_reset(phydev, 1);
-	}
+	/* Assert the reset signal */
+	phy_device_reset(phydev, 1);
+
 	phydev->drv = NULL;
 
 	return 0;
-- 
2.26.1

