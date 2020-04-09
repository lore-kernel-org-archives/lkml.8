Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92EBC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7603820757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L1WRbXtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDIGCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:02:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41040 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgDIGCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:02:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id m13so4483337pgd.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 23:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIZVAq7xeySwQmWqTMtWLzT3ZnpjRce1QK8YJF3B6lA=;
        b=L1WRbXtfVXrT3HXPWD00KG1nxuFSYrWBgXFk4bRo9iE2SQC73JN4rDwGcVRRLRd76w
         5840611TdDz7Jp7c8mLSuUuEAaUCM2OD6SGmXB8Blb4eyN/OXSWfgn7pk/WgYfn3Juwt
         9uDSZVlPK7PibTEsypLQ/DEdelkme+qsc1Pag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIZVAq7xeySwQmWqTMtWLzT3ZnpjRce1QK8YJF3B6lA=;
        b=DvKi/Drcvgx9inmdkvjd2Ahf2AbH6k9hdHpvW0gWYzvSnDOVngOrUbcBmqk8gzDyGa
         NHmcmDbFfrG0XymBvg3TSqaRYrtYHwyhg+Qckao8vlraW+3NMs/NdekgAz6tQoECT46Z
         xYTzdQeG6NY6s4xMWSlCsJMjWeqLyxIHeWjj1Z2LdK2Yi6iS7xZqCLkJMMxBnEzTq/jZ
         rfDJXXTplkm1mB4ORsjKAilb0yB4ipFbTAbKRC690AtKJZaSc14y6VHhRhtQu1TY1IiF
         bMctAuok2mS8F1whdpdBY8Ay3We7u7GKGgTo8war4YlGJ3i3+9ujTK5SRZxQtDeyqRWo
         gkPw==
X-Gm-Message-State: AGi0PuZbUvpCxt+8apfkxLbc+p9iY2DcC6XcomtPWKWSZK09HuUfUn/T
        7qxUUztJiTNJ0rnCA1zZLYogkg==
X-Google-Smtp-Source: APiQypJ9qI2t3pspPrOWIlE7/3vyVy7azmPo/Qc+dpNgwSnPI0bXNEXcIKDQeD8aDbDAZmL3cT8sHg==
X-Received: by 2002:aa7:99d1:: with SMTP id v17mr12234526pfi.165.1586412133880;
        Wed, 08 Apr 2020 23:02:13 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id w205sm18193515pfc.75.2020.04.08.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 23:02:13 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: mediatek: fix device passed to cmdq
Date:   Thu,  9 Apr 2020 14:02:09 +0800
Message-Id: <20200409060209.202677-1-hsinyi@chromium.org>
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
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
The patch is based on
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
branch v5.6-next/soc

Change log:
v1->v2:
align with 60fa8c13ab1a ("drm/mediatek: Move gce event property to mutex device node")
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 ++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 615a54e60fe2..7247c6f87f4a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -822,7 +822,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	mtk_crtc->cmdq_client =
-			cmdq_mbox_create(dev, drm_crtc_index(&mtk_crtc->base),
+			cmdq_mbox_create(mtk_crtc->mmsys_dev,
+					 drm_crtc_index(&mtk_crtc->base),
 					 2000);
 	if (IS_ERR(mtk_crtc->cmdq_client)) {
 		dev_dbg(dev, "mtk_crtc %d failed to create mailbox client, writing register by CPU now\n",
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index e2bb0d19ef99..28418e5b83ee 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -517,7 +517,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 				goto err_node;
 			}
 
-			ret = mtk_ddp_comp_init(dev, node, comp, comp_id, NULL);
+			ret = mtk_ddp_comp_init(dev->parent, node, comp, comp_id, NULL);
 			if (ret) {
 				of_node_put(node);
 				goto err_node;
-- 
2.26.0.292.g33ef6b2f38-goog

