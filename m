Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C35C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A133520734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMOhtXzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgFCJZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:25:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33749C05BD43;
        Wed,  3 Jun 2020 02:25:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so1342906pgo.9;
        Wed, 03 Jun 2020 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjR15KopJP6zOaarv5W3RFOr1FfhGQ5XkUnFKdb2y28=;
        b=JMOhtXzgXvitBoKlXVbXLhISmX+Djvz0qHp7icGepMKPD5XxVwvuRS0t/Paa05/h1h
         rS1alLFZHbZz24OO4xGvz1R3xVTzc3eMzktLA/pBfteBz5Tbi3uT5FjhpeMLozTO6V25
         GDvPgvnhQ+v1uTW5jVReN8LZSI2Wdqm8oJk9Itd5Q80UKEp361IWx65IrSxwnSLI3T4R
         fWDtkBMO+ftSkrxjcAsW4Hf+cwt7xdtLT4xts+KWQnK+OiP0q8bbs8FM1L+T4aiCBfvh
         ifB+bYo8krOQ+cOQ/H0UDvCrQcBQpX47jVz6Deslf2IaldwMRJEEtJFQPJdzil9lb+ja
         9j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjR15KopJP6zOaarv5W3RFOr1FfhGQ5XkUnFKdb2y28=;
        b=HaeIC9YUQ2riDaBQB5FDZF81fBurTR7VcBaUi0XvgRYOb2XTlGSL09p8WbTa1lA+1O
         2aB5ax54lYKjrkGFw0Fu7j9/xfPPVQN7bC88/ZdoFDHTLsXpeULAp9G3enAEh9qXpUNv
         64SJ/AtZ/MvYxeAsPjHfP08+nZ78M+HD+qp5jT74c9xU+S/GPQqU6d5d/2LRKxx+Vp/+
         5PDHSwJggjNC/3+QiLXHAahAVSIK4R9rnxgAGriIkPTRoy2RLDV+3hwNQJF7N/lJBfv5
         hOvMBl22cjG1wot+d6+uiF7RGGfJP4EhuMkVmlEvSAmX0eH0FFpJYlWapIpSfm0aFBoR
         eAQQ==
X-Gm-Message-State: AOAM531D44w7tZbbLTkx7TCrxELxGTsvypUb+vtY1NDU7HuoK1bSDfqm
        SwbByyf3M6FwyzQVERABXZ8=
X-Google-Smtp-Source: ABdhPJy8c3SbMCVjwLGnJJ9sDOUCnnE+0fiDi4go6QAhsOfWrG+uqSUf5ar3mYtmqnZODA1yzia6dA==
X-Received: by 2002:a17:90b:b14:: with SMTP id bf20mr4623918pjb.231.1591176357821;
        Wed, 03 Jun 2020 02:25:57 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id n9sm1797825pjj.23.2020.06.03.02.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:25:57 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Andres Salomon <dilinger@queued.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Adrian Bunk <bunk@stusta.de>, David Vrabel <dvrabel@arcom.com>,
        James Simmons <jsimmons@infradead.org>,
        Andrew Morton <akpm@osdl.org>, linux-geode@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] fbdev: geocode: Add the missed pci_disable_device() for gx1fb_map_video_memory()
Date:   Wed,  3 Jun 2020 17:25:47 +0800
Message-Id: <20200603092547.1424428-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although gx1fb_probe() has handled the failure of gx1fb_map_video_memory()
partly, it does not call pci_disable_device() as gx1fb_map_video_memory()
calls pci_enable_device().
Add the missed function call to fix the bug.

Fixes: 53eed4ec8bcd ("[PATCH] fbdev: geode updates]")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/geode/gx1fb_core.c | 37 ++++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/geode/gx1fb_core.c b/drivers/video/fbdev/geode/gx1fb_core.c
index 5d34d89fb665..c9465542204a 100644
--- a/drivers/video/fbdev/geode/gx1fb_core.c
+++ b/drivers/video/fbdev/geode/gx1fb_core.c
@@ -208,29 +208,44 @@ static int gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
 
 	ret = pci_request_region(dev, 0, "gx1fb (video)");
 	if (ret < 0)
-		return ret;
+		goto err;
 	par->vid_regs = pci_ioremap_bar(dev, 0);
-	if (!par->vid_regs)
-		return -ENOMEM;
+	if (!par->vid_regs) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
-	if (!request_mem_region(gx_base + 0x8300, 0x100, "gx1fb (display controller)"))
-		return -EBUSY;
+	if (!request_mem_region(gx_base + 0x8300, 0x100,
+				"gx1fb (display controller)")) {
+		ret = -EBUSY;
+		goto err;
+	}
 	par->dc_regs = ioremap(gx_base + 0x8300, 0x100);
-	if (!par->dc_regs)
-		return -ENOMEM;
+	if (!par->dc_regs) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
-	if ((fb_len = gx1_frame_buffer_size()) < 0)
-		return -ENOMEM;
+	if ((fb_len = gx1_frame_buffer_size()) < 0) {
+		ret = -ENOMEM;
+		goto err;
+	}
 	info->fix.smem_start = gx_base + 0x800000;
 	info->fix.smem_len = fb_len;
 	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
-	if (!info->screen_base)
-		return -ENOMEM;
+	if (!info->screen_base) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	dev_info(&dev->dev, "%d Kibyte of video memory at 0x%lx\n",
 		 info->fix.smem_len / 1024, info->fix.smem_start);
 
 	return 0;
+
+err:
+	pci_disable_device(dev);
+	return ret;
 }
 
 static int parse_panel_option(struct fb_info *info)
-- 
2.26.2

