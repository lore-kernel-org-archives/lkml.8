Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27137C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0611A20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="YYX1Qo7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgBMS4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:56:19 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:44609 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgBMS4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:56:18 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6EA2122F9C;
        Thu, 13 Feb 2020 19:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1581620173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9an3iRVq2YjIPfUhYxOoLpl1wuu7J1Z3FBZN8OEzMp4=;
        b=YYX1Qo7Rs5XhmvPZejBWD6p/KoWkO9d5YsN0SaQ96glLZGpziObPS2TFDC7CncV2UmbpD2
        8xXQMIuFMJ3RsLc/MRs6EcORpgWLZIrDUjfvVEusE/Ol0vLj8V4vu/UBFTr7pjCliSgfR+
        cpHNY7y6PlPwxYOHLI4WTFVSXLhby58=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: add missing SPI nodes
Date:   Thu, 13 Feb 2020 19:56:06 +0100
Message-Id: <20200213185606.2747-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 6EA2122F9C
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.32.167.96:email,0.32.50.48:email,0.32.89.64:email,0.32.11.32:email];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.747];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1028A has three (dual) SPI controller. These are compatible with
the ones from the LS1021A. Add the nodes.

This was tested on a custom board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 36007d07ac6d..302f353e57db 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -290,6 +290,45 @@
 			status = "disabled";
 		};
 
+		dspi0: spi@2100000 {
+			compatible = "fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 1>;
+			spi-num-chipselects = <4>;
+			little-endian;
+			status = "disabled";
+		};
+
+		dspi1: spi@2110000 {
+			compatible = "fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2110000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 1>;
+			spi-num-chipselects = <4>;
+			little-endian;
+			status = "disabled";
+		};
+
+		dspi2: spi@2120000 {
+			compatible = "fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2120000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 1>;
+			spi-num-chipselects = <3>;
+			little-endian;
+			status = "disabled";
+		};
+
 		esdhc: mmc@2140000 {
 			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
-- 
2.20.1

