Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0845C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A92D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gb8G4Fxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIJVl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbgIJNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:05:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C466C061799
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so5571078wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uif8G7qHTGRhCmGeHPmCwg86SJ2eGD23rP8ij/IiTw=;
        b=gb8G4Fxh3KQ3n8CxPbVo6AHusqeWeHNuQJv14YbC8w5o71a/LD/mUEJs06V1WBrKsI
         ujHkimYi85EqYVCRha+Jv5LxryYkLKVNKolPcztATkaHBYykPu8IauwcsofY7ObUlh4j
         d5bv/pRE2isIvJo3a5oINc0ZQ4AT+WnOfOwTFnA+iR3vtpuLRxVByd8sBQrkV2CjpgkS
         aR4E/HefjSqMtrwz0b9+aKqB3B4TLfPvoL7QH+UXIrgkegP9kdGroVBwwtbb78V4Bm+5
         5Q53aou/xPtCJuJIMx12893gxth82y4pJrhmBGrIWGiZ67NNr3kor/VjBNynOttHGylu
         J7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uif8G7qHTGRhCmGeHPmCwg86SJ2eGD23rP8ij/IiTw=;
        b=TDU/ALM9mCY1M3C7+QTYFbj0vgtGmREiVLXNEnstYO4/AyUc27uLvD0FFW4YGTiCgd
         608k68uRd8ScQf/XLJmuU8qmpO3seGA6tANgpN2oFVmkEbZNYIHHfi6Yq9T7S/BJrGCO
         XaXXxq08CJ7TTndUxixbJPYJ/WtxedeIbaEvr0+1kI8GfGDpIy+0l9xvV0XIk8ZB/JJT
         dJwJ34g0HUTX0NIBkWoE0ANDHUROfWNSRpuPigsmcPLCwb9Qodita6T4taF3DmNm6LYL
         6Pu7GT0UiY+23cjpmY2aX25op7N8QmQIHEKTAEdJYbUC5vy8NhkYq/hvebHORMHjBXyE
         hkOQ==
X-Gm-Message-State: AOAM531asbaxhOVgQhysiohs0EIYJDfJx8kbsyVXLzyk4z4xYFFHx6R1
        G3XsgkSXD7g7A8s47ExU97nrng==
X-Google-Smtp-Source: ABdhPJyicW4ns45b8xZhcFkK1PbXfBjeX/nBAc4igspZuSMMeFcb4ULvJxC9mxlgL33Lek65yIZOWA==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr8868118wmh.31.1599743101924;
        Thu, 10 Sep 2020 06:05:01 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id p16sm9321988wro.71.2020.09.10.06.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:05:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 04/11] rtc: rx8010: rename ret to err in rx8010_set_time()
Date:   Thu, 10 Sep 2020 15:04:39 +0200
Message-Id: <20200910130446.5689-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200910130446.5689-1-brgl@bgdev.pl>
References: <20200910130446.5689-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All other functions in this driver use 'err' for integer return values.
Do the same in rx8010_set_time() for consistency.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 2038700a3e8e..67ff06a76629 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -140,7 +140,7 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
 	u8 date[7];
-	int ctrl, flagreg, ret;
+	int ctrl, flagreg, err;
 
 	if ((dt->tm_year < 100) || (dt->tm_year > 199))
 		return -EINVAL;
@@ -150,10 +150,10 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 	if (ctrl < 0)
 		return ctrl;
 	rx8010->ctrlreg = ctrl | RX8010_CTRL_STOP;
-	ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
+	err = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
 					rx8010->ctrlreg);
-	if (ret < 0)
-		return ret;
+	if (err < 0)
+		return err;
 
 	date[RX8010_SEC - RX8010_SEC] = bin2bcd(dt->tm_sec);
 	date[RX8010_MIN - RX8010_SEC] = bin2bcd(dt->tm_min);
@@ -163,27 +163,27 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 	date[RX8010_YEAR - RX8010_SEC] = bin2bcd(dt->tm_year - 100);
 	date[RX8010_WDAY - RX8010_SEC] = bin2bcd(1 << dt->tm_wday);
 
-	ret = i2c_smbus_write_i2c_block_data(rx8010->client,
+	err = i2c_smbus_write_i2c_block_data(rx8010->client,
 					     RX8010_SEC, 7, date);
-	if (ret < 0)
-		return ret;
+	if (err < 0)
+		return err;
 
 	/* clear STOP bit after changing clock/calendar */
 	ctrl = i2c_smbus_read_byte_data(rx8010->client, RX8010_CTRL);
 	if (ctrl < 0)
 		return ctrl;
 	rx8010->ctrlreg = ctrl & ~RX8010_CTRL_STOP;
-	ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
+	err = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
 					rx8010->ctrlreg);
-	if (ret < 0)
-		return ret;
+	if (err < 0)
+		return err;
 
 	flagreg = i2c_smbus_read_byte_data(rx8010->client, RX8010_FLAG);
 	if (flagreg < 0)
 		return flagreg;
 
 	if (flagreg & RX8010_FLAG_VLF)
-		ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG,
+		err = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG,
 						flagreg & ~RX8010_FLAG_VLF);
 
 	return 0;
-- 
2.26.1

