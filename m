Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8361C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828EC20788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xsl08M/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgCXOU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:20:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44865 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgCXOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:20:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so12685270wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAwZJvvwLgZDn1ywdQ6nPmOn7qCnl4VE3QuxXpY3Nzg=;
        b=Xsl08M/PvJVLWLPPkngG3LxHwcqqyhr1PyrntQo1Pjna55EDs/31lpg+TG8gyM5/HN
         3qsQEuzohclevTKn8dveoyUoF6SPBqe9oy0xahadz23jBugTJ6u3GqH6gID8E2tNcGR3
         UwHXHkoUTt/s20spoekxsaOKiGnKxhmDvMc3ZkpCIltoF5iM4f5siceEK58bjtzDZnnp
         zUyCUP0ZPizxM5h//4JTGHjyIMgA2B0r8ok+mhu4vaIWN7364GedTRyqqbs5YNhYELKs
         NEYFvYUjqli9tU9gd6UxpnDofklf/imdf613vFbnVFKXDQC9CcbZYullWH7c+K4ejNM6
         QfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAwZJvvwLgZDn1ywdQ6nPmOn7qCnl4VE3QuxXpY3Nzg=;
        b=WKo30lgEXXB2eZGJLk5mS/m3rf1U77YGhNUBTXxa+7qYfWcch4dejbT9HpMIvRaKfD
         ZQo0Dkh/sp4J+3Bfsvy3F9u+S6mbB8RFxgjrY7y7M7mEthodkwm/KNT3EL0m723WPAcv
         fmqeV+hq8wo4mKoCM8tOffvq/f/zq+S8y/J+5ngJbOwEGiXDkADWnqHDONI12Gv2za+c
         YrBYCe+3cRmxJKw+zRfzO5nmWkkO93BaGD1k8i6ziroFeueUsEtLGzh5UmsdpPRTiisE
         kw5IMZrjec3uXC/cYgQgELKcYIsMohdIoFIizIrZInT2ps2+2x6OFv2Gng94iswVnmjR
         pjUQ==
X-Gm-Message-State: ANhLgQ3grYERnpfEEIlUAKTefnKNRFz60UEvwDUm/PJIBnn8/vC1ORKz
        ThzJhv7kKGvWcljucxDqK5ZmzA==
X-Google-Smtp-Source: ADFU+vuWKFRgRnFG7irPanaxg/SMcv7FNJEKjQfKU2zqGDySjvyd/47d3NcTB7S4cBNrQ3ZYXpAi9g==
X-Received: by 2002:a5d:49c8:: with SMTP id t8mr22990127wrs.5.1585059624463;
        Tue, 24 Mar 2020 07:20:24 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o4sm28688472wrp.84.2020.03.24.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:20:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] drm/fourcc: Add modifier definitions for describing Amlogic Video Framebuffer Compression
Date:   Tue, 24 Mar 2020 15:20:10 +0100
Message-Id: <20200324142016.31824-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324142016.31824-1-narmstrong@baylibre.com>
References: <20200324142016.31824-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic uses a proprietary lossless image compression protocol and format
for their hardware video codec accelerators, either video decoders or
video input encoders.

It considerably reduces memory bandwidth while writing and reading
frames in memory.

The underlying storage is considered to be 3 components, 8bit or 10-bit
per component, YCbCr 420, single plane :
- DRM_FORMAT_YUV420_8BIT
- DRM_FORMAT_YUV420_10BIT

This modifier will be notably added to DMA-BUF frames imported from the V4L2
Amlogic VDEC decoder.

This introduces the basic layout composed of:
- a body content organized in 64x32 superblocks with 4096 bytes per
  superblock in default mode.
- a 32 bytes per 128x64 header block

This layout is tranferrable between Amlogic SoCs supporting this modifier.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/uapi/drm/drm_fourcc.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 8bc0b31597d8..6564813d2f7a 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -309,6 +309,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
+#define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
 
 /* add more to the end as needed */
 
@@ -804,6 +805,35 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
 
+/*
+ * Amlogic Video Framebuffer Compression modifiers
+ *
+ * Amlogic uses a proprietary lossless image compression protocol and format
+ * for their hardware video codec accelerators, either video decoders or
+ * video input encoders.
+ *
+ * It considerably reduces memory bandwidth while writing and reading
+ * frames in memory.
+ *
+ * The underlying storage is considered to be 3 components, 8bit or 10-bit
+ * per component YCbCr 420, single plane :
+ * - DRM_FORMAT_YUV420_8BIT
+ * - DRM_FORMAT_YUV420_10BIT
+ */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC(__modes) fourcc_mod_code(AMLOGIC, __modes)
+
+/*
+ * Amlogic FBC Basic Layout
+ *
+ * The basic layout is composed of:
+ * - a body content organized in 64x32 superblocks with 4096 bytes per
+ *   superblock in default mode.
+ * - a 32 bytes per 128x64 header block
+ *
+ * This layout is transferrable between Amlogic SoCs supporting this modifier.
+ */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC		(1ULL << 0)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.22.0

