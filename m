Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F0C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5EE20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608504;
	bh=apdVoM1n0KbyCo2+Qj7vg+Z37yBrWQBTkDgIYKkM5Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dh2piAx82TNTap36jR+JHO+nz4HzXFVsxd5ZC2KhasbVi50777xL3iWLN1U7odpIW
	 mY74iUZbZgyDT9SUU7d1UtSWefnjB+fTmjVBNCnvs0eLhSA54ythO7cO1yq0knP78F
	 omsN3nOGuzu2UbpV5PgW6GORBdAFRG7fa0ypatM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgBMPln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbgBMP2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:31 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3F420661;
        Thu, 13 Feb 2020 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607711;
        bh=apdVoM1n0KbyCo2+Qj7vg+Z37yBrWQBTkDgIYKkM5Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcbX5L4par3glKAOUl2dteebJoW0OQRX7JB3b77ztNu0upn4AGw1YBlmcnBdMoBxm
         LV875aVW8g1hk29danxd6MZjBQW8rpPOFojGy/9Zj7fJLWDVk0+I/MsgCt5rjXldYo
         l0alELVJYqhwzo925Ivz1EUjzNX35aiOPnQngGCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.5 049/120] rtc: i2c/spi: Avoid inclusion of REGMAP support when not needed
Date:   Thu, 13 Feb 2020 07:20:45 -0800
Message-Id: <20200213151918.505301005@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit 34719de919af07682861cb0fa2bcf64da33ecf44 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/Kconfig |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -848,14 +848,14 @@ config RTC_I2C_AND_SPI
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
@@ -875,6 +875,8 @@ config RTC_DRV_DS3232_HWMON
 config RTC_DRV_PCF2127
 	tristate "NXP PCF2127"
 	depends on RTC_I2C_AND_SPI
+	select REGMAP_I2C if I2C
+	select REGMAP_SPI if SPI_MASTER
 	select WATCHDOG_CORE if WATCHDOG
 	help
 	  If you say yes here you get support for the NXP PCF2127/29 RTC
@@ -891,6 +893,8 @@ config RTC_DRV_PCF2127
 config RTC_DRV_RV3029C2
 	tristate "Micro Crystal RV3029/3049"
 	depends on RTC_I2C_AND_SPI
+	select REGMAP_I2C if I2C
+	select REGMAP_SPI if SPI_MASTER
 	help
 	  If you say yes here you get support for the Micro Crystal
 	  RV3029 and RV3049 RTC chips.


