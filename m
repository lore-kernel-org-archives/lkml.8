Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58343C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A4C2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ilb28TMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgIDPW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgIDPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DB9C061258
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:21:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so6427725wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uif8G7qHTGRhCmGeHPmCwg86SJ2eGD23rP8ij/IiTw=;
        b=Ilb28TMfg4uo67ZfwyzeEk/tbFpBcLHskbaHfCkZefZJv7c+N6XEFnVT439XAFb9k1
         V5++oXIEY4Rv03Opj/9JbiTlh/NceXPQ3QvwqTc72OXlDwNCruSfXHpO83w9S4sxswKN
         MPC839CR5hdleTR+524c8W5Qan0HT7ad8o9uZT+S4On2phkJPxsBGe8/bU2rQgWuwNnf
         gbCzfDb9Ko/gv8iEsXU3d6+Xw66zCeBvl/tZgoZThGvcswPv4EpKNhrxwcpYHG28nTDj
         ngiqTYQucFKxuvq8QILU8vUMW+Y4IkCyOqYuQebPZRmdxr6WZZBM7kI856d4EovK8ecA
         pdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uif8G7qHTGRhCmGeHPmCwg86SJ2eGD23rP8ij/IiTw=;
        b=H49m1fCP5n7d95/qZOkD8mOCBCI6Q/cunGzo3xprM0+F6yH4lUYxV1ZfouxKe/FdaA
         qAi/JTDo0R52UZ/UyI4rzDxiWilE1OJZ6isrHSG4seQvpyNLn3DKLhHpoMgX6mfGEg2q
         6qp/S2pIClSERDwEPFipW1F2C3yQgTN86ds7djbfRmb6o4Cwwbd7K7AQkfmSQEPTGkQx
         wZw2iXM8ai83QJsLgyD4+JDFFBk/MAnTfVziIAOPFrvI3cQlIeFq7E/oZTvHWHSyENbD
         92816RnM4xfkyEX49MeRuo3Yt7fElwiJrWRJ/eTAI1aJ7u3wda1vpAWTbVna2Vs0RAQe
         iDFQ==
X-Gm-Message-State: AOAM5329ioj8yw3QDdmuzEjJAVNAeEE3PEd9b+J69w0g/h2G7VDU9l70
        m/T8X9RIkgQiZ70tGNg9IQruIA==
X-Google-Smtp-Source: ABdhPJwReXIbSBcaWjilKYJdCmgalWKDDkGAhjHOmGsTWimou4pWtVIAHL5BLnlyUHrs9otkFQskoQ==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr8606644wme.159.1599232886611;
        Fri, 04 Sep 2020 08:21:26 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id a11sm7789534wmm.18.2020.09.04.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:21:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/8] rtc: rx8010: rename ret to err in rx8010_set_time()
Date:   Fri,  4 Sep 2020 17:21:12 +0200
Message-Id: <20200904152116.2157-5-brgl@bgdev.pl>
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

