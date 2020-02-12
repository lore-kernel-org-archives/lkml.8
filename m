Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E19AC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9B520848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581499553;
	bh=kaH0XnJ9K/qMwTAZt9T13PJlb0gOqZptdBxl1nrZCtI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tMBmbn40bfpQZMmnwoHcmjahXTxL0VMS/KmuOsQxjyOufBJdkaYG4l1Nlrme7NJ0G
	 rPGxfp8F9Gy03VlJlTy6Yv++WBOchb/gf/w8EImQl0vmLRJa52Z5Y/08JB7L+FIdWA
	 siYXGyWmbrlnJsUPeCCvOOPsz0tgVDRdyje1CkG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgBLJZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:25:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46857 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgBLJZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:25:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id z26so1049578lfg.13;
        Wed, 12 Feb 2020 01:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifVBoElaw72KKsiNn+qqQmzu9vHWs2oOvtGDepzDH9Q=;
        b=Y6h1p4DF+nTqOjvv06cYn3RwyH6maa2KNziVQJvl8aR5CL8thTqG+ReUbXdh99GV2V
         BbLdUCQKdivn3REus/Kvcjcv42Wv7BzN2HUJXhqTjLN8+KP52/WHMj8zBkJbuMnX/igQ
         UrkR/TQreFKgu32vbX5tHDKwVh8fDIQ7KIvNd3lEKurAFPJqLP2l2BrNmlTkRw0xT/+K
         frqliF+mwBa538tvN1rbHj7h+rqYRmTIcN8Mpj1mBfgtjv1/OJx7Lj4meLEocORUzuhY
         uRKcet4Uu43yeJxOth4lf+v4fQvwURNN70LpvxXk+/o58HfnpBBbp0KZGd6zwE0P3nKo
         n5hQ==
X-Gm-Message-State: APjAAAW961CvKuH/QUv1L/t1sA3uZwcQ+nufKH+r0xQCjO5saZES1qyG
        8rz+2YHhfz5M+YU+q71gXAw=
X-Google-Smtp-Source: APXvYqxzeMI7No4vh6JimUYiC7TU1It0zng2DzQfioWK6SV1tPvit6H57afYyo0U1T08X8qtvv4MAg==
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr6199085lfk.175.1581499549950;
        Wed, 12 Feb 2020 01:25:49 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id 14sm3156520lfz.47.2020.02.12.01.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 01:25:49 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1j1oHE-0006Gm-9H; Wed, 12 Feb 2020 10:25:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH] hwmon: (pmbus/xdpe12284): fix typo in compatible strings
Date:   Wed, 12 Feb 2020 10:24:26 +0100
Message-Id: <20200212092426.24012-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the driver compatible strings matches the binding by
removing the space between the manufacturer and model.

Fixes: aaafb7c8eb1c ("hwmon: (pmbus) Add support for Infineon Multi-phase xdpe122 family controllers")
Cc: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/hwmon/pmbus/xdpe12284.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/xdpe12284.c b/drivers/hwmon/pmbus/xdpe12284.c
index 3d47806ff4d3..ecd9b65627ec 100644
--- a/drivers/hwmon/pmbus/xdpe12284.c
+++ b/drivers/hwmon/pmbus/xdpe12284.c
@@ -94,8 +94,8 @@ static const struct i2c_device_id xdpe122_id[] = {
 MODULE_DEVICE_TABLE(i2c, xdpe122_id);
 
 static const struct of_device_id __maybe_unused xdpe122_of_match[] = {
-	{.compatible = "infineon, xdpe12254"},
-	{.compatible = "infineon, xdpe12284"},
+	{.compatible = "infineon,xdpe12254"},
+	{.compatible = "infineon,xdpe12284"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, xdpe122_of_match);
-- 
2.24.1

