Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C923C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2176420770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N2blinJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgIDPWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbgIDPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F35C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:21:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so7173241wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+NW3ywAC/uanmt42NpnVbbuokCChZKYNRWziVF2DC4=;
        b=N2blinJjlupo88maqUS5WAVYUyr4cxdQ/rPg+8LSJY7CEPEpxcFJhypybzP5x7Z/Nm
         yAJhPV3cpxBcd60hXygcgcH7AR+nGWKLfJ7Cv5dpnUe0tLctk2M9ZFINwnFcTZF3ydz7
         DlBED3Hz2zkW54uoD/Gtdl2ITJrjDCHDqDOEzOFM1KFx+luO59Nhad90V+4GY9Gfv8yl
         9n7/6UlXhxjWci5hFnYNAj6edZWfWEOSG25t4zJdYFZEvyp1qZEJPGXDVqW8BuWIiqlK
         IiSYTF/YNhPQh/feA5TbMizHcAvFnuKdOGYEuV4NsENV+rVTG76FVmKlFx31zFNA+Cdm
         21xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+NW3ywAC/uanmt42NpnVbbuokCChZKYNRWziVF2DC4=;
        b=DVT1EOpYCl3A/JT+e5VfdhXuZSnaoMkPrf2VIKcTmwipctk7z3GKkBIz8Lr7O+z3/1
         7IU/btjQAOeGE/8xBZvuQkF5uQtOuMBHhKIaq4NKjJz6a5sSubddOXw8iGnn7bouW3LG
         3XJD91oktGz9123HXICtRX9Vx+lSXWPdjnZLNFiCnvxA6aegCYGGLENzrXg3YhCNYi4F
         nS/PDj60XBGLkLNVIkdNjNoZDVzuVWqUU91tueO14Kpu4hsn4kwpeVc61igrBi0dqdpB
         hSH1XwA8xyySkhwjtwLMTQGY2r8XRCzD/hYvl0+TjdbJM9VXw0kUxNiZUCxqtzBOV8h2
         FWbA==
X-Gm-Message-State: AOAM5335OGeo/HVoPZ+gDSHaVonWFdcU1m9hp8XcRLg4sI0gs3hbzYdl
        a9ZX5i5CwULHc27r/vrIck2HSQ==
X-Google-Smtp-Source: ABdhPJyuKewa1rTm4mj8n8YuA7Q4/uIFSQWnj17ML08IvCmIMK67PeeWiPxQqKEku7qkH3WDhX5R1A==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr2605254wrp.224.1599232887545;
        Fri, 04 Sep 2020 08:21:27 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id a11sm7789534wmm.18.2020.09.04.08.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:21:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/8] rtc: rx8010: don't use magic values for time buffer length
Date:   Fri,  4 Sep 2020 17:21:13 +0200
Message-Id: <20200904152116.2157-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904152116.2157-1-brgl@bgdev.pl>
References: <20200904152116.2157-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The time buffer len is used directly in this driver. For readability
it's better to define a constant.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 67ff06a76629..f3bed7be2533 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -48,6 +48,8 @@
 
 #define RX8010_ALARM_AE		BIT(7)
 
+#define RX8010_TIME_BUF_LEN	7
+
 static const struct i2c_device_id rx8010_id[] = {
 	{ "rx8010", 0 },
 	{ }
@@ -108,7 +110,7 @@ static irqreturn_t rx8010_irq_1_handler(int irq, void *dev_id)
 static int rx8010_get_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
-	u8 date[7];
+	u8 date[RX8010_TIME_BUF_LEN];
 	int flagreg, err;
 
 	flagreg = i2c_smbus_read_byte_data(rx8010->client, RX8010_FLAG);
@@ -121,8 +123,8 @@ static int rx8010_get_time(struct device *dev, struct rtc_time *dt)
 	}
 
 	err = i2c_smbus_read_i2c_block_data(rx8010->client, RX8010_SEC,
-					    7, date);
-	if (err != 7)
+					    RX8010_TIME_BUF_LEN, date);
+	if (err != RX8010_TIME_BUF_LEN)
 		return err < 0 ? err : -EIO;
 
 	dt->tm_sec = bcd2bin(date[RX8010_SEC - RX8010_SEC] & 0x7f);
@@ -139,7 +141,7 @@ static int rx8010_get_time(struct device *dev, struct rtc_time *dt)
 static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
-	u8 date[7];
+	u8 date[RX8010_TIME_BUF_LEN];
 	int ctrl, flagreg, err;
 
 	if ((dt->tm_year < 100) || (dt->tm_year > 199))
@@ -164,7 +166,8 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 	date[RX8010_WDAY - RX8010_SEC] = bin2bcd(1 << dt->tm_wday);
 
 	err = i2c_smbus_write_i2c_block_data(rx8010->client,
-					     RX8010_SEC, 7, date);
+					     RX8010_SEC, RX8010_TIME_BUF_LEN,
+					     date);
 	if (err < 0)
 		return err;
 
-- 
2.26.1

