Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FF420739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiT28Uep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgFOJCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgFOJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F11AC061A0E;
        Mon, 15 Jun 2020 02:02:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so4365231wmh.4;
        Mon, 15 Jun 2020 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knVNalxyxtKtb4hbONTCKOf3kMZwkGfBNHoePvfHKus=;
        b=uiT28UepS7YwKq24zjAGRHTmJheAWs11FXsonxY77xSq8kqa43SlG74WPsE8wOvYE7
         1fI731bgAJ/Vw/qHUemFkCHb2Sr/r4S302HVI4ZJzhXEQLm4z2+G+LlsMh+LLCizx7OQ
         h2/j+YjFsMjrGoamxzRpQ8T81TWlJrJjSXauFpXX0e99Xxt3RDL1/ViQ8q6FdvlXt7Gz
         fHEPHHWDGflx64hTcxsxmXPdCfqAl5z6wuS4Iva9Z+sXoAysLH0gKkYsQhOFLM9olssP
         OHvSGpU9DuOOJr3Yp+LN8cPMc4U3bTvdthcBU444I8vXWrB+To9xCJQpSOdpgLWnmG82
         4dkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knVNalxyxtKtb4hbONTCKOf3kMZwkGfBNHoePvfHKus=;
        b=kx8YVh4v8sPOowDU8r9kR4OoydDFpQ+v8JTPsuM1knSywl6mu6FApu54ttFvmdyBB+
         OnkO+fWa5hejZkOaDyPZTzrOSI33iAb1/lqZlAOs0koYjgVfTP2rh0UhgEaoMCi3LfVH
         RVu3n9Ni/OlnH9ZypfTWTPVQjLThfaAPTe3/Pggwa51TSSYUAyMGqmtq7+0smUNRSXJJ
         g6YWcy8POUmozLZXDTljkA0PPq92umKY/C4767vMgs4zbALVlEhK7WRNwLTXYlQzkS6l
         4yuQcfQTD2rTi6sMP0Pox3TdlbCfKoadM7/Hm4VFVTZMJ6dUHhpA67Ow9LHSAQf+4oMd
         Yzqw==
X-Gm-Message-State: AOAM5318HJlUZprHe/9Ay2lO6Gy3mVpiP7X3ZCF1bRDhCJg3Vlx/vnuU
        Y/lAqmQOEWiNiGnGKSIDP5o=
X-Google-Smtp-Source: ABdhPJz58Mg/HUFBrF/gAk1m4i3WIMu2tlUiS7RrioP4s6hNcH/o4v3EmbAiLpMPNmhwTKZ6AejQKA==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr11532570wmj.2.1592211764635;
        Mon, 15 Jun 2020 02:02:44 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 8/8] clk: bcm63xx-gate: switch to dt-bindings definitions
Date:   Mon, 15 Jun 2020 11:02:31 +0200
Message-Id: <20200615090231.2932696-9-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615090231.2932696-1-noltari@gmail.com>
References: <20200615090231.2932696-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there are header files for each SoC, let's use them in the
bcm63xx-gate controller driver.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/clk/bcm/clk-bcm63xx-gate.c | 580 ++++++++++++++++++++++-------
 1 file changed, 439 insertions(+), 141 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm63xx-gate.c b/drivers/clk/bcm/clk-bcm63xx-gate.c
