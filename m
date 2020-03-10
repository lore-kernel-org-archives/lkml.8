Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35546C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C78E24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3daWSPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCJDnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:43:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38554 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgCJDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 23:43:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id w3so4875825plz.5;
        Mon, 09 Mar 2020 20:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJRaRZ4naX3Vnv5pmVF9pvGr8T/5dEuyNUhM/Hub+PE=;
        b=r3daWSPEY9Uv+21e3FeeuaaVrZl1TLEKPbfhYSAW/PKUS5xWLkTJn6KOxSn82D/MTI
         LNF2vHRgY8rH7HSn098uS6WuDkE7lXkCWCPy/Vuzk505jHF8XZ/NzTtLI4qrhFYG/5aI
         dm+Lym2eERwjXSoQ1AHaU8twICmCsfj6ZvaYoVerKsCEy53VU8E1jCphrQh7kLCb5C1J
         8+GbwanjoeDJZehn1bknUAPH8T8X2bVg6uPnmJZDNPvex+RCT1CbT0CoahE4nylZK+fV
         vsXNKazNbIq/KbU/m4KWIdiVMjDSH3EZod+exPnTVT/UaX/5vuXHyj9M3oQLPTFwp/0d
         O64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJRaRZ4naX3Vnv5pmVF9pvGr8T/5dEuyNUhM/Hub+PE=;
        b=r47BNniweq+pGFgUB4Nc0ll3yXAf1RcRpNLqQ6nDQwRSTphFXQeR1guODXQPGPuxM6
         SILyJ/YgXFrbzGW1BH43iXzKZw/adRJ06BUwzKfDcM1y5ggoTbTb4GbWCjq4+PuQlUfW
         +Vy5QQAccI+LnHkF58BG3XFTKa++3bnVL4eEXKALpZAnOn/b/vbfLkG6NftWpfCPTD4j
         f1OlAgdeIJK9oSZxf/XMMtkXrtwYEDBmaiIfRC5UiUAaXc9Lkg+aFSU49YRgp6WJe1Pg
         mQNld1NajVelz5e2Q37bQeAhhmEX+OlFhfgFVjAM8xtuyaOYdd9lPl4T/9DWPUpvCjB3
         e5qw==
X-Gm-Message-State: ANhLgQ0fZsMHMpl6sICcqzWNakPxf4kQ05h6fP/YohxqBtMsiKWhYt18
        dawb+naPSNCts/FOtJRdQiI=
X-Google-Smtp-Source: ADFU+vv4G89H+vV2DiLZrhX6m7BY78nga1L/yVPTRxdMuCHNWhODFybtIruHBzBlmP9I2Mg0T+t/hA==
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr2550213pjk.135.1583811833984;
        Mon, 09 Mar 2020 20:43:53 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id q7sm31499354pfs.17.2020.03.09.20.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 20:43:53 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jaya Kumar <jayalk@intworks.biz>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] video: fbdev: arcfb: add missed free_irq and fix the order of request_irq
Date:   Tue, 10 Mar 2020 11:41:05 +0800
Message-Id: <20200310034105.14379-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to free irq in remove which is requested in
probe.
Add the missed call to fix it.
Also, the position of request_irq() in probe should be put before
register_framebuffer().

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Modify the commit message.
  - Adjust the order of operations in probe and remove.

 drivers/video/fbdev/arcfb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 314ab82e01c0..ab553f940f9f 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -544,10 +544,6 @@ static int arcfb_probe(struct platform_device *dev)
 	par->cslut[1] = 0x06;
 	info->flags = FBINFO_FLAG_DEFAULT;
 	spin_lock_init(&par->lock);
-	retval = register_framebuffer(info);
-	if (retval < 0)
-		goto err1;
-	platform_set_drvdata(dev, info);
 	if (irq) {
 		par->irq = irq;
 		if (request_irq(par->irq, &arcfb_interrupt, IRQF_SHARED,
@@ -558,6 +554,10 @@ static int arcfb_probe(struct platform_device *dev)
 			goto err1;
 		}
 	}
+	retval = register_framebuffer(info);
+	if (retval < 0)
+		goto err1;
+	platform_set_drvdata(dev, info);
 	fb_info(info, "Arc frame buffer device, using %dK of video memory\n",
 		videomemorysize >> 10);
 
@@ -593,6 +593,8 @@ static int arcfb_remove(struct platform_device *dev)
 
 	if (info) {
 		unregister_framebuffer(info);
+		if (irq)
+			free_irq(par->irq, info);
 		vfree((void __force *)info->screen_base);
 		framebuffer_release(info);
 	}
-- 
2.25.1

