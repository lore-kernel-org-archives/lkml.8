Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC5EC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049DB20774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nGzIz3b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCRPXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:23:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40989 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:23:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so2144137wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vcuQ9gcytyRyDY8O+hV2btKMyad21nj7al+XoxPWHJE=;
        b=nGzIz3b8BS+V35Arf30oggbsc/tPZjP11gUMYxid52jBa2s9rJgwlGXTg6QiOfyHXw
         J3XMSRISYs58xGGakGzW4VeeieqMi0KkQ0AYDynXCN7QJWOGjRmwh3E2E0vTxTsX1YOC
         5UfgdjXRHcMwEWG6RS1JZsl5y+/Y72SNan1fQs4uWeNbck8sXBffJVA+/QyirERP848B
         5DdA6sZn3TwGRsgmVtwhiP6uSZVx7f6y1VO8J9SJUASeVqcYkPvXPkWoAOExjY7l+YS2
         OyhAXthKt0wKqpSzWCj9BzeVQjSJumvScqcO77UZO1eXQas46QyaJTBCDKD/LHwyKejA
         NZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vcuQ9gcytyRyDY8O+hV2btKMyad21nj7al+XoxPWHJE=;
        b=lXJ+8krDZStwa+ehB//KIf838Zk9BVNi/chdl0FOnEr07Mo+iPVwVwS852TI8igiIT
         7wn4Cb1G57xSOfNO15F5VvDi4xEA+q0abINl8oD5QgWqphJLNrgEJ+JNMWDOKcV9gLgh
         tnsJWxWwyaiid1c0hGKQRwOdMWuXDWXi3Ak6Wvho+vNxaElIrPnSA5ooWMRXwNZ7hWpy
         Qwmm3nNWuIawHwmIAWrtYRQfjekAkHtrjU5HnLnnjypvtkT4Ycbe1GTeVTTjRIz5fzfI
         3FjKLW5mWt6PbepNPqlLVdc5yDAeWoukeIfyHjMwHy/DaiNglw2rP6MEF0uHZdjZNI35
         4VIQ==
X-Gm-Message-State: ANhLgQ11iwtuVsSXh2i8C1TwgWZhKnEIk9TbQVp0aWqgCexaEwpR1qwD
        9AnkhGu5ziWs4yUeKX1ExJhD+Q==
X-Google-Smtp-Source: ADFU+vvGk6xRRdtafKwG/IAn8PrMglCVvUmZVoJhe+n4XquEkaUXMZhe+dh6g8+sA8wedIJ2nB2gFw==
X-Received: by 2002:a5d:440a:: with SMTP id z10mr6208528wrq.177.1584545021409;
        Wed, 18 Mar 2020 08:23:41 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v10sm4015464wml.44.2020.03.18.08.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Mar 2020 08:23:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jonathanh@nvidia.com, kishon@ti.com, nkristam@nvidia.com,
        thierry.reding@gmail.com, treding@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] phy: tegra: should select USB_PHY
Date:   Wed, 18 Mar 2020 15:23:33 +0000
Message-Id: <1584545013-19859-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have hit the following build error:
armv7a-hardfloat-linux-gnueabi-ld: drivers/phy/tegra/xusb.o: in function `tegra_xusb_port_unregister':
xusb.c:(.text+0x2ac): undefined reference to `usb_remove_phy'
armv7a-hardfloat-linux-gnueabi-ld: drivers/phy/tegra/xusb.o: in function `tegra_xusb_setup_ports':
xusb.c:(.text+0xf30): undefined reference to `usb_add_phy_dev'

PHY_TEGRA_XUSB should select USB_PHY

Fixes: 23babe30fb45d ("phy: tegra: xusb: Add usb-phy support")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/phy/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index df07c4dea059..a208aca4ba7b 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -3,6 +3,7 @@ config PHY_TEGRA_XUSB
 	tristate "NVIDIA Tegra XUSB pad controller driver"
 	depends on ARCH_TEGRA
 	select USB_CONN_GPIO
+	select USB_PHY
 	help
 	  Choose this option if you have an NVIDIA Tegra SoC.
 
-- 
2.24.1

