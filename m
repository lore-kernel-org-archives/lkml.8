Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FB3C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1675D20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CQYbnIbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgIJVlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgIJNFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:05:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF59C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so5570845wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QD4+/zp80KYG7+QlHWRWXdVVYXAehdvYKldSIelaUaw=;
        b=CQYbnIbSD26YR0Rot7mifqg+cBHViUddg7JwHyo/tXjL7FDc3L3E0Px8Qk34E1WtDc
         yFRPBve7pSGnToCwxzEjeXneObv1XyPPrQ71bANgQOaKCKmqyTpisaEEnUyb0fiuyhfB
         eviCALOu0ZoiGWodg5c71WVWdzfQMwht5gzh/mwbPSF9LAlH5ntsb2YkjQ+W95f8iFfp
         vLwcmf66YI9xGG5Pkid9W1C6E2E9vqF2kzdknAteqfsNNto5XgMykoe6nJIi8XAqRcfn
         W1Mta4aVPJEHft+D0xTr9CcclB0msG9bmnaSvc603HSUAR06RyMYldIUvJPLzASHEDnb
         jvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QD4+/zp80KYG7+QlHWRWXdVVYXAehdvYKldSIelaUaw=;
        b=hzRP54BGCUGfRrpC+KRWsBcENvqglHNijrPqJp+SOHLlz75HSWrHzOK6t8XfSyOYIL
         XppCQ31hDdPeDanAnuEy8lvBodfa6cId6cg4KHmKa5TB5sFY21xMfjHo/lhvMJ63RJE+
         kX7YVALgbPsrNbTNgKsxEVdIcJoAwj++Z59Jz4mdrwNuCUL0wcLY7kU29ChaVZjtHwsP
         QfTAyLWbfZyHIrj+v6HBhe4+zCXMB5dZaCWvC0tKMIBFCl6txx4zWUwmJBqj1m6qZCps
         v9VTVOLBt2D0D4ZP45OtUqPTU8qa8ayfWi778l6HyUNdYj1OQUSBzs5Q89av3pFvXQgL
         rhRw==
X-Gm-Message-State: AOAM533OdrYXOrQAbsLxGyRJNJMrO+qCQ1cWLi877XOCfsBeNPxLxl4u
        m25imrxZUxgIOjbcHEv2GZ7wHA==
X-Google-Smtp-Source: ABdhPJyQsgitJHjVQRLFHvNm0QyVkVrkhwOMOMP7nDl1jGSAcTayJaNDjKqgeto4lHEEdqJHg9IJ2Q==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr8763036wmc.85.1599743098541;
        Thu, 10 Sep 2020 06:04:58 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id p16sm9321988wro.71.2020.09.10.06.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:04:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/11] rtc: rx8010: remove unnecessary brackets
Date:   Thu, 10 Sep 2020 15:04:36 +0200
Message-Id: <20200910130446.5689-2-brgl@bgdev.pl>
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

Remove brackets wherever they guard a single line.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index fe010151ec8f..2faf5357a3a5 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -181,9 +181,8 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 		return ret;
 
 	flagreg = i2c_smbus_read_byte_data(rx8010->client, RX8010_FLAG);
-	if (flagreg < 0) {
+	if (flagreg < 0)
 		return flagreg;
-	}
 
 	if (flagreg & RX8010_FLAG_VLF)
 		ret = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG,
@@ -284,17 +283,15 @@ static int rx8010_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	int err;
 
 	flagreg = i2c_smbus_read_byte_data(client, RX8010_FLAG);
-	if (flagreg < 0) {
+	if (flagreg < 0)
 		return flagreg;
-	}
 
 	if (rx8010->ctrlreg & (RX8010_CTRL_AIE | RX8010_CTRL_UIE)) {
 		rx8010->ctrlreg &= ~(RX8010_CTRL_AIE | RX8010_CTRL_UIE);
 		err = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
 						rx8010->ctrlreg);
-		if (err < 0) {
+		if (err < 0)
 			return err;
-		}
 	}
 
 	flagreg &= ~RX8010_FLAG_AF;
-- 
2.26.1

