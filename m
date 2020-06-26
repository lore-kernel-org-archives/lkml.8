Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA47F20702
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JAecZ0nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgFZPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgFZPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:53:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686DBC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so8339157wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HpTeBheR2Max3bhies4A06Ktq37O/EquFsiIja/0Us=;
        b=JAecZ0nqvo8AmnXIX2it/8IMyi2bxnGgFQInkwWVdB1gyEwzvTZguf53OiXpKjDr6y
         XP2eAnAw1phsaoewWx9UM711SHyjGGQdeq5cZ1l7dm/CVkG+gffP/GiO44aTIYXu9Sj7
         SoiPsJ/Iewa8R6x8q+8xHp7Q9YsYONLEXHs5N6HdHwJzMkr52uE192l7JFB9sfFE96Cj
         sRzv2MhjjKl9+QiKr320vkzzqyZWP7HUMGB9t47/01awDQxXSONb/BI5McCjkKDOOLz/
         EQt3qTjgN9QXIhz6OcSfMNLFxrS0hNrzzgfa4n23U8vG5+uhGcLtkHuXGYGJ7oFPqf7A
         wmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HpTeBheR2Max3bhies4A06Ktq37O/EquFsiIja/0Us=;
        b=NUVOQ7EqFMuwkpYK1WJZNtkEr4kh7vY/F/T4g6ixoH9vpzNyky/zC5KcUYdGbMUjUG
         pUvWYCmi20kpP4dEMtTDak/7qJ/KvWFBEIiqfhdhBMeDWzVfyH3yiCPwSi8TAmBuO65F
         8XCcR7yzofBdWr1IbmDfbF9y/e3Bdrwaq45yOFLTK1oL4ASXcThOFchYGh6u/HDSlaRF
         R9iSZXgXHAIn/NeGhLjGoQTJT9CztYEnqPf9XlEAcrfKI4jSpG7L+ne10E4L1CylEe3N
         l96XMBYN+1VZinFm2ttCtHf9ZufPMS4WI7QB/mkSIr3nyz4YriWZDYQOlZzh+5y704Z4
         Nv4A==
X-Gm-Message-State: AOAM532e7XBbrH4Z55IOt13/jJQFeorMUK/uhiscc35mkYm0R5U2QaE9
        c7MuuvwaOvSC9IkSj8rvU/+Ltw==
X-Google-Smtp-Source: ABdhPJy3y+RszAJGTbdP/01nZi0Y5pYeHN3bFnyQygRzQP1z4vAf5Ce19XLI9TY8keSgctRUay0Xjg==
X-Received: by 2002:a1c:5583:: with SMTP id j125mr4342157wmb.189.1593186827220;
        Fri, 26 Jun 2020 08:53:47 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h142sm8242791wme.3.2020.06.26.08.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:53:46 -0700 (PDT)
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
Subject: [PATCH 3/6] net: phy: arrange headers in phy_device.c alphabetically
Date:   Fri, 26 Jun 2020 17:53:22 +0200
Message-Id: <20200626155325.7021-4-brgl@bgdev.pl>
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

Keeping the headers in alphabetical order is better for readability and
allows to easily see if given header is already included.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/phy_device.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 04946de74fa0..1b4df12c70ad 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -9,28 +9,28 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
+#include <linux/bitmap.h>
 #include <linux/delay.h>
-#include <linux/netdevice.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/skbuff.h>
+#include <linux/ethtool.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mdio.h>
+#include <linux/mii.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/mii.h>
-#include <linux/ethtool.h>
-#include <linux/bitmap.h>
+#include <linux/netdevice.h>
 #include <linux/phy.h>
 #include <linux/phy_led_triggers.h>
 #include <linux/sfp.h>
-#include <linux/mdio.h>
-#include <linux/io.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/unistd.h>
 
 MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
-- 
2.26.1

