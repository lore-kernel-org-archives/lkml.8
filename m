Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6C6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E9C2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YKsGX6vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgGMPMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgGMPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:12:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1BCC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:12:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so16969159wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9xxbXFyrtlGeFDUjb611TWuOvSdsWZ5MdXBOYYr2j8=;
        b=YKsGX6vZMawq7T2fMKOHhZBjRXmK2aFNzZOc1jZ6HIHbBIqYejfmAC9S7AQhTVE7u6
         0Qo66R4UQGE9m5FcdrBHVZm08dkZngp4+e3dIjfTn1y2R1CtM6jJGmgeSukEbmjVxb88
         /fK8ZVsp94fwqQ4Wfjd+aHg+wPYKvdFccL8/4BNe0LrzXvkTq1gJiD+KaoCaak+eFFBo
         UvmJ3kTp13r6Ey7PGzV+17Hey7b7JzDu/fp09foEBdOYBYLCfRuRyJwXjTe0GOGm+eqa
         xO6NefVRgOmwcmplwCqHyZioMU8cfFuQOUCSzc8y6S6jY5V9kWzk+KgdOUANk4DXYwKg
         m5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9xxbXFyrtlGeFDUjb611TWuOvSdsWZ5MdXBOYYr2j8=;
        b=pOQQ4g5vyXhrmNvCYcUzZsqbjl+UCDmuVDSgmB033ZRKehHgecC1r+HhH5vipm0YFA
         hZcGlbWOaD3vbZNW/EadNEUf+LIzl1xCy/My8dTxD6c2pvtFyPYLJ10EX/nbkeFqAO35
         xwmJQ3tegVo7YChe8McDunO95rmqTCmaFgcnNQmlvJXO5fLwhiC7/IecwoIm/N8zDIN3
         hI49vWvEcsH8MaGCgG9/Ae4mPLihuEAl3tJeO8PUUulQXOjZNSbKYFkKdjd7Bi/WpzOd
         KlqOUVq61gx2WuYIQAZVim2DJJxhMvnnEjjH0atUX8Z1DeYDRGgw9Imy8P3kwqIe/J1J
         oa6g==
X-Gm-Message-State: AOAM531uIl6AasuHdZDAB00xAfKQoU+YiKf0F/w/UVm0me/NVebxrVAQ
        yOW2+t9ScDJaxhXCR0+l9xMM5g==
X-Google-Smtp-Source: ABdhPJxgl7e4SXZGiBQHgW6nDqBxiEfI26ZYvhrRLJFDd7dULkmU0/xIRAlcSaiExjcYdao35CCBvg==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr38781714wrq.104.1594653130157;
        Mon, 13 Jul 2020 08:12:10 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id j24sm25203665wrd.43.2020.07.13.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:12:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] net: phy: fix mdio-mscc-miim build
Date:   Mon, 13 Jul 2020 17:12:07 +0200
Message-Id: <20200713151207.29451-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

PHYLIB is not selected by mdio-mscc-miim but it uses mdio devres helpers.
Explicitly select MDIO_DEVRES in this driver's Kconfig entry.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 1814cff26739 ("net: phy: add a Kconfig option for mdio_devres")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7ffa8a4529a8e..dd20c2c27c2f6 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -185,6 +185,7 @@ config MDIO_MOXART
 config MDIO_MSCC_MIIM
 	tristate "Microsemi MIIM interface support"
 	depends on HAS_IOMEM
+	select MDIO_DEVRES
 	help
 	  This driver supports the MIIM (MDIO) interface found in the network
 	  switches of the Microsemi SoCs; it is recommended to switch on
-- 
2.26.1

