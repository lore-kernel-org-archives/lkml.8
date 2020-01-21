Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72142C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A16224655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wduEk0Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgAUKOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:14:50 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40008 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbgAUKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:14:50 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LA7oZc022161;
        Tue, 21 Jan 2020 11:14:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=k5qJRWoSgLmpSjylS2Utl+lUx5HEle5o+YTZ31pLcBY=;
 b=wduEk0LvIblC2IcFcHYwE7nIdG53pbfzZg6CUixJoMHvLCga8LLYZHhVlTBWnnQnTYri
 KzCSJ4cKGDzV5Y+4Dvw4LniveJQjHSWRtvMyfdLC0JoXYi5nAkE3sdMaRlKF3dmc34Rd
 EVjTFgmnhvIw1pcfNmh1cIW0OQf/ApBZTe61MP6rKG7R1TUzMXo+SnxvHwcJ0r5DR2Tk
 1UZJo8+zw8HQNlAenjGRnyb+EnHKQdePG0DEXNUSTzIEFtZsW4OYOdLtKcUrZ+Z00RRR
 pxqwNi11kGkQEgNca1CGmj6BXh0+AB5lRCRGr3MfC6k75GAyXTcuJqGwKyAvZmaqcfCh wQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrc4x3h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 11:14:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1431510002A;
        Tue, 21 Jan 2020 11:14:36 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 04B062B1874;
        Tue, 21 Jan 2020 11:14:36 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jan 2020 11:14:35
 +0100
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: ltdc: check number of endpoints
Date:   Tue, 21 Jan 2020 11:14:33 +0100
Message-ID: <1579601673-7111-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-21,2020-01-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number of endpoints could exceed the fix value MAX_ENDPOINTS(2).
Instead of increase simply this value, the number of endpoint
could be read from device tree. Load sequence has been a little
rework to take care of several panel or bridge which can be
connected/disconnected or enable/disable.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 104 ++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index c2815e8..dba8e7f 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -42,8 +42,6 @@
 
 #define MAX_IRQ 4
 
-#define MAX_ENDPOINTS 2
-
 #define HWVER_10200 0x010200
 #define HWVER_10300 0x010300
 #define HWVER_20101 0x020101
@@ -1190,36 +1188,20 @@ int ltdc_load(struct drm_device *ddev)
 	struct ltdc_device *ldev = ddev->dev_private;
 	struct device *dev = ddev->dev;
 	struct device_node *np = dev->of_node;
-	struct drm_bridge *bridge[MAX_ENDPOINTS] = {NULL};
-	struct drm_panel *panel[MAX_ENDPOINTS] = {NULL};
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
 	struct drm_crtc *crtc;
 	struct reset_control *rstc;
 	struct resource *res;
-	int irq, ret, i, endpoint_not_ready = -ENODEV;
+	int irq, i, nb_endpoints;
+	int ret = -ENODEV;
 
 	DRM_DEBUG_DRIVER("\n");
 
-	/* Get endpoints if any */
-	for (i = 0; i < MAX_ENDPOINTS; i++) {
-		ret = drm_of_find_panel_or_bridge(np, 0, i, &panel[i],
-						  &bridge[i]);
-
-		/*
-		 * If at least one endpoint is -EPROBE_DEFER, defer probing,
-		 * else if at least one endpoint is ready, continue probing.
-		 */
-		if (ret == -EPROBE_DEFER)
-			return ret;
-		else if (!ret)
-			endpoint_not_ready = 0;
-	}
-
-	if (endpoint_not_ready)
-		return endpoint_not_ready;
-
-	rstc = devm_reset_control_get_exclusive(dev, NULL);
-
-	mutex_init(&ldev->err_lock);
+	/* Get number of endpoints */
+	nb_endpoints = of_graph_get_endpoint_count(np);
+	if (!nb_endpoints)
+		return -ENODEV;
 
 	ldev->pixel_clk = devm_clk_get(dev, "lcd");
 	if (IS_ERR(ldev->pixel_clk)) {
@@ -1233,6 +1215,43 @@ int ltdc_load(struct drm_device *ddev)
 		return -ENODEV;
 	}
 
