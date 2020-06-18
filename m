Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3025BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11F220656
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NUjfXVK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgFROA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:00:28 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:52085 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgFROAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592488817; x=1624024817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFBBeUdsgnPsuFvnRzCF7Y44JOpXgF4o3vVcEbdN1KY=;
  b=NUjfXVK1j6+3u+Y+er+IW6i5PLYOf8vDs1r2QLys+VdFRSDhbIPz3B0I
   JnVXW5g3qmxW7ou8PEstijM4vzarUxpI8PtbD7uWd2EyMcxo6QsMFDRDZ
   TpWvarDfboLr5848AqyLzPSIG1k+ylie/UFD9VAuNBClxJCuLUr8lTuSK
   6eLOm1NnglOBl77jYaPY4nK4+pLGCrPLXccqcgzNKC2nYBWUiUCKWVbW0
   4lmUM8rKUAFxER0s3hv3wvmmUkJ+N3yb/kX2WLl9BKHw/uVwCYrDdjDpq
   9phWvPVE28by48n5SDMcwWLk2CI4+8Jq9pM7a+cptB8I03AGEkXRV83ER
   g==;
IronPort-SDR: fHJmfuPB40utm2y2txw+RULjrzSuEFsZDJi3GD5QFTnuqv4sc4BCu1RV9TjtKHaMPQJoPuwTSG
 3baw0cuCx7ZSb+6ivesYUX8IByWE3tPx/2iTMTFa73KbSBAcdFfl86jC6mj29pcaDQGmg3KGEF
 0fId0Ih3SUXpNsYUKWI7PgWlxgAmKHeD09fhnyoYZkvH5Ea3M5sx7o1Snz5zBffcTDZB9V68OT
 CT3qAS1KvlPi7QHAERSNa7F8Hjxk9qAqxp26e5+CfUdFjQnqtC2ysQYs6L2JFgOVpQhfHYZ5er
 9iw=
X-IronPort-AV: E=Sophos;i="5.73,526,1583218800"; 
   d="scan'208";a="78949046"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 07:00:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 07:00:09 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Jun 2020 07:00:13 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 2/3] arm64: dts: sparx5: Add hwmon temperature sensor
Date:   Thu, 18 Jun 2020 15:59:50 +0200
Message-ID: <20200618135951.25441-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618135951.25441-1-lars.povlsen@microchip.com>
References: <20200618135951.25441-1-lars.povlsen@microchip.com>
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
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index c9dbd1a8b22b6..7e811e24f0e99 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -244,5 +244,12 @@ i2c1: i2c@600103000 {
 			clock-frequency = <100000>;
 			clocks = <&ahb_clk>;
 		};
+
+		tmon0: tmon@610508110 {
+			compatible = "microchip,sparx5-temp";
+			reg = <0x6 0x10508110 0xc>;
+			#thermal-sensor-cells = <0>;
+			clocks = <&ahb_clk>;
+		};
 	};
 };
-- 
2.27.0

