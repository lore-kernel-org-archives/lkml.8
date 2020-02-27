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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30D4C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E8124699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZv8TNID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgB0MDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38128 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so3100322wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlvu3hS2FOo3jvYAFvg3HmupOT4tMbHUqUGMTdB0I0E=;
        b=BZv8TNIDUFwIG3XR5jTpC43/0HS4ISDRzsQP4QhE3dlcUIz/WeFLHmAXHaeIvwSsUq
         R7SxGRHjkL0zokvs3HwE2JaguZE7dCCSigW1UQSHM9lYsy4YaVzC7uJWR9YoDmutR03x
         rDkXLppqNkYUyr6cMX8MVshvl31rWo7RVgktxVt6SbKEj01xt2iQSuf6cY4rxAzdaSa+
         yyIxaYMV17Z8s68a5LXeKaKJpYZ3EitjrqNn85Vsp2s4h3NmP3WfGn0efg86p0CBe3s3
         P4zTMd9ufsIk4i2z03Exow5d+8y8vG29XoBfOoDj6fqkgMckKEEdc1+jeVPdvSyFCvak
         vHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlvu3hS2FOo3jvYAFvg3HmupOT4tMbHUqUGMTdB0I0E=;
        b=Z1/DAC0aLZQqnS6KDq9o/bR9yJ2s5pNlbmTkXObOT71jpFyOnieHZE3qsSRAHrRYLG
         RuFRP+3C6ureg5u+Qwto8HgO6DIinX5eLoxZnirH3R5Mcxi3zyWBwU3XHDYP1V1MHBNU
         nZOibfr5/aNDLGRa/cy+nF91HDUvM0lU2UnelPoVex2CogmUPliTiXHTN3YSiyWklt+x
         q8UymJEtuPiBGc0rJnkkydlOGzGZlk544M2ZGUUaV7CMYGDlMzyGky1vkYIk9n8ZP9gJ
         aUm08sNytQiCZCMGXidny4nsurntTjxlBQT8giL1KAWQrvf2zdkfDXE3ymTc5nxv20DL
         hMuw==
X-Gm-Message-State: APjAAAUuXBQ5BNcy4DlJs5tiqpUZJssRin8EcD/pUA8CuCcUCJIb/lLz
        4ftN4NJyUTAw2F/UzbIKc0w=
X-Google-Smtp-Source: APXvYqwLTKlxTSe9jq6sfhmtWPDKx6ENvxFA/rCWw8/Sac/kMbjC4rIqOFLUs/Tb4QLjqA2V3FeKrw==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5079981wmi.116.1582804994162;
        Thu, 27 Feb 2020 04:03:14 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:13 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 08/21] drm/etnaviv: remove check for return value of drm_debugfs function
Date:   Thu, 27 Feb 2020 15:02:19 +0300
Message-Id: <20200227120232.19413-9-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), drm_debugfs_create_file only
returns 0, and there is no need to check the return value.
This change therefore removes the check and error handling in
etnaviv_debugfs_init() and also makes the function return void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6b43c1c94e8f..a39735316ca5 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -231,21 +231,11 @@ static struct drm_info_list etnaviv_debugfs_list[] = {
 		{"ring", show_each_gpu, 0, etnaviv_ring_show},
 };
 
-static int etnaviv_debugfs_init(struct drm_minor *minor)
+static void etnaviv_debugfs_init(struct drm_minor *minor)
 {
-	struct drm_device *dev = minor->dev;
-	int ret;
-
-	ret = drm_debugfs_create_files(etnaviv_debugfs_list,
-			ARRAY_SIZE(etnaviv_debugfs_list),
-			minor->debugfs_root, minor);
-
-	if (ret) {
-		dev_err(dev->dev, "could not install etnaviv_debugfs_list\n");
-		return ret;
-	}
-
-	return ret;
+	drm_debugfs_create_files(etnaviv_debugfs_list,
+				 ARRAY_SIZE(etnaviv_debugfs_list),
+				 minor->debugfs_root, minor);
 }
 #endif
 
-- 
2.25.0

