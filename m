Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C8020726
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="aDyUWMhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCEShU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:37:20 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39092 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgCEShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:37:20 -0500
Received: by mail-qv1-f68.google.com with SMTP id fc12so2886947qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVLGt4j/QYyjZ+3/rCrgc0GJ7j43MM2UGJs3lgyOEpk=;
        b=aDyUWMhUKKXxS6Vhp3vnS8xBPJbhvHrhe56sBrYBFQvuJoD7c8+LgDz6/qtSWJ7+tD
         QoYKl4Knf82Mf8wS3QuqzpcVXQWvTeDq5cReqdvWjFLntFG4VjZnQ0jzsDsdkEagkxHs
         zp9YgkLTLh/y/CviVKvbz6NMSRIhQfZ83cy4Bkvouhde3ITo7RTaABE1SIWAMtiLH/gu
         8sZgl3bkxj9LmE4owXTQt6Pjc/cS7woy4SIYJUP1zzyIiDcITroR8uhZMV71HTiE5GLT
         PnEunU3gGo2REn+I/dN7JSXy0Unm/0gxnEytRhh1topfkhKaxH1MYssN27Fbi0W1MC9t
         vPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVLGt4j/QYyjZ+3/rCrgc0GJ7j43MM2UGJs3lgyOEpk=;
        b=d/LFVbhJJV3K/5xEOd1lRdoGst26OEitfqaggl7OAiW19hM3XwPaPJ4eGy6c8/Iij7
         klsLDcjGpfsljTavH48yBoRu8t8m2DOlll2m9XLSKYB3zXR8cK493zQKdu99/FO6uhsl
         9pmOKyP/Cx94L6r/Rpp6AGLfWt9Fa4TZ6+nCfHddLQ3ngEOPSp9P//7AOd+uUNwjYciF
         zV/rV/apf2CrUkqBJMjIH+W4o1qfwZRMEheDYTR27kslOljhUcOa1GAG3COVi3H4rA7V
         YeQfGKjoIfhVyRHn/quJ9Sk2xHRlAVUZ1IOtrCEinNe1Y5zymSbMkooYBaCQgLLv+niN
         aPCw==
X-Gm-Message-State: ANhLgQ04Uwgg2UayxLbQOdjah3Ee0nIMeEtqOKxm5qoIDqICk+yTv9Zh
        Kq/WzkD2wH/U8RxCqs/AQiFzg/rxG1g=
X-Google-Smtp-Source: ADFU+vtAB4m+frt4OgPhGK3bjFH/Mq6EFNWAn4lywl9mtCgIsj+7JWPOo6i9rKGPSDIUMb2g4nqQHg==
X-Received: by 2002:ad4:5673:: with SMTP id bm19mr46300qvb.231.1583433439112;
        Thu, 05 Mar 2020 10:37:19 -0800 (PST)
Received: from dfj.bfc.timesys.com (host134-3-dynamic.50-79-r.retail.telecomitalia.it. [79.50.3.134])
        by smtp.gmail.com with ESMTPSA id z4sm13868300qtm.69.2020.03.05.10.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:37:18 -0800 (PST)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        zbr@ioremap.net
Cc:     Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] w1: ds2430: non functional fixes
Date:   Thu,  5 Mar 2020 19:39:51 +0100
Message-Id: <20200305183951.2647785-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainly discovered a typo in the eeprom size that may lead to
misunderstandings.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/w1/slaves/w1_ds2430.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2430.c b/drivers/w1/slaves/w1_ds2430.c
index 6fb0563fb2ae..67d168ddfb60 100644
--- a/drivers/w1/slaves/w1_ds2430.c
+++ b/drivers/w1/slaves/w1_ds2430.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * w1_ds2430.c - w1 family 14 (DS2430) driver
- **
+ *
  * Copyright (c) 2019 Angelo Dureghello <angelo.dureghello@timesys.com>
  *
  * Cloned and modified from ds2431
@@ -290,6 +290,6 @@ static struct w1_family w1_family_14 = {
 module_w1_family(w1_family_14);
 
 MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com>");
-MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256kb EEPROM");
+MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256b EEPROM");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_DS2430));
-- 
2.25.0

