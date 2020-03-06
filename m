Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB4CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F45207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQyzRFDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCFKUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:20:17 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37453 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:20:16 -0500
Received: by mail-yw1-f68.google.com with SMTP id g206so1729977ywb.4;
        Fri, 06 Mar 2020 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZtPV4lyilADfqy1eD7YIQ/XfyrDcGPt4PIlFlX/erI=;
        b=bQyzRFDo+Vb/MswGw+eHElqyqGb3zJ0MWFv0WK6p0ACeczEHSnMryHED7qFSgioL1u
         ZrXaPm0ePM6GoyFxEkW+IRFcu18hwLzdLW4X3oME9tiS72gbt9P5EBimS/62i8QBQjTY
         IyL0P29Zjat1c2UWDQcdCMS2LCdflmaEc+LzAdD3ATQOtCmX2lu1Hn+m1QS8uK5L+sJ9
         9Fks3eEusAer9qGOilctBHANj11MWxnB6W3eIXNjrf3So6IDXOeY+Rs992jHykbD8Pcs
         U5fajFIk5S/WaQre6PSWpN21cJSE0D2dkxfBZlZ8ax55G67e23jIkvFZIMgwx5WhkFuq
         gznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZtPV4lyilADfqy1eD7YIQ/XfyrDcGPt4PIlFlX/erI=;
        b=CEFn6wpHr1mza7WLj8HwsElrCLSDbV7FaeD2KXMnK9Rkp+vAl9NrBtw3jBp04RWrwy
         U97bknHSXy12dwlWjR7C/19GY3CeeZwAxWiXG06tXcmWXQ0ZwPquuSKc7RwbOECKfksk
         FSA0Fl/m6HWzarVl/6G/A7IGD/IgMCjQltSvpJ560UG1IBjJItzO9kBpnhtI0KtXJ/oM
         PCjdpGg/yFhJpGA+GgP5kU2Hmm3o7wqC/+5Z1S0Et4hamh54FucVfJWrad6SlO0Ce1xl
         uo/BhqCgejz6GO4bD+h1LYBUUlgbe/t1483G2oiGNaeQhPBi/KBjYI7fqM/T9+jHJVuB
         FDfQ==
X-Gm-Message-State: ANhLgQ2wM62ZFpFN0IWu8Ss65K8pH3hvbj7sQfxIrZicOywXHbgyV/oq
        LVgqktCTCq5J5z8X7A9580k=
X-Google-Smtp-Source: ADFU+vteD7dUx1U48uUDIL7XDGNdrDmdW0/Uf18cgj4qg//uICALRMG5MYEWvbGkTm+FC7YAoWjqEA==
X-Received: by 2002:a81:5e09:: with SMTP id s9mr3248359ywb.348.1583490014862;
        Fri, 06 Mar 2020 02:20:14 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id p2sm13978658ywd.58.2020.03.06.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:20:14 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64: dts: enable fspi in imx8mm dts
Date:   Fri,  6 Mar 2020 04:19:57 -0600
Message-Id: <20200306101957.1229406-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull in upstream patch from NXP repo to:
enable fspi in imx8mm DT file

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3: Move flexspi to order the unit address.
V2: Reorder s-o-b lines to give credit in proper order.

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 1e5e11592f7b..7e6c0722afa6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -558,7 +558,8 @@ aips3: bus@30800000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x30800000 0x30800000 0x400000>;
+			ranges = <0x30800000 0x30800000 0x400000>,
+				 <0x8000000 0x8000000 0x10000000>;
 
 			ecspi1: spi@30820000 {
 				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
@@ -760,6 +761,19 @@ usdhc3: mmc@30b60000 {
 				status = "disabled";
 			};
 
+			flexspi: spi@30bb0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_QSPI_ROOT>,
+					 <&clk IMX8MM_CLK_QSPI_ROOT>;
+				clock-names = "fspi", "fspi_en";
+				status = "disabled";
+			};
+
 			sdma1: dma-controller@30bd0000 {
 				compatible = "fsl,imx8mm-sdma", "fsl,imx8mq-sdma";
 				reg = <0x30bd0000 0x10000>;
-- 
2.25.0

