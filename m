Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C9CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC942074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="okftafqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgIDPWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgIDPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE6AC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:21:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so7165167wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41Qpf9U4SrfFhPD50QAUNJfCt0M/GeyQmwAlMT5vSWE=;
        b=okftafqQMXRcABXmeAaH6FT2kjmQmoEkLdsZzFvtoSabJBIq8tnlJyNt0w2/SXtbU1
         zAZp7mGzAYrjSdO6SpoR0EOKo7dBNtI0J/uXB8IduamXjqWUxfFbh1LA3ErY/1Ew4Mop
         nvhl3J0132Zttgkx1B0FeE589baLLNUCv5Wd0S5qewpEVxrqxzlK+RnGqeoKCAjpqz1m
         LhOVA1SvB0EcbOFAT+vQ2hsm4F9pjWgCe2U/6oC4gpv4Rs2Ueds/YgahqfoOTqLw0ZyX
         hCyhwNRWemvdVtTZzemwtN7U2y39fbhD+tEoKKvgtlKtEVkYX3EACXxV2H15MzOb60c8
         4fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41Qpf9U4SrfFhPD50QAUNJfCt0M/GeyQmwAlMT5vSWE=;
        b=tmQ8hzCw7OAmEEwIN4StxK83/xB543IF/zkcP9Hf4uGpIFWgN2wdB/km6IP9sdn/8v
         s5YdwmCFxjqRzw0e3ToYvJ1XrJwiR2lbv5yWD/MnfxD1QuS7sGQwrkwHKrmpopLgOxFO
         a26aC2hZISoep1iQ7jaoOdBR+bAXmFequB122cbYtMdUVpYF27R7OSbJDvAYX+WZGycD
         Q9uWwuYhmXLXGpSy/4KFEL3Ou1kz5JLlc8dRmFoMss/FpO5WdwIRtB9Y3LFoUCYMRb4L
         EZeIQwxy5dIb7gUI26n6KNvp8Wy2653P9sl3rDAy+ZVmVBY9JaXiF1xqSZyaHOD5tcyl
         Pj2Q==
X-Gm-Message-State: AOAM533jHMHmadDn9+UykBwP52KKgiQaDiy7yRXHEn+2khw9Gf9L1y9j
        cb7XvSSMP+trO/AZiLnce8MqQg==
X-Google-Smtp-Source: ABdhPJyBwyfuS8JLYCUpzdLvZ2JVLMxKXzI5OWO3X4lAHWfZFyWWvU3gWZqvRDM/AoKC5pNb8Zhrzg==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr7867716wra.176.1599232885571;
        Fri, 04 Sep 2020 08:21:25 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id a11sm7789534wmm.18.2020.09.04.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:21:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/8] rtc: rx8010: use tabs for instead of spaces for code formatting
Date:   Fri,  4 Sep 2020 17:21:11 +0200
Message-Id: <20200904152116.2157-4-brgl@bgdev.pl>
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

The define values in this driver are close to their names and they are
separated by spaces. Use tabs instead and align all defines.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 4c790d33f589..2038700a3e8e 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -13,40 +13,40 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 
-#define RX8010_SEC     0x10
-#define RX8010_MIN     0x11
-#define RX8010_HOUR    0x12
-#define RX8010_WDAY    0x13
-#define RX8010_MDAY    0x14
-#define RX8010_MONTH   0x15
-#define RX8010_YEAR    0x16
-#define RX8010_RESV17  0x17
-#define RX8010_ALMIN   0x18
-#define RX8010_ALHOUR  0x19
-#define RX8010_ALWDAY  0x1A
-#define RX8010_TCOUNT0 0x1B
-#define RX8010_TCOUNT1 0x1C
-#define RX8010_EXT     0x1D
-#define RX8010_FLAG    0x1E
-#define RX8010_CTRL    0x1F
+#define RX8010_SEC		0x10
+#define RX8010_MIN		0x11
+#define RX8010_HOUR		0x12
+#define RX8010_WDAY		0x13
+#define RX8010_MDAY		0x14
+#define RX8010_MONTH		0x15
+#define RX8010_YEAR		0x16
+#define RX8010_RESV17		0x17
+#define RX8010_ALMIN		0x18
+#define RX8010_ALHOUR		0x19
+#define RX8010_ALWDAY		0x1A
+#define RX8010_TCOUNT0		0x1B
+#define RX8010_TCOUNT1		0x1C
+#define RX8010_EXT		0x1D
+#define RX8010_FLAG		0x1E
+#define RX8010_CTRL		0x1F
 /* 0x20 to 0x2F are user registers */
-#define RX8010_RESV30  0x30
-#define RX8010_RESV31  0x31
-#define RX8010_IRQ     0x32
+#define RX8010_RESV30		0x30
+#define RX8010_RESV31		0x31
+#define RX8010_IRQ		0x32
 
-#define RX8010_EXT_WADA  BIT(3)
+#define RX8010_EXT_WADA		BIT(3)
 
-#define RX8010_FLAG_VLF  BIT(1)
-#define RX8010_FLAG_AF   BIT(3)
-#define RX8010_FLAG_TF   BIT(4)
-#define RX8010_FLAG_UF   BIT(5)
+#define RX8010_FLAG_VLF		BIT(1)
+#define RX8010_FLAG_AF		BIT(3)
+#define RX8010_FLAG_TF		BIT(4)
+#define RX8010_FLAG_UF		BIT(5)
 
-#define RX8010_CTRL_AIE  BIT(3)
-#define RX8010_CTRL_UIE  BIT(5)
-#define RX8010_CTRL_STOP BIT(6)
-#define RX8010_CTRL_TEST BIT(7)
+#define RX8010_CTRL_AIE		BIT(3)
+#define RX8010_CTRL_UIE		BIT(5)
+#define RX8010_CTRL_STOP	BIT(6)
+#define RX8010_CTRL_TEST	BIT(7)
 
-#define RX8010_ALARM_AE  BIT(7)
+#define RX8010_ALARM_AE		BIT(7)
 
 static const struct i2c_device_id rx8010_id[] = {
 	{ "rx8010", 0 },
-- 
2.26.1

