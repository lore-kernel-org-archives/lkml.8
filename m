Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A04206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RkGI6tow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFVKCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgFVKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:01:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E227C0617B9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:01:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so522982wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcgV1UNGKm4K4QD82m2Udcr1uoHRVa+LAuPxtdS553M=;
        b=RkGI6towfSCgupn14twIBaRcPBpM6kTZkAyARWvNzlnwP2dFp8mTrnv4XT4CqOTAtt
         IZZIzKyBSsI3/vkakwGdPxh4YtWTjHfNDgdbQoZiEHDRdqwaJzeBZU2n3pe3Hl1JIPX3
         j5b+wJ80RHNzlW79fmuSMN+irizFshjUfl7KHbTO/28J+86JZlFjPu2oxnw1xDlP9U+o
         Tz/qaKPx5+I3TcQfOgtfVc5nagMQ1oAW9Ofb8YpEYwg0Zu2KW4gsBJQW7Tl/PL353xVB
         MT3qUFDfoJzdv7OI5y+BMBaG6gcer8a9lZAr62OJTJz3NDwnsNdQyvR6wevtOPQ6vWAU
         9aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcgV1UNGKm4K4QD82m2Udcr1uoHRVa+LAuPxtdS553M=;
        b=fuTA9tjSbExkm6qNl/Wq4lQsGIoDeI+Lq/ml5Rrz0Cvz1nkubnFct+e5gFxkRbUJeS
         41gZVW5nZL1nkLkVMX5R9mBfn0ix+TmTWhy2UBNFsObJEr18nWeJDosUP649zOTUVp7I
         0GGGtPR4TtSOcW8yISLB4lRoM4k274imK+VMr25Ps/VX0yzBWjF3s9VKmxB7uyFN4Cl0
         ni5DAwgzAbBzVUBlM/+1I2Maw8rnqp9yX1tWJ016awGIRo1+dazYnAJyHOCIO7sQML8+
         aSivCVV52bu62BTDfaRUPL5Vd7XBhDoas8XTJONBPg/ixkzDhvBDxDUD4pa038L1iVrg
         gUoQ==
X-Gm-Message-State: AOAM530sfGHRPFfcGW+U6JXDKhAmA++QkBL55tNKHXCkFHuECxBWzJUt
        mwT1S7GHgrsIXlJIygOOmbbvkA==
X-Google-Smtp-Source: ABdhPJy6HpyoKYwmL67X7W6b1kvbkakGECdClzNJkWp/hMLI6DOqKfaBEc4Vc9FAS3rR166Apmbchw==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr9844980wmc.155.1592820077095;
        Mon, 22 Jun 2020 03:01:17 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id x205sm16822187wmx.21.2020.06.22.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:01:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/11] phy: mdio: add kerneldoc for __devm_mdiobus_register()
Date:   Mon, 22 Jun 2020 12:00:52 +0200
Message-Id: <20200622100056.10151-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200622100056.10151-1-brgl@bgdev.pl>
References: <20200622100056.10151-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This function is not documented. Add a short kerneldoc description.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/mdio_devres.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/mdio_devres.c b/drivers/net/phy/mdio_devres.c
index f0b4b6cfe5e3..3ee887733d4a 100644
--- a/drivers/net/phy/mdio_devres.c
+++ b/drivers/net/phy/mdio_devres.c
@@ -2,6 +2,13 @@
 
 #include <linux/phy.h>
 
+/**
+ * __devm_mdiobus_register - Resource-managed variant of mdiobus_register()
+ * @bus:	MII bus structure to register
+ * @owner:	Owning module
+ *
+ * Returns 0 on success, negative error number on failure.
+ */
 int __devm_mdiobus_register(struct mii_bus *bus, struct module *owner)
 {
 	int ret;
-- 
2.26.1

