Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05EFC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9904822206
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="l4NjfMb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgIJVla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgIJNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:05:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD2C061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so6654037wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41Qpf9U4SrfFhPD50QAUNJfCt0M/GeyQmwAlMT5vSWE=;
        b=l4NjfMb++5EhmU+ddqjntiOo6Mxg1QeAS1hNO17T4UxCaryj+60CJMFbO45FHq2JlM
         ZVYLs9M/TzTdU/Hr6Hmu7pq7Lum3ydkkF4gW7f9qiQ8pztH4JfIlkmhM0k85PpIh0uhl
         Uhq6NYhfyz/hMQfpaa2cpAcKIVxzdcKmqGmm+mYTgmtBrsYjeX1g73Nkf489TyPBvQpn
         L0JFNnKDAsHIxbMg5qnRL4byAOSEctNjMXJmeWa/LpPgUqLFqshoKrMudGctxpIDgkiq
         VBYFap1vRRyUPCqcLuLYcRqCSPLGg/kECDQEAu03eOD4/fzl9JtenwTmyxZ09uToJ9Gd
         kl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41Qpf9U4SrfFhPD50QAUNJfCt0M/GeyQmwAlMT5vSWE=;
        b=IoApRXfA2rBWLmzc8z2RjAIq4r6BHAT9Di/bs1+9xxAHApJ1wqNR5IALVtkFtNor/d
         ircMRXjuWKX0O5P5wjMEci+xunUTd2LgyND9RR72dCfq4M/SaDKO9njIOjzlQ5/1jdAS
         Pt/P0PerKsRMe6mvdDhaEGqTKfdE2INfZ46awZ9Pc6R4r3DqGQhX7aVHcCcZwEOSMORG
         +fWxxlTgnQKU4S4Sd6hYxrIrBdPEwhSvHDCm+RzWtYUPt5vVEG/cwAGgh2vIBV6PPQdE
         Jr17ZtbbecUXu+HII6ogcNf1jSysL55X/wgwXKa+wntjPJk4WNa+BLZ95ZH/DLHDhDKA
         97MA==
X-Gm-Message-State: AOAM532RtUTMuvbbvxK6kblXo91RahFqH1jdhWpRYSWpUFpdc1BkHoyi
        WhuQFBCVTvSvMxbHGnkcVbuXEA==
X-Google-Smtp-Source: ABdhPJzL3YlrjpcmsxEB7n/Pv9j6SWBA7DI0VDlwxl9zrHhyGEvdyBVu6xoXFllHtccBs5Nhxd6BWA==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr4866601wrs.153.1599743100798;
        Thu, 10 Sep 2020 06:05:00 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id p16sm9321988wro.71.2020.09.10.06.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:05:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 03/11] rtc: rx8010: use tabs instead of spaces for code formatting
Date:   Thu, 10 Sep 2020 15:04:38 +0200
Message-Id: <20200910130446.5689-4-brgl@bgdev.pl>
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

