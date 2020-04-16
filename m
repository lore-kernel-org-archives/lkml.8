Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A682C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374E0214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="av4SWgmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgDPPZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504260AbgDPPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:25:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09709C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id u13so5345276wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MC9RC4OOYOTP32+3XNp7wtNFT17uV5Ek7QfI8e7TLeo=;
        b=av4SWgmAtX8p7gi1AsSSRhSkIO8kXiG7Gc5yAUoDxLuQLFB2+YyPCpAsF+UiXwGO16
         +RTClbCkA+GdD940Ag1J2VIJ8Bt6Qhq1jnTdieVlr1Fg+D1baxB/12zCvOR13kOJBNrx
         qSOGs5Gu064uzBGBaxMahp1GaKPBHga6AIJ/uGx0dNi6xBArRg+RYZUFJVyh+b+5/hkO
         qBDaeo7vY3BUYTQSMikC0l55Cj3qUnOcmRbe/2/+XiiHMyghqaydmsbwbht3//6eiT2F
         d7EE7b+troPC5AmV+nhY8ocQcqrZkq4kHsfNdDdLWWh/kHtibBYV7qNsTV4iHzymk9cM
         4h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MC9RC4OOYOTP32+3XNp7wtNFT17uV5Ek7QfI8e7TLeo=;
        b=dTNlv5mh7FnQSAOssU6gol0FTcXnDXQJ5TbGoVjaLsgQUzaU2Y6QRwzkQ2vTtHHA2C
         wJV9JA0nrxQ8Dt1p3L63qqMj41t/k1JNX5e2VlS+ExITgidSMUySDA/zgIZ7Oc60y2tW
         P6v24gsXMAYnqhXlIhraiIa/CSvlO0rv0X9iF16HGdedI/TBl1CrXmo68QTZrDjuKbgZ
         qPppGNkqXDVdDMtB/8i1HYec/LH8lJ0Tr2oPgFsRfqqYjQuSbeaZTAtTM9FWXCWxKsdt
         UdkXM0dM7olF/nehY7N4dYqQxwU7vmkkQI28gE0sNk8/V4JWl7WPz5wnMlvXQWP9iPmG
         eb3g==
X-Gm-Message-State: AGi0Pub/iyE5XD/eVBmEYJHMwnY13d7T32f58fLlsqppWGWnHLcE3Zmv
        ub56eOBHKzh0DMt9KGIsMZMf2Np43di9jg==
X-Google-Smtp-Source: APiQypIl+0gLXQFH0DVOclNzoYwFPgHGOgZCv5kErtoHhYcJAHaQM8n7WhFcobA+2fZkAQ6FkWe+2A==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr7635635wro.327.1587050704557;
        Thu, 16 Apr 2020 08:25:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm18019489wru.39.2020.04.16.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:25:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] drm/meson: add support for Amlogic Video FBC
Date:   Thu, 16 Apr 2020 17:24:52 +0200
Message-Id: <20200416152500.29429-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
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

At least two layout are supported :
- Basic: composed of a body and a header
- Scatter: the buffer is filled with a IOMMU scatter table referring
  to the encoder current memory layout. This mode if more efficient in terms
  of memory allocation but frames are not dumpable and only valid during until
  the buffer is freed and back in control of the encoder

At least two options are supported :
- Memory saving: when the pixel bpp is 8b, the size of the superblock can
  be reduced, thus saving memory.

This serie adds the missing register, updated the FBC decoder registers
content to be committed by the crtc code.

The Amlogic FBC has been tested with compressed content from the Amlogic
HW VP9 decoder on S905X (GXL), S905D2 (G12A) and S905X3 (SM1) in 8bit
(Scatter+Mem Saving on G12A/SM1, Mem Saving on GXL) and 10bit
(Scatter on G12A/SM1, default on GXL).

It's expected to work as-is on GXM and G12B SoCs.

Changes since v4 at [4]:
- added layout and options mask
- cosmetic changes in fourcc.h
- fixed mod check using the masks
- fixed plane apply using the masks

Changes since v3 at [3]:
- added dropped fourcc patch for scatter
- fixed build of last patch

Changes since v2 at [2]:
- Added "BASIC" layout and moved the SCATTER mode as layout, making
  BASIC and SCATTER layout exclusives
- Moved the Memory Saving at bit 8 for options fields
- Split fourcc and overlay patch to introduce basic, mem saving and then
  scatter in separate patches
- Added comment about "transferability" of the buffers

Changes since v1 at [1]:
- s/VD1_AXI_SEL_AFB/VD1_AXI_SEL_AFBC/ into meson_registers.h

[1] https://patchwork.freedesktop.org/series/73722/#rev1
[2] https://patchwork.freedesktop.org/series/73722/#rev2
[3] https://patchwork.freedesktop.org/series/73722/#rev3
[4] https://patchwork.freedesktop.org/series/73722/#rev4

Neil Armstrong (8):
  drm/fourcc: Add modifier definitions for describing Amlogic Video
    Framebuffer Compression
  drm/meson: add Amlogic Video FBC registers
  drm/meson: overlay: setup overlay for Amlogic FBC
  drm/meson: crtc: handle commit of Amlogic FBC frames
  drm/fourcc: amlogic: Add modifier definitions for Memory Saving option
  drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
  drm/fourcc: amlogic: Add modifier definitions for the Scatter layout
  drm/meson: overlay: setup overlay for Amlogic FBC Scatter Memory
    layout

 drivers/gpu/drm/meson/meson_crtc.c      | 118 +++++++---
 drivers/gpu/drm/meson/meson_drv.h       |  16 ++
 drivers/gpu/drm/meson/meson_overlay.c   | 289 +++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_registers.h |  22 ++
 include/uapi/drm/drm_fourcc.h           |  68 ++++++
 5 files changed, 475 insertions(+), 38 deletions(-)

-- 
2.22.0