+	/* Get endpoints if any */
+	for (i = 0; i < nb_endpoints; i++) {
+		ret = drm_of_find_panel_or_bridge(np, 0, i, &panel, &bridge);
+
+		/*
+		 * If at least one endpoint is -ENODEV, continue probing,
+		 * else if at least one endpoint returned an error
+		 * (ie -EPROBE_DEFER) then stop probing.
+		 */
+		if (ret == -ENODEV)
+			continue;
+		else if (ret)
+			goto err;
+
+		if (panel) {
+			bridge = drm_panel_bridge_add_typed(panel,
+							    DRM_MODE_CONNECTOR_DPI);
+			if (IS_ERR(bridge)) {
+				DRM_ERROR("panel-bridge endpoint %d\n", i);
+				ret = PTR_ERR(bridge);
+				goto err;
+			}
+		}
+
+		if (bridge) {
+			ret = ltdc_encoder_init(ddev, bridge);
+			if (ret) {
+				DRM_ERROR("init encoder endpoint %d\n", i);
+				goto err;
+			}
+		}
+	}
+
+	rstc = devm_reset_control_get_exclusive(dev, NULL);
+
+	mutex_init(&ldev->err_lock);
+
 	if (!IS_ERR(rstc)) {
 		reset_control_assert(rstc);
 		usleep_range(10, 20);
@@ -1268,7 +1287,6 @@ int ltdc_load(struct drm_device *ddev)
 		}
 	}
 
-
 	ret = ltdc_get_caps(ddev);
 	if (ret) {
 		DRM_ERROR("hardware identifier (0x%08x) not supported!\n",
@@ -1278,27 +1296,6 @@ int ltdc_load(struct drm_device *ddev)
 
 	DRM_DEBUG_DRIVER("ltdc hw version 0x%08x\n", ldev->caps.hw_version);
 
-	/* Add endpoints panels or bridges if any */
-	for (i = 0; i < MAX_ENDPOINTS; i++) {
-		if (panel[i]) {
-			bridge[i] = drm_panel_bridge_add_typed(panel[i],
-							       DRM_MODE_CONNECTOR_DPI);
-			if (IS_ERR(bridge[i])) {
-				DRM_ERROR("panel-bridge endpoint %d\n", i);
-				ret = PTR_ERR(bridge[i]);
-				goto err;
-			}
-		}
-
-		if (bridge[i]) {
-			ret = ltdc_encoder_init(ddev, bridge[i]);
-			if (ret) {
-				DRM_ERROR("init encoder endpoint %d\n", i);
-				goto err;
-			}
-		}
-	}
-
 	crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
 	if (!crtc) {
 		DRM_ERROR("Failed to allocate crtc\n");
@@ -1331,8 +1328,8 @@ int ltdc_load(struct drm_device *ddev)
 
 	return 0;
 err:
-	for (i = 0; i < MAX_ENDPOINTS; i++)
-		drm_panel_bridge_remove(bridge[i]);
+	for (i = 0; i < nb_endpoints; i++)
+		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
 
 	clk_disable_unprepare(ldev->pixel_clk);
 
@@ -1341,11 +1338,14 @@ int ltdc_load(struct drm_device *ddev)
 
 void ltdc_unload(struct drm_device *ddev)
 {
-	int i;
+	struct device *dev = ddev->dev;
+	int nb_endpoints, i;
 
 	DRM_DEBUG_DRIVER("\n");
 
-	for (i = 0; i < MAX_ENDPOINTS; i++)
+	nb_endpoints = of_graph_get_endpoint_count(dev->of_node);
+
+	for (i = 0; i < nb_endpoints; i++)
 		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
 
 	pm_runtime_disable(ddev->dev);
-- 
2.7.4

