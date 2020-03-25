Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92116C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695A520714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wWvVIPh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCYIud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:50:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36407 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgCYIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:50:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so1521866wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNQXsVDevnlZb1LKGB3Ujzy43w3o9PSRXDwMVWOkBSw=;
        b=wWvVIPh6SDMtMbmcyPL+7DTO5b9bPC/1AiW8rKENoQunhsv0xqdP3US3/Wk/EC0JkP
         riB7Oi5CewnR6asT+DzI380C2FTSkdGaA9jfKMQMFS0uEt/pL53jeahTpHSZDEqgf4mQ
         Js59FtpnZBmynZRL1f/+S8ed45pyCJSMqaSnqSxaX5AmlTIafSajCfH2OaJR1BOn29s6
         h+WYi6w3ccoTkAta4dspSRgyLaRQq99BXMeuSddM4S3D1py5KQep31KwL+Ab6iotS6Oh
         OR+jc1Q0fCYX9V7ADzy7V6irNYRtlLMS0a6QlRyQD6qAlAmfPYlqTxqzdDyYq+kjTG3c
         akPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNQXsVDevnlZb1LKGB3Ujzy43w3o9PSRXDwMVWOkBSw=;
        b=M5wQ1a18O34PsTtltqa7Jf4ZCPHEhJvxcyf4/pxIYlcWxj3If+uuk34l+HsurBaclF
         9nR2/ligseyB9+wpyHSevYZnGka3YiCK206PiFJfE9HPI5sxx/5BWSCIMY0kcWxEQoGL
         mMVTb1GI+4mL7pIOkkpuOuzxb95xs0zp2w52f/7s/f+EKmyaoFHM5pPikurErXlPjejS
         x9338Vds6QGNwjGS2zb0GgsWWjiCztdXZRUY57Yjd6VxGl2mGmrZQH/LAdm9MJ0OX+0D
         9yYROLIEdEcF8OFDSK5LN37bDy0TCmRpbal4nnQXFSMVa4gcZ0S6W/miSlGt3qIrFirN
         Hq0A==
X-Gm-Message-State: ANhLgQ3Qd89DzNAtipq5xChjWd1IA+HsWrx6rPT2peKnIQ5x8IS9QewT
        qlF3SxT6NGdcFwPz+JuwG+osQA==
X-Google-Smtp-Source: ADFU+vutjR8yjcwJIWw7JDjncyKk41p3983bAe/W5fRN3MrpHabRbIq4Oh/Ad+2cQD1wZgWl/XnxJA==
X-Received: by 2002:a1c:5654:: with SMTP id k81mr2378424wmb.145.1585126230271;
        Wed, 25 Mar 2020 01:50:30 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o16sm33892229wrs.44.2020.03.25.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:50:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v4 1/8] drm/fourcc: Add modifier definitions for describing Amlogic Video Framebuffer Compression
Date:   Wed, 25 Mar 2020 09:50:18 +0100
Message-Id: <20200325085025.30631-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325085025.30631-1-narmstrong@baylibre.com>
References: <20200325085025.30631-1-narmstrong@baylibre.com>
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

Tested-by: Kevin Hilman <khilman@baylibre.com>
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

