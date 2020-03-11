Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25AC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAF920736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="hPQCexlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgCKRJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:09:28 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:29593 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgCKRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:09:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 0471A3F7B1;
        Wed, 11 Mar 2020 18:09:25 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=hPQCexlx;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cz_VO7BgdaS5; Wed, 11 Mar 2020 18:09:20 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 379BD3F2CE;
        Wed, 11 Mar 2020 18:09:19 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 5B42A362EAA;
        Wed, 11 Mar 2020 18:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583946559; bh=NL/DzYHk3m2clWzYK7Ke75NpMUvhxbmPahNrqpDVM+w=;
        h=From:To:Cc:Subject:Date:From;
        b=hPQCexlxexyqsc6IGBvttwM6bwpEvhCknBMMjIMsQTjHfCtnuZ+aofEnEjc4VFpH8
         QFoEvQdBSg9AjeQiF82qXrb4lX+jiRTy0LN8HpQIfWPi3Snt7LMrHXCwQQ367lpq0x
         VzVFb1iCVi4/g6PAla7+RVricVM6o3r0YuNAj2ho=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>
Subject: [PATCH 1/2] drm/vmwgfx: Fix the refuse_dma mode when using guest-backed objects
Date:   Wed, 11 Mar 2020 18:08:38 +0100
Message-Id: <20200311170839.3617-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

When we refuse DMA from system pages for whatever reason, we don't
handle that correctly when guest-backed objects was enabled.
Since guest-backed objects by definition require DMA to and from
system pages, disable all functionality that relies on them.
That basically amounts to 3D acceleration and screen targets.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c | 3 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c    | 6 ++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c   | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 065015d2a8f6..3b41cf63110a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -1241,7 +1241,8 @@ int vmw_cmdbuf_set_pool_size(struct vmw_cmdbuf_man *man,
 		 * actually call into the already enabled manager, when
 		 * binding the MOB.
 		 */
-		if (!(dev_priv->capabilities & SVGA_CAP_DX))
+		if (!(dev_priv->capabilities & SVGA_CAP_DX) ||
+		    !dev_priv->has_mob)
 			return -ENOMEM;
 
 		ret = ttm_bo_create(&dev_priv->bdev, size, ttm_bo_type_device,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index cf3dc56d7cf4..f2ec3155468d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -682,8 +682,10 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 
 	ret = vmw_dma_select_mode(dev_priv);
 	if (unlikely(ret != 0)) {
-		DRM_INFO("Restricting capabilities due to IOMMU setup.\n");
+		DRM_INFO("Restricting capabilities since DMA not available.\n");
 		refuse_dma = true;
+		if (dev_priv->capabilities & SVGA_CAP_GBOBJECTS)
+			DRM_INFO("Disabling 3D acceleration.\n");
 	}
 
 	dev_priv->vram_size = vmw_read(dev_priv, SVGA_REG_VRAM_SIZE);
@@ -866,7 +868,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 		dev_priv->has_gmr = false;
 	}
 
-	if (dev_priv->capabilities & SVGA_CAP_GBOBJECTS) {
+	if (dev_priv->capabilities & SVGA_CAP_GBOBJECTS && !refuse_dma) {
 		dev_priv->has_mob = true;
 		if (ttm_bo_init_mm(&dev_priv->bdev, VMW_PL_MOB,
 				   VMW_PL_MOB) != 0) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 570687a1a327..68aecb6d9f87 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1888,7 +1888,7 @@ int vmw_kms_stdu_init_display(struct vmw_private *dev_priv)
 
 
 	/* Do nothing if Screen Target support is turned off */
-	if (!VMWGFX_ENABLE_SCREEN_TARGET_OTABLE)
+	if (!VMWGFX_ENABLE_SCREEN_TARGET_OTABLE || !dev_priv->has_mob)
 		return -ENOSYS;
 
 	if (!(dev_priv->capabilities & SVGA_CAP_GBOBJECTS))
-- 
2.21.1