index fce6746cc607..8ebc49082374 100644
--- a/drivers/clk/bcm/clk-bcm63xx-gate.c
+++ b/drivers/clk/bcm/clk-bcm63xx-gate.c
@@ -6,6 +6,14 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
+#include <dt-bindings/clock/bcm3368-clock.h>
+#include <dt-bindings/clock/bcm6318-clock.h>
+#include <dt-bindings/clock/bcm6328-clock.h>
+#include <dt-bindings/clock/bcm6358-clock.h>
+#include <dt-bindings/clock/bcm6362-clock.h>
+#include <dt-bindings/clock/bcm6368-clock.h>
+#include <dt-bindings/clock/bcm63268-clock.h>
+
 struct clk_bcm63xx_table_entry {
 	const char * const name;
 	u8 bit;
@@ -20,168 +28,458 @@ struct clk_bcm63xx_hw {
 };
 
 static const struct clk_bcm63xx_table_entry bcm3368_clocks[] = {
-	{ .name = "mac", .bit = 3, },
-	{ .name = "tc", .bit = 5, },
-	{ .name = "us_top", .bit = 6, },
-	{ .name = "ds_top", .bit = 7, },
-	{ .name = "acm", .bit = 8, },
-	{ .name = "spi", .bit = 9, },
-	{ .name = "usbs", .bit = 10, },
-	{ .name = "bmu", .bit = 11, },
-	{ .name = "pcm", .bit = 12, },
-	{ .name = "ntp", .bit = 13, },
-	{ .name = "acp_b", .bit = 14, },
-	{ .name = "acp_a", .bit = 15, },
-	{ .name = "emusb", .bit = 17, },
-	{ .name = "enet0", .bit = 18, },
-	{ .name = "enet1", .bit = 19, },
-	{ .name = "usbsu", .bit = 20, },
-	{ .name = "ephy", .bit = 21, },
-	{ },
+	{
+		.name = "mac",
+		.bit = BCM3368_CLK_MAC,
+	}, {
+		.name = "tc",
+		.bit = BCM3368_CLK_TC,
+	}, {
+		.name = "us_top",
+		.bit = BCM3368_CLK_US_TOP,
+	}, {
+		.name = "ds_top",
+		.bit = BCM3368_CLK_DS_TOP,
+	}, {
+		.name = "acm",
+		.bit = BCM3368_CLK_ACM,
+	}, {
+		.name = "spi",
+		.bit = BCM3368_CLK_SPI,
+	}, {
+		.name = "usbs",
+		.bit = BCM3368_CLK_USBS,
+	}, {
+		.name = "bmu",
+		.bit = BCM3368_CLK_BMU,
+	}, {
+		.name = "pcm",
+		.bit = BCM3368_CLK_PCM,
+	}, {
+		.name = "ntp",
+		.bit = BCM3368_CLK_NTP,
+	}, {
+		.name = "acp_b",
+		.bit = BCM3368_CLK_ACP_B,
+	}, {
+		.name = "acp_a",
+		.bit = BCM3368_CLK_ACP_A,
+	}, {
+		.name = "emusb",
+		.bit = BCM3368_CLK_EMUSB,
+	}, {
+		.name = "enet0",
+		.bit = BCM3368_CLK_ENET0,
+	}, {
+		.name = "enet1",
+		.bit = BCM3368_CLK_ENET1,
+	}, {
+		.name = "usbsu",
+		.bit = BCM3368_CLK_USBSU,
+	}, {
+		.name = "ephy",
+		.bit = BCM3368_CLK_EPHY,
+	}, {
+		/* sentinel */
+	},
 };
 
 static const struct clk_bcm63xx_table_entry bcm6318_clocks[] = {
-	{ .name = "adsl_asb", .bit = 0, },
-	{ .name = "usb_asb", .bit = 1, },
-	{ .name = "mips_asb", .bit = 2, },
-	{ .name = "pcie_asb", .bit = 3, },
-	{ .name = "phymips_asb", .bit = 4, },
-	{ .name = "robosw_asb", .bit = 5, },
-	{ .name = "sar_asb", .bit = 6, },
-	{ .name = "sdr_asb", .bit = 7, },
-	{ .name = "swreg_asb", .bit = 8, },
-	{ .name = "periph_asb", .bit = 9, },
-	{ .name = "cpubus160", .bit = 10, },
-	{ .name = "adsl", .bit = 11, },
-	{ .name = "sar125", .bit = 12, },
-	{ .name = "mips", .bit = 13, .flags = CLK_IS_CRITICAL, },
-	{ .name = "pcie", .bit = 14, },
-	{ .name = "robosw250", .bit = 16, },
-	{ .name = "robosw025", .bit = 17, },
-	{ .name = "sdr", .bit = 19, .flags = CLK_IS_CRITICAL, },
-	{ .name = "usbd", .bit = 20, },
-	{ .name = "hsspi", .bit = 25, },
-	{ .name = "pcie25", .bit = 27, },
-	{ .name = "phymips", .bit = 28, },
-	{ .name = "afe", .bit = 29, },
-	{ .name = "qproc", .bit = 30, },
-	{ },
+	{
+		.name = "adsl_asb",
+		.bit = BCM6318_CLK_ADSL_ASB,
+	}, {
+		.name = "usb_asb",
+		.bit = BCM6318_CLK_USB_ASB,
+	}, {
+		.name = "mips_asb",
+		.bit = BCM6318_CLK_MIPS_ASB,
+	}, {
+		.name = "pcie_asb",
+		.bit = BCM6318_CLK_PCIE_ASB,
+	}, {
+		.name = "phymips_asb",
+		.bit = BCM6318_CLK_PHYMIPS_ASB,
+	}, {
+		.name = "robosw_asb",
+		.bit = BCM6318_CLK_ROBOSW_ASB,
+	}, {
+		.name = "sar_asb",
+		.bit = BCM6318_CLK_SAR_ASB,
+	}, {
+		.name = "sdr_asb",
+		.bit = BCM6318_CLK_SDR_ASB,
+	}, {
+		.name = "swreg_asb",
+		.bit = BCM6318_CLK_SWREG_ASB,
+	}, {
+		.name = "periph_asb",
+		.bit = BCM6318_CLK_PERIPH_ASB,
+	}, {
+		.name = "cpubus160",
+		.bit = BCM6318_CLK_CPUBUS160,
+	}, {
+		.name = "adsl",
+		.bit = BCM6318_CLK_ADSL,
+	}, {
+		.name = "sar125",
+		.bit = BCM6318_CLK_SAR125,
+	}, {
+		.name = "mips",
+		.bit = BCM6318_CLK_MIPS,
+		.flags = CLK_IS_CRITICAL,
+	}, {
+		.name = "pcie",
+		.bit = BCM6318_CLK_PCIE,
+	}, {
+		.name = "robosw250",
+		.bit = BCM6318_CLK_ROBOSW250,
+	}, {
+		.name = "robosw025",
+		.bit = BCM6318_CLK_ROBOSW025,
+	}, {
+		.name = "sdr",
+		.bit = BCM6318_CLK_SDR,
+		.flags = CLK_IS_CRITICAL,
+	}, {
+		.name = "usbd",
+		.bit = BCM6318_CLK_USBD,
+	}, {
+		.name = "hsspi",
+		.bit = BCM6318_CLK_HSSPI,
+	}, {
+		.name = "pcie25",
+		.bit = BCM6318_CLK_PCIE25,
+	}, {
+		.name = "phymips",
+		.bit = BCM6318_CLK_PHYMIPS,
+	}, {
+		.name = "afe",
+		.bit = BCM6318_CLK_AFE,
+	}, {
+		.name = "qproc",
+		.bit = BCM6318_CLK_QPROC,
+	}, {
+		/* sentinel */
+	},
 };
 
 static const struct clk_bcm63xx_table_entry bcm6318_ubus_clocks[] = {
-	{ .name = "adsl-ubus", .bit = 0, },
-	{ .name = "arb-ubus", .bit = 1, .flags = CLK_IS_CRITICAL, },
-	{ .name = "mips-ubus", .bit = 2, .flags = CLK_IS_CRITICAL, },
-	{ .name = "pcie-ubus", .bit = 3, },
-	{ .name = "periph-ubus", .bit = 4, .flags = CLK_IS_CRITICAL, },
-	{ .name = "phymips-ubus", .bit = 5, },
-	{ .name = "robosw-ubus", .bit = 6, },
-	{ .name = "sar-ubus", .bit = 7, },
-	{ .name = "sdr-ubus", .bit = 8, },
-	{ .name = "usb-ubus", .bit = 9, },
-	{ },
+	{
+		.name = "adsl-ubus",
+		.bit = BCM6318_UCLK_ADSL,
+	}, {
+		.name = "arb-ubus",
+		.bit = BCM6318_UCLK_ARB,
+		.flags = CLK_IS_CRITICAL,
+	}, {
+		.name = "mips-ubus",
+		.bit = BCM6318_UCLK_MIPS,
+		.flags = CLK_IS_CRITICAL,
+	}, {
+		.name = "pcie-ubus",
+		.bit = BCM6318_UCLK_PCIE,
+	}, {
+		.name = "periph-ubus",
+		.bit = BCM6318_UCLK_PERIPH,
+		.flags = CLK_IS_CRITICAL,
+	}, {
+		.name = "phymips-ubus",
+		.bit = BCM6318_UCLK_PHYMIPS,
+	}, {
+		.name = "robosw-ubus",
+		.bit = BCM6318_UCLK_ROBOSW,
+	}, {
+		.name = "sar-ubus",
+		.bit = BCM6318_UCLK_SAR,
+	}, {
+		.name = "sdr-ubus",
+		.bit = BCM6318_UCLK_SDR,
+	}, {
+		.name = "usb-ubus",
+		.bit = BCM6318_UCLK_USB,
+	}, {
+		/* sentinel */
+	},
 };
 
 static const struct clk_bcm63xx_table_entry bcm6328_clocks[] = {
-	{ .name = "phy_mips", .bit = 0, },
-	{ .name = "adsl_qproc", .bit = 1, },
-	{ .name = "adsl_afe", .bit = 2, },
-	{ .name = "adsl", .bit = 3, },
-	{ .name = "mips", .bit = 4, .flags = CLK_IS_CRITICAL, },
-	{ .name = "sar", .bit = 5, },
-	{ .name = "pcm", .bit = 6, },
-	{ .name = "usbd", .bit = 7, },
-	{ .name = "usbh", .bit = 8, },
-	{ .name = "hsspi", .bit = 9, },
-	{ .name = "pcie", .bit = 10, },
-	{ .name = "robosw", .bit = 11, },
-	{ },
+	{
+		.name = "phy_mips",
+		.bit = BCM6328_CLK_PHYMIPS,
+	}, {
+		.name = "adsl_qproc",
+		.bit = BCM6328_CLK_ADSL_QPROC,
+	}, {
+		.name = "adsl_afe",
+		.bit = BCM6328_CLK_ADSL_AFE,
+	}, {
+		.name = "adsl",
+		.bit = BCM6328_CLK_ADSL,
+	}, {
+		.name = "mips",
+		.bit = BCM6328_CLK_MIPS,
+		.flags = CLK_IS_CRITICAL,
+	}, {
+		.name = "sar",
+		.bit = BCM6328_CLK_SAR,
+	}, {
+		.name = "pcm",
+		.bit = BCM6328_CLK_PCM,
+	}, {
+		.name = "usbd",
+		.bit = BCM6328_CLK_USBD,
+	}, {
+		.name = "usbh",
+		.bit = BCM6328_CLK_USBH,
+	}, {
+		.name = "hsspi",
+		.bit = BCM6328_CLK_HSSPI,
+	}, {
+		.name = "pcie",
+		.bit = BCM6328_CLK_PCIE,
+	}, {
+		.name = "robosw",
+		.bit = BCM6328_CLK_ROBOSW,
+	}, {
+		/* sentinel */
+	},
 };
 
 static const struct clk_bcm63xx_table_entry bcm6358_clocks[] = {
-	{ .name = "enet", .bit = 4, },
-	{ .name = "adslphy", .bit = 5, },
-	{ .name = "pcm", .bit = 8, },
-	{ .name = "spi", .bit = 9, },
-	{ .name = "usbs", .bit = 10, },
-	{ .name = "sar", .bit = 11, },
-	{ .name = "emusb", .bit = 17, },
-	{ .name = "enet0", .bit = 18, },
-	{ .name = "enet1", .bit = 19, },
-	{ .name = "usbsu", .bit = 20, },
-	{ .name = "ephy", .bit = 21, },
-	{ },
+	{
+		.name = "enet",
+		.bit = BCM6358_CLK_ENET,
+	}, {
+		.name = "adslphy",
+		.bit = BCM6358_CLK_ADSLPHY,
+	}, {
+		.name = "pcm",
+		.bit = BCM6358_CLK_PCM,
+	}, {
+		.name = "spi",
+		.bit = BCM6358_CLK_SPI,
+	}, {
+		.name = "usbs",
+		.bit = BCM6358_CLK_USBS,
+	}, {
+		.name = "sar",
+		.bit = BCM6358_CLK_SAR,
+	}, {
+		.name = "emusb",
+		.bit = BCM6358_CLK_EMUSB,
+	}, {
+		.name = "enet0",
+		.bit = BCM6358_CLK_ENET0,
+	}, {
+		.name = "enet1",
+		.bit = BCM6358_CLK_ENET1,
+	}, {
+		.name = "usbsu",
+		.bit = BCM6358_CLK_USBSU,
+	}, {
+		.name = "ephy",
+		.bit = BCM6358_CLK_EPHY,
+	}, {
+		/* sentinel */
+	},
 };
 
 static const struct clk_bcm63xx_table_entry bcm6362_clocks[] = {
-	{ .name = "adsl_qproc", .bit = 1, },
-	{ .name = "adsl_afe", .bit = 2, },
-	{ .name = "adsl", .bit = 3, },
-	{ .name = "mips", .bit = 4, .flags = CLK_IS_CRITICAL, },
-	{ .name = "wlan_ocp", .bit = 5, },
-	{ .name = "swpkt_usb", .bit = 7, },
-	{ .name = "swpkt_sar", .bit = 8, },
-	{ .name = "sar", .bit = 9, },
-	{ .name = "robosw", .bit = 10, },
-	{ .name = "pcm", .bit = 11, },
-	{ .name = "usbd", .bit = 12, },
-	{ .name = "usbh", .bit = 13, },
-	{ .name = "ipsec", .bit = 14, },
-	{ .name = "spi", .bit = 15, },
-	{ .name = "hsspi", .bit = 16, },
-	{ .name = "pcie", .bit = 17, },
-	{ .name = "fap", .bit = 18, },
-	{ .name = "phymips", .bit = 19, },
-	{ .name = "nand", .bit = 20, },
-	{ },
+	{
+		.name = "adsl_qproc",
+		.bit = BCM6362_CLK_ADSL_QPROC,
+	}, {
+		.name = "adsl_afe",
+		.bit = BCM6362_CLK_ADSL_AFE,
+	}, {
+		.name = "adsl",
+		.bit = BCM6362_CLK_ADSL,
+	}, {
+		.name = "mips",
+		.bit = BCM6362_CLK_MIPS,
+		.flags = CLK_IS_CRITICAL,
+	}, {
+		.name = "wlan_ocp",
+		.bit = BCM6362_CLK_WLAN_OCP,
+	}, {
+		.name = "swpkt_usb",
+		.bit = BCM6362_CLK_SWPKT_USB,
+	}, {
+		.name = "swpkt_sar",
+		.bit = BCM6362_CLK_SWPKT_SAR,
+	}, {
+		.name = "sar",
+		.bit = BCM6362_CLK_SAR,
+	}, {
+		.name = "robosw",
+		.bit = BCM6362_CLK_ROBOSW,
+	}, {
+		.name = "pcm",
+		.bit = BCM6362_CLK_PCM,
+	}, {
+		.name = "usbd",
+		.bit = BCM6362_CLK_USBD,
+	}, {
+		.name = "usbh",
+		.bit = BCM6362_CLK_USBH,
+	}, {
+		.name = "ipsec",
+		.bit = BCM6362_CLK_IPSEC,
+	}, {
+		.name = "spi",
+		.bit = BCM6362_CLK_SPI,
+	}, {
+		.name = "hsspi",
+		.bit = BCM6362_CLK_HSSPI,
+	}, {
+		.name = "pcie",
+		.bit = BCM6362_CLK_PCIE,
+	}, {
+		.name = "fap",
+		.bit = BCM6362_CLK_FAP,
+	}, {
+		.name = "phymips",
+		.bit = BCM6362_CLK_PHYMIPS,
+	}, {
+		.name = "nand",
+		.bit = BCM6362_CLK_NAND,
+	}, {
+		/* sentinel */
+	},
 };
 
 static const struct clk_bcm63xx_table_entry bcm6368_clocks[] = {
-	{ .name = "vdsl_qproc", .bit = 2, },
-	{ .name = "vdsl_afe", .bit = 3, },
-	{ .name = "vdsl_bonding", .bit = 4, },
-	{ .name = "vdsl", .bit = 5, },
-	{ .name = "phymips", .bit = 6, },
-	{ .name = "swpkt_usb", .bit = 7, },
-	{ .name = "swpkt_sar", .bit = 8, },
-	{ .name = "spi", .bit = 9, },
-	{ .name = "usbd", .bit = 10, },
-	{ .name = "sar", .bit = 11, },
-	{ .name = "robosw", .bit = 12, },
-	{ .name = "utopia", .bit = 13, },
-	{ .name = "pcm", .bit = 14, },
-	{ .name = "usbh", .bit = 15, },
-	{ .name = "disable_gless", .bit = 16, },
-	{ .name = "nand", .bit = 17, },
-	{ .name = "ipsec", .bit = 18, },
-	{ },
+	{
+		.name = "vdsl_qproc",
+		.bit = BCM6368_CLK_VDSL_QPROC,
+	}, {
+		.name = "vdsl_afe",
+		.bit = BCM6368_CLK_VDSL_AFE,
+	}, {
+		.name = "vdsl_bonding",
+		.bit = BCM6368_CLK_VDSL_BONDING,
+	}, {
+		.name = "vdsl",
+		.bit = BCM6368_CLK_VDSL,
+	}, {
+		.name = "phymips",
+		.bit = BCM6368_CLK_PHYMIPS,
+	}, {
+		.name = "swpkt_usb",
+		.bit = BCM6368_CLK_SWPKT_USB,
+	}, {
+		.name = "swpkt_sar",
+		.bit = BCM6368_CLK_SWPKT_SAR,
+	}, {
+		.name = "spi",
+		.bit = BCM6368_CLK_SPI,
+	}, {
+		.name = "usbd",
+		.bit = BCM6368_CLK_USBD,
+	}, {
+		.name = "sar",
+		.bit = BCM6368_CLK_SAR,
+	}, {
+		.name = "robosw",
+		.bit = BCM6368_CLK_ROBOSW,
+	}, {
+		.name = "utopia",
+		.bit = BCM6368_CLK_UTOPIA,
+	}, {
+		.name = "pcm",
+		.bit = BCM6368_CLK_PCM,
+	}, {
+		.name = "usbh",
+		.bit = BCM6368_CLK_USBH,
+	}, {
+		.name = "disable_gless",
+		.bit = BCM6368_CLK_DIS_GLESS,
+	}, {
+		.name = "nand",
+		.bit = BCM6368_CLK_NAND,
+	}, {
+		.name = "ipsec",
+		.bit = BCM6368_CLK_IPSEC,
+	}, {
+		/* sentinel */
+	},
 };
 
 static const struct clk_bcm63xx_table_entry bcm63268_clocks[] = {
-	{ .name = "disable_gless", .bit = 0, },
-	{ .name = "vdsl_qproc", .bit = 1, },
-	{ .name = "vdsl_afe", .bit = 2, },
-	{ .name = "vdsl", .bit = 3, },
-	{ .name = "mips", .bit = 4, .flags = CLK_IS_CRITICAL, },
-	{ .name = "wlan_ocp", .bit = 5, },
-	{ .name = "dect", .bit = 6, },
-	{ .name = "fap0", .bit = 7, },
-	{ .name = "fap1", .bit = 8, },
-	{ .name = "sar", .bit = 9, },
-	{ .name = "robosw", .bit = 10, },
-	{ .name = "pcm", .bit = 11, },
-	{ .name = "usbd", .bit = 12, },
-	{ .name = "usbh", .bit = 13, },
-	{ .name = "ipsec", .bit = 14, },
-	{ .name = "spi", .bit = 15, },
-	{ .name = "hsspi", .bit = 16, },
-	{ .name = "pcie", .bit = 17, },
-	{ .name = "phymips", .bit = 18, },
-	{ .name = "gmac", .bit = 19, },
-	{ .name = "nand", .bit = 20, },
-	{ .name = "tbus", .bit = 27, },
-	{ .name = "robosw250", .bit = 31, },
-	{ },
+	{
+		.name = "disable_gless",
+		.bit = BCM63268_CLK_DIS_GLESS,
+	}, {
+		.name = "vdsl_qproc",
+		.bit = BCM63268_CLK_VDSL_QPROC,
+	}, {
+		.name = "vdsl_afe",
+		.bit = BCM63268_CLK_VDSL_AFE,
+	}, {
+		.name = "vdsl",
+		.bit = BCM63268_CLK_VDSL,
+	}, {
+		.name = "mips",
+		.bit = BCM63268_CLK_MIPS,
+		.flags = CLK_IS_CRITICAL,
+	}, {
+		.name = "wlan_ocp",
+		.bit = BCM63268_CLK_WLAN_OCP,
+	}, {
+		.name = "dect",
+		.bit = BCM63268_CLK_DECT,
+	}, {
+		.name = "fap0",
+		.bit = BCM63268_CLK_FAP0,
+	}, {
+		.name = "fap1",
+		.bit = BCM63268_CLK_FAP1,
+	}, {
+		.name = "sar",
+		.bit = BCM63268_CLK_SAR,
+	}, {
+		.name = "robosw",
+		.bit = BCM63268_CLK_ROBOSW,
+	}, {
+		.name = "pcm",
+		.bit = BCM63268_CLK_PCM,
+	}, {
+		.name = "usbd",
+		.bit = BCM63268_CLK_USBD,
+	}, {
+		.name = "usbh",
+		.bit = BCM63268_CLK_USBH,
+	}, {
+		.name = "ipsec",
+		.bit = BCM63268_CLK_IPSEC,
+	}, {
+		.name = "spi",
+		.bit = BCM63268_CLK_SPI,
+	}, {
+		.name = "hsspi",
+		.bit = BCM63268_CLK_HSSPI,
+	}, {
+		.name = "pcie",
+		.bit = BCM63268_CLK_PCIE,
+	}, {
+		.name = "phymips",
+		.bit = BCM63268_CLK_PHYMIPS,
+	}, {
+		.name = "gmac",
+		.bit = BCM63268_CLK_GMAC,
+	}, {
+		.name = "nand",
+		.bit = BCM63268_CLK_NAND,
+	}, {
+		.name = "tbus",
+		.bit = BCM63268_CLK_TBUS,
+	}, {
+		.name = "robosw250",
+		.bit = BCM63268_CLK_ROBOSW250,
+	}, {
+		/* sentinel */
+	},
 };
 
 static int clk_bcm63xx_probe(struct platform_device *pdev)
-- 
2.27.0

