Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C7AC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9767720770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hG22uCLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgIDPWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgIDPV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20971C06124F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:21:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e11so7744125wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PF6iUUI6SI+SJ6z3aC7j/JhZxFAycexdCgWf22To5o=;
        b=hG22uCLiFR7asAwpfTFSwQU1iT/gHSJGscx3xXml/kyxE1JnDfx2MImY/2H1R8hLKJ
         KfCjg6MZKknAkIKZotyKG6V6+B4nonb97c3ZWtPawkNO8Jkk2A4zk1b4rjfuNlZFAIMP
         7Nengc5DlafgZ1S+i4Vx+EqWWER+cB9wNIsVMWDs8lbGwmw97s+ZL173l3s2Obdzotar
         ayKP7cRX4JqUx2ALb/DjcNiWn377sT5SR3DGB9Laa8iyUktr0lOizPQHLFHIvu6DI1kx
         i/crp9Xnio/Y+MqlzSjqheLANh0YjRxvrEgBrOsSZkzu7pWuJiKCVnHyQ9qzaIcp66vt
         JHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PF6iUUI6SI+SJ6z3aC7j/JhZxFAycexdCgWf22To5o=;
        b=gjrp8tb8iVMxd9AoFARBbao5v0c0C28G0iFwK3AhpagOc3bmGyvtHiAcqjxrwHVAVF
         6LLSdoKTCu9rg8bVgonAAc7jGi9+k9Pp/01r5tVLHLaXHESsiaPvZZyudiqPskoxDhKy
         O0Jlo8M3iopkJEYhY3oKu1/ULCs0YILHyhvOWt9LBPk9zRR++TCxhvZItg/x1ZAcmXtW
         CorrLm9lVFAg2PizLc+UIXU+aG44jrPJwrqXdcOjOE+REJ6qHh1VL6faV1OxJLPQfG1j
         BGnRsNkC2HB183Q90kqRy7z3AEytimS+9qPPsqGiGEMApZlArcrExfxTeip50YdObqtF
         /SNQ==
X-Gm-Message-State: AOAM533cytPx5XmLnjpa/+3xjNWrFgyHK7WhqBC9NovgCMPjmDPGYcnd
        xn0LTgUySpsf878tpWEVcmkSJg==
X-Google-Smtp-Source: ABdhPJzwZNrCv4oELX+wCyr/BptjE1Vzk+IEHthZyONGkq5f0OG68w9UJLc9TtP8XmHM+y68jgRZMQ==
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr8082237wmc.73.1599232883838;
        Fri, 04 Sep 2020 08:21:23 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id a11sm7789534wmm.18.2020.09.04.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:21:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/8] rtc: rx8010: consolidate local variables of the same type
Date:   Fri,  4 Sep 2020 17:21:10 +0200
Message-Id: <20200904152116.2157-3-brgl@bgdev.pl>
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

Move local variables of the same type into a single line for better
readability.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 2faf5357a3a5..4c790d33f589 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -109,8 +109,7 @@ static int rx8010_get_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
 	u8 date[7];
-	int flagreg;
-	int err;
+	int flagreg, err;
 
 	flagreg = i2c_smbus_read_byte_data(rx8010->client, RX8010_FLAG);
 	if (flagreg < 0)
@@ -141,8 +140,7 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
 	u8 date[7];
-	int ctrl, flagreg;
-	int ret;
+	int ctrl, flagreg, ret;
 
 	if ((dt->tm_year < 100) || (dt->tm_year > 199))
 		return -EINVAL;
@@ -250,8 +248,7 @@ static int rx8010_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
 	struct i2c_client *client = rx8010->client;
 	u8 alarmvals[3];
-	int flagreg;
-	int err;
+	int flagreg, err;
 
 	err = i2c_smbus_read_i2c_block_data(client, RX8010_ALMIN, 3, alarmvals);
 	if (err != 3)
@@ -279,8 +276,7 @@ static int rx8010_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
 	u8 alarmvals[3];
-	int extreg, flagreg;
-	int err;
+	int extreg, flagreg, err;
 
 	flagreg = i2c_smbus_read_byte_data(client, RX8010_FLAG);
 	if (flagreg < 0)
@@ -346,9 +342,8 @@ static int rx8010_alarm_irq_enable(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
-	int flagreg;
+	int flagreg, err;
 	u8 ctrl;
-	int err;
 
 	ctrl = rx8010->ctrlreg;
 
@@ -387,8 +382,7 @@ static int rx8010_alarm_irq_enable(struct device *dev,
 static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
 	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
-	int tmp;
-	int flagreg;
+	int tmp, flagreg;
 
 	switch (cmd) {
 	case RTC_VL_READ:
-- 
2.26.1

