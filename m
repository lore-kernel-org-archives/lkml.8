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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440CC34048
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D45A24656
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI/uH1xI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBRR2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34386 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so2681076wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxzxVwtma/sV1OQLWFOvLbYDQnp164egmH9oHWBKQVY=;
        b=SI/uH1xIfGPD62vOdOEf7CHgVLuavz+9UnHb0QSFE1QC7srr+PLLyPC4Wouwv/q3wb
         EghJWSRtEEmtL06aNjYJVegEuXoSCBPSXvT3hz3216Jrcleq1EXIeFyThIdSwhUGjg7s
         lakD2jP63CuPYBsWpVDEOLF2orsp6BAHUtYZ4Jl+QY89p7I+M9n6X24EPrZxgCgvvbv6
         2SGkyWXj8erV/x2GssFTXboxcMLFMuxpAdTa/8mAdRc5h2Q/TjPTkdA3YODmdPinCsRj
         J/pLbAl0iEq8OrEsBQSsZkb6Gl5CoLoZzsnVOPM6qnVstc1X9cZth1qHLRtNCEhdrG6F
         Yd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxzxVwtma/sV1OQLWFOvLbYDQnp164egmH9oHWBKQVY=;
        b=k6+nLHlR8TESDamaARWGAh3TAF+sbAq0P8cX5PifMoktNG/lKi0DyoeZpvWhQsTrvU
         WhoGJUH8aP0m3zFfPpMR99aAGNCjtr63650ULQNK40bIHrt1Z58BcO7Y/1NlqO/4SWl2
         ipnzNw/alUMOtuAz/gKidFflDvHdHRxuA+jWWgQnWQPo0C0TJjR5Mv9T7f+nLm0bfJoh
         G36LANiPlZtr18JSi9dPi0g1rSm1ROIRxM14hM0DY6L9FtDAT4vm1xQZfTsxaFa2Ivru
         zIOXKstLnJa570t+q5r0TECev4jrJ4vAQwtP0lRy5e72Rtt+SbeLZue0xPSUj/wCbR5f
         stEg==
X-Gm-Message-State: APjAAAWtVTWNhN7G7whHeBQsuNJb894iFH1Kw5k98gPiOAd2+wTSq44v
        RYPNUEIT7KOcraSJrOXySp8=
X-Google-Smtp-Source: APXvYqzYLL3egDD8D+n9GtknUJLIOCGz2zsS+wJ285OUyyD0DtU9qnJklm62Ceb7raBfb6FtI0omRw==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr4442372wme.83.1582046923100;
        Tue, 18 Feb 2020 09:28:43 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:28:42 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     linux+etnaviv@armlinux.org.uk, l.stach@pengutronix.de,
        christian.gmeiner@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] drm/etnaviv: remove check for return value of drm_debugfs function
Date:   Tue, 18 Feb 2020 20:28:15 +0300
Message-Id: <20200218172821.18378-4-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no need to check the return value if
drm_debugfs_create_files, remove the check and error handling in
etnaviv_debugfs_init and have the function return 0 directly.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6b43c1c94e8f..a65d30a48a9d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -233,19 +233,11 @@ static struct drm_info_list etnaviv_debugfs_list[] = {
 
 static int etnaviv_debugfs_init(struct drm_minor *minor)
 {
-	struct drm_device *dev = minor->dev;
-	int ret;
-
-	ret = drm_debugfs_create_files(etnaviv_debugfs_list,
-			ARRAY_SIZE(etnaviv_debugfs_list),
-			minor->debugfs_root, minor);
+	drm_debugfs_create_files(etnaviv_debugfs_list,
+				 ARRAY_SIZE(etnaviv_debugfs_list),
+				 minor->debugfs_root, minor);
 
-	if (ret) {
-		dev_err(dev->dev, "could not install etnaviv_debugfs_list\n");
-		return ret;
-	}
-
-	return ret;
+	return 0;
 }
 #endif
 
-- 
2.25.0

