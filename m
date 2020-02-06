Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A7EC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3510022314
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bmdEfnPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBFTSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:18:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42495 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgBFTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:18:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so8548876wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYTni/YaBkgYSQUn7nXBaoqEYGtf4zrlvskOsHha/TE=;
        b=bmdEfnPnck6nyJBX1ADt368GsRzqd4CbXNpRlPtBo14FVVOOROz0eUc6IapgJNTBwM
         xcfeQxcyE+uODfH2zu2aCS3Uo0jcRZ+YAH94rhk45tk0+ATLvcma94RKPGRE3hEQ9J9p
         /j6iWX/esvHtxwJy7Y5G3lJMGt9dGPGPHb0yRj6n62bS/OAF9Vjy6W8bTrK2uX+G6tN+
         ailRf0TH67OMFrt7Q0SKGEzZUGDQGs6RtOIELCL/Nn53VIhlgVbjc93mTQb2R5PcXo3e
         Am5rL0zAnodwNstQ4AA8fNadUMjwbI/qojOC2lJYz3BnUJXAdFKS/klFxMpXdlORMdVe
         Fzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYTni/YaBkgYSQUn7nXBaoqEYGtf4zrlvskOsHha/TE=;
        b=qdFf2Mt6ik+6xKCShNMizdDHKsSqbjzOUhUvr5Ra6viEjkii9PcjrLwkR8xKXxBHbA
         lhxvrFP34fjFt6q41E6Y5ISsg2TTMav7u/g1+Y9ZYBgFbvKL7jPCWK+x79CfkO3q7ax9
         UoBBggeIZAdqfjZTPIy1lBf6m0Dy6HlUJXNCWMt9YbEAkKLtjbNhSkX+4PM3H5qxCPE/
         jHGrWB2FmoR7zZjjAOs2Fu4f4sCw8zLixwB59UKceZdCV1He8Mkkueo+nKjfMwAeAnG0
         Y0QIAXww7eQ4AWOsr0HlnNvRvcGjoxmIvA3B1zDiV/GtUCoRVEon4SXvskzdsmuOv6vJ
         58KA==
X-Gm-Message-State: APjAAAUg6mOxqDSr3vMJXEm3kbqEZvJgm7wXRKpjyD0z+AfJcwHgCWlY
        Ld/fCTqpGXirGAeOMD9g0k6KKxbJOFAI3g==
X-Google-Smtp-Source: APXvYqwQ2YaIscLYLTZlPv5SR3uwVCyWbeNrLfCxatvYPEfxDKBWb2zLGGXHVocZnr1kFsNujoV31w==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr5253101wrv.196.1581016725325;
        Thu, 06 Feb 2020 11:18:45 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id m3sm272662wrs.53.2020.02.06.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:18:44 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] drm/meson: venc: make drm_display_mode const
Date:   Thu,  6 Feb 2020 20:18:29 +0100
Message-Id: <20200206191834.6125-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200206191834.6125-1-narmstrong@baylibre.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before switching to bridge funcs, make sure drm_display_mode is passed
as const to the venc functions.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
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

