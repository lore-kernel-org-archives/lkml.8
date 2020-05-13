Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C3CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3930E24932
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dLSr9niX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbgEMM5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:57:20 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:41632 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgEMM5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589374633; x=1620910633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aUjp6oy3r1TDYSdccq62Ov16XGvhgsJHPueAfKWciMA=;
  b=dLSr9niXT+f2++/Xq5tuOWBun4m1bs1o9Wmez2tieX7hHHd6e9u/v4AX
   GEveESoHtaGRTXy6CvxV9f8gK3jBKZzh3scNrBBQGcsgZzqA1GTDR2t8q
   oDxHl/6M+U73jHINb/8VuMIdadB1Kw+602DQhWoBDl/pi9dwXjBj4ttZT
   YD8KltXuhc9O/VHb2Y+Waa/ZT6QHLktAqQo6p/0GI7cgMIyxIrecRXhCW
   r+CSxl4f8y1WjzlJWoM76uFAaC1H55WlJwM30zZlZIfNHKpM67JchYZob
   NUmBvhYK/QNvTD8czwqRUgmDpUPu1wLrLc/iRHnb9ALgdOFayN/TmUQqZ
   w==;
IronPort-SDR: 6OmNHJS2iNRdv0z5Pazs+fRJZRz1K+xhXuTj+efWI5TEbf9FRG5Etpqx1HbOqVemDE+Qjpdwo1
 eUBy38odCPmHHSW+HZRbMBGegkhYtx0NHhUewpAATP5eTSOzzDfYc+MLjc7DGnBizKoFuR1hOK
 vMwkqnV+puIQOgKvSv6ILJwOlhzr4Ws53zVL+Zxmwjtxp5IBsal3BZu0/+QHJTQQtfyMC0fZP5
 CNCjS88/dPM5YfULX+pvPfvf/oesrmb2W20FGSnswNJMDK7Q55L9nw8B1/TCW6Hnurx82YSMRM
 wUQ=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="79436370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 05:57:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 05:57:14 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 05:57:09 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Olof Johansson <olof@lixom.net>,
        "Michael Turquette" <mturquette@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 13/14] arm64: dts: sparx5: Add Sparx5 SoC DPLL clock
Date:   Wed, 13 May 2020 14:55:31 +0200
Message-ID: <20200513125532.24585-14-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513125532.24585-1-lars.povlsen@microchip.com>
References: <20200513125532.24585-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a DPLL clock to the Sparx5 SoC. It is used to generate clock
to misc peripherals, specifically the SDHCI/eMMC controller.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 45a60993789c8..ca4055f04ac26 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -82,6 +82,11 @@ sys_clk: sys-clk {
 			#clock-cells = <0>;
 			clock-frequency = <625000000>;
 		};
+		clks: clks@61110000c {
+			compatible = "microchip,sparx5-dpll";
+			#clock-cells = <1>;
+			reg = <0x6 0x1110000c 0x24>;
+		};
 	};

 	axi: axi@600000000 {
--
2.26.2
