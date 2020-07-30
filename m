Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBEDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6362082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="KC3TWDmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgG3Osq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:48:46 -0400
Received: from crapouillou.net ([89.234.176.41]:35518 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Osp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596120516; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdoE1nkLDPbTG7FoC1IHhp8tIhNRgkzWtzI0H+/zMgQ=;
        b=KC3TWDmn1K7+LRoLXGczHqEpdLlgf0dZ/d9rTADan7xOdnYeqYhPcBLLYFkzwyFBVin8aE
        tMLvBhYZX7m4SZAiBwfjsI4MbjqTwhhApqK21WmODvvyX5AlDKwtm4Hj/nziIaccY8OKNq
        XLlRe5/RYoIehupCk5crTM7mg5VesCo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] drm/ingenic: ipu: Only restart manually on older SoCs
Date:   Thu, 30 Jul 2020 16:48:28 +0200
Message-Id: <20200730144830.10479-2-paul@crapouillou.net>
In-Reply-To: <20200730144830.10479-1-paul@crapouillou.net>
References: <20200730144830.10479-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On older SoCs, it is necessary to restart manually the IPU when a frame
is done processing. Doing so on newer SoCs (JZ4760/70) kinds of work
too, until the input or output resolutions or the framerate are too
high.

Make it work properly on newer SoCs by letting the LCD controller
trigger the IPU frame restart signal.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-ipu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index 7a0a8bd865d3..7eae56fa92ea 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -35,6 +35,7 @@ struct soc_info {
 	const u32 *formats;
 	size_t num_formats;
 	bool has_bicubic;
+	bool manual_restart;
 
 	void (*set_coefs)(struct ingenic_ipu *ipu, unsigned int reg,
 			  unsigned int sharpness, bool downscale,
@@ -645,7 +646,8 @@ static irqreturn_t ingenic_ipu_irq_handler(int irq, void *arg)
 	unsigned int dummy;
 
 	/* dummy read allows CPU to reconfigure IPU */
-	regmap_read(ipu->map, JZ_REG_IPU_STATUS, &dummy);
+	if (ipu->soc_info->manual_restart)
+		regmap_read(ipu->map, JZ_REG_IPU_STATUS, &dummy);
 
 	/* ACK interrupt */
 	regmap_write(ipu->map, JZ_REG_IPU_STATUS, 0);
@@ -656,7 +658,8 @@ static irqreturn_t ingenic_ipu_irq_handler(int irq, void *arg)
 	regmap_write(ipu->map, JZ_REG_IPU_V_ADDR, ipu->addr_v);
 
 	/* Run IPU for the new frame */
-	regmap_set_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_RUN);
+	if (ipu->soc_info->manual_restart)
+		regmap_set_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_RUN);
 
 	drm_crtc_handle_vblank(crtc);
 
@@ -806,6 +809,7 @@ static const struct soc_info jz4725b_soc_info = {
 	.formats	= jz4725b_ipu_formats,
 	.num_formats	= ARRAY_SIZE(jz4725b_ipu_formats),
 	.has_bicubic	= false,
+	.manual_restart	= true,
 	.set_coefs	= jz4725b_set_coefs,
 };
 
@@ -831,6 +835,7 @@ static const struct soc_info jz4760_soc_info = {
 	.formats	= jz4760_ipu_formats,
 	.num_formats	= ARRAY_SIZE(jz4760_ipu_formats),
 	.has_bicubic	= true,
+	.manual_restart	= false,
 	.set_coefs	= jz4760_set_coefs,
 };
 
-- 
2.27.0

