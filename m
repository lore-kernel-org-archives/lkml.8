Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00CCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8509620786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v8tXmR+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgFPI0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:26:24 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19855 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFPI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592295982; x=1623831982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9zgZF5bF0PxY60Zea7h/pZzEv9hjVHtWCRJ66bY+LUo=;
  b=v8tXmR+BNSU7L4Dq/zFcXfS+RAy8HZ2X47RYTc04mZpGyprzSFwRz8g2
   h/k3lafyBLqZoEnjTTqrwApDQatZfS2lM1X5qLU0zvfbxrWvYIMBiCS2y
   Z7RBu1btksBK1TvL88VmJ2RQR+XEA+UhsOkeAbE5Z/pcFaKmKThoH+/MQ
   kx3sO2iPnIRjqI1W4SPydgVJEnZOYwddE4CwqOgBsmCHQMU9jCAgISdod
   LeLWNMsTkAulR0cO9T2FTHh0tz3HRyvxb1njYpjcHdvLlA5qCihJFJQB3
   hJz1jmW6x5+Wtp1729C3PFUHWeTQFzvcZtjLVkSRvSI6W1FCfjDjqFWif
   w==;
IronPort-SDR: nQLKe7M2JbKxcSEuN9o9/w/3B80GVtsqVwMNHg/UCcgFRRCfQH0sTMIGeM6Aa13NFsjjKR2Vko
 Zv1AArKEH1CaF8ZIamKCZYP1VgEtb4/KLVHqik52uqyYwhtFmyNMa609/IRbOTaxcUjp113oiJ
 nr9mLuyH0Azz5FHI6m/P3jqWuKcdJH5TkA1h+bE4TNT9w8yWYr46WiRqOIQT9Eln7ABDYkbVMd
 8IxNrS1VxOKHU3cg76/fJysE6Ov2Jx5uxYB6YRQTK2205YCK/uH6NTgUl0aBQJ1SmnnpWlBQ3y
 zhY=
X-IronPort-AV: E=Sophos;i="5.73,518,1583218800"; 
   d="scan'208";a="79621936"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2020 01:26:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 01:26:18 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 16 Jun 2020 01:26:16 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 2/3] arm64: dts: sparx5: Add hwmon temperature sensor
Date:   Tue, 16 Jun 2020 10:25:55 +0200
Message-ID: <20200616082556.27877-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616082556.27877-1-lars.povlsen@microchip.com>
References: <20200616082556.27877-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a hwmon temperature node sensor to the Sparx5 SoC.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index c9dbd1a8b22b6..49d4f289b9026 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -244,5 +244,11 @@ i2c1: i2c@600103000 {
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
2.27.0

