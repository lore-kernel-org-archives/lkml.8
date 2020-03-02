Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C14F246D3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWfvCa6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCBKcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:32:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40807 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgCBKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:32:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id p5so1210521lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 02:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lA6XSsmPXQf5mrnzBqE57rsPnQlVgQ6Ap8oWgg7cT00=;
        b=MWfvCa6kEJXuqzXV+kdcxty1S6FBaGUOzTk1kthaaE069wtgI+P72vHB1qfIopivxZ
         gJnjPIXZssIAjc8d9yWRRd02fYWQ471YRC5NI9XMVu2XgWF/BUmJaS/TbvzIVy8PXdMe
         qx2VY3cvve2G/Te77pZjzix0EdrL9QeiNiv/lsHV/Ne8Bk63YQEv4IUd9alBuQd+oHyg
         BnTZWPFsRWSRCgo7I3PRDhVaFxe6pY7JSxzQQrcuIah8djX6u4wIx8mhlHvq+0xaCYOx
         WHoroY05ObJqdr+cXTp1nbklF7mBHcmNKw/W4CoEfVNIICla4LchTxlMy/FW/X2X0Ekr
         jsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lA6XSsmPXQf5mrnzBqE57rsPnQlVgQ6Ap8oWgg7cT00=;
        b=czNQDNSfrSZu+FOChi8mLf0KbXdF+xfattSH8AL3JChTa1TCBmM0443zJZ7OW4gQBC
         dvry2HS9XgqpdEAcsGTHquVN4lP1k/iHIuNSkGwdfAj25NSx1qLk7FzSrnAu9dVtudlQ
         Gyq7L9UnQpt7h7bm6L53iKL5uBeAoZYxn/1c7YDtPE5HYeWun4VVlpEGL5mEE0tPzqaI
         bYw0Hve9Es+75TTbnpmVAY6I71RzZdA6Yok74bY8/pOL9cKWcDMikhGafIFAW16+yEGr
         PBq9Y2G9BNuCRMz76TMcKj4Wgg0ihz+FQjBi8ohd66E1RChyjF6ZKy1cMljBlEh+sbRV
         bRQQ==
X-Gm-Message-State: ANhLgQ1cAgZE7Xu2eQi9jJGOpBOBckDX7hlJlbJ/HNr3hOMHP1Ke9cRE
        87/iE7NaNxbv09/GT2ljCSg=
X-Google-Smtp-Source: ADFU+vuNr0azHbfnA1i+aCmcAniY6aYZpgCbWZhAZTK4ySNU2/ubZ5sWytbt8JBkhYrTNwRVU8sN6A==
X-Received: by 2002:a19:915c:: with SMTP id y28mr10417617lfj.127.1583145148364;
        Mon, 02 Mar 2020 02:32:28 -0800 (PST)
Received: from localhost.localdomain ([149.255.131.2])
        by smtp.gmail.com with ESMTPSA id n21sm3895328lfh.2.2020.03.02.02.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 02:32:27 -0800 (PST)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH v4 1/4] drm/sun4i: Add alpha property for sun8i UI layer
Date:   Mon,  2 Mar 2020 12:31:35 +0200
Message-Id: <20200302103138.17916-2-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302103138.17916-1-r.stratiienko@gmail.com>
References: <.>
 <20200302103138.17916-1-r.stratiienko@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DE2.0 and DE3.0 UI layers supports plane-global alpha channel.
Add alpha property to the DRM plane and connect it to the
corresponding registers in mixer.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
v2: Initial commit by mistake
v3:
- Picked `reviewed-by` line
V4:
- Changed author e-mail to avoid mail rejecting.
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 29 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 19f42004cebe..5278032567a3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -72,6 +72,27 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
 	}
 }
 
+static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane)
+{
+	u32 mask, val, ch_base;
+
+	ch_base = sun8i_channel_base(mixer, channel);
+
+	mask = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK |
+		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK;
+
+	val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(plane->state->alpha >> 8);
+
+	val |= (plane->state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
+		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL :
+		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
+			   mask, val);
+}
+
 static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 				       int overlay, struct drm_plane *plane,
 				       unsigned int zpos)
@@ -258,6 +279,8 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 
 	sun8i_ui_layer_update_coord(mixer, layer->channel,
 				    layer->overlay, plane, zpos);
+	sun8i_ui_layer_update_alpha(mixer, layer->channel,
+				    layer->overlay, plane);
 	sun8i_ui_layer_update_formats(mixer, layer->channel,
 				      layer->overlay, plane);
 	sun8i_ui_layer_update_buffer(mixer, layer->channel,
@@ -332,6 +355,12 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 
 	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
 
+	ret = drm_plane_create_alpha_property(&layer->plane);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't add alpha property\n");
+		return ERR_PTR(ret);
+	}
+
 	ret = drm_plane_create_zpos_property(&layer->plane, channel,
 					     0, plane_cnt - 1);
 	if (ret) {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
index f4ab1cf6cded..e3e32ee1178d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -40,6 +40,11 @@
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(x)		((x) << 24)
+
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL		((0) << 1)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_LAYER		((1) << 1)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED	((2) << 1)
 
 struct sun8i_mixer;
 
-- 
2.17.1

