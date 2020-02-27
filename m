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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822EFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676224695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtiph7rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgB0MDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36474 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id j16so1457461wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6giR7jkVNS7f8olWtdVB9r9gFLVEFocgKkHFBXumSM=;
        b=qtiph7rTPwSvoI8X9dyOJvpnelDSW6j0fJ9qb82EkXIWN0iu4X5c4qBKwi4OJSat7t
         e25bYmOIjcLHWX11AkNRI9Hjvp2F1P0fSaitDVtKr4ICufmsHgHiVM4ikqJUroaKfRac
         ud40Z77NAFACV4PgRFMLvTEGYmxzdZzKeV7hbmgLUHbiIJYANJga4ZYWvQVFscPgw47+
         jjY3l/RZn6ep08kgkFPXD8vmSobd+hQvhNyyktqD7WbREkmlc5NlDh6NfpXAxbbdfvtE
         fT3XHQUdj42+YyccNOU/pFBRnX+4LB7gHr42btocC8WWHvWgWM/475ImAZdBMjN+LlSb
         YYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6giR7jkVNS7f8olWtdVB9r9gFLVEFocgKkHFBXumSM=;
        b=J4MKHZCBU7Idj5TAm7r+D1FstnA9WO9ht2EMB/49e3Cs7tW4Q+UzZxfM0Vdu9N9XNh
         mCIP1IeftQqrM1g1PfBT6o9TLyQrr5x3XHajoU2rxzcAMBAeB8QRheBQUTEF8gHJju0X
         3gDZVlLc9Sx06Y5hiMc4I2xCaYRd9j8UiO71i3vO2sDJBYSI1Mff5SkbDI1lVyLT72je
         zTMoQrzU1tDjdMs3RslpkZ+SCgdnP2K9bGggzDloB49CX8rvSZTNZfM3lmqK3Qm2L5eP
         +5nwzBCSB0U9HyUilrsrPqVqAQszF3aBKdnUEG7QBSG/uj2xIEaxN2JfdLRWRdLdDfQN
         +8Ug==
X-Gm-Message-State: APjAAAWGc6q7we306vwjw9PTWfVAVKfpaQxBRPXytgTh8que8h1kfoK6
        WW0zDh8lY8IP0NuMIwsiVvH/ab3b6jOvVg==
X-Google-Smtp-Source: APXvYqz2UYFvgu0Eu1AiFlAQOUZiIvr7aNsYGZxBKzzaL/wlRLO7BinAulm+0C+yFoZDQ0ISPP6ABA==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr4826270wrt.132.1582805017785;
        Thu, 27 Feb 2020 04:03:37 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:37 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie, Eric Anholt <eric@anholt.net>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/21] drm/pl111: make pl111_debugfs_init return void
Date:   Thu, 27 Feb 2020 15:02:25 +0300
Message-Id: <20200227120232.19413-15-wambui.karugax@gmail.com>
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
drm_debugfs_create_files() never fail) drm_debugfs_create_files()
should return void. Therefore, remove its use as the return value in
pl111_debugfs_init, and have the function declared as void instead.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/pl111/pl111_debugfs.c | 8 ++++----
 drivers/gpu/drm/pl111/pl111_drm.h     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_debugfs.c b/drivers/gpu/drm/pl111/pl111_debugfs.c
index 3c8e82016854..26ca8cdf3e60 100644
--- a/drivers/gpu/drm/pl111/pl111_debugfs.c
+++ b/drivers/gpu/drm/pl111/pl111_debugfs.c
@@ -51,10 +51,10 @@ static const struct drm_info_list pl111_debugfs_list[] = {
 	{"regs", pl111_debugfs_regs, 0},
 };
 
-int
+void
 pl111_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(pl111_debugfs_list,
-					ARRAY_SIZE(pl111_debugfs_list),
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(pl111_debugfs_list,
+				 ARRAY_SIZE(pl111_debugfs_list),
+				 minor->debugfs_root, minor);
 }
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 77d2da9a8a7c..ba399bcb792f 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -84,6 +84,6 @@ struct pl111_drm_dev_private {
 
 int pl111_display_init(struct drm_device *dev);
 irqreturn_t pl111_irq(int irq, void *data);
-int pl111_debugfs_init(struct drm_minor *minor);
+void pl111_debugfs_init(struct drm_minor *minor);
 
 #endif /* _PL111_DRM_H_ */
-- 
2.25.0

