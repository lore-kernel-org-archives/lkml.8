Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE816C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B918204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EXNwcZV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgE2PTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:19:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B047C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:19:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so4154331wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1VA2cI3luBKl+1A9IqPQvaPilBfCEdbV/wVG2oiOog=;
        b=EXNwcZV8afVOfwzR4c0U8MUyODazMaEzwEvIGyp3wVLivLkT1MDmIj4zdnjkv+V4gc
         YaVyk8iluliw3t6wieJTWQp7lWEPezY0040mBRcatrwpxJLKHMbNeAth47OtzPlHExME
         gDTHrm6QR/aBITo4qcv10f+0aYIg9heADIMrw4UyWU8E1WlcFtjSLuZPRAOLFs66gwZy
         rqCL2eMvJnXWAkAoAkBK1e3cLmGsj42oZd0o60FE9FxP+BdWYyo+4SlC0pB0zu7Pmwqr
         LT/AGulEftv1BEHhCHFHR4JSzXv/1JjLJXMn6LLE7qTjxQsza7a32LZuW/L6T7sz9GFc
         xd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1VA2cI3luBKl+1A9IqPQvaPilBfCEdbV/wVG2oiOog=;
        b=MTwUtGYgpV6EDQGJh+XI2sQIiswkWXkEFbxZ9Ra+fWORdIq/CnbGOCQ79a5eiHmujL
         L67Rbon57Gkk/fdwl5IW+rAP7Ji9bdMojp+ERE3lRnC+EUjeCTDaIjb4aXi+t9o6m3cJ
         bhzlChmCLL/+rHvQPOubcUQ5hCIcCocCEyJEpwkMhKxiNE3hAhHOKA9rhXHX+1LR55WP
         ioINW6KhFhJtmdceksntd3QzHxsC62rcLUT5bnwvBnWp0jYuokIdjkV9J3dLgNqBK02J
         60u9f2hr6bJvyEABD/ckXUckDtvzy51UOg9P8NDD9adaPV8sw20sOwS3XwpZL86mGcLA
         /u3A==
X-Gm-Message-State: AOAM531Sn4+pcDEKZVcfZtaXeAja/T78kjj1Sd0DTdGNCTkKWAzxWt+o
        nTblMIFd9vDZtffTTL9+ePCbYe5jFlGK+A==
X-Google-Smtp-Source: ABdhPJzQPebNNU06xppIc8ZCSKYkvgk6OTr93lLpMRDtFo/HVqX1vFcPCRezXTfa9vkCVSmurfLytQ==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr9093962wrt.199.1590765579103;
        Fri, 29 May 2020 08:19:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:acf8:18a8:b3a5:a17b])
        by smtp.gmail.com with ESMTPSA id x66sm9220421wmb.40.2020.05.29.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:19:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] drm/meson: add support for Amlogic Video FBC
Date:   Fri, 29 May 2020 17:19:29 +0200
Message-Id: <20200529151935.13418-1-narmstrong@baylibre.com>
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

Changes since v6 at [6]:
- rebased on drm-misc-next (after drm-misc-next-2020-05-14)
- updated patch 1 commit log for completion

Changes since v5 at [5]:
- merged all fourcc patches in 1
- fixed fourcc definition to have only a single DRM_MOD_
- fixed 2 checkpatch issues

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
[5] https://patchwork.freedesktop.org/series/73722/#rev5
[6] https://patchwork.freedesktop.org/series/73722/#rev6

Neil Armstrong (6):
  drm/fourcc: Add modifier definitions for describing Amlogic Video
    Framebuffer Compression
  drm/meson: add Amlogic Video FBC registers
  drm/meson: overlay: setup overlay for Amlogic FBC
  drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
  drm/meson: overlay: setup overlay for Amlogic FBC Scatter Memory
    layout
  drm/meson: crtc: handle commit of Amlogic FBC frames

 drivers/gpu/drm/meson/meson_crtc.c      | 118 +++++++---
 drivers/gpu/drm/meson/meson_drv.h       |  16 ++
 drivers/gpu/drm/meson/meson_overlay.c   | 290 +++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_registers.h |  22 ++
 include/uapi/drm/drm_fourcc.h           |  74 ++++++
 5 files changed, 482 insertions(+), 38 deletions(-)

-- 
2.22.0

