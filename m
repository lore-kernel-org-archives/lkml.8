Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1667C34048
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C29820801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uevSn+j9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgBRR2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36389 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRR2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3833485wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ie5YGPYxd8lGggojJkvA6bITgwj0tY3zWA881s73+aw=;
        b=uevSn+j9agd4NIGL1xvTzNef3JpFjWh25FoMaLWR7noN8FpOOjdrTu1/yWss/4GUvs
         aRbwOiDPK5p5Y7CS/jAnFupVAfywCQtQ8uDECPMKnxSp9fut+BezKaonLeH7i/I4ffQq
         /EGU5E3QQGqsv+Ukk3jhGyRaQJeq403NFp4Vi0/M2wxsdbatjKTXCOmwRVS3p3chVUbX
         2zE13WHmRTYAaLmLl/PEe4qY0oy9Ein0QWAQntyPM3bF7L3zqmsQMZ2SSR1hae04NvcY
         k0sRW+qYoI3G/nb2t2Ft7YnYHbNgtAZb6mS2Vqhxb68G4hGhndap7ZWc/O9u9ddxK2gV
         fm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ie5YGPYxd8lGggojJkvA6bITgwj0tY3zWA881s73+aw=;
        b=ZdXzNCpO8+53pB0Xxl9J7wnq9V17+L6MT2mLhMULRTmLH1EmGMBSfbHUQ4vGZy2WaK
         uDzcOrWooAeiDPhhnB1eOHUMAnJvJwdF6R5ItZ5IJNqEyQN9h5yQgh+WSMZbofEGlwg7
         2mu2RML7Xm73l0KNVQrR876Sr0Dejes/HxDkicvfqKcfZq35tIclEZvbLkBNkPBtQF16
         sj2hWr19l+TWEPkmH5MXOIOkg9FT75x+mjv/m3FtRaNCAw404SsJQtkh2914PL64gNzQ
         rEyXb3WZw/jlDCMFqq6fYi1JZs5sHGo7uAudbMFvKuPhY2ZPtm7v7Wl0qSBcOsvTlP+t
         sR5Q==
X-Gm-Message-State: APjAAAUYBRx/alJ1LmtJnqKi9DYPPzxTZXpe9imJsu1qKdE1oK1QIrRk
        rLZIxCx2Bl6dYssPYRSsMBg=
X-Google-Smtp-Source: APXvYqxlLNXuC7m8cYGnNtZkvw2jXBqqjJApovuUMRpVfZCcm5M+2hds6XYi9gNneV08MEAMJLbSng==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr4043429wmj.7.1582046914607;
        Tue, 18 Feb 2020 09:28:34 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:28:34 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] drm/arm: make hdlcd_debugfs_init return 0
Date:   Tue, 18 Feb 2020 20:28:13 +0300
Message-Id: <20200218172821.18378-2-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As drm_debugfs_create_files should return void, remove its use as a
return value in hdlcd_debugfs_init and have the latter function return 0
directly.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 2e053815b54a..bd0ad6f46a97 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -226,8 +226,10 @@ static struct drm_info_list hdlcd_debugfs_list[] = {
 
 static int hdlcd_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(hdlcd_debugfs_list,
-		ARRAY_SIZE(hdlcd_debugfs_list),	minor->debugfs_root, minor);
+	drm_debugfs_create_files(hdlcd_debugfs_list,
+				 ARRAY_SIZE(hdlcd_debugfs_list),
+				 minor->debugfs_root, minor);
+	return 0;
 }
 #endif
 
-- 
2.25.0

