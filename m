Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFC5C43446
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE4121775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGTHxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:53:09 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55059 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgGTHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:53:00 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 205791BF20D;
        Mon, 20 Jul 2020 07:52:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: ds1374: remove unused define
Date:   Mon, 20 Jul 2020 09:52:50 +0200
Message-Id: <20200720075250.1019172-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720075250.1019172-1-alexandre.belloni@bootlin.com>
References: <20200720075250.1019172-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused define and fix typo where it should have been used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1374.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index c71065d26cd2..177d870bda0d 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -377,8 +377,6 @@ static const struct rtc_class_ops ds1374_rtc_ops = {
 #define TIMER_MARGIN_MIN	1
 #define TIMER_MARGIN_MAX	4095 /* 24-bit value */
 
-#define DRV_NAME "DS1374 Watchdog"
-
 static int wdt_margin;
 module_param(wdt_margin, int, 0);
 MODULE_PARM_DESC(wdt_margin, "Watchdog timeout in seconds (default 32s)");
@@ -389,7 +387,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default ="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT)")");
 
 static const struct watchdog_info ds1374_wdt_info = {
-	.identity       = "DS1374 WTD",
+	.identity       = "DS1374 Watchdog",
 	.options        = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
 						WDIOF_MAGICCLOSE,
 };
-- 
2.26.2

