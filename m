Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3468C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AD62074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AMP42dGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgE2Qcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:32:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54875 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2Qcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:32:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200529163230euoutp0130793859f0e77fa2688bffb5cceab7c3~TjNd8ePyL1129311293euoutp01F
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:32:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200529163230euoutp0130793859f0e77fa2688bffb5cceab7c3~TjNd8ePyL1129311293euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590769950;
        bh=ZA0i9eHHG5iu5/RTCzNyz3w0SkS4Fkzs8grCQaAd27k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMP42dGdaoNciWAvezQNZhZOqLlFNpf5q4Q569M4OGLHmaxhtUMmSOutb1G4hXmpv
         5Pfki1rRO4k3rcAx1GHx7PtvCjoBrZWHQX1jrwqPuc0jk7PqAiaTs/kH/Lp7itYluV
         iu//CxdVlUvZHWUkuztdl6cFMTxqYiRtOvppEx0k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200529163230eucas1p17a7d2b6bfadc0e04b85afd2e276ad790~TjNdseh5o2226622266eucas1p1I;
        Fri, 29 May 2020 16:32:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.5D.61286.E1931DE5; Fri, 29
        May 2020 17:32:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde~TjNdXTWjd2862228622eucas1p2a;
        Fri, 29 May 2020 16:32:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529163229eusmtrp1babf093f6914f71910758ef451f0ee69~TjNdRHHOa2579525795eusmtrp1L;
        Fri, 29 May 2020 16:32:29 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-5f-5ed1391e0a89
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.25.07950.D1931DE5; Fri, 29
        May 2020 17:32:29 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163228eusmtip1d835c6b590f59bad320b4e50b49b9452~TjNcgtTCT1280712807eusmtip1F;
        Fri, 29 May 2020 16:32:28 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 6/6] drm: exynos: mixer: Add interconnect support
Date:   Fri, 29 May 2020 18:32:00 +0200
Message-Id: <20200529163200.18031-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529163200.18031-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7pylhfjDFo+cFrcn9fKaLFxxnpW
        i+tfnrNaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW9xuXMFm
        cfhNO6vFjMkv2Rz4PDat6mTzuHNtD5vH/e7jTB6bl9R79G1ZxejxeZNcAFsUl01Kak5mWWqR
        vl0CV8alyc/YCq5qVjQf/MTUwDhdqYuRk0NCwERi0Y/VLF2MXBxCAisYJfbPWccE4XxhlHi9
        ZBcLSJWQwGdGiacbrWE6Dl3eygxRtJxR4kD7VEaIIqCOtwtTQWw2AUOJ3qN9YHERAReJtqfz
        wFYwC+xhktg3+x2Qw8EhLOAh0TmzCKSGRUBVYsamJnaQMK+AtcSRTSoQu+QlVm84wAxicwrY
        SHT/mQFm8woISpyc+QTsNmagmuats8HukRC4xS5x+ccyRohmF4ltXavYIWxhiVfHt0DZMhKn
        J/ewQDQ0M0r07L7NDuFMYJS4f3wBVLe1xJ1zv9hALmIW0JRYv0sfIuwocbm/lxUkLCHAJ3Hj
        rSDEEXwSk7ZNZ4YI80p0tAlBVKtI/F41nQnClpLofvKfBcL2kOhqnsQ0gVFxFpJ3ZiF5ZxbC
        3gWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzEC09bpf8c/7WD8einpEKMAB6MSD2+F
        1sU4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2x
        JDU7NbUgtQgmy8TBKdXA6L7Z93jrct4em9nPGsU2xH+/0XV4obhHc/T7g/+Lp52aFtgrYHp0
        j89XlZZ/NeE7k9coT9D48e2UpoFP4Wb+rdMSI9cvVMqwvl7GfyXLbm7sfoWipNnr5v902fBV
        rpnhi+isgrCr6fZ6YYZCPydNKM8LbU3j5da+k8FhvXi1/Qv/HZ9O7V+yV4mlOCPRUIu5qDgR
        ADHSCiFXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7qylhfjDC6t17W4P6+V0WLjjPWs
        Fte/PGe1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt7jduILN
        4vCbdlaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n36NuyitHj8ya5ALYoPZui/NKSVIWM
        /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxLk5+xFVzVrGg++Imp
        gXG6UhcjJ4eEgInEoctbmbsYuTiEBJYyShxdfYmti5EDKCElMb8FqkZY4s+1LjaImk+MEmtv
        rmMHSbAJGEr0Hu1jBLFFBDwkTrWuZQUpYhY4wSTxpHcj2CBhoETnzCKQGhYBVYkZm5rYQcK8
        AtYSRzapQMyXl1i94QAziM0pYCPR/WcGmC0EVNL2eBYriM0rIChxcuYTFpBWZgF1ifXzhEDC
        zECtzVtnM09gFJyFpGoWQtUsJFULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbitmM/
        t+xg7HoXfIhRgINRiYf3gs7FOCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYf
        YjQF+mwis5Rocj4wTeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCU
        amDcsVOXaZrktxOqfqeLzit1By/pVl2XZemprlJnvaXPUdXLd2nzBbHiU5lFNswfe8MNt52J
        a4mTPqI4aVs6y8fjvnxMXZNuz5j8wqO6W2h5pe9fuxUWKx5qBSrkzUyIUG/Q/nj/p7mSxuo6
        NnOp6vX/W70Wdrpo3UvJmPMh6JjOsf53G6RNKpVYijMSDbWYi4oTAYOAGL/bAgAA
