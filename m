Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B6B20716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JohkqRDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgFVJn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgFVJl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80B3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so461708wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZFWs1jjiaVnSG438fJkY7s38xrX7YeHfB9snWv0f6M=;
        b=JohkqRDOkStLwOQBjn7GAxxxqeMmpsJpexC5Nvm3ZMZvZkzc6ARClZYDLYdCfBzdNP
         R+QJVrGl3nve0LVt+ru6aBGSu24D+tdHE1WXHHZuvA5Ccg3nHihCl36U5ScPUL7gEh57
         udVFjmWNOm6E0bczq/erJCZqK+GBkdblmTaRS2wxUujd7J+4fpcSfkvXc70p5jeaQvh0
         r7uqyKqpQR2LYCzlfV/PSR3Z3SvvEaicHAEj11kmaMKkCWH4prC3PqUu8JFXFO7jY4OE
         2ZItHe0laJ0Lf9dSzMlvGGUIslglMGg/vMwUmi0/DI2fZnDGPbhyK9nizsa0eDmyC4EL
         qmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZFWs1jjiaVnSG438fJkY7s38xrX7YeHfB9snWv0f6M=;
        b=YVQL0MJbkEVNtvBsJIAfYJqGGgT8moecVquEWhAkXXXbW9Tx+XhYrGP4eO+Il3I9U/
         s4i4fdi3hgS2ZlqVU1x8LhZFoU6hurZcVRdLxwpCu0oAI8reIESXK/+SXXTvSJ8eGLr7
         +8cvEidUcpdfsqIOtTgOb1b0IU0OqAOSq/Rlih6ZnW3IRuHWrJM6Wts0NYzkAAb694cw
         e6K7t7oaQj+p/SRY4jDXkBxVqpRRsiphB+Zmyp/U24NoWgyTuJxwdXKR9hs+Ca76oRbm
         YVEM8zT3zOv6l/xol+4/iIBMKasdGZaNhCkAQVDJIaYmmDfCQAB7A6BqyKFfN9FXIroE
         EFFQ==
X-Gm-Message-State: AOAM532xrh5+rKQDRjYhNAAeAJQBC79tFqMnl18hqEfhC9oXyWaM4Z3o
        0Ygb4Um6rJFmStc+X0dbSn9/Bg==
X-Google-Smtp-Source: ABdhPJyC1ihQ/cFNQCt/b68/kb0LNRNlp3xUizgD1UJeHr9htbQzK5ESNt14EIs0DoIuJdIEW8DsUQ==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr18307854wmf.51.1592818883659;
        Mon, 22 Jun 2020 02:41:23 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:23 -0700 (PDT)
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
Subject: [PATCH 01/15] net: phy: arrange headers in mdio_bus.c alphabetically
Date:   Mon, 22 Jun 2020 11:37:30 +0200
Message-Id: <20200622093744.13685-2-brgl@bgdev.pl>
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

Keeping the headers in alphabetical order is better for readability and
allows to easily see if given header is already included.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/mdio_bus.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6ceee82b2839..296cf9771483 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -8,32 +8,32 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/of_device.h>
-#include <linux/of_mdio.h>
 #include <linux/of_gpio.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
 #include <linux/reset.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/mii.h>
-#include <linux/ethtool.h>
-#include <linux/phy.h>
-#include <linux/io.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/unistd.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mdio.h>
-- 
2.26.1

