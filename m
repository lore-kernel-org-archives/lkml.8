Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41160C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC4220773
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MKa56Wr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgFZPyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbgFZPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:53:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51221C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so9283371wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHAzuFTcnXjRnCecFfdtoCttWR6EYSo9VB+Mynb0BCU=;
        b=MKa56Wr4oR9+OTmtV3S9SJ1MLBBE5u0EgzITpr0eYOyeblpLCSaAipT23Hb/rw5iHi
         JvyREVrUh1mArBn8SKWzt9gk/B5CsqVFdGtJ3B6JHISYoY5iiRuKEbRx8XNkjVXerqgu
         fW5XluGma4IBAnSC3CB97Vx1wJLfyGWpHpgvPnhhq6w1K0bWOZwUlfoXRAnwsq7/hQ0p
         vRz+nLEajgMbAGZ3XsjgRUKiYGU5nDZUYSS2wy2DYHfcp3vxcMSkSJ2WoF9Xun1lR27g
         aBIesvER+HSb4xUd9GNs1HDmoSH34Or8HSjDPeqBULN157iwyUlsLXeCrQqCIsa1Ufoc
         VOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHAzuFTcnXjRnCecFfdtoCttWR6EYSo9VB+Mynb0BCU=;
        b=k6hR4Prfl975NjB9bm9zcRnPH79tyr/H28M2GxuS4vLA7P3ySX3voEfhUUar14lt2/
         TOf5ev8AOT4+mSxO2NvVUVkpm4KCiyWXEdSW/1PRL4o2przz8MKdU1XQx7nT4EgtMh/g
         e1cbjF4S7rG+gfwN7k8UtQP1jJS/PJjDwhOC/bxn8UHvV4UL3XKh1zdZymDK30Xhvyq/
         D3ATdjjgeASKDRrvV35neckML5o5k8skJuNf/ZW4u+Or6sNI8XMSYAVQz7zh69e6aiL3
         aT/nJhlqXZS94SHY+qB775hcM11gzBRlKbWdj1DtRFFElJMlSOlY62PCIEnMTdOv10Iy
         HKwg==
X-Gm-Message-State: AOAM531POD6+NNEPTKouMshZRWv3lsdDHwfq9XdmBqpk91UJtHSdyKdt
        CERSeZTnYwwlBxsIzqzBBJiSb9pN6n4=
X-Google-Smtp-Source: ABdhPJwwituQPOEL46rDs7SCGfIEASNzMaGomeXCnYCrU332v5ZNWT//XKF7nCnUdV0jddo1iNWX+w==
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr3349659wmj.12.1593186826030;
        Fri, 26 Jun 2020 08:53:46 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h142sm8242791wme.3.2020.06.26.08.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:53:45 -0700 (PDT)
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
Subject: [PATCH 2/6] net: phy: arrange headers in mdio_device.c alphabetically
Date:   Fri, 26 Jun 2020 17:53:21 +0200
Message-Id: <20200626155325.7021-3-brgl@bgdev.pl>
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
 drivers/net/phy/mdio_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index c1d345c3cab3..f60443e48622 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
@@ -20,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/unistd.h>
-#include <linux/delay.h>
 
 void mdio_device_free(struct mdio_device *mdiodev)
 {
-- 
2.26.1

