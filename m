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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70677C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3589624698
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdInBT6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgB0MDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51688 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so3259513wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFKRLVR3En2qAyWAFyjSG1BfnWs6i3rEBFI+3Z3Uh14=;
        b=vdInBT6S+Cz7AIQeFEX/HBaX1a273oG5ysqqQNm6tMxsB11TcE6gB7Qk7dSWeJk+dR
         +UdWmHGvW/PT2YtbbK/p6BxPnkCfSkaXP60ZOmuwNesmvONeuAn/hneMI1pfBdhL0pBW
         TtEWwU4gp2vmK/cWYrqWWyGPF0Bk8fmwDpyAWbZly5vhqdXPVAXFR6VGTaNFFo+5S2gh
         DEtiqgzQUC41JK3cQ1LVa+siCwhhbGyvkPuOCbGFoRfVLZtYoc69I/8Ch6159+ee21E3
         2ZPsrUKSFCC2he7B22o8IFsQGT1CcU1NSHwhjNO7XgcfQnaWrOutEdrBvrc0/rf1GOQx
         +chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFKRLVR3En2qAyWAFyjSG1BfnWs6i3rEBFI+3Z3Uh14=;
        b=WzQZAWr5IJ6SWKvEQry/uOhKsKkSVoVVHnhHCB619l2ylKMjIpTmI1+jJjKIrqxFRc
         Rp7uAS/WaVGjlPcFCtOgjLGdMd41JSzqYs15LBL+e2h5xs5IkXzTxcHk2W9XA9p+L5BA
         /rCcDXDO3hlwiTXoXjmw74ZdYu5jx7lw9dArgARSUDFo7T+ShyHOYhpAqIgRQgCY5s4z
         vbc23iLHciCITvYd+ThcpqKwjs4dKV8a0+29gsQhbF1Y9+wWTxtoz7AyA8cLV2TQTV3H
         Ut2N2ofsUX2mv7FCflG51ABh5cM3jK5ptqA5Rzy0uwVqEZUtZQ74IYrJV89saDzEv7Ux
         1F1Q==
X-Gm-Message-State: APjAAAV/2QRXKliTS8lKJEfB/HpmDQIiMi1EKOsiGJjmh1GQ30qCzZgt
        UR1WSte3U3JrAqmNgbLqDlM=
X-Google-Smtp-Source: APXvYqzgXMIf7d0ygpseoochEgHCgZpMjbGcGRwlunhf+x0Lp5zstDVWt367HgvoaXcO0f8N7F5PJQ==
X-Received: by 2002:a1c:a443:: with SMTP id n64mr4733588wme.141.1582804977474;
        Thu, 27 Feb 2020 04:02:57 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:02:56 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/21] drm/vram-helper: make drm_vram_mm_debugfs_init() return void
Date:   Thu, 27 Feb 2020 15:02:15 +0300
Message-Id: <20200227120232.19413-5-wambui.karugax@gmail.com>
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
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails and should return void. Therefore, remove its use as the
return value of drm_vram_mm_debugfs_init(), and have the function
declared as void instead.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 14 ++++----------
 include/drm/drm_gem_vram_helper.h     |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 92a11bb42365..76506bedac11 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1042,20 +1042,14 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
  *
  * @minor: drm minor device.
  *
- * Returns:
- * 0 on success, or
- * a negative error code otherwise.
  */
-int drm_vram_mm_debugfs_init(struct drm_minor *minor)
+void drm_vram_mm_debugfs_init(struct drm_minor *minor)
 {
-	int ret = 0;
-
 #if defined(CONFIG_DEBUG_FS)
-	ret = drm_debugfs_create_files(drm_vram_mm_debugfs_list,
-				       ARRAY_SIZE(drm_vram_mm_debugfs_list),
-				       minor->debugfs_root, minor);
+	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
+				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
+				 minor->debugfs_root, minor);
 #endif
-	return ret;
 }
 EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
 
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 0f6e47213d8d..b63bcd1b996d 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -196,7 +196,7 @@ static inline struct drm_vram_mm *drm_vram_mm_of_bdev(
 	return container_of(bdev, struct drm_vram_mm, bdev);
 }
 
-int drm_vram_mm_debugfs_init(struct drm_minor *minor);
+void drm_vram_mm_debugfs_init(struct drm_minor *minor);
 
 /*
  * Helpers for integration with struct drm_device
-- 
2.25.0

