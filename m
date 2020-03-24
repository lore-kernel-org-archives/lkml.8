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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB1EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BA420753
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTEo3+rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgCXNaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:30:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37135 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgCXNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:23:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id h72so7055681pfe.4;
        Tue, 24 Mar 2020 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9W5asHoSbtI69dnrLRaFeOykWQKzVNx1ATwcX4bFlQ=;
        b=cTEo3+rd8HjtvQG84BxeLG5XwUFWbasowEp0PVZ6AJ/I5pEqpW4uEbt3Wuk2CT+SCt
         De2wcAyw3uw+IPmKMCPaFITdnf7zCEl9kM5er3APCB5PKEpirrz+U4dKfY0+2ZpWDm5g
         9hz8y5gJDvNwfgilx3+eMuNGsqiEccHlKCNPyw1NrgHDn9o9O4JCm9posf1Sco1085zY
         IxsIbbH+dmxoTN3oX85CHQhhKxuVHo+gKMCzDjn5eqWW3qrUJ8BsBRQ/8HBXfXiAEtyt
         zb3NMACa4XBLpk1faZBKgIDplrvs0jDPyHvOvMMPnT8c0mA0OLTukH08sccg8nDez6xR
         8iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9W5asHoSbtI69dnrLRaFeOykWQKzVNx1ATwcX4bFlQ=;
        b=NsQdQP5AHbOHJgKH/XffMLrAnHpoSAqsPd13UIGYfPvI4sFdxy8TuRkB8d2vUynpMD
         UrVcHeQGkMOKsPCbZB8aT6UKA73yBXl8MdcXotO+xEjal1CkLB1fF6pNNQQWcUz1HzKD
         uYpdHBC0WDATYKMExHN9PRxbsz/TgXQBkal27InyMc8t2RC/aeQBoprMtc2me19BVhKT
         jo4GLEVF/pvHGTkGPKTUJrS0xSzwEC2M2jakK2qHIQjFTkm6j6zH+MMk3+B4y/0X172J
         ssfL/0RKx/v5iSjyDdF9F8Y1QbgsTIPRNH5rsZYl0rWN5RiuE3hFANyslLlBpQkCTPsC
         bDpg==
X-Gm-Message-State: ANhLgQ0PhghWoq51pszZSB0LT6KMis5wrb6okZgzPrKA43vjsJnOlgXi
        tmhF1L1D4KBX6PuZ6dyn+hCtNq4K
X-Google-Smtp-Source: ADFU+vvaV82cQxYW+iVQ8iL9mUZuQav300Ftc7kBv07XCthMCJNg/aF3ZNj3CMKOFKg++p2Xw3BLbA==
X-Received: by 2002:a62:1745:: with SMTP id 66mr30225015pfx.291.1585056200107;
        Tue, 24 Mar 2020 06:23:20 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id r189sm4187618pgr.31.2020.03.24.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:23:19 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3] fbdev: s1d13xxxfb: add missed unregister_framebuffer in remove
Date:   Tue, 24 Mar 2020 21:23:11 +0800
Message-Id: <20200324132311.21729-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver calls register_framebuffer() in probe but does not call
unregister_framebuffer() in remove.
Rename current remove to __s1d13xxxfb_remove() for error handler.
Then add a new remove to call unregister_framebuffer().

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Fix code style.
  - Set __s1d13xxxfb_remove() to return void.
  - Remove redundant check for info.

 drivers/video/fbdev/s1d13xxxfb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 8048499e398d..d51ef7619115 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -721,9 +721,7 @@ static void s1d13xxxfb_fetch_hw_state(struct fb_info *info)
 		xres, yres, xres_virtual, yres_virtual, is_color, is_dual, is_tft);
 }
 
-
-static int
-s1d13xxxfb_remove(struct platform_device *pdev)
+static void __s1d13xxxfb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct s1d13xxxfb_par *par = NULL;
@@ -749,9 +747,18 @@ s1d13xxxfb_remove(struct platform_device *pdev)
 			pdev->resource[0].end - pdev->resource[0].start +1);
 	release_mem_region(pdev->resource[1].start,
 			pdev->resource[1].end - pdev->resource[1].start +1);
+}
+
+static int s1d13xxxfb_remove(struct platform_device *pdev)
+{
+	struct fb_info *info = platform_get_drvdata(pdev);
+
+	unregister_framebuffer(info);
+	__s1d13xxxfb_remove(pdev);
 	return 0;
 }
 
+
 static int s1d13xxxfb_probe(struct platform_device *pdev)
 {
 	struct s1d13xxxfb_par *default_par;
@@ -895,7 +902,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
 	return 0;
 
 bail:
-	s1d13xxxfb_remove(pdev);
+	__s1d13xxxfb_remove(pdev);
 	return ret;
 
 }
-- 
2.25.2

