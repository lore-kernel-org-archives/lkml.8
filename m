Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32270C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0938924699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szuXZwZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgB0MDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54572 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id z12so3232456wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tv1b66VHXsMeh5NR7gAtTfq8XGx1hp57Pkw74uVLNqA=;
        b=szuXZwZCgGMpeKcpOVV11orhHMphZe60+AHcLd7eNz9P3yjVvMzvLiUJiUgshDCHpa
         b69cTkrGMy8WCkJBiF0Zb9E5ZbRLGeC/e0c085g2DAEZemzOtkaGzL72ivfodm71Ot3k
         G2Ts52SAJcX/MLV/0elGr0wDkE5RHTcenvSkcig8StUDKPsOKArtl3c7eAXdr3+/RFpC
         930eX7Ki1OEUEeHkWbpmL6wwZTjwdWtqe2vY+CbqhTslvLFKvqM59hGERsdQGJ03PUYN
         WKll6Yd5JNB5V5JyRJIRjI7TD4fW3UVVws72L+00NiTy40YVPi8y9iYoA0/Khxhp9qaY
         jd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tv1b66VHXsMeh5NR7gAtTfq8XGx1hp57Pkw74uVLNqA=;
        b=DcG3B5Aep8aTdgfN0cNlONKYfx3DBKhc4cB2ht/6CXYN1d/Q9lZ1nwBFPd+FcywSrz
         0ut/C99dbZ2tg13kMR6bIaNPtqj0Fw5dfPB3EIcz5NtzqWFqmiCHM+MOhYbXhtW9e02x
         /4t5DC+rNprSfqO0KtJ8Rk9lFeWDQfzZgzXybyJU1DDbppznF4XRQhmhGfWWx/Bvyz59
         9FyTjALg1nODIFlTF9wSu1Z2gkEdDEOkE8QxSBca+V071O3DpgFsfnOhPF35nfewvWWS
         UX8N/dcp6hOt5gsmaBQ0xkI49zynywGKdN1mHsIr94+7bEAK/yoT5YCnTrSqFx8zzYQa
         uupg==
X-Gm-Message-State: APjAAAVcg/U1zN2IHpod0HhtCBHUZnBexuN6TyweTgDU+bt835wLD1zW
        ZzcGzs6dol6qrmF7/Gh0C+4=
X-Google-Smtp-Source: APXvYqyZ45URLS4OCvwl7pFZT+ggkw0Dgp9j3XUU0EO03gCbFAzyTvmLPyx+BMGDfIJeegvYHNIrsg==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr1784802wmc.33.1582805014531;
        Thu, 27 Feb 2020 04:03:34 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:34 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/21] drm/omapdrm: remove checks for return value of drm_debugfs functions.
Date:   Thu, 27 Feb 2020 15:02:24 +0300
Message-Id: <20200227120232.19413-14-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
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
void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_debugfs.c | 29 +++++++-------------------
 drivers/gpu/drm/omapdrm/omap_drv.h     |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_debugfs.c b/drivers/gpu/drm/omapdrm/omap_debugfs.c
index 34dfb33145b4..b57fbe8a0ac2 100644
--- a/drivers/gpu/drm/omapdrm/omap_debugfs.c
+++ b/drivers/gpu/drm/omapdrm/omap_debugfs.c
@@ -80,31 +80,16 @@ static struct drm_info_list omap_dmm_debugfs_list[] = {
 	{"tiler_map", tiler_map_show, 0},
 };
 
-int omap_debugfs_init(struct drm_minor *minor)
+void omap_debugfs_init(struct drm_minor *minor)
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
-
-	if (ret) {
-		dev_err(dev->dev, "could not install omap_dmm_debugfs_list\n");
-		return ret;
-	}
-
-	return ret;
+		drm_debugfs_create_files(omap_dmm_debugfs_list,
+					 ARRAY_SIZE(omap_dmm_debugfs_list),
+					 minor->debugfs_root, minor);
 }
 
 #endif
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 7c4b66efcaa7..8a1fac680138 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -82,6 +82,6 @@ struct omap_drm_private {
 };
 
 
-int omap_debugfs_init(struct drm_minor *minor);
+void omap_debugfs_init(struct drm_minor *minor);
 
 #endif /* __OMAPDRM_DRV_H__ */
-- 
2.25.0

