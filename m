Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CB0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0FF20709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGTHxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:53:04 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47131 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgGTHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:52:59 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7BF541C000E;
        Mon, 20 Jul 2020 07:52:56 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: ds1374: fix RTC_DRV_DS1374_WDT dependencies
Date:   Mon, 20 Jul 2020 09:52:49 +0200
Message-Id: <20200720075250.1019172-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not enough to select WATCHDOG_CORE, the watchdog part of the driver
now also depends on WATCHDOG. This is currently the best we can do because
alarm support and watchdog support are mutually exclusive.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index c25d51f35f0c..2753e0f54cc3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -281,8 +281,8 @@ config RTC_DRV_DS1374
 
 config RTC_DRV_DS1374_WDT
 	bool "Dallas/Maxim DS1374 watchdog timer"
-	depends on RTC_DRV_DS1374
-	select WATCHDOG_CORE if WATCHDOG
+	depends on RTC_DRV_DS1374 && WATCHDOG
+	select WATCHDOG_CORE
 	help
 	  If you say Y here you will get support for the
 	  watchdog timer in the Dallas Semiconductor DS1374
-- 
2.26.2

