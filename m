Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6963FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435BF2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MttvX8sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFEQP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFEQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:15:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5DC08C5C2;
        Fri,  5 Jun 2020 09:15:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d8so624050plo.12;
        Fri, 05 Jun 2020 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fuq8iZ/w30hGFlRF7P+LbLAz0hBlIdSZDfbjIwkl+Ys=;
        b=MttvX8sgmxw6H5NSZaRGauZRhobavEOiAKvRo0ATGJCUoMGnKdk/fOph76//jM0WtB
         hI1o++k/E5WSqsPG3+snSomrZmq03ik1WZV8syJgto7yOOBqR3u1v4d7WyAfNwii+ryQ
         FsTf5b7/qZJwcD4yUmaYBuO/cF/262SwLp/o79UopfS3oCmY3ej3Dd+xK/NPYmmUKb8w
         0GPNNvBejEWzW+/37kuMLoSuBdUjUc1qfM1t+hS9qzqZEQISQ5d4umuKrVK2VxqZTzoC
         EpEpDSETY+CuB6AmdsG0fGilKthilo6GE7WiOFD42IHE47ErvP0srMy28Ra0Ewh1ae+v
         DkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fuq8iZ/w30hGFlRF7P+LbLAz0hBlIdSZDfbjIwkl+Ys=;
        b=Alhe8Dohs7QDLdIie8YZzKorJUd57K3OnSSV+QoBI5wI1Nkh8CVsK9Iue1eUC0Q8dG
         PhsiN6GlSeS5kWdILeljULhXx/TEef3XPPMZYBXIFlUy2k6kv3sxUKmxxW92FCMdF0yZ
         IOGhB75AutqRbfpKqau41ypYfdy1zTwAqpvCExa87O9EybRtIvzIEZz7CJA2w61s2gAX
         CpF48AuEGSuIX7mr0RAFlyYV+n9oaEUaoaAGeYq0J69xenGhXzBmjhu4PaJ3MsRB4LE1
         lNKUwbzDiKKlbRmLfHdPrqB1daAfH24Ie+2gEK4a0IY4UX0phY8S483LXJAQiT1VuMDE
         cpeQ==
X-Gm-Message-State: AOAM532Zk4AlK07d+fS+zudH34xw7M3Dqn6pX7vEDX4wbtr4tA5cdR8P
        d236mo5uelzgDfRyGX33lYU=
X-Google-Smtp-Source: ABdhPJw+Yh+6a9DtpZMLVt18+l2rdWHlZ/HrTCVinrjrjK1NAV9KB7wxpACoWzuM2Yd6mArQ1x72xQ==
X-Received: by 2002:a17:902:bc4c:: with SMTP id t12mr10171340plz.141.1591373754191;
        Fri, 05 Jun 2020 09:15:54 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id h17sm62665pgv.41.2020.06.05.09.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:15:53 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Andres Salomon <dilinger@queued.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Adrian Bunk <bunk@stusta.de>,
        Markus Elfring <Markus.Elfring@web.de>,
        James Simmons <jsimmons@infradead.org>,
        David Vrabel <dvrabel@arcom.com>,
        Andrew Morton <akpm@osdl.org>, linux-geode@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] fbdev: geode: Add the missed pci_disable_device() in gx1fb_map_video_memory()
Date:   Sat,  6 Jun 2020 00:14:58 +0800
Message-Id: <20200605161458.2513177-1-hslester96@gmail.com>
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
Changes in v2:
  - Fix the typo in the subject.
  - Modify the label of error handler.
  - Refactor the code.
 
 drivers/video/fbdev/geode/gx1fb_core.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/geode/gx1fb_core.c b/drivers/video/fbdev/geode/gx1fb_core.c
index 5d34d89fb665..15645244e4d0 100644
--- a/drivers/video/fbdev/geode/gx1fb_core.c
+++ b/drivers/video/fbdev/geode/gx1fb_core.c
@@ -208,29 +208,39 @@ static int gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
 
 	ret = pci_request_region(dev, 0, "gx1fb (video)");
 	if (ret < 0)
-		return ret;
+		goto err_disable_device;
 	par->vid_regs = pci_ioremap_bar(dev, 0);
 	if (!par->vid_regs)
-		return -ENOMEM;
+		goto err_nomem;
 
-	if (!request_mem_region(gx_base + 0x8300, 0x100, "gx1fb (display controller)"))
-		return -EBUSY;
+	if (!request_mem_region(gx_base + 0x8300, 0x100,
+				"gx1fb (display controller)")) {
+		ret = -EBUSY;
+		goto err_disable_device;
+	}
 	par->dc_regs = ioremap(gx_base + 0x8300, 0x100);
 	if (!par->dc_regs)
-		return -ENOMEM;
+		goto err_nomem;
 
 	if ((fb_len = gx1_frame_buffer_size()) < 0)
-		return -ENOMEM;
+		goto err_nomem;
+
 	info->fix.smem_start = gx_base + 0x800000;
 	info->fix.smem_len = fb_len;
 	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
 	if (!info->screen_base)
-		return -ENOMEM;
+		goto err_nomem;
 
 	dev_info(&dev->dev, "%d Kibyte of video memory at 0x%lx\n",
 		 info->fix.smem_len / 1024, info->fix.smem_start);
 
 	return 0;
+
+err_nomem:
+	ret = -ENOMEM;
+err_disable_device:
+	pci_disable_device(dev);
+	return ret;
 }
 
 static int parse_panel_option(struct fb_info *info)
-- 
2.26.2

