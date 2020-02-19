Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28813C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8908208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWvoQLwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBSEiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:38:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41059 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgBSEiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:38:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so9021256plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 20:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wyqz/1IxHBeAeMfC2NP6oUGVH86hCvXiXyWJMK0KcrY=;
        b=cWvoQLwDZ+lWVPPmRYI9nVWMMlZ7CGifcoAQ9rv/5NmgVMEEKrfC28QzEtsdEHbats
         scchNfc/jSkLlsxp9F/hvAEJ8BOkEhWTlIU/OxPGH+eRhT3Yg7NE/v+XZ9DmYsOWvHof
         veKmi10YcracWLwofnliFA7o6hD8aNpeU7liqHPPXcwrw5hB6/EU87fCxT+5s8rwNMIy
         O7f5NvHDDFGkRyjhh4P/hQ7pxCIfVGZ2TLvdA+7M1VqJ4hFJKtwfLIpdSfrS6a6LAd18
         hhhzaDkEXDtjl7JcAo3ygC6GGtLkHX/NfkYqbUoCe58X5RqeKQzjM7Di51rGapmY0GLu
         oriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wyqz/1IxHBeAeMfC2NP6oUGVH86hCvXiXyWJMK0KcrY=;
        b=C72SrUf0J+eW8XfGJqTCyP1gFQtVLJVPk3fR2QHMQMee97PP+anO8L2824YCW3n8xp
         0dS8PQ7NtnxXvQPmMZUV2cZ9NFzyvqIJi59ALvXLzVOIeD/11ui/JwJVQR1nEsq9Zkyi
         l4po1KiBoxcs28YEtdxTaH5Tf5n5nTBoB0UWhzjSaIBgM9JGxjHKMysO+IFAiBNJq9Qr
         K8ZzmHtjSCRN64fFjixNX7+PGj+mA/QEf49Pt38GedYQ6kzTfXEtYMFVctMiZlWqsoie
         XH3G+66TtlkwgoxpRD8K7D1GGfLVyB/w3RfwlYEHd49lM4/oSlz038mat1gp/eXO9eqX
         qPWA==
X-Gm-Message-State: APjAAAVQbKwtvng08FdVJIbbYSgtHto+CpLQqSEHiJksqze7dXxbD3MN
        hxfT8pvGE3Qk69ch6mr5VXHCckmD0KM=
X-Google-Smtp-Source: APXvYqz9W2eWUB/i10L9fsdaVYRvioFGo1JZXiDNgfJ4E9+wACPDewnsUa1aStp6I6VdrrjgoNcmPQ==
X-Received: by 2002:a17:90a:d990:: with SMTP id d16mr6800277pjv.143.1582087081356;
        Tue, 18 Feb 2020 20:38:01 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o73sm536053pje.7.2020.02.18.20.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:38:00 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm: kirin: Revert "Fix for hikey620 display offset problem"
Date:   Wed, 19 Feb 2020 04:37:58 +0000
Message-Id: <20200219043758.122552-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ff57c6513820efe945b61863cf4a51b79f18b592.

With the commit ff57c6513820 ("drm: kirin: Fix for hikey620
display offset problem") we added support for handling LDI
overflows by resetting the hardware.

However, its been observed that when we do hit the LDI overflow
condition, the irq seems to be screaming, and we do nothing but
stream:
  [drm:ade_irq_handler [kirin_drm]] *ERROR* LDI underflow!
over and over to the screen

I've tried a few appraoches to avoid this, but none has yet
been successful and the cure here is worse then the original
disease, so revert this for now.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Fixes: ff57c6513820 ("drm: kirin: Fix for hikey620 display offset problem")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_ade_reg.h   |  1 -
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 20 -------------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
index 0da860200410..e2ac09894a6d 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
@@ -83,7 +83,6 @@
 #define VSIZE_OFST			20
 #define LDI_INT_EN			0x741C
 #define FRAME_END_INT_EN_OFST		1
-#define UNDERFLOW_INT_EN_OFST		2
 #define LDI_CTRL			0x7420
 #define BPP_OFST			3
 #define DATA_GATE_EN			BIT(2)
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 73cd28a6ea07..86000127d4ee 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -46,7 +46,6 @@ struct ade_hw_ctx {
 	struct clk *media_noc_clk;
 	struct clk *ade_pix_clk;
 	struct reset_control *reset;
-	struct work_struct display_reset_wq;
 	bool power_on;
 	int irq;
 
@@ -136,7 +135,6 @@ static void ade_init(struct ade_hw_ctx *ctx)
 	 */
 	ade_update_bits(base + ADE_CTRL, FRM_END_START_OFST,
 			FRM_END_START_MASK, REG_EFFECTIVE_IN_ADEEN_FRMEND);
-	ade_update_bits(base + LDI_INT_EN, UNDERFLOW_INT_EN_OFST, MASK(1), 1);
 }
 
 static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
@@ -304,17 +302,6 @@ static void ade_crtc_disable_vblank(struct drm_crtc *crtc)
 			MASK(1), 0);
 }
 
-static void drm_underflow_wq(struct work_struct *work)
-{
-	struct ade_hw_ctx *ctx = container_of(work, struct ade_hw_ctx,
-					      display_reset_wq);
-	struct drm_device *drm_dev = ctx->crtc->dev;
-	struct drm_atomic_state *state;
-
-	state = drm_atomic_helper_suspend(drm_dev);
-	drm_atomic_helper_resume(drm_dev, state);
-}
-
 static irqreturn_t ade_irq_handler(int irq, void *data)
 {
 	struct ade_hw_ctx *ctx = data;
@@ -331,12 +318,6 @@ static irqreturn_t ade_irq_handler(int irq, void *data)
 				MASK(1), 1);
 		drm_crtc_handle_vblank(crtc);
 	}
-	if (status & BIT(UNDERFLOW_INT_EN_OFST)) {
-		ade_update_bits(base + LDI_INT_CLR, UNDERFLOW_INT_EN_OFST,
-				MASK(1), 1);
-		DRM_ERROR("LDI underflow!");
-		schedule_work(&ctx->display_reset_wq);
-	}
 
 	return IRQ_HANDLED;
 }
@@ -919,7 +900,6 @@ static void *ade_hw_ctx_alloc(struct platform_device *pdev,
 	if (ret)
 		return ERR_PTR(-EIO);
 
-	INIT_WORK(&ctx->display_reset_wq, drm_underflow_wq);
 	ctx->crtc = crtc;
 
 	return ctx;
-- 
2.17.1