X-CMS-MailID: 20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163229eucas1p2ee6394f184e5eba12599559f8a621fde@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

This patch adds interconnect support to exynos-mixer. The mixer works
the same as before when CONFIG_INTERCONNECT is 'n'.

For proper operation of the video mixer block we need to ensure the
interconnect busses like DMC or LEFTBUS provide enough bandwidth so
as to avoid DMA buffer underruns in the mixer block. i.e we need to
prevent those busses from operating in low perfomance OPPs when
the mixer is running.
In this patch the bus bandwidth request is done through the interconnect
API, the bandiwidth value is calculated from selected DRM mode, i.e.
video plane width, height, refresh rate and pixel format.

Co-developed-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
[s.nawrocki: renamed soc_path variable to icc_path, edited commit desc.]
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v5:
 - renamed soc_path variable to icc_path
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 73 ++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 21b726b..bdae683 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -13,6 +13,7 @@
 #include <linux/component.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -98,6 +99,7 @@ struct mixer_context {
 	struct exynos_drm_crtc	*crtc;
 	struct exynos_drm_plane	planes[MIXER_WIN_NR];
 	unsigned long		flags;
+	struct icc_path		*icc_path;
 
 	int			irq;
 	void __iomem		*mixer_regs;
@@ -934,6 +936,42 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
 	mixer_reg_writemask(mixer_ctx, MXR_INT_EN, 0, MXR_INT_EN_VSYNC);
 }
 
+static void mixer_set_memory_bandwidth(struct exynos_drm_crtc *crtc)
+{
+	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
+	struct mixer_context *ctx = crtc->ctx;
+	unsigned long bw, bandwidth = 0;
+	u32 avg_bw, peak_bw;
+	int i, j, sub;
+
+	if (!ctx->icc_path)
+		return;
+
+	for (i = 0; i < MIXER_WIN_NR; i++) {
+		struct drm_plane *plane = &ctx->planes[i].base;
+		const struct drm_format_info *format;
+
+		if (plane->state && plane->state->crtc && plane->state->fb) {
+			format = plane->state->fb->format;
+			bw = mode->hdisplay * mode->vdisplay *
+							drm_mode_vrefresh(mode);
+			if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+				bw /= 2;
+			for (j = 0; j < format->num_planes; j++) {
+				sub = j ? (format->vsub * format->hsub) : 1;
+				bandwidth += format->cpp[j] * bw / sub;
+			}
+		}
+	}
+
+	/* add 20% safety margin */
+	bandwidth = bandwidth / 4 * 5;
+	dev_dbg(ctx->dev, "exynos-mixer: safe bandwidth %ld Bps\n", bandwidth);
+
+	avg_bw = peak_bw = Bps_to_icc(bandwidth);
+	icc_set_bw(ctx->icc_path, avg_bw, peak_bw);
+}
+
 static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct mixer_context *ctx = crtc->ctx;
@@ -985,6 +1023,7 @@ static void mixer_atomic_flush(struct exynos_drm_crtc *crtc)
 	if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
 		return;
 
+	mixer_set_memory_bandwidth(crtc);
 	mixer_enable_sync(mixer_ctx);
 	exynos_crtc_handle_event(crtc);
 }
@@ -1032,6 +1071,7 @@ static void mixer_atomic_disable(struct exynos_drm_crtc *crtc)
 	for (i = 0; i < MIXER_WIN_NR; i++)
 		mixer_disable_plane(crtc, &ctx->planes[i]);
 
+	mixer_set_memory_bandwidth(crtc);
 	exynos_drm_pipe_clk_enable(crtc, false);
 
 	pm_runtime_put(ctx->dev);
@@ -1223,12 +1263,22 @@ static int mixer_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct mixer_drv_data *drv;
 	struct mixer_context *ctx;
+	struct icc_path *path;
 	int ret;
 
+	/*
+	 * Returns NULL if CONFIG_INTERCONNECT is disabled.
+	 * May return ERR_PTR(-EPROBE_DEFER).
+	 */
+	path = of_icc_get(dev, NULL);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
 		DRM_DEV_ERROR(dev, "failed to alloc mixer context.\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 
 	drv = of_device_get_match_data(dev);
@@ -1236,6 +1286,7 @@ static int mixer_probe(struct platform_device *pdev)
 	ctx->pdev = pdev;
 	ctx->dev = dev;
 	ctx->mxr_ver = drv->version;
+	ctx->icc_path = path;
 
 	if (drv->is_vp_enabled)
 		__set_bit(MXR_BIT_VP_ENABLED, &ctx->flags);
@@ -1245,17 +1296,29 @@ static int mixer_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctx);
 
 	ret = component_add(&pdev->dev, &mixer_component_ops);
-	if (!ret)
-		pm_runtime_enable(dev);
+	if (ret < 0)
+		goto err;
+
+	pm_runtime_enable(dev);
+
+	return 0;
+
+err:
+	icc_put(path);
 
 	return ret;
 }
 
 static int mixer_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct mixer_context *ctx = dev_get_drvdata(dev);
+
+	pm_runtime_disable(dev);
+
+	component_del(dev, &mixer_component_ops);
 
-	component_del(&pdev->dev, &mixer_component_ops);
+	icc_put(ctx->icc_path);
 
 	return 0;
 }
-- 
2.7.4

