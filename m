Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05898C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE968206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="flSVXLW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBTQ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:28:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34240 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgBTQ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:28:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so5381424wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4L5pErhEaYa7J2GkK43QrlafHtSEfJ6mEB5MQxQaGdU=;
        b=flSVXLW8+HCvS8lAoJdppN6qT5tWnzrNaEvEDnJmCgXcC2tk9cOjdv39eJrYBTrce6
         EE/1vV9CN8QbXXJsX0KSgeSB2gmE+JqHk9DjtSAUBjiL7T1KieNxc7BkDooT9hlfc32z
         Uoi7JJddr44DQ+YGv+YisVbx4co+nwyfkwRUHk+vsmmqGdilfxBKTuc6WKWpLbN6r6b0
         08mfBvTjdJmVCPuNVGCt3gzrs8JFmo2tI27Ped5uetie25Z8Bx+0kqR3Qp8WGFcfTdfl
         7derxVfCJGNu99SNb4n+lADjOUAjezljlLhQjh9H4Gm2LsMu9SILZx0lw+bn9TkZDCU9
         rstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4L5pErhEaYa7J2GkK43QrlafHtSEfJ6mEB5MQxQaGdU=;
        b=EL+xPhV8bKQNtwBw0WeD88OyvtMSlHBCkAtv9p11xNXaP5+h8X3suv+Elyppv2DYb4
         B6VC/YUYN/qoUNkiSfbeoYMaFzMmYm4TIYNDFXNzSZBfgpQhFJjnWQy5GRCd8pTWlOfc
         lPqaz5tcx5YOvBkHgVwELRuJ01iVjeuV5/w3J3RWekWqPua/rjLyXrKUodIKRGNwEeoZ
         1w3qa937ryZa8rueheW3y14Haw0R9C1spoy1nQ2adkxod6uMwWUVpdvQKks0PqRy+4ih
         apiDAJP6VfXZvdGQZX6eZWT6Vv8u21kzDkHzerTGv4+ooSjrfLMtOUDs3iwXEV8sF/b0
         yt3w==
X-Gm-Message-State: APjAAAW0B9DdLJEgW/pT702MQv6KYPJbSRSoNxNKxA38v1NMPp/Gp43H
        uJnHonLKD4zx3aA6KKz0U05KL0FtCrpd8Q==
X-Google-Smtp-Source: APXvYqz8btEuioC58lPL2CALueebDz5VNXjtrpbgzakzF4p5lCTfG1eLu+ErlTVF5foqpDnbiJSStA==
X-Received: by 2002:adf:f14b:: with SMTP id y11mr20564948wro.90.1582216082632;
        Thu, 20 Feb 2020 08:28:02 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c15sm104164wrt.1.2020.02.20.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:28:02 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/meson: add Amlogic Video FBC registers
Date:   Thu, 20 Feb 2020 17:27:56 +0100
Message-Id: <20200220162758.13524-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200220162758.13524-1-narmstrong@baylibre.com>
References: <20200220162758.13524-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the registers of the VPU VD1 Amlogic FBC decoder module, and routing
register.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 8ea00546cd4e..f784d7d1fe2e 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -144,10 +144,15 @@
 #define		VIU_SW_RESET_OSD1               BIT(0)
 #define VIU_MISC_CTRL0 0x1a06
 #define		VIU_CTRL0_VD1_AFBC_MASK         0x170000
+#define		VIU_CTRL0_AFBC_TO_VD1		BIT(20)
 #define VIU_MISC_CTRL1 0x1a07
 #define		MALI_AFBC_MISC			GENMASK(15, 8)
 #define D2D3_INTF_LENGTH 0x1a08
 #define D2D3_INTF_CTRL0 0x1a09
+#define VD1_AFBCD0_MISC_CTRL 0x1a0a
+#define		VD1_AXI_SEL_AFB			(1 << 12)
+#define		AFBC_VD1_SEL			(1 << 10)
+#define VD2_AFBCD1_MISC_CTRL 0x1a0b
 #define VIU_OSD1_CTRL_STAT 0x1a10
 #define		VIU_OSD1_OSD_BLK_ENABLE         BIT(0)
 #define		VIU_OSD1_OSD_MEM_MODE_LINEAR	BIT(2)
@@ -365,6 +370,23 @@
 #define VIU_OSD1_OETF_LUT_ADDR_PORT 0x1add
 #define VIU_OSD1_OETF_LUT_DATA_PORT 0x1ade
 #define AFBC_ENABLE 0x1ae0
+#define AFBC_MODE 0x1ae1
+#define AFBC_SIZE_IN 0x1ae2
+#define AFBC_DEC_DEF_COLOR 0x1ae3
+#define AFBC_CONV_CTRL 0x1ae4
+#define AFBC_LBUF_DEPTH 0x1ae5
+#define AFBC_HEAD_BADDR 0x1ae6
+#define AFBC_BODY_BADDR 0x1ae7
+#define AFBC_SIZE_OUT 0x1ae8
+#define AFBC_OUT_YSCOPE 0x1ae9
+#define AFBC_STAT 0x1aea
+#define AFBC_VD_CFMT_CTRL 0x1aeb
+#define AFBC_VD_CFMT_W 0x1aec
+#define AFBC_MIF_HOR_SCOPE 0x1aed
+#define AFBC_MIF_VER_SCOPE 0x1aee
+#define AFBC_PIXEL_HOR_SCOPE 0x1aef
+#define AFBC_PIXEL_VER_SCOPE 0x1af0
+#define AFBC_VD_CFMT_H 0x1af1
 
 /* vpp */
 #define VPP_DUMMY_DATA 0x1d00
-- 
2.22.0

