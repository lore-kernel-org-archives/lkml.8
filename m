Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41751C2D0E1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001242074B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="B1Gh0qWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgIJVkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbgIJNGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:06:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F6C0617A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so6597570wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d3M68c+gKjavrjhZL6Hw37sOLz3mMgIonseWIHUXsKg=;
        b=B1Gh0qWRTUMtQUUGTtPv22uFz/eA/bqQLzh7LJleZjKTNq7LSV/tLZUasG2+gBqg/X
         f7ReYjeo5IopmKPvgH7P0NuoQ7s+r4AW6xq87jWKtCxVxmzqIvkjzky+ltf6WOOKwqLQ
         3TQ5+LnsuXX7ACDf2aoENVbKp2tkhk4OYvYfdejQjTBdiK3fDcE23MXQY1SpSvZm0EOY
         YmPtC84URmLsIAusLyF/uXbJdKQ0LVuU+uts0pzbiq3LE2GUEQV2UPMK5DHmiP8dXQjR
         SGUsQfII08SAJ6wSiagebKBfywG/jpmv0AbY4LZZ8XMchmIe2G9Qh4jPIDWfhh7UFaM1
         H/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3M68c+gKjavrjhZL6Hw37sOLz3mMgIonseWIHUXsKg=;
        b=qOOpdmVkFkmztrBuU0pb2UxftRcd+NXduNOY1XEphLO2NUrSjmkBP+cftuMTdToP4C
         a0oPyhbpU8eyFMjZS4VoTxrvh7+AYWvj+LmoWeCf5ZtRECD6C7F8eCbz0DxT6jeNYm1h
         +sPPsKGXyiJXehUc+/Owb11e8FOLtQIlMe6RQKWQv5Clqt0rx1eq1S94TlC/lYNsmSbR
         4+LWiKqOuRWyL8qRSGy1rjLzQowy5EFRcxnE+TnIRwqOKZm4mtGpIZFCfX5p0VIxVjwj
         wl+FdC1teup0fXhaoBPx6f9pzhQK+fSBTfauTnmlFw+M09j6VTMqagyJUgcO0mCaqZQc
         jLkQ==
X-Gm-Message-State: AOAM533KsHBJVVrZ5IpBgo6WpH+0X88exp8z43TctWjlcXig6AFSgi7l
        9/DEKS0oovCwYP1y3uQSrZSbdw==
X-Google-Smtp-Source: ABdhPJwr4zmWD1pKPf0ftvs/o1r1NeSvWsNX0YIaHg57u4rr9cjb5L/OY+yhtGwYgEo+nYQGcCWlGw==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr9186629wrv.139.1599743105450;
        Thu, 10 Sep 2020 06:05:05 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id p16sm9321988wro.71.2020.09.10.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:05:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 07/11] rtc: rx8010: use a helper variable for client->dev in probe()
Date:   Thu, 10 Sep 2020 15:04:42 +0200
Message-Id: <20200910130446.5689-8-brgl@bgdev.pl>
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

Simple 'dev' looks better then repeated &client->dev and has the added
benefit of avoiding unnecessary line breaks.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 3b8a95330a0a..e401d8ed0e19 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -409,6 +409,7 @@ static int rx8010_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
 	struct rx8010_data *rx8010;
 	int err = 0;
 
@@ -418,8 +419,7 @@ static int rx8010_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	rx8010 = devm_kzalloc(&client->dev, sizeof(struct rx8010_data),
-			      GFP_KERNEL);
+	rx8010 = devm_kzalloc(dev, sizeof(struct rx8010_data), GFP_KERNEL);
 	if (!rx8010)
 		return -ENOMEM;
 
@@ -431,14 +431,14 @@ static int rx8010_probe(struct i2c_client *client,
 		return err;
 
 	if (client->irq > 0) {
-		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
-		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+		dev_info(dev, "IRQ %d supplied\n", client->irq);
+		err = devm_request_threaded_irq(dev, client->irq, NULL,
 						rx8010_irq_1_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"rx8010", client);
 
 		if (err) {
-			dev_err(&client->dev, "unable to request IRQ\n");
+			dev_err(dev, "unable to request IRQ\n");
 			client->irq = 0;
 		} else {
 			rx8010_rtc_ops.read_alarm = rx8010_read_alarm;
@@ -447,11 +447,11 @@ static int rx8010_probe(struct i2c_client *client,
 		}
 	}
 
-	rx8010->rtc = devm_rtc_device_register(&client->dev, client->name,
+	rx8010->rtc = devm_rtc_device_register(dev, client->name,
 		&rx8010_rtc_ops, THIS_MODULE);
 
 	if (IS_ERR(rx8010->rtc)) {
-		dev_err(&client->dev, "unable to register the class device\n");
+		dev_err(dev, "unable to register the class device\n");
 		return PTR_ERR(rx8010->rtc);
 	}
 
-- 
2.26.1

