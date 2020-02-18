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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF6CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639502464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXCr3MwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBRR2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51969 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so3632795wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t79WR+N+O/xLx5EnVWrI0Bo3jvdlkHF5FexB0Coc0e4=;
        b=SXCr3MwKdGml/kqRlZx4Xh4HTwEskmbeNPapQbWyh/0AFZLtr7H0LjfEQ/QreiBVFZ
         yYR7oqLZp0tLk5n0qtUrPIY/YsoxjvX9WHdxo39RNOd/9ompVe//5LAONCw+ZvpX3c2e
         CcX1mtyKAL70MMo0vvlzbCRWKDZyjdpNoWFf5O8tPwsunHyazKYcpQX1CMD13poeMMFe
         vXegohfcsya/9OJxOU66FTUnUf8QO56vawRumP2jQgsPuzVnINSXgllL1FF0AUh4k9fm
         +IEw1P/m/TfUYtpaqnVrRyX/txLl4Zvy1bB7BoLUsuN3eyM0GNty0jskgQ9goi/lD/XO
         eAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t79WR+N+O/xLx5EnVWrI0Bo3jvdlkHF5FexB0Coc0e4=;
        b=QJ5wOM8YWwKYBQsf0e+H+oou1l43FLJDsyj4Ue31btGjWgi8T3cFmyrd5zJPCikl42
         VkodJ4zgbg5caCjveh2sGjhIn42xkt+AdxQ28bG/VZIVrDhHLrwzS+1kOxSDZoobH0Yw
         +yzEwFLBDEZITrZ4itYDK+HdSVj78+SRJzxSbv5JyMqoGbZiC11D3OoDGqLdMcg7Ncpd
         P141qSdnC9OMLTASS0Z6oFUbwEFqA/WXUqfCO6C00Qt7hRVgnrUkbjsc3rm8AStleX78
         Nh/od5Db7h7Wiong6/cif23elsvbd1D4q/kOjcxDizVgTSayKO8DqerLR1ntBF2wzWin
         PTvw==
X-Gm-Message-State: APjAAAWqyrtF7+8w/H+cAR+p8S+8ewA3CKhKN6mmL5k/sw0Z0cxo8CMs
        OtaRAw/gYidOII4abtnR5wQ=
X-Google-Smtp-Source: APXvYqzEklauFIvbHoHH6Q4TOD2OrcGCFpTLs5/jFW8oZl6MOSuEwmS7hrvyc7XPl7s5DXAKl7VxXA==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr3986014wmb.99.1582046910216;
        Tue, 18 Feb 2020 09:28:30 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:28:29 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     abrodkin@synopsys.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/arc: make arcpgu_debugfs_init return 0
Date:   Tue, 18 Feb 2020 20:28:12 +0300
Message-Id: <20200218172821.18378-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As drm_debugfs_create_files should return void, remove its use as the
return value of arcpgu_debugfs_init and have the latter function
return 0 directly.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/arc/arcpgu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
index d6a6692db0ac..660b25f9588e 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -139,8 +139,10 @@ static struct drm_info_list arcpgu_debugfs_list[] = {
 
 static int arcpgu_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(arcpgu_debugfs_list,
-		ARRAY_SIZE(arcpgu_debugfs_list), minor->debugfs_root, minor);
+	drm_debugfs_create_files(arcpgu_debugfs_list,
+				 ARRAY_SIZE(arcpgu_debugfs_list),
+				 minor->debugfs_root, minor);
+	return 0;
 }
 #endif
 
-- 
2.25.0

