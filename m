Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2284CC04F80
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021E22072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFHfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:35:06 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47155 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgCFHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:35:04 -0500
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2C671E0011;
        Fri,  6 Mar 2020 07:35:01 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: ds1305: switch to rtc_tm_to_time64
Date:   Fri,  6 Mar 2020 08:34:59 +0100
Message-Id: <20200306073459.57197-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306073459.57197-1-alexandre.belloni@bootlin.com>
References: <20200306073459.57197-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit version of rtc_tm to time conversion.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1305.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index ca55ebab24fb..a3d790889eea 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -325,17 +325,13 @@ static int ds1305_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	u8		buf[1 + DS1305_ALM_LEN];
 
 	/* convert desired alarm to time_t */
-	status = rtc_tm_to_time(&alm->time, &later);
-	if (status < 0)
-		return status;
+	later = rtc_tm_to_time64(&alm->time);
 
 	/* Read current time as time_t */
 	status = ds1305_get_time(dev, &tm);
 	if (status < 0)
 		return status;
-	status = rtc_tm_to_time(&tm, &now);
-	if (status < 0)
-		return status;
+	now = rtc_tm_to_time64(&tm);
 
 	/* make sure alarm fires within the next 24 hours */
 	if (later <= now)
-- 
2.24.1

