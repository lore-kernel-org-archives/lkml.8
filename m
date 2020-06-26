Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E071C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A85C2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EVUJjBN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgFZPyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgFZPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:53:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7374C03E97E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so9816625wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbnIQG0QHISwW/i84YvrCuX1R8Xn9pu9QKVIxgPnwPw=;
        b=EVUJjBN8sxl7dynrrBDu7PHBrUi+wFFMq5tb0hZV31YnJQU6ZSB5VsT0F59sh1HNs2
         uPjTKB8yALRduXU4eLgOTIq8K7bbdrWeq0F8rIqX5k5oO2VUI73fCjvfcTmRMHocyCl7
         7Nit5Fnhmb3wzUbXCwXzrc4ZjhD7u1WSeZhmYVherSgfwcRgUFl/tHqI2NDlce7liHeA
         legSrznURkRtbfaHBHhzNy73fHl7FfsdYAhzPrYLTUzmTsJP8e0it5tBdbFW3cn/wjXA
         yfjLEATMugtYRbOGoLMMvrUls3uUExk1B3lqSv6L2jFnZatq+UIv1WpsqbGtGPzMnIpt
         Ghew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbnIQG0QHISwW/i84YvrCuX1R8Xn9pu9QKVIxgPnwPw=;
        b=o1w4BZwT2CB3o4ROEZKQT1aiPWDbnN4bdHrSIpPyx2hnO8fUyvXluTsMN+GzrZ93mI
         a9l61qOALJkT78tRYC/gV9RhEaVPlwoo065OJw2/g1969swboA3YMqg7OBrRaE+FEJo/
         fMlIAukeTMFNSKize311kh/22f+hGeW2X4QHN9ZsUGqlUsvRY+mJ4/78BzDb1gOoL02O
         snIgcoMfPQ4RQPIF7DI7slXcmzK2SmCBQll/FSixfPFRbowhGEZHzyBIVtrZlKvdeAL3
         tb5N/JHp7sxEXYuqoeAdvIE1iuK7QUuVcik0D7q1RXLHIOmIPeTaBzv/DxluhxVx8e9o
         DLqw==
X-Gm-Message-State: AOAM5335dcLwi6Wyi/75xMRGuZteOf5lth+tsl6zvFCNB1fZywVh/lCv
        LM0JzymuGsx379Bw43Kl7gzZVw==
X-Google-Smtp-Source: ABdhPJwZ/GZzuZzZ5R/O//GZ8s1TehBYsWqMkVPkM1A+iw4VakcREenLIdIEwMKrTHeTj5M/lp9Qdw==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr4252746wmg.71.1593186829554;
        Fri, 26 Jun 2020 08:53:49 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h142sm8242791wme.3.2020.06.26.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:53:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/6] net: phy: reset the PHY even if probe() is not implemented
Date:   Fri, 26 Jun 2020 17:53:24 +0200
Message-Id: <20200626155325.7021-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200626155325.7021-1-brgl@bgdev.pl>
References: <20200626155325.7021-1-brgl@bgdev.pl>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

