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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84417C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3FF24695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMJX/X0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgB0MD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36252 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id f19so940875wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtHezE3UGL1RPYJOwBTjyDIi0Fh4N6k97/ik2JLlTsM=;
        b=TMJX/X0S8sBJVi0Yp1uUUHmgnXpAO/i1XPye+sdM84ZXBcJFwfGuRbf0QmdaNi5v6+
         WWs3HrfR+0tNL6/ctrvxd/vP556Ce6RZvgrl1hkmaKA1c9dxIsZ2Y7lOS24IeQwXHXv9
         e31xzGLy7AaM9+eoo5mFcNSF33Z6WfCXZX7uZCSCQ9EvNL4U6YWUQiGNectCr3YpFa+X
         gmpWJRW6j0+OrhUChyYwCCP0MV7mCK4tjF3qBjxVwDjROE2oRJeo5W0zZRh4aWZtoFMd
         59+b4OgpXT6Dg63JnxaVfhNV3y4w9ChKczgBJd3tMh+yk/ZIvdmtLkYTM7pmxxn7N+kZ
         qSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtHezE3UGL1RPYJOwBTjyDIi0Fh4N6k97/ik2JLlTsM=;
        b=CHSlJDkc/Yd/1QbUkvkZ/WyzWKzRJwZadKmd25biXYObfWs5e4qyEo7HEgf3PThg8t
         4kQJCdSKr4z3xlkQ025zJQzS9FnsYUzEvTZzfpmDZNCZU7USR1XcSrQsXvggUIJI07X4
         jwNA9vadStf7agb8vYzPoh8LgItbNmOIcE3QKaYHuctZYsE0jY3s7bjkbWvHC3LY99kv
         DogDOedrV8h16W1YPtPM+SMj93vU6Z0uS2nZVwcKTImOhFoyDNyOb1cgRI697FulJXar
         y1vpPE0gkGY9qOMDP+Po4d0n7Wp1twtzrkX418GiYZ7tpOC8dIbhPD/9GTyHPYqh5ikz
         NYhw==
X-Gm-Message-State: APjAAAUOtA74qJ/I2Fk5wMbtwUMppCT2ONwMtuQ7eamXfaVUAbPj427d
        74g+Vrt42RbmqXihvn1J1C6kikCuN1Bdfg==
X-Google-Smtp-Source: APXvYqws1uPMjBRoMVkeVqz7GBquunp9ZSqYKqUnCjXmOFLkbEp4mvdi77iUzZXlZKIR+Os1fu9FAQ==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr2127251wmm.79.1582805036202;
        Thu, 27 Feb 2020 04:03:56 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:55 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/21] drm/mipi_dbi: make midi_dbi_debugfs_init() return void.
Date:   Thu, 27 Feb 2020 15:02:30 +0300
Message-Id: <20200227120232.19413-20-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As midi_dbi_debugfs_init() never fails and does not return anything
other than zero, declare its return value as void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 6 +-----
 include/drm/drm_mipi_dbi.h     | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 558baf989f5a..113a767442d3 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -1308,10 +1308,8 @@ static const struct file_operations mipi_dbi_debugfs_command_fops = {
  * controller or getting the read command values.
  * Drivers can use this as their &drm_driver->debugfs_init callback.
  *
- * Returns:
- * Zero on success, negative error code on failure.
  */
-int mipi_dbi_debugfs_init(struct drm_minor *minor)
+void mipi_dbi_debugfs_init(struct drm_minor *minor)
 {
 	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(minor->dev);
 	umode_t mode = S_IFREG | S_IWUSR;
@@ -1320,8 +1318,6 @@ int mipi_dbi_debugfs_init(struct drm_minor *minor)
 		mode |= S_IRUGO;
 	debugfs_create_file("command", mode, minor->debugfs_root, dbidev,
 			    &mipi_dbi_debugfs_command_fops);
-
-	return 0;
 }
 EXPORT_SYMBOL(mipi_dbi_debugfs_init);
 
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index 33f325f5af2b..30ebdfd8a51f 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -192,7 +192,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 })
 
 #ifdef CONFIG_DEBUG_FS
-int mipi_dbi_debugfs_init(struct drm_minor *minor);
+void mipi_dbi_debugfs_init(struct drm_minor *minor);
 #else
 #define mipi_dbi_debugfs_init		NULL
 #endif
-- 
2.25.0

