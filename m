Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA827C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B282820789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ujq4taOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgCXOU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:20:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53133 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgCXOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:20:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id z18so3397437wmk.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBEY6IZdpR56nXsPUK2cFqYc8DeNfrXDbwpY0flDUNU=;
        b=Ujq4taOC53EX1VPxJIgX0apsuybWLHZBAKegJRrf/6iNtbxxaFxidGswTmXhcSbMeS
         5Xw3ZVu/LmLaXCJcuW8EMPuv9z7UYqeNNGxgLAQ6VinOKxZvBF/JnMPnZMfv87Rd4h5x
         QI1vyPTYzCjWy/FZgINt6zQKZQd/3dhqTrXo6uDt5z1xtyg5B7IY9IoQ53kXeZwpBs4L
         qcEzw7jIKeAWHn1oyzhZHE1t2mkKVCEZSRS+Lm9l6zcwA1TCayaFEaU7efzyfrGQKe/h
         srTZdxNIRvztfg6C9z37mIq4oy5+ODSMBiID77DGBu3wnQ9RmzjIbGgcHiF/ptrkmn+J
         h/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBEY6IZdpR56nXsPUK2cFqYc8DeNfrXDbwpY0flDUNU=;
        b=LJ4w6YVMyCGvXwe40DMton2VYcLdo1G/ZiB4mLsjwHfxXMz/7l9RmaoJXYFkyiGsPL
         fB8QIFo9K1D6SyXLYNMPOMfA/Cpd6HrtQ/0YnlL1vbZvSebPgAxcIZ/qjhaN+iNU9HZd
         7qSGqmi0LxFC7lTC2hXNasqg4tGz0lQs17Gd6NDR4fk5UdZRW8IOeTOe0618PEF+GuFa
         wh11umnvHscwzmD4jBrsAWx9dhoQFjMHXFEMReiMgk48mtz8/QiEd/8VdwVpdlmDQRsu
         Q7NFaN2XFLm7U8GEZCIX70IRyEDNLtNJP5WGUgru5lsIgTp7gBx+w6bSIJrA0VqQ/pwj
         MXxw==
X-Gm-Message-State: ANhLgQ0DYuzfFIOk1iHzbfsOV/f0lMt1WIijh7esFvbEECOmM9t+FOai
        FUHMlYFdk1gf34YkMyd3g/Yw8g==
X-Google-Smtp-Source: ADFU+vvOnCjmbsfdy/PDaPF1ocXefI+ISW1golVVq0SNsJU1J64MUUy13XNRUmg4TPFrYbXH1WjhsQ==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr4817627wmi.1.1585059625706;
        Tue, 24 Mar 2020 07:20:25 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o4sm28688472wrp.84.2020.03.24.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:20:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] drm/meson: add Amlogic Video FBC registers
Date:   Tue, 24 Mar 2020 15:20:11 +0100
Message-Id: <20200324142016.31824-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324142016.31824-1-narmstrong@baylibre.com>
References: <20200324142016.31824-1-narmstrong@baylibre.com>
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
index 8ea00546cd4e..08631fdfe4b9 100644
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
+#define		VD1_AXI_SEL_AFBC		(1 << 12)
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

