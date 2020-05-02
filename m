Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38AC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2613821974
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaInghGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgEBNAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgEBNAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:00:25 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A5C061A0C;
        Sat,  2 May 2020 06:00:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb4so6052261qvb.7;
        Sat, 02 May 2020 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kwbMlfQSR1Pqoy/79RUUNFt2eixa1c08qMSZ+873Tc=;
        b=DaInghGAsXiWWEbtudR3PREl/QYaGVlhziolqAO1iy/gQ6mSCCVWm4MJ9ScAojhPjd
         Yy7j3lphdH2oXJWz7aoSX107Ijs27xU/021K48++GJM83VWePR4ZcYIK1M/Z/YZaQQgG
         hLNhgUcIVTz/3BeT8v5Djfm3XBBJlASWAYbY1znowQWVvyroLJTR/F/pAmeRV7yOmPXT
         yydMj3JuOToRL5JqXM8o+wUCgoVUjPsleK2pTpgHxfnXDmAmuT22S7nwPtkUG9lpq5rD
         3XCYKtNtExYX0zp+AwfgKPV6zFp2dB5h+XP+fTiB/qPGdu1Qfpfuw6229c8+t44fcj8b
         osnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kwbMlfQSR1Pqoy/79RUUNFt2eixa1c08qMSZ+873Tc=;
        b=YBO6w+Y0NYzqJwQZzStyQXdX5rCfDjrpSm0W65Q+wWvrpFvidDz1su9I/J/ukY30Y2
         1PqXj/Ugr8epbLoyS6+VteLJ0l8AS2HPGkF5lTWmP7Y94rh9Me7SU7af342cpWPOssS8
         S9Ph1LJidxod3mowvPsV8T85pXZUHu8g4tiBmM6ipIa/N+XIQsxJ158NwqHEzHAieJ0D
         X/wu8YcIIsz2gXwvd0QilTQMG/RnD9o2YACoLomaLukdevs2DeYcvqQLNCMXntlMZOoz
         VqO9iZv8fX59VIg2oHQJfmI7ka8wEb3V+wfws1sPXkR0WqI2U66hFLp1Ih9/RQfazrfp
         F0jw==
X-Gm-Message-State: AGi0Pubru39d3ar4exUa9zKOqj/ZrdfgOiiWRqaiS05NwePrVu5xVZzj
        zG92tPGpcgcb9q5nzuEBkIA=
X-Google-Smtp-Source: APiQypL4ud5AXEGsm2wV1m5m08s8m7db7FSm5j+s/gbf4l05ArLHzm0zLuQ6R/RKitsjmOrjCivCgg==
X-Received: by 2002:a0c:9002:: with SMTP id o2mr6012949qvo.3.1588424423450;
        Sat, 02 May 2020 06:00:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l24sm5067668qtp.8.2020.05.02.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 06:00:22 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconemedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm: Add support for micfil
Date:   Sat,  2 May 2020 07:59:48 -0500
Message-Id: <20200502125949.194032-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502125949.194032-1-aford173@gmail.com>
References: <20200502125949.194032-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini has supports the MICFIL digital interface.
It's a 16-bit audio signal from a PDM microphone bitstream.
The driver is already in the kernel, but the node is missing.

This patch adds the micfil node.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c63685ae80ee..d46e727fc362 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -339,6 +339,25 @@ sai6: sai@30060000 {
 				status = "disabled";
 			};
 
+			micfil: micfil@30080000 {
+				compatible = "fsl,imx8mm-micfil";
+				reg = <0x30080000 0x10000>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_PDM_IPG>,
+					 <&clk IMX8MM_CLK_PDM_ROOT>,
+					 <&clk IMX8MM_AUDIO_PLL1_OUT>,
+					 <&clk IMX8MM_AUDIO_PLL2_OUT>,
+					 <&clk IMX8MM_CLK_EXT3>;
+				clock-names = "ipg_clk", "ipg_clk_app",
+					      "pll8k", "pll11k", "clkext3";
+				dmas = <&sdma2 24 25 0x80000000>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.25.1

