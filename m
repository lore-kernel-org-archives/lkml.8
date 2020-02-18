Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E9C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D0E2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YDEakFwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgBRUH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:07:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42382 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgBRUHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:07:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so25480577wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 12:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4cyBnsbCp8K2dn/otOwt/zGstBiNP7FQVjJ9JQxVYLE=;
        b=YDEakFwS6rx6Yuo1qVqHilKpZwkpVTSJrXWNBeXgJM77Lu7v3HNEQfmmphSYGWpMee
         NRh7b3NKjTgOAEdBMne5KxfZzsInfjIfRCtosemivDHWrdCq9MFDDw50wuRWa7d3HoBK
         K71JzLvjubtSpjOJgJYKD/1DLuMeGEPOEl7LVb8hcf+cy5uUz6M3v5z0zuGnUezIjzYQ
         YAEDuJK2A83PKRn2ZJ/JaNOgD2WhKzUbcsia5M7vGXW3vbdtdSu6+U6MElOuqcsS0m9/
         s+d3Y2tPjhIUuTSGAW9Q7CuSRkz/m7aXEVevsm381tXXX6hniDdmsqZnJp3k/fCi2hD9
         59YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4cyBnsbCp8K2dn/otOwt/zGstBiNP7FQVjJ9JQxVYLE=;
        b=fCi8yIc9n8nOLFJ2m9VpU9GNbgMh+vgEfZk1QU4gJJRz4sqca4h+tglDb3P9orExla
         YKUWCthtmslvpCSHZyqs2JV+PUTeLX1XSnoxJmm9Vfcv2npj47R+mS9HGwwak+QRlmpK
         r6RmLWd0j1OgIzCIvksub9j9FEhA/t16k1nAO8XdvIoIfmUpPa+xoVqA0X9db1tH+WQK
         FpynN+YPrItZ/vCcsPhi0dnC9a27S9hSOLCDDgQEvPJJ0xwPCXVlJStuIgN0XzMCyFKs
         ycpnNpmCdl9DCWO/Iong1OtJpLFldecS4sZuOQUHGjxKirsV6F4LeTn75FQRnBL/paVX
         qgxg==
X-Gm-Message-State: APjAAAXuBldXHVWJRQ0cXJ8nrv9sDMWZkRmNF4fsoVdXaA1nAtMcmxxr
        oTrty3gMWqs7mI59izu9Ml56JQ==
X-Google-Smtp-Source: APXvYqw7Iu6rNwB0fChV/KT1WXBuRYh6hKrG/zUYDS6v7xZhRgdxSSH7TL6Jasof0jfX5poJDsy7Pw==
X-Received: by 2002:a5d:4746:: with SMTP id o6mr4379632wrs.70.1582056442773;
        Tue, 18 Feb 2020 12:07:22 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a9sm4576598wmm.15.2020.02.18.12.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 12:07:22 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] pcmcia: omap: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 20:07:16 +0000
Message-Id: <1582056436-15775-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
driver_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/pcmcia/omap_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 0a04eb04f3a2..d3ef5534991e 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -329,7 +329,7 @@ static int __exit omap_cf_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_cf_driver = {
 	.driver = {
-		.name	= (char *) driver_name,
+		.name	= driver_name,
 	},
 	.remove		= __exit_p(omap_cf_remove),
 };
-- 
2.24.1

