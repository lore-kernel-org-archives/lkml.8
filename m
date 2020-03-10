Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FD824649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqSjKHGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgCJNcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39184 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgCJNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:32:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id f7so1352083wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PDXUNP0CNWIcOfZIatzfIp7MveLX2/j+5KT4VopvNc=;
        b=mqSjKHGj010PNQfFZwfvEAmV8ADnB1wWjI4PptouwtPF1tHRYa+/DX4AQxW14hNUIy
         yws6pL6lXIbp/OY5sKPGIpD+hiliV3ZIpgEaM2hRRoksOdzVTJhmUpUTPMkcXPQE70AM
         oaluGsvPDi9Ae258jTLONdHvwLzIaaLTz4ASzlhD0zMfanLXbc0aJktA/Z97UdNtnoTv
         BlxmaVfkLnP1Lg5RkSevCvFVdlINZNRcroScsQuOjIUz7eD8Q6v/e5jagkdBjmUsHTvL
         qP6T0H63x/A0Fxb38hSCohESNWEF3RklHtLnBF4BGVDPkpgdNNVBdGrnoVGoBT+JURVA
         KJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PDXUNP0CNWIcOfZIatzfIp7MveLX2/j+5KT4VopvNc=;
        b=T8EZpfuL7BYNK/rdy8fwMzhYJw3oI01OXJ1woJfekprsLXChVi+TwmYtNejx371e4L
         oJt6MjXFf1q1IxA3HWclQ2CTFymys9OLnL7mFmK6KZwpHj1T9ydXN6jYLiWvltF6xfJ9
         iIWDCsPT221cNFHFKVBWUuDRgk4xZrd28BMn7O6rl2CjQ0+Tnzmbfwbh9Ourk1WJ7DZQ
         UQkM6nvo6hTRa9KbCt4XDf/EOwp9d3TJNTWDIyeg5J4kKB7J28Iy1EqFpuVaG9GYblHx
         KbkJHoi65pIBK6v/FESQyGkWBLZ7QZjaX5AR77vaR6X6XbWRcftmHT3JzM8jLmOcEeSp
         lNpw==
X-Gm-Message-State: ANhLgQ3WQ8/duOu7+KXJ6YdWaFu7gQoNvH8QizgdPRyP2UonzN/8qBu3
        AN2V+YwsUyBHFCq6G/xTG6Q=
X-Google-Smtp-Source: ADFU+vv+T6EX42I7QsCPKFPJNMq6GUXg9pANHhKWydd9YqyV4Y93WsRrc5JL+R7T0hRAGNFYQNCtDA==
X-Received: by 2002:a05:600c:c8:: with SMTP id u8mr2236586wmm.178.1583847120433;
        Tue, 10 Mar 2020 06:32:00 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:59 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 13/17] drm/omap: remove checks for return value of drm_debugfs functions
Date:   Tue, 10 Mar 2020 16:31:17 +0300
Message-Id: <20200310133121.27913-14-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), there is no need to ever check
the return value for drm_debugfs_create_files(). Therefore remove the
checks for the return value and subsequent error handling in
omap_debugfs_init().

These changes also enables the changing of omap_debugfs_init() to return
0 directly.

v2: convert omap_debugfs_init() to return 0 instead of void to avoid
introduction of build issues and enable individual driver compilation.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_debugfs.c | 27 +++++++-------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_debugfs.c b/drivers/gpu/drm/omapdrm/omap_debugfs.c
index 34dfb33145b4..ed63dcced79a 100644
--- a/drivers/gpu/drm/omapdrm/omap_debugfs.c
+++ b/drivers/gpu/drm/omapdrm/omap_debugfs.c
@@ -82,29 +82,16 @@ static struct drm_info_list omap_dmm_debugfs_list[] = {
 
 int omap_debugfs_init(struct drm_minor *minor)
 {
-	struct drm_device *dev = minor->dev;
-	int ret;
-
-	ret = drm_debugfs_create_files(omap_debugfs_list,
-			ARRAY_SIZE(omap_debugfs_list),
-			minor->debugfs_root, minor);
-
-	if (ret) {
-		dev_err(dev->dev, "could not install omap_debugfs_list\n");
-		return ret;
-	}
+	drm_debugfs_create_files(omap_debugfs_list,
+				 ARRAY_SIZE(omap_debugfs_list),
+				 minor->debugfs_root, minor);
 
 	if (dmm_is_available())
-		ret = drm_debugfs_create_files(omap_dmm_debugfs_list,
-				ARRAY_SIZE(omap_dmm_debugfs_list),
-				minor->debugfs_root, minor);
+		drm_debugfs_create_files(omap_dmm_debugfs_list,
+					 ARRAY_SIZE(omap_dmm_debugfs_list),
+					 minor->debugfs_root, minor);
 
-	if (ret) {
-		dev_err(dev->dev, "could not install omap_dmm_debugfs_list\n");
-		return ret;
-	}
-
-	return ret;
+	return 0;
 }
 
 #endif
-- 
2.25.1

