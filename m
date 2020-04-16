Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C24C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0950206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LWOSh6J4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410261AbgDPPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504268AbgDPPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:25:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2749AC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k11so5339322wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlAyBA8CcMUXp85BDwBKC42D/qldDHdyj7qKWzB2WdM=;
        b=LWOSh6J4oHdRqocw6T+gupl4SfkmDILSRdedkw9pNCBnbVeVMJ3p1vQ1jCXYGKSc9P
         G0TA75egWRpZcSgxW5QXjT5T6mgsnueYjjSx9mGvHqaYdLtSaspzusSO94UPUN+DouSZ
         YL8ZnEfEjC2DLNwASGkAg6MFSdsEZDekgema+Db2EoTTBZcR/Nkbp/j9cVxdKpaNpBAA
         ygQy9iRIzRrLeevaU+aGRWNGMt9BbEtSSS7diKjj3kezmFZRztjSvWPX+/rpsxr2B+Ck
         xSWSrg8bO2kyHv7vtQ7cLw8FXu+gjR3cfceCa7AzvF08UuE+wX+dbOjizaaXH6DNugSE
         4rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlAyBA8CcMUXp85BDwBKC42D/qldDHdyj7qKWzB2WdM=;
        b=EQly8iFpGWAhidDxj0v0cNy0SCN59jZNfocpqDqDlp5k/oQN+etRE+ybx1f3sNloBa
         R96HqWXcMbRrv8LB7SegKUz9pz9/dYsz5XM9106WaZD+0EOay+8+fsxXxVDxgtbsRzmU
         KlPNgAM5lJue+3h4nDOxjyvXcCZDffkTwGOyJop16Yq84+783sl+4APJS2/433UTOpyb
         8Dxi++gwMEaPNIS91oG7HSeSLmptr7Cwgywd7RE9HRA1PHbWhDRD1ZwbZm1oNTeF/mGO
         arTp1/+87s/vPspxxASLwnQXY9aAateUzuMixwa2nsoI7fRROacr1CIj6oncd8iBRkKt
         /oAw==
X-Gm-Message-State: AGi0PuYR78uWNnbAMlfMthV4YkywS3/hqYkNvsrF3TbdFRIm5ZvTzrp7
        oaVc+9kShz4i0B7yP9CmOs/Xvg==
X-Google-Smtp-Source: APiQypLqBg7kl4HJjT8KQzhJlt3fJAI3Rp5CAv4vKPEYnCZ6J+g5WvsII7utk6pPSMtnCGw9RSueSA==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr20565789wrj.320.1587050706682;
        Thu, 16 Apr 2020 08:25:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm18019489wru.39.2020.04.16.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:25:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 1/8] drm/fourcc: Add modifier definitions for describing Amlogic Video Framebuffer Compression
Date:   Thu, 16 Apr 2020 17:24:53 +0200
Message-Id: <20200416152500.29429-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200416152500.29429-1-narmstrong@baylibre.com>
References: <20200416152500.29429-1-narmstrong@baylibre.com>
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
 include/uapi/drm/drm_fourcc.h | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 8bc0b31597d8..a1b163a5641f 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -309,6 +309,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
+#define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
 
 /* add more to the end as needed */
 
@@ -804,6 +805,44 @@ extern "C" {
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
+ *
+ * The first 8 bits of the mode defines the layout, then the following 8 bits
+ * defines the options changing the layout.
+ *
+ * Not all combinations are valid, and different SoCs may support different
+ * combinations of layout and options.
+ */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC(__modes) fourcc_mod_code(AMLOGIC, __modes)
+
+/* Amlogic FBC Layouts */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_MASK		(0xf << 0)
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

