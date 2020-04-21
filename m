Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D00C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF04206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zTcqxvYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgDUQQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbgDUQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:16:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEBEC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:16:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so4192561wmk.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBXmUVijjl77qmlPJjceabUZhKXPDQu30ucjlCWJLm8=;
        b=zTcqxvYVH3V2nN32H6116A8cns9nt9Jpmu7xJFjkr0jvy37yVdA303M5a34KILWxLo
         Q8GI/lqn62BIwjr+5j0scfwmXHyc0OuPCGX21RH2ie71+C0W+LZ6Ogl0nNuwTE29Rq7u
         jlJJdCV1o8VjezXu7qMgqtzuC+2hqz6ObWTB1/MlnxfptH2SeO946uXbpzEg+QdchicC
         zxcESoE2lLWr/hK0JfVmRvMbVifObY85Yc6DOuDvVzZIWjtiVMDwZKNVcuIOwHwfORKD
         qKSimoTghbyjU0z/6qRjzKJjfiq8F4c6JDloqnUJWaLO8hKnip+dmiRGPjf7z5Dl0mtn
         CkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBXmUVijjl77qmlPJjceabUZhKXPDQu30ucjlCWJLm8=;
        b=thcRQlKkAlVm2AAVUnckYwK0S0/1IM1RlKMlma4vR5u4+5CzgSfNa84BwAroxulHtm
         0E3fK2KSfqY4hR2UTOqjPJTl1yT8ezNexbWKkDRagJ3BfKkbo4IEdSsKDby8ViLL3dpS
         kSjAKXi6TCe6FFXDIwJkzz1upstnFXOUjbC68rrG0DAeDMiZl7tWdd26d2cym6aqmSnK
         LgG58p8sLon2w7+kFbshcbdxo3ZXvuyx3FSJ27d6hZAcpkNdtUn9NV1X0hrRmWxNbkAR
         nj66bYAq9N1t7VX+zRMP6I9E9He4Rh9M3+f3UHOUbzCGsRp1J0Hnaaoj43tXZ9JZq6YQ
         Lq8A==
X-Gm-Message-State: AGi0Pubd2PbC8dCEkPneh7Kc4k9SrFs2Nvd47az1x80qW4pFDIVozgj2
        VU45mTPTBIV3IJ7+Q0R+A8VwcV2ZUoo=
X-Google-Smtp-Source: APiQypLNjUCb6VGu7+SdjDGqKPYjok1sR95NqggclMqD39jzf+Kt7RT7+hcKHV1dlfZrLkjO6+6OlQ==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr5600881wmm.9.1587485764463;
        Tue, 21 Apr 2020 09:16:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id m8sm4410873wrx.54.2020.04.21.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:16:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] drm/meson: add support for Amlogic Video FBC
Date:   Tue, 21 Apr 2020 18:15:53 +0200
Message-Id: <20200421161559.2347-1-narmstrong@baylibre.com>
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
[4] https://patchwork.freedesktop.org/series/73722/#rev5

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

