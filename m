Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C41C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3349E217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgATRGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:06:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38176 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:06:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 28AD3291322
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 2/5] drm/rockchip: Fix the device unbind order
Date:   Mon, 20 Jan 2020 14:05:59 -0300
Message-Id: <20200120170602.3832-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120170602.3832-1-ezequiel@collabora.com>
References: <20200120170602.3832-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cleanup the configuration, destroying the components
in the pipeline, the components must be present.

Therefore, cleanup the config first, and unbind the components
later.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 20ecb1508a22..ca12a35483f9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -108,6 +108,11 @@ static void rockchip_iommu_cleanup(struct drm_device *drm_dev)
 	iommu_domain_free(private->domain);
 }
 
+static void unbind_cleanup(void *data)
+{
+	drm_mode_config_cleanup((struct drm_device *)data);
+}
+
 static int rockchip_drm_bind(struct device *dev)
 {
 	struct drm_device *drm_dev;
@@ -140,13 +145,13 @@ static int rockchip_drm_bind(struct device *dev)
 	rockchip_drm_mode_config_init(drm_dev);
 
 	/* Try to bind all sub drivers. */
-	ret = component_bind_all(dev, drm_dev);
+	ret = component_bind_all_or_cleanup(dev, drm_dev, unbind_cleanup);
 	if (ret)
-		goto err_mode_config_cleanup;
+		goto err_free;
 
 	ret = drm_vblank_init(drm_dev, drm_dev->mode_config.num_crtc);
 	if (ret)
-		goto err_unbind_all;
+		goto err_drm_cleanup;
 
 	drm_mode_config_reset(drm_dev);
 
@@ -158,7 +163,7 @@ static int rockchip_drm_bind(struct device *dev)
 
 	ret = rockchip_drm_fbdev_init(drm_dev);
 	if (ret)
-		goto err_unbind_all;
+		goto err_drm_cleanup;
 
 	/* init kms poll for handling hpd */
 	drm_kms_helper_poll_init(drm_dev);
@@ -171,10 +176,9 @@ static int rockchip_drm_bind(struct device *dev)
 err_kms_helper_poll_fini:
 	drm_kms_helper_poll_fini(drm_dev);
 	rockchip_drm_fbdev_fini(drm_dev);
-err_unbind_all:
-	component_unbind_all(dev, drm_dev);
-err_mode_config_cleanup:
+err_drm_cleanup:
 	drm_mode_config_cleanup(drm_dev);
+	component_unbind_all(dev, drm_dev);
 	rockchip_iommu_cleanup(drm_dev);
 err_free:
 	drm_dev->dev_private = NULL;
@@ -193,8 +197,8 @@ static void rockchip_drm_unbind(struct device *dev)
 	drm_kms_helper_poll_fini(drm_dev);
 
 	drm_atomic_helper_shutdown(drm_dev);
-	component_unbind_all(dev, drm_dev);
 	drm_mode_config_cleanup(drm_dev);
+	component_unbind_all(dev, drm_dev);
 	rockchip_iommu_cleanup(drm_dev);
 
 	drm_dev->dev_private = NULL;
-- 
2.25.0

