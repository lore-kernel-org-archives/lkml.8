Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A42C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F741206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duqJNACt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgCXN3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:29:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42068 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgCXNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:24:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id 22so5666440pfa.9;
        Tue, 24 Mar 2020 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J59vOQButIA7wOzAY9wmajFYSXUMpXsPzQxaHYbQv0o=;
        b=duqJNACteTZSXSWcZF+gw1gKTJ4q1aUrfnAY8rwv1olCQqbbh2Ieil2rGE28zWqW3N
         jGzY6h6Xgd0f/k30hX8o57PFadqh2jKETuPVzX8vwAssZlz5pPGqwJiuzZSM3aR4swVU
         FxmlGfJLVFvEMBi0/LJjGqquKL866NuDSzfVlWxpAuXd/1BWw/1+mXcJ0mVVVIUSKKWz
         y+BKGvYDHary7SK/O5BJ3X/8vmBQy0a6K+GmIYS96bRriWhDd85terlO2mrXxQ8xdu52
         U52SS2J29H1F4dqDlA4XfVa/KRcJ/u7GKgELhyNTAUFciHaVFdDDX5Kd5eWqg2UG3r5X
         1Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J59vOQButIA7wOzAY9wmajFYSXUMpXsPzQxaHYbQv0o=;
        b=G26+GEc+7lY1wDuwBpI3QgRIhB/Ot7mGNJUrudUFGykbLIBmgvCOdcA2jrm6t6W67m
         B1NvpJTMkgNnNBtAI4BIz5OKgBYVlx0armIiz/20cR0KSqgf6qxv9Orf7Ziqf7MTXLYI
         3p5q9WRAl9qxRY/kbYeJ0L9nBbiDBRcosvKDeCOkDmoxnsZdJM85b68MY0gVzM6Xr7ag
         ylTqoZk37CUt9FsR261+FB7mrcOJP5NbAwSycYM6ISvV6nAVcRPKoq/q9ztx0d1Irz2P
         TGyuALJoC0XRodqAAkUkzXBzweZZkAcYn6NA1gCBt2UpWfKtDP9l2PvoWGIZbWtPdd7h
         cq9A==
X-Gm-Message-State: ANhLgQ2fJO787p43Kz/Tq8jS8J7N76xbNk/JZNUVXRb1fQazsyhOz8DT
        duuyH0yEk8v45favuW4dGAE=
X-Google-Smtp-Source: ADFU+vuGRwIJvFbAqb+kj/0gocMW4ppLpIEgYm9sWVVBwJaPcIjDZns5zlU0AC9H0zhDUZoQKzK5OQ==
X-Received: by 2002:a65:6910:: with SMTP id s16mr1545967pgq.426.1585056241100;
        Tue, 24 Mar 2020 06:24:01 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id g11sm15874883pfm.4.2020.03.24.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:24:00 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4] video: fbdev: arcfb: add missed free_irq and fix the order of request_irq
Date:   Tue, 24 Mar 2020 21:23:53 +0800
Message-Id: <20200324132353.21785-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.25.2
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
Changes in v4:
  - Use info->par->irq instead of par->irq to avoid dereferencing NULL pointer.

 drivers/video/fbdev/arcfb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 314ab82e01c0..6f7838979f0a 100644
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
+			free_irq(((struct arcfb_par *)(info->par))->irq, info);
 		vfree((void __force *)info->screen_base);
 		framebuffer_release(info);
 	}
-- 
2.25.2

