Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F05C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 06:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F1620724
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 06:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgHVG6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 02:58:24 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:23552 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbgHVG6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 02:58:24 -0400
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app4 (Coremail) with SMTP id cS_KCgB3v__vwUBfK74zAQ--.24265S4;
        Sat, 22 Aug 2020 14:57:55 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        zhengbin <zhengbin13@huawei.com>, Jyri Sarha <jsarha@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        YueHaibing <yuehaibing@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drm/omap: Fix runtime PM imbalance on error
Date:   Sat, 22 Aug 2020 14:57:33 +0800
Message-Id: <20200822065743.13671-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgB3v__vwUBfK74zAQ--.24265S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr15ArW7ZF1xZr17WF1kAFb_yoWrAF1Dpr
        Wkta4jvryxAa13tr1DA3ZxXas8Wa1xZFyfGryUC3s3ua1rAa4Utr95AFWYvFyvkrWkAF17
        tFsrJrWavF1rKr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoSBlZdtPnBhAAwsv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter
even when it returns an error code. However, users of its
direct wrappers in omapdrm assume that PM usage counter will
not change on error. Thus a pairing decrement is needed on
the error handling path for these wrappers to keep the counter
balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Fix 5 additional similar cases in omapdrm.
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 7 +++++--
 drivers/gpu/drm/omapdrm/dss/dsi.c   | 7 +++++--
 drivers/gpu/drm/omapdrm/dss/dss.c   | 7 +++++--
 drivers/gpu/drm/omapdrm/dss/hdmi4.c | 6 +++---
 drivers/gpu/drm/omapdrm/dss/hdmi5.c | 6 +++---
 drivers/gpu/drm/omapdrm/dss/venc.c  | 7 +++++--
 6 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index 48593932bddf..599183879caf 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -653,8 +653,11 @@ int dispc_runtime_get(struct dispc_device *dispc)
 	DSSDBG("dispc_runtime_get\n");
 
 	r = pm_runtime_get_sync(&dispc->pdev->dev);
-	WARN_ON(r < 0);
-	return r < 0 ? r : 0;
+	if (WARN_ON(r < 0)) {
+		pm_runtime_put_noidle(&dispc->pdev->dev);
+		return r;
+	}
+	return 0;
 }
 
 void dispc_runtime_put(struct dispc_device *dispc)
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index eeccf40bae41..973bfa14a104 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -1112,8 +1112,11 @@ static int dsi_runtime_get(struct dsi_data *dsi)
 	DSSDBG("dsi_runtime_get\n");
 
 	r = pm_runtime_get_sync(dsi->dev);
-	WARN_ON(r < 0);
-	return r < 0 ? r : 0;
+	if (WARN_ON(r < 0)) {
+		pm_runtime_put_noidle(dsi->dev);
+		return r;
+	}
+	return 0;
 }
 
 static void dsi_runtime_put(struct dsi_data *dsi)
diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 6ccbc29c4ce4..d7b2f5bcac16 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -858,8 +858,11 @@ int dss_runtime_get(struct dss_device *dss)
 	DSSDBG("dss_runtime_get\n");
 
 	r = pm_runtime_get_sync(&dss->pdev->dev);
-	WARN_ON(r < 0);
-	return r < 0 ? r : 0;
+	if (WARN_ON(r < 0)) {
+		pm_runtime_put_noidle(&dss->pdev->dev);
+		return r;
+	}
+	return 0;
 }
 
 void dss_runtime_put(struct dss_device *dss)
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index 2578c95570f6..2cc804bdc2e4 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -44,10 +44,10 @@ static int hdmi_runtime_get(struct omap_hdmi *hdmi)
 	DSSDBG("hdmi_runtime_get\n");
 
 	r = pm_runtime_get_sync(&hdmi->pdev->dev);
-	WARN_ON(r < 0);
-	if (r < 0)
+	if (WARN_ON(r < 0)) {
+		pm_runtime_put_noidle(&hdmi->pdev->dev);
 		return r;
-
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index 4d4c1fabd0a1..92fe05d3da5a 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -45,10 +45,10 @@ static int hdmi_runtime_get(struct omap_hdmi *hdmi)
 	DSSDBG("hdmi_runtime_get\n");
 
 	r = pm_runtime_get_sync(&hdmi->pdev->dev);
-	WARN_ON(r < 0);
-	if (r < 0)
+	if (WARN_ON(r < 0)) {
+		pm_runtime_put_noidle(&hdmi->pdev->dev);
 		return r;
-
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm/dss/venc.c
index e0817934ee16..4844743fd507 100644
--- a/drivers/gpu/drm/omapdrm/dss/venc.c
+++ b/drivers/gpu/drm/omapdrm/dss/venc.c
@@ -361,8 +361,11 @@ static int venc_runtime_get(struct venc_device *venc)
 	DSSDBG("venc_runtime_get\n");
 
 	r = pm_runtime_get_sync(&venc->pdev->dev);
-	WARN_ON(r < 0);
-	return r < 0 ? r : 0;
+	if (WARN_ON(r < 0)) {
+		pm_runtime_put_noidle(&venc->pdev->dev);
+		return r;
+	}
+	return 0;
 }
 
 static void venc_runtime_put(struct venc_device *venc)
-- 
2.17.1

