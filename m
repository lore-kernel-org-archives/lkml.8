Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA07C2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q5ZNIUka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE2PTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgE2PTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:19:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50545C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:19:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so4094422wrv.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEt0VLaSvhUT7nyu4RhagnuYQaTu9Oo49aJG5CKXEWA=;
        b=Q5ZNIUkaRmhpBDJ4LceIIaTnEfLhTi5oO4woa+dgK6kQ4P2e3VY9r6KjSP7t9AeSRd
         S3oMwoVa6jV2TqYSKqdJJ5qMlPBhbLIfE2OGowqazAbHGS4qP9p+qooIz2RPXD3AaYQU
         e+iDNOgW3NFVPvpcUEYch2cFxQyA5/CNMAy8HdHYCVK3vOoLJRN1eHmutSztz2ZfModv
         lYkFstFROGM0s0CM/FQ7eyEGYhOQrXzN/zBETgmUTGltyZtxpHsWorGILse47si/B0/n
         MYikgEAE39oAHgPJrtByFGSCsyjb9An/auII7fCZZ/f64oUWqtmcveiXLEHP8eCNW3Tg
         t0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEt0VLaSvhUT7nyu4RhagnuYQaTu9Oo49aJG5CKXEWA=;
        b=Hkf41q8ZjSVjZfkGeAEYirmkI6p2YzWWFVZnTwSB784sbUO5ADnk+z6xfABPWZBhxr
         kgm5ew7nDunFR3GqLkIj47EdKQfzPelrfRd2zX2WG05hyAGTjQd2TWTUZDKGP1bVXhp6
         Xd2OxMdmlmDN9Q5GtB34/WvVB2Ynwwy6Y8vmmEkjdaUYQkNF8Xt/DcbziHyKdz5Ktdjx
         7JYUwRa+/+mMeKPXog9XWyVMWOmdvxAzOhGZ7gPqCIRNOvEB+IDJNQykWyicvK/0w3gx
         OtU51JpwsPSRd7lQVZCc9UANurJTn9XeAG+p4+CvXPNapiYm04lASCr6tUvW0GZsX6nZ
         nxFQ==
X-Gm-Message-State: AOAM530S2fdqQA/J37FUQuu1Av4z4p5inb/iBNmctv0X6GSY9Qn1QMJQ
        4ntqc1T4AIrqp2gyUdLb/yycMw==
X-Google-Smtp-Source: ABdhPJwwXKujZEL84AYoxUXSi3o7HiF74mdQYTkApzTGzV2pftYI+I07v/PLLfCiorqMoe+4lBDjNA==
X-Received: by 2002:adf:e587:: with SMTP id l7mr9309219wrm.352.1590765582952;
        Fri, 29 May 2020 08:19:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:acf8:18a8:b3a5:a17b])
        by smtp.gmail.com with ESMTPSA id x66sm9220421wmb.40.2020.05.29.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:19:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v7 2/6] drm/meson: add Amlogic Video FBC registers
Date:   Fri, 29 May 2020 17:19:31 +0200
Message-Id: <20200529151935.13418-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200529151935.13418-1-narmstrong@baylibre.com>
References: <20200529151935.13418-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the registers of the VPU VD1 Amlogic FBC decoder module, and routing
register.

Tested-by: Kevin Hilman <khilman@baylibre.com>
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

