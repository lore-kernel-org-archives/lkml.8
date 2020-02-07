Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B56C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3181B20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eiiOqXCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBGEYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:24:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39963 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgBGEYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:24:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so461768plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 20:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4CLMTIbjn78HyIw3MbTj9fsK/Q9HVmk1YRH08HvFW4=;
        b=eiiOqXCQpKTTs3qcK0ClTRSeD0ED+jYP1J9vmKsXeIxVqH7nb3dGN8TXf1xmZgDlwZ
         y2cRaE8wwKl+xqQwb9n1WEutzhlXPKh+ksiz8uU4xYzGVv9hHFpOq1Zh4lOqB+UysOVM
         nlPGDQkicWj7hfppZ1DzZB4KXiZedkDnLILEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4CLMTIbjn78HyIw3MbTj9fsK/Q9HVmk1YRH08HvFW4=;
        b=qjc31qFnX8X+dcYVet4HwNRGRI8t77hBBHsNX3/ZnUcxHmrmUzD3vynm2GP53rPys5
         TxNb5amiZqZ4jZGY43H1dVCsew/GbwLm3oIdjLxNHzbJi9CD7FIw1ttOJLXa915B+x/v
         lQhyI/YySgI4yCpP7eA1MgAj9H+ms3TSoWggyLuA7K/8Hqbrb0VqqLMcxn+N2ghgMS5S
         rGX7VXlDyFUxLKxS3y6xfUC395cI9HpgMMJAetCRpUXdSjOEzdRC6oyb7nYKO/0PRIYc
         MPB0zXGnyttm3h2r6qQWFFm1Wqvp2yKJCpaj/3Zn35vZiU8IPqUzAwgWgQIe7+OOXNby
         mxWg==
X-Gm-Message-State: APjAAAXnH+F9rveLxDbz403blyY9qCq5S3gPHCWc1zjeot0Ep9VBmhCm
        HTDURQBsvDa+MbcaZN2ruYFgFp6xnFCiXQ==
X-Google-Smtp-Source: APXvYqxiM3mqXCuN//rbnMylmv3QEfgT2tAo0lrKJQKSE7Su2Tg5GR9a9AXOc66j0jtTmDYhbnQnRw==
X-Received: by 2002:a17:90a:3ae5:: with SMTP id b92mr1540962pjc.26.1581049438091;
        Thu, 06 Feb 2020 20:23:58 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:1105:3e8a:838d:e326])
        by smtp.gmail.com with ESMTPSA id v7sm950245pfn.61.2020.02.06.20.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 20:23:57 -0800 (PST)
From:   Evan Benn <evanbenn@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Evan Benn <evanbenn@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/mediatek: Find the cursor plane instead of hard coding it
Date:   Fri,  7 Feb 2020 15:23:51 +1100
Message-Id: <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200206140140.GA18465@art_vandelay>
References: <20200206140140.GA18465@art_vandelay>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cursor and primary planes were hard coded.
Now search for them for passing to drm_crtc_init_with_planes

Signed-off-by: Evan Benn <evanbenn@chromium.org>
---

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 7b392d6c71cc..935652990afa 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -658,10 +658,18 @@ static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
 
 static int mtk_drm_crtc_init(struct drm_device *drm,
 			     struct mtk_drm_crtc *mtk_crtc,
-			     struct drm_plane *primary,
-			     struct drm_plane *cursor, unsigned int pipe)
+			     unsigned int pipe)
 {
-	int ret;
+	struct drm_plane *primary = NULL;
+	struct drm_plane *cursor = NULL;
+	int i, ret;
+
+	for (i = 0; i < mtk_crtc->layer_nr; i++) {
+		if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_PRIMARY)
+			primary = &mtk_crtc->planes[i];
+		else if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_CURSOR)
+			cursor = &mtk_crtc->planes[i];
+	}
 
 	ret = drm_crtc_init_with_planes(drm, &mtk_crtc->base, primary, cursor,
 					&mtk_crtc_funcs, NULL);
@@ -830,9 +838,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			return ret;
 	}
 
-	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
-				mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
-				NULL, pipe);
+	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, pipe);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.0.341.g760bfbb309-goog

