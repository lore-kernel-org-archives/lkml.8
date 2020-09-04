Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72525C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A64B2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="R5Dqco5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgIDPWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgIDPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D864AC061247
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:21:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so7172966wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stUHoXBLhmGzCwZtEJAUKXLxs5aOWuJj0Ee8wOeFjkw=;
        b=R5Dqco5Vp40iB/h46/HNZAv1XlB31sJ1uLGZz0PIHiNSuFyPEIvqOG0s3JiYF+lh3u
         DurSlxoDn/IFY+Fbf5xSfktwwY5BC84nKcYoiG8OR5b1/efxzcT2XWjZAPsadyfJskzF
         oHaVA+C2KEV7MKjlE0XUBbHp3MXCuih647KUKkedt85whqODx3C2FEopKhUim+AOuB0U
         E5GPclZWVElCYYr+ofk7B9yjyHzhgWjKrwfgx63n+Eq18kgjNg95pQarqWmU6Xl2gCSX
         +HnJE8kCQ4VctMsImFS8lFPAD00bcCs2JXlkAM3c5Zeqld1EIAshT8hcndkPjtrZz3TM
         lzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stUHoXBLhmGzCwZtEJAUKXLxs5aOWuJj0Ee8wOeFjkw=;
        b=uaq9FrixQNF2VMPx6qwfXM+RY3zWlg60GnL3qyzYNESwqs8EaoX3i8iv/hTGPFtUZA
         FEoHG+r3HG+oAUPJQTBu3zDzNzNXV0QDvy5jPlDrKExarC3JlTdzsH0691Zt8h8L2HZN
         a8Kb573dr2Y47wtqwdzOKGm1iQ3LUOrz+riILvjip5ZJjLPoqJZUO7o3NjpoNixpIK0K
         tULqDS9aPWTRV352psaCozvSys5BvAaCbnTGu2lWMzs0jY0J+LU/RzRYfbdi52Yu15Ua
         mAdc97OCWRlNkPXfk1++HrwHAbRNgzazXM3efWdcAv+2IvJWivUM9fBgzftEEoBPbdz6
         X2eA==
X-Gm-Message-State: AOAM533RE+Iaq/L+OmfyBrrKd1Jo4zE1WWAWueRhXAtN7rRTJ/AQWcQ4
        kQ+2gvHiWLjQ3zEtysTbcNONWA==
X-Google-Smtp-Source: ABdhPJwl7Nn/2R7VILQzKg8oX0n4CU6PnnWJQYviy0/NYR2eE/0FgjwSs2ONiVU4fkwPEDEObs/jPA==
X-Received: by 2002:adf:94c1:: with SMTP id 59mr8817819wrr.29.1599232882017;
        Fri, 04 Sep 2020 08:21:22 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id a11sm7789534wmm.18.2020.09.04.08.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:21:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/8] rtc: rx8010: remove unnecessary parentheses
Date:   Fri,  4 Sep 2020 17:21:09 +0200
Message-Id: <20200904152116.2157-2-brgl@bgdev.pl>
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

Remove parentheses whenever they guard a single line.

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

