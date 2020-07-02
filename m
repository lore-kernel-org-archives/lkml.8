Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8C7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684AD20936
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cJyoYcdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGBHsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGBHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:48:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C119AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 00:48:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so26958623wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 00:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8M+mFGruIPk3CS9J1xbXhvwkPs322aITgShX5ewQVTQ=;
        b=cJyoYcdt4qoPTsDOKgbH8BDy1hkTA/lU8+OoimqiKhJuvup+eJ5pShA3oQLtmM790u
         k0taMEOv17PPxFh1QUb4TjyW+sV4RFR7CWqsJ5SSxPRYUUWWm3zrKaZU1Ic5fOQKPk2T
         9aTDQZIig2oovyHfnrrwP68+s/Qn8FkNG+anTz5kbO1hMCjgd1DACAGD+nXuyCnTjqEr
         IERyt7j3A7oZFIuXaHb5Vj/CkYlr8HxzA3LO/T6j4PQfjHsIlX+GHjHjlbduIxiw+Xap
         0lKy2nYdiq7knHZhIe6P9MLhGi6NeDcLfGrItHHRUv10LYyFcOcDK0MRol834AURfg15
         DWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8M+mFGruIPk3CS9J1xbXhvwkPs322aITgShX5ewQVTQ=;
        b=p0cd0+NM9rBTE8nDz8X9OLhRGjn+qJJ8HXZ69MaBvNdrjNXv7PGCOF6J9dApCgtRGD
         B6mrGDCPUQ7CfRTRmUGHziGV892N2bUDculikj74jJuG1LEMwNYHw13xjSUg8WWGtMOB
         sDabfLkoNvm9aJ+cpMbv29XlgE/jMvLr6oM8dsGVVHM6FxUYQKHhlCk8cLTEoiENKgk5
         QaRR6daQA9XXD/JA90s+QQE54dXfUARgxfrTOWRGvCAtJked0W47jyBfGRP77jkNET1F
         N584PNKsbNBvJEfLEYJx957Pn6HCvHh25eJAo0BUtwYaSe6ciLesTKTKmF6byDsqEIBX
         pvxw==
X-Gm-Message-State: AOAM531e5qUDfFUCP+oNttJ9bWiRB+zjMnKq0w0wlc+cra9dwMyhfwsm
        J7a6pPEaJ1AfDHLXaKCxAdC06w==
X-Google-Smtp-Source: ABdhPJxFuxuBKpXZuocxj+mJU51KU9NfMukKtxA52BnS1Gg6Wc9/gDjoChATQ11FAkuy6Pfk5q1uCw==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr33073968wrw.213.1593676082299;
        Thu, 02 Jul 2020 00:48:02 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7023:727a:c688:cf9b])
        by smtp.gmail.com with ESMTPSA id z1sm10001882wru.30.2020.07.02.00.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:48:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     jianxin.pan@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/6] drm/meson: add support for Amlogic Video FBC
Date:   Thu,  2 Jul 2020 09:47:53 +0200
Message-Id: <20200702074759.32356-1-narmstrong@baylibre.com>
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

Changes since v7 at [7]:
- rebased on drm-misc-next
- removed spurious DEBUG in drivers/gpu/drm/meson/meson_overlay.c

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
[7] https://patchwork.freedesktop.org/series/73722/#rev7

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
 drivers/gpu/drm/meson/meson_overlay.c   | 289 +++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_registers.h |  22 ++
 include/uapi/drm/drm_fourcc.h           |  74 ++++++
 5 files changed, 481 insertions(+), 38 deletions(-)

-- 
2.22.0

