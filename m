Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 07:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5267207FB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 07:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="srhvhHbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHBHt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgHBHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 03:49:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A7C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 00:49:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so12737591wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ygrcvr2pVcE4Pssi2xhoGsnrMUWar3eSBDrbKhPdTA4=;
        b=srhvhHbFtVzZIJgytVDqFouTKqelYJupQGgfXgM8V6ioJvWRHiQikLj5FSN+Ew6QSz
         KOgPmJd4X7Q1Ms+XCE+HMjMTKDe542oum2EWk1M6bnAroOPRhNrwUCxnxSTzXLVA5U07
         aE+hU5ox3wKjbu97uB4vaqw9FiBjQsoT0IhmAAlT87QY3JZ+0xLab0Zp6jSCymJVEw5R
         X26R1t5E1zr19fElUM23kmp6RSoGa+gzInDnXxeUf9Tw6xqVfb6u5pEfQZyXwJodDFAO
         8mO5wSV9/gcLhaGmb7o+BDcpFyxXqFuyqsM5X1zOvdQt5mVYTnz1KhW3HYQqaUszKzV9
         Tu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ygrcvr2pVcE4Pssi2xhoGsnrMUWar3eSBDrbKhPdTA4=;
        b=Kldu6e/MvWPwzpwinKbp4Y/LzMbM0Gye8uyctvG5FE24GU96Mb44NkLY+9qGkteo6C
         wFrW0jGVEfMAjBMi50Ug10ekhNB9D2BLS2V5QhSOODbPeOtrnKIQCMmQ868lPIUoYDQg
         WjNbN/aQHPa4/a+Xw7CD/kS/Wy0f/m9t4Nfh5ZE6MTz0kAKG9lwSmdR9L8J7+IEizH07
         /3iOtUVpBTt3cJApG0s/wGp1BZVCa3Es/xDK1q3zop9g/UUttQ6SNLc/vKpWZ6wifHq7
         Baoll9VfpYUwFVdJ9ke1U3bwBZdxwORmpQjDTac+YsDlYhXOXO3yfstYnl/GF8YZnWZS
         xj+A==
X-Gm-Message-State: AOAM5325jwja1zNSvYOCScG8VFtTYsT2MXJewzf5TkSLWOU6XWOwApRN
        9OGh9qw8HVU43z2jVsjNMZBZYA==
X-Google-Smtp-Source: ABdhPJwlgi2uT9QxGsIte/MTAulpm12MyyQy962GURP3ppmJ4rCnVPT46enfy8Qic81ndW4b/3xePA==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr10548082wmj.122.1596354596373;
        Sun, 02 Aug 2020 00:49:56 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id d14sm19175611wre.44.2020.08.02.00.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 00:49:55 -0700 (PDT)
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
Subject: [net-next PATCH] net: phy: mdio-mvusb: select MDIO_DEVRES in Kconfig
Date:   Sun,  2 Aug 2020 09:49:53 +0200
Message-Id: <20200802074953.1529-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

PHYLIB is not selected by the mvusb driver but it uses mdio devres
helpers. Explicitly select MDIO_DEVRES in this driver's Kconfig entry.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 1814cff26739 ("net: phy: add a Kconfig option for mdio_devres")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index e351d65533aa..7a756e0374fd 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -190,6 +190,7 @@ config MDIO_MSCC_MIIM
 config MDIO_MVUSB
 	tristate "Marvell USB to MDIO Adapter"
 	depends on USB
+	select MDIO_DEVRES
 	help
 	  A USB to MDIO converter present on development boards for
 	  Marvell's Link Street family of Ethernet switches.
-- 
2.26.1

