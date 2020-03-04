Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926EDC3F2DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F7821741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XcGhPvIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbgCDKl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46131 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387870AbgCDKlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so1728755wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/8VSn4BSTxpxifrr9xpvRTdlmzrHeBSw3JBloziieU=;
        b=XcGhPvIsT0kOHFNFSXWK3ZzMv8C4/UFyZ5LndTo1MXYOxVPx1j05mGkqc9FC3we4bK
         lT/qwwtVuTAO0Y4yNF2qNNQj9eEDMm9NGQDPEhzCMPQJpStz5U0u8Vu6qAj21Dv3r5Dz
         j6gwWGbKE+TYPkBcrM/+aPFcXpCFg6yqfVxqQ2vCPiSz/1szy/72S5wzUqs1akUl2wDb
         Vp4Bakgqk6bff6UnSxKng+RT+u48v4bo16TI3vic6gtfvWqH6IdB1JuzlwwzbDkRJnjO
         q7ScHi3ErH7DvyZBOni0R+2M2cWWUxWFbAhxwSWCCUiUHS118MKFQE6RmZjkyMJ3jMXT
         WrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/8VSn4BSTxpxifrr9xpvRTdlmzrHeBSw3JBloziieU=;
        b=soqz5Eo+0RtG/z8srNKkKzvl8mtMUVknZ41N9c1lypNliewmMhlTm79XmgWL2TB31R
         GDy2ecHCYU5JGPvno9v49vO6UHxZWh5liVF4JXNO5rdbndcKPjQWkG9K0JVZr/+CHPE4
         Zmka6mD5fEqDpH62UuZPc/RDJ44YVo4J4ij+5+n4fVPjFQes5+ybgW56ayP0BW9zyhj2
         N1Z1xyHY1yNOnmFAHEaGj7IN8KScIbDyFrfI+YjUyWnaYuyWelReM4Vh40DJD1/0If2B
         pO5KaqrmoNKCut0qB3mateS3emf/zT+EQJbtbLUkNFdYqxKgGQrVfZpMLTDFr7HMvCo3
         DAdA==
X-Gm-Message-State: ANhLgQ07Wb1SRTL455L9dnNgdhKFF+sgWr15pGXmfyaZIBtXiPhLa44A
        6SN9HeSNq4evJzcGqOmpOF5cmw==
X-Google-Smtp-Source: ADFU+vtfXrxN7a2jFW3uC2w7Gx3F9vuEUPrqanyTm8wR2pFQVZu8Rn/8XgSfGjhXG7zZ/D0PEvMr6g==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr3338076wrw.47.1583318465253;
        Wed, 04 Mar 2020 02:41:05 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:41:04 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 06/11] drm/meson: venc: make drm_display_mode const
Date:   Wed,  4 Mar 2020 11:40:47 +0100
Message-Id: <20200304104052.17196-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200304104052.17196-1-narmstrong@baylibre.com>
References: <20200304104052.17196-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before switching to bridge funcs, make sure drm_display_mode is passed
as const to the venc functions.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/meson/meson_venc.c | 2 +-
 drivers/gpu/drm/meson/meson_venc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 4efd7864d5bf..a9ab78970bfe 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -946,7 +946,7 @@ bool meson_venc_hdmi_venc_repeat(int vic)
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
 
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
-			      struct drm_display_mode *mode)
+			      const struct drm_display_mode *mode)
 {
 	union meson_hdmi_venc_mode *vmode = NULL;
 	union meson_hdmi_venc_mode vmode_dmt;
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 576768bdd08d..1abdcbdf51c0 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -60,7 +60,7 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
 void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			       struct meson_cvbs_enci_mode *mode);
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
-			      struct drm_display_mode *mode);
+			      const struct drm_display_mode *mode);
 unsigned int meson_venci_get_field(struct meson_drm *priv);
 
 void meson_venc_enable_vsync(struct meson_drm *priv);
-- 
2.22.0

