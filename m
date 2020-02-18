Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF2DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E6624125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="106kcsSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBRTeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:34:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45185 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBRTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so25351057wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6WHmT1Q8HUElfvFbGW9Dh3Pw5PPNoHiq3K4083/U04=;
        b=106kcsSZ4LU/10R3o2p3osg/GDCO9WirwxTaO3LgTuMSCiG6apeUuthE3ZI9gItity
         u3rzE4mWwKv5n+cW9tmSB7Ljv+JXMY7bKTrWbRycZSmP5ElaRG6v8N9oPitXuBHcCySp
         +NtWaIFwwI2D2ajZEPiV1vAf4U9PlAdEVAVPs7xXnu1LVK7OhvEbrD8Hahoczg9oGCsH
         EebqJfPXqOrchabWBFKUzzw7WwpKStIUtPc63sCOdzDmYqOrv0HhZFxD6vaG5KMAsD4u
         UQwtvBDEDgMYHK7UQ1hV+wnAB8qJkk6PjAyK4MEvTJz5X5AXC+emiuSSYN+EsbVu6yWS
         hXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K6WHmT1Q8HUElfvFbGW9Dh3Pw5PPNoHiq3K4083/U04=;
        b=HNXJ3bAZL8ino2g3okN4ptoRX7MhPdyj+YzwZiUH9p9moXle9MIQEHOxcyZwq5IdlB
         8V78r8x0GNaP+PrlEE0XhqPbsI8cK/Hqkk3K6VAD0C9CvstOxJcTlEA/jLX5FpPX33MP
         NalsEq6awWiyChc8Rt2UrxKRI9qBhhp+j7DIhPd4UUst6Ow/USR7u2SAEABt7ajeAT+8
         Thi7weoo6KAjAPFuKWy2rMbj5hlYF6j9ViK8A9Ht+908BY0hOJH8zxbdmWj3nF+rloxB
         o9eD1fiRtTOOOHv2hNKKpOyLfajlRKQp8vUzGK5y+4kz4wIivgTAYYXpJSPipt+8t6w2
         dpUQ==
X-Gm-Message-State: APjAAAUFSY94CFrU4PpgZITMIO/u6MCwt7KtIX2h+d4U5ufGTmYP2a2+
        pRPXpNVJwz5xakTQPlIzb7KrUcBDpAY=
X-Google-Smtp-Source: APXvYqzvoP4MSFReUflySE73Nx02NzCW0jknJD3OEVLpu7rFICnkripQt1AiTb5uiiwG9a8GPfXtEA==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr32971190wrw.347.1582054406291;
        Tue, 18 Feb 2020 11:33:26 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:25 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 12/20] usb: gadget: omap_udc: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:55 +0000
Message-Id: <1582054383-35760-13-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
driver_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/gadget/udc/omap_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index bd12417996db..bf87c6c0d7f6 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -3001,7 +3001,7 @@ static struct platform_driver udc_driver = {
 	.suspend	= omap_udc_suspend,
 	.resume		= omap_udc_resume,
 	.driver		= {
-		.name	= (char *) driver_name,
+		.name	= driver_name,
 	},
 };
 
-- 
2.24.1

