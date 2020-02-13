Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B99C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC2F218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607849;
	bh=DIrkXbGb/ga3AX6/AEEose0jWcl44fW09Or1iBgmwOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pGd9T5jTvfl0jLLUSgd4k4YH5qrD2JVq4cwExjeguVvXHbCpsy5gF+RkPmSy8bpZO
	 8pe3eD5T3SKd1nHWYBWYDOkMfF/n12BR7xxC76Xc9OxUtEMpPSpWsoxtj36X37xTxZ
	 Yozn4IioGC02QFnyhxuY1Ni+78sBkIpQ3kYcv8ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgBMPat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgBMP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:31 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30444222C2;
        Thu, 13 Feb 2020 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607651;
        bh=DIrkXbGb/ga3AX6/AEEose0jWcl44fW09Or1iBgmwOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zez9xH6cksMXPOc2DCyt39QcAgAxntVfC/bOVKUdMiG1rniT+/wPNUgwlcbn55aTJ
         dRH2wPpqyOTBZuSJs5ArEf39JIcm7Nr8bbH92J3c9ZhqlkJFc6Cb+cl/XVUpKsps4Y
         tb6lCq1mEdojQ3MpRq4402YwBWlIaRpaXbsptBGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.4 36/96] rtc: i2c/spi: Avoid inclusion of REGMAP support when not needed
Date:   Thu, 13 Feb 2020 07:20:43 -0800
Message-Id: <20200213151853.109812966@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
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


