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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B7C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08932464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGq8d6zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgBRR2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33625 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so25024573wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zS4ft/vYKXfE+WleANo6vegk5u6xXjxUfiyGUHRUqRQ=;
        b=pGq8d6zwYjI+mQ8QceGCxr+PYF4+sY/8o7MKXhSYEtFsh3Nid96TVjuWpqbhbWrsq3
         VcC16WuLlI64bW2I99sbde/ZvK2hUlUqyc5ohpZFEuEc1KwE6YzriPJaSbE21HnM2DZG
         hWYDyojjafNov+pYyrxUFeTvw7PbrLFy4EceYgXNeE77/2HQNEpP8dqZt+KcgX7PZlAw
         Os0pCO/kkeAv+AUQD6COIADNj6qpTydR30o/F9+LXZo/twTAt6GHx+He9UogRiRR8ICW
         S2sATrpiY/ftoJ94+N3mykphyzwKFput3dIrOIULe3pY6+NKQ0k5Zhz8VudbvZ3NEhBZ
         /6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zS4ft/vYKXfE+WleANo6vegk5u6xXjxUfiyGUHRUqRQ=;
        b=tWTgBEL1rqveZHRNBsujwL8xE2JA94IrrvgZxO6g86Dfnb4HNaV8VTosVgbFMH2Xr+
         br4Qykey4Cy6fq2zxdhkEm8koyKwc0Cd6cTKMzJ1KzEKC4IFCDCjyFiqoObioD4DhXcO
         XN19t32cgHDFMgs9o0wxPdiSabCRJSefMwIn66F8q0hWht8jwIn9UwR1Qr3rjDtFo84K
         rIBWPJ2l2PKOUNLwYBibO6j4G5jbIkog3kqHywPiLnoVGcCrBCB0XzH4I+/JiQL2JiAx
         uI/C+d1Yz8Yort4jRfxL2rpfJX2QTW2dQ8OuYuQHJLYHxqa8b7uWFO0hpPPw7ghtrFQ3
         lsfA==
X-Gm-Message-State: APjAAAUn0S7QcsJaoflGZmepcJRGxMPGiwaNY5lLFzvPtkfJoWPtgHRj
        MBTAEu3aR3KULmqdTATzTejd3Y56cLQ=
X-Google-Smtp-Source: APXvYqwEG3yaKNXCA6VkkFFEcJLRAXQz5aVgp9S+xFNUYZCzMbVvk0wpBhd3k2EsPTbUCsiJmYVicg==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr29565396wrt.36.1582046919627;
        Tue, 18 Feb 2020 09:28:39 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:28:39 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH 1/2] drm/debugfs: remove checks for return value of drm_debugfs functions.
Date:   Tue, 18 Feb 2020 20:28:14 +0300
Message-Id: <20200218172821.18378-3-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no need to check the return value of
drm_debugfs_create_files, remove unnecessary checks and error handling
statement blocks.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_debugfs.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 4e673d318503..6a2f141b6a38 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -215,35 +215,17 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 	sprintf(name, "%d", minor_id);
 	minor->debugfs_root = debugfs_create_dir(name, root);
 
-	ret = drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
-				       minor->debugfs_root, minor);
-	if (ret) {
-		debugfs_remove(minor->debugfs_root);
-		minor->debugfs_root = NULL;
-		DRM_ERROR("Failed to create core drm debugfs files\n");
-		return ret;
-	}
+	drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
+				 minor->debugfs_root, minor);
 
 	if (drm_drv_uses_atomic_modeset(dev)) {
-		ret = drm_atomic_debugfs_init(minor);
-		if (ret) {
-			DRM_ERROR("Failed to create atomic debugfs files\n");
-			return ret;
-		}
+		drm_atomic_debugfs_init(minor);
 	}
 
 	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
-		ret = drm_framebuffer_debugfs_init(minor);
-		if (ret) {
-			DRM_ERROR("Failed to create framebuffer debugfs file\n");
-			return ret;
-		}
+		drm_framebuffer_debugfs_init(minor);
 
-		ret = drm_client_debugfs_init(minor);
-		if (ret) {
-			DRM_ERROR("Failed to create client debugfs file\n");
-			return ret;
-		}
+		drm_client_debugfs_init(minor);
 	}
 
 	if (dev->driver->debugfs_init) {
-- 
2.25.0

