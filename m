Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5363FC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AAF20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgCOTmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:42:49 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:52908 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgCOTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 15:42:49 -0400
Received: from localhost.localdomain ([93.22.37.174])
        by mwinf5d57 with ME
        id Ejij2200K3lSDvh03jijNx; Sun, 15 Mar 2020 20:42:47 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Mar 2020 20:42:47 +0100
X-ME-IP: 93.22.37.174
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, dianders@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/msm: Fix an error handling path 'msm_drm_init()'
Date:   Sun, 15 Mar 2020 20:42:39 +0100
Message-Id: <20200315194239.28785-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If this memory allocation fails, we have to go through the error handling
path to perform some clean-up, as already done in other other paths of
this function.

Fixes: db735fc4036b ("drm/msm: Set dma maximum segment size for mdss")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/msm/msm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 2a82c23a6e4d..29295dee2a2e 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -444,8 +444,10 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	if (!dev->dma_parms) {
 		dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
 					      GFP_KERNEL);
-		if (!dev->dma_parms)
-			return -ENOMEM;
+		if (!dev->dma_parms) {
+			ret = -ENOMEM;
+			goto err_msm_uninit;
+		}
 	}
 	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
-- 
2.20.1

