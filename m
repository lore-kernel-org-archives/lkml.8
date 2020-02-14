Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731A0C3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1EA24654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696257;
	bh=kxpirQj5IrgXL6otZ76CxHFPJdZleVRuEeL9JZvpVKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKtikYSJ8lvcMoz3ZiFAM+/rS70E9gt0qRAS/H/rFORWKt1XO9AOnkQU0kofOLDrx
	 8fDx/akmguIF3dJRWcM7yBIrL5VTdMazV36tIRq20oWX2emMldzojciJA5Zf1J5s9I
	 JE5FAj9p92OActpBxF+4Dqscua5SvlCZGzYau4Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbgBNQEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:04:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389830AbgBNQEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:04:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B3A2187F;
        Fri, 14 Feb 2020 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696241;
        bh=kxpirQj5IrgXL6otZ76CxHFPJdZleVRuEeL9JZvpVKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIQtj4C8Up9oKzBxG8wToXmRNZPMkKdoPgmtNcU2GjoH10wNbkrqnLC4/12Z5uK6r
         PYXKVitbEuHVFQpRur1shR8zrhfY7NRAZQw3mtQ5t6ZMELlkw94XVdKvqCJvKJT29Q
         QBema4Z2bnwXI04QsDYFadJ8YeHFAw6biMLoA3M8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 100/459] rtc: i2c/spi: Avoid inclusion of REGMAP support when not needed
Date:   Fri, 14 Feb 2020 10:55:50 -0500
Message-Id: <20200214160149.11681-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 34719de919af07682861cb0fa2bcf64da33ecf44 ]

Merely enabling I2C and RTC selects REGMAP_I2C and REGMAP_SPI, even when
no driver needs it.  While the former can be moduler, the latter cannot,
and thus becomes built-in.

Fix this by moving the select statements for REGMAP_I2C and REGMAP_SPI
from the RTC_I2C_AND_SPI helper to the individual drivers that depend on
it.

Note that the comment for RTC_I2C_AND_SPI refers to SND_SOC_I2C_AND_SPI
for more information, but the latter does not select REGMAP_{I2C,SPI}
itself, and defers that to the individual drivers, too.

Fixes: 080481f54ef62121 ("rtc: merge ds3232 and ds3234")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20200112171349.22268-1-geert@linux-m68k.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 1adf9f8156522..5efc6af539c0d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -859,14 +859,14 @@ config RTC_I2C_AND_SPI
 	default m if I2C=m
 	default y if I2C=y
 	default y if SPI_MASTER=y
-	select REGMAP_I2C if I2C
-	select REGMAP_SPI if SPI_MASTER
 
 comment "SPI and I2C RTC drivers"
 
 config RTC_DRV_DS3232
 	tristate "Dallas/Maxim DS3232/DS3234"
 	depends on RTC_I2C_AND_SPI
+	select REGMAP_I2C if I2C
+	select REGMAP_SPI if SPI_MASTER
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS3232 and DS3234 real-time clock chips. If an interrupt is associated
@@ -886,6 +886,8 @@ config RTC_DRV_DS3232_HWMON
 config RTC_DRV_PCF2127
 	tristate "NXP PCF2127"
 	depends on RTC_I2C_AND_SPI
+	select REGMAP_I2C if I2C
+	select REGMAP_SPI if SPI_MASTER
 	select WATCHDOG_CORE if WATCHDOG
 	help
 	  If you say yes here you get support for the NXP PCF2127/29 RTC
@@ -902,6 +904,8 @@ config RTC_DRV_PCF2127
 config RTC_DRV_RV3029C2
 	tristate "Micro Crystal RV3029/3049"
 	depends on RTC_I2C_AND_SPI
+	select REGMAP_I2C if I2C
+	select REGMAP_SPI if SPI_MASTER
 	help
 	  If you say yes here you get support for the Micro Crystal
 	  RV3029 and RV3049 RTC chips.
-- 
2.20.1

