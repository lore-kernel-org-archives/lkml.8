Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7132C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947532074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dcDygH+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgDFFMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 01:12:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34764 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgDFFMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 01:12:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so5468945plm.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 22:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6G7y8QFHpxPoNxMI7C/eKVE0aY7FMH8n0m08py+N9o=;
        b=dcDygH+3H7RfJ8k3R9ugCj5Hu0PXxS2To/zA0WK7GU/A/MQo9xuqp2ojj5PJIpWcUa
         wtz5YOxKZA3vTWb7f4arNcS8lhf6CjzI2pDNTSmxr+VZFdX15TsG3B2NoSixDhezYpxo
         eWnEEkkOmHM9HB/RD/iD01J7tktIBu4CBba5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6G7y8QFHpxPoNxMI7C/eKVE0aY7FMH8n0m08py+N9o=;
        b=T+vBuqr/8BLoiOarGpbvuRZKIDYv3TvlNq3XZl5PHuqphZUULbyW1oElfquHzRb4kR
         +RSv25rs/JLNdzP6CeCzNaYi/dnlB2c/UGDqtcdOr8LV8uMC60aScistV9hRvlJNUqGl
         esTPzeF53lU+2/XiZjoQKFb3uOq5WdJ8Axh82OUpywN19PoO9drD2oUrAB8doiAP6TLx
         8CmbMLfcuueAh3BNUZFBX13OctGlnHvpaYtv/NUW6mi9w2dQlfYsomXFiKQZ0axCplwM
         d5IzYqQA/vNn6XcotOh0WL+En/+daLjcBA9C0zsVB7Hq9mcklZJJsHWkQl2hk60HWL31
         STig==
X-Gm-Message-State: AGi0PuZoOfRd9gFythxysWzchZ7IzIqE2109T8G9HvrQpGMCfeFp6lgq
        Dl/gCvlFC+pPmDYXg5WWEhy7DA==
X-Google-Smtp-Source: APiQypIIXfPCYmCJ6Az4vd/oeMZuklz0Lp206sJXppbut8+ldlWVk5HoXoCqx3VSKUh3QlHRXs0OSQ==
X-Received: by 2002:a17:902:9f8e:: with SMTP id g14mr18309768plq.289.1586149920348;
        Sun, 05 Apr 2020 22:12:00 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id r63sm10727776pfr.42.2020.04.05.22.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 22:11:59 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: mediatek: fix device passed to cmdq
Date:   Mon,  6 Apr 2020 13:11:32 +0800
Message-Id: <20200406051131.225748-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm device is now probed from mmsys. We need to use mmsys device to get gce
nodes. Fix following errors:

[    0.740068] mediatek-drm mediatek-drm.1.auto: error -2 can't parse gce-client-reg property (0)
[    0.748721] mediatek-drm mediatek-drm.1.auto: error -2 can't parse gce-client-reg property (0)
...
[    2.659645] mediatek-drm mediatek-drm.1.auto: failed to request channel
[    2.666270] mediatek-drm mediatek-drm.1.auto: failed to request channel

Fixes: 1d367541aded ("soc / drm: mediatek: Fix mediatek-drm device probing")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 6 ++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 615a54e60fe2..8621f0289399 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -822,14 +822,16 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	mtk_crtc->cmdq_client =
-			cmdq_mbox_create(dev, drm_crtc_index(&mtk_crtc->base),
+			cmdq_mbox_create(mtk_crtc->mmsys_dev,
+					 drm_crtc_index(&mtk_crtc->base),
 					 2000);
 	if (IS_ERR(mtk_crtc->cmdq_client)) {
 		dev_dbg(dev, "mtk_crtc %d failed to create mailbox client, writing register by CPU now\n",
 			drm_crtc_index(&mtk_crtc->base));
 		mtk_crtc->cmdq_client = NULL;
 	}
-	ret = of_property_read_u32_index(dev->of_node, "mediatek,gce-events",
+	ret = of_property_read_u32_index(mtk_crtc->mmsys_dev->of_node,
+					 "mediatek,gce-events",
 					 drm_crtc_index(&mtk_crtc->base),
 					 &mtk_crtc->cmdq_event);
 	if (ret)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index e2bb0d19ef99..dc78e86bccc0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -517,7 +517,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
 				goto err_node;
 			}
 
-			ret = mtk_ddp_comp_init(dev, node, comp, comp_id, NULL);
+			ret = mtk_ddp_comp_init(dev->parent, node, comp,
+						comp_id, NULL);
 			if (ret) {
 				of_node_put(node);
 				goto err_node;
-- 
2.26.0.292.g33ef6b2f38-goog

