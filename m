Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF0C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47D8204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xsUR00wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbgEMNmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:42:31 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:60431 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589377351; x=1620913351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PV07J/wAT10xDYr9kx06zNqja/xgCGRaYSoB57UP5EA=;
  b=xsUR00wgiYPKZwHX8VDkx4Lsd2Khp2/qLniLVmrSvoejRO7iP7xXqak/
   UE7Ib/MfA7jM5AKv+EE0SHWnOr3Ka9E/frBGZXcgKG3VQxRefk+JchcZo
   S/3hbNAj2b9C5q4TXglbWzxT1cCqr/qYVsW1Zz48wQq5WHIbbp7QCiQsL
   zgS1Jir82++Gvc2yb/9a6bRZr0GPHrvCh05nl7HJWA5ixfENHD+2awTun
   AsB0xiv+3IdVegPZhvO/+99pVCdCcJ7ymHHHaZw/N0H6bI2QlEHEU/Uz+
   wiTx8hudb9YggQTeosecKLMv55Ha6gqWr1xj0eOeiMnxB2s2Y+p5o6hYL
   Q==;
IronPort-SDR: G9KdmkzZxo6j5xx25DGIDDmDefKyX/w0bsG8CdPIn9a7RBFlaLp2vc0dkyZa4XLPoBOrBXuZGg
 CY87CN9ml9fv7a9axPhgMkERYAcnXBh2MAKZlDARR7BdY7lcK3qBYJvsYXyhUybUomFPjFzLBe
 Tw1O5C+jE5+AO4u5VEYTBhKteWPbnnr91XKTO91NfAHrwxMbTxtOs8IPJ887vLcal9YVO13RZ/
 fqZvORksXotyjqiGYNIzioj1uG4UvI0XXMJpqnIhcnJy2G8msgEoU+gEysh2QMhaovgs5A7rRs
 GL0=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="75771963"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:41:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:41:55 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:41:53 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] arm64: dts: sparx5: Add hwmon temperature sensor
Date:   Wed, 13 May 2020 15:41:39 +0200
Message-ID: <20200513134140.25357-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513134140.25357-1-lars.povlsen@microchip.com>
References: <20200513134140.25357-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a hwmon temperature node sensor to the Sparx5 SoC.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index f09a49c41ce19..b5f2d088af30e 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -233,5 +233,11 @@ i2c1: i2c@600103000 {
 			clock-frequency = <100000>;
 			clocks = <&ahb_clk>;
 		};
+
+		tmon0: tmon@610508110 {
+			compatible = "microchip,sparx5-temp";
+			reg = <0x6 0x10508110 0xc>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 };
--
2.26.2
