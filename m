Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BF5C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E538D21739
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCFHiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:38:16 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57515 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgCFHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:38:10 -0500
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D71C3C000A;
        Fri,  6 Mar 2020 07:38:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] rtc: pm8xxx: : switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Fri,  6 Mar 2020 08:37:57 +0100
Message-Id: <20200306073758.58050-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306073758.58050-1-alexandre.belloni@bootlin.com>
References: <20200306073758.58050-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pm8xxx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 71bd56d32c90..2da0d80224c3 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -84,7 +84,7 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	if (!rtc_dd->allow_set_time)
 		return -EACCES;
 
-	rtc_tm_to_time(tm, &secs);
+	secs = rtc_tm_to_time64(tm);
 
 	dev_dbg(dev, "Seconds value to be written to RTC = %lu\n", secs);
 
@@ -208,7 +208,7 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
 	       ((unsigned long)value[3] << 24);
 
-	rtc_time_to_tm(secs, tm);
+	rtc_time64_to_tm(secs, tm);
 
 	dev_dbg(dev, "secs = %lu, h:m:s == %ptRt, y-m-d = %ptRdr\n", secs, tm, tm);
 
@@ -224,7 +224,7 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 
-	rtc_tm_to_time(&alarm->time, &secs);
+	secs = rtc_tm_to_time64(&alarm->time);
 
 	for (i = 0; i < NUM_8_BIT_RTC_REGS; i++) {
 		value[i] = secs & 0xFF;
@@ -280,7 +280,7 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
 	       ((unsigned long)value[3] << 24);
 
-	rtc_time_to_tm(secs, &alarm->time);
+	rtc_time64_to_tm(secs, &alarm->time);
 
 	rc = rtc_valid_tm(&alarm->time);
 	if (rc < 0) {
-- 
2.24.1

