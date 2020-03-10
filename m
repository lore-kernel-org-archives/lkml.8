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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9129DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642B520828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KttrUyVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgCJObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:31:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41387 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgCJObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:31:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so6373256pgm.8;
        Tue, 10 Mar 2020 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MacYADCTD8qyc7WRcNZs8kAJcizBx9dQZtfdy9R4RNE=;
        b=KttrUyVNMJm4tVYsndEJewihA/Fnj3N2ZrjYXIrDKeGl8u/WNjT48KZrE5gagQlRGw
         NsMbdCIkZCKNQ9PqKTuT6DOghaGLkm6UW7HV2ruq5QGTJfIBEw1k3T8+NDHpBWC2FvGm
         GFuEtFUCuPXElbvO+Bt8GVG9txDegpQ7HBGqNL86qPmCGmC8/pmKM2VCCtl9gcZlEaKF
         Sqk7gHJNqdfImZj4Tnq8kPoqYQtJOzyS+KFCV1P9sXrSEsYdNSJzBUxzbwJYwT9iFFq+
         +HCsss44iRlGKPmrcylrkKGSpHUyGX4EKEPerBxQ8IrBOqRHSih0RLo1b1i5TRsWs+LX
         erIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MacYADCTD8qyc7WRcNZs8kAJcizBx9dQZtfdy9R4RNE=;
        b=Bz5kwrHwjuR55luBQackEX5I3B5GiPL0rI0kFbxyqmxuFvgp8dox9AzH4Jk0uhgYTp
         du/0u1AbjehQ7aQYALJZ8tP5pJDpg+KRuZNONDqsXTcMwEaVJBzc9GCK7thy63/uDXnA
         CO4Fa0+281WZ/8vh4y4En74SsOfkUHzM1NQmz/JJPS28JM0gTQKOFDlJO4+txZlGN5pO
         XYRc4qU/PvOhSc5CmsMj6cFqaCDhIB86p7K8hMDFFYzU93avh6QyXttIRu8yveCMBUUz
         MO0lPD0gHuowVYL5odfDrKuCWriEDQuwwoQpxLSbSrx17Cazd1bCJ+j7bNKUWMv3zhbJ
         AMRw==
X-Gm-Message-State: ANhLgQ0j2mUC3obSsoic7JituRflQSHZWNRNMRmee1EwWphYFt142p86
        XO/bRecYr78HMgZ8OwgBeLg=
X-Google-Smtp-Source: ADFU+vtOz7EqaVGESIcXkflwV06RHK6js+BsrPdEsZ/CtPuy/i+I8NN2JdKWWajI6r7UnUNzTZwOCQ==
X-Received: by 2002:aa7:9af8:: with SMTP id y24mr6740721pfp.91.1583850658299;
        Tue, 10 Mar 2020 07:30:58 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id j21sm2537919pji.13.2020.03.10.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:30:57 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3] video: fbdev: arcfb: add missed free_irq and fix the order of request_irq
Date:   Tue, 10 Mar 2020 22:30:50 +0800
Message-Id: <20200310143050.5154-1-hslester96@gmail.com>
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
Changes in v3:
  - Add missed variable par in remove.

 drivers/video/fbdev/arcfb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 314ab82e01c0..9a720c14056c 100644
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
 
@@ -590,9 +590,12 @@ static int arcfb_probe(struct platform_device *dev)
 static int arcfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
+	struct arcfb_par *par = info->par;
 
 	if (info) {
 		unregister_framebuffer(info);
+		if (irq)
+			free_irq(par->irq, info);
 		vfree((void __force *)info->screen_base);
 		framebuffer_release(info);
 	}
-- 
2.25.1

