Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35652C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106292465B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgA0WRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:17:33 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59945 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA0WRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 17:17:32 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6E90F60002;
        Mon, 27 Jan 2020 22:17:30 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: Kconfig: select REGMAP_I2C when necessary
Date:   Mon, 27 Jan 2020 23:17:24 +0100
Message-Id: <20200127221724.10160-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127221724.10160-1-alexandre.belloni@bootlin.com>
References: <20200127221724.10160-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some i2c RTC drivers are using regmap but are not selecting REGMAP_I2C
which may lead to build failures.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 01af948a7fc2..e66c64dd18bf 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -240,6 +240,7 @@ config RTC_DRV_AS3722
 
 config RTC_DRV_DS1307
 	tristate "Dallas/Maxim DS1307/37/38/39/40/41, ST M41T00, EPSON RX-8025, ISL12057"
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for various compatible RTC
 	  chips (often with battery backup) connected with I2C. This driver
@@ -621,6 +622,7 @@ config RTC_DRV_RX8010
 
 config RTC_DRV_RX8581
 	tristate "Epson RX-8571/RX-8581"
+	select REGMAP_I2C
 	help
 	  If you say yes here you will get support for the Epson RX-8571/
 	  RX-8581.
@@ -648,6 +650,7 @@ config RTC_DRV_EM3027
 
 config RTC_DRV_RV3028
 	tristate "Micro Crystal RV3028"
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the Micro Crystal
 	  RV3028.
@@ -677,6 +680,7 @@ config RTC_DRV_S5M
 
 config RTC_DRV_SD3078
 	tristate "ZXW Shenzhen whwave SD3078"
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the ZXW Shenzhen whwave
 	  SD3078 RTC chips.
-- 
2.24.1

