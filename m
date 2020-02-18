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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEA6C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33536208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9um02Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgBRR3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:29:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37996 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:29:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so3827777wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKHpAHwQO0ZJNB1lrvAWzx1AGPBc49IojeZLdlNmXVA=;
        b=u9um02XzQH1NC/AWZlnP0B2eL8HnanaORyx0WuuW4GOlOuuI9t55KV26Fr67Cih48y
         1FphTc4b+rqeHwGn21O1HiPsN6DJc+cO3vf3vl/cSnJyyrk/n37cBVVZXX+ZmbkG/Kl2
         PNsa7UaJse1lGqNVhmxkCByyEtbOomYxZ138Frp8mbMwdkJzTPHCA58U/bkzzAf6bUry
         9nDhH1cVa+fExqcL7UDNaCtsCsnx6gGUdcr/M9w/XI8IA/fAzRZDL+bgS1shSZkH+14L
         i5uRZaxGI8CAcpbSFvJWqE1irvKrPvS21uXYZPmLvybR/rNTv9RhYx9fmCkpos2oK+IC
         RjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKHpAHwQO0ZJNB1lrvAWzx1AGPBc49IojeZLdlNmXVA=;
        b=Zs6M5uRF0Hj5R1JLspFqtNiUnCo+rAD/wCcoIh368GB7S+LtcuCyQloBjyjAdDWQ7o
         0UoJCVIrvX4nquw7HGO6Vw+zXE9lKMZGOippv8mSIOBrRb/PjCPkzLhTB8/ivaw2Ixtm
         Fyx6NNy7oURilmaAqiE0vod0GY4GifeKN2RUmpnE7J8vrhVjoFbubQi6JDm6R8SlzK4P
         beBnMPEw2k6n+YBa+gf2f7TzKoVFWhqF8Myhdi8SA98KyBenJra7k9f6Tg6ezseKF55N
         zsGP+KS6h6eltsfA6KpYEMvTDieZ/rZhRk+QxhG5euq0wyqoIZ9D/mbvUXjVVXtTgYX+
         SP4A==
X-Gm-Message-State: APjAAAW5P1NIPPe2feYV7copq38bwIKgE3GOmUgRvGOw/suN2vgNjyUC
        Z0oknyVZWEz06LyhEJTyDt4=
X-Google-Smtp-Source: APXvYqwlLVc9vTdSjRtRyYwlcbrlOH7LvyED2+7ucGHibiIydghiVg8qYqdOGPDXj/JvzKz60NJXjQ==
X-Received: by 2002:a1c:b08a:: with SMTP id z132mr4421044wme.73.1582046946804;
        Tue, 18 Feb 2020 09:29:06 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:29:05 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] drm/vram-helper: make drm_vram_mm_debugfs_init return 0
Date:   Tue, 18 Feb 2020 20:28:20 +0300
Message-Id: <20200218172821.18378-9-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As drm_debugfs_create_files() should return 0, remove its use as the
return value of drm_vram_mm_debugfs_init(), and have the function return
0 directly.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 92a11bb42365..77b36a2286f9 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1043,19 +1043,16 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
  * @minor: drm minor device.
  *
  * Returns:
- * 0 on success, or
- * a negative error code otherwise.
+ * 0
  */
 int drm_vram_mm_debugfs_init(struct drm_minor *minor)
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
+	return 0;
 }
 EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
 
-- 
2.25.0

