Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF0C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F27E20708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgEKODl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:03:41 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48817 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgEKODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:03:40 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DF38D240017;
        Mon, 11 May 2020 14:03:38 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] rtc: pcf2127: report battery switch over
Date:   Mon, 11 May 2020 16:03:35 +0200
Message-Id: <20200511140335.799133-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RTC_VL_BACKUP_SWITCH flag to report battery switch over
events.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2127.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 039078029bd4..e5e3cd128476 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -188,18 +188,27 @@ static int pcf2127_rtc_ioctl(struct device *dev,
 				unsigned int cmd, unsigned long arg)
 {
 	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
-	int touser;
+	int val, touser = 0;
 	int ret;
 
 	switch (cmd) {
 	case RTC_VL_READ:
-		ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &touser);
+		ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &val);
 		if (ret)
 			return ret;
 
-		touser = touser & PCF2127_BIT_CTRL3_BLF ? RTC_VL_BACKUP_LOW : 0;
+		if (val & PCF2127_BIT_CTRL3_BLF)
+			touser |= RTC_VL_BACKUP_LOW;
+
+		if (val & PCF2127_BIT_CTRL3_BF)
+			touser |= RTC_VL_BACKUP_SWITCH;
 
 		return put_user(touser, (unsigned int __user *)arg);
+
+	case RTC_VL_CLR:
+		return regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
+					  PCF2127_BIT_CTRL3_BF, 0);
+
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -493,7 +502,6 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	 */
 	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
 				 PCF2127_BIT_CTRL3_BTSE |
-				 PCF2127_BIT_CTRL3_BF |
 				 PCF2127_BIT_CTRL3_BIE |
 				 PCF2127_BIT_CTRL3_BLIE, 0);
 	if (ret) {
-- 
2.26.2

