Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88A1C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB7C206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="klP7C+Qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCYIud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:50:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45414 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCYIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:50:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id t7so1751386wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoXHfuXYzc7+p6uA7OR0OLG4JPoyNaGh9u2qRQoG7QA=;
        b=klP7C+QxkpkwvekqXQb/Ju4yyTjbf+2WirsTFD+RvppuVSgw8RLF4oDkiJV5Vk4lMd
         xqXSWWCekWRsLvvY6YJd8ek781hrgVRUnrwPML6G++2ZxVBfd7aiFZY/dnxdJCZ1Alz/
         C3xF4AHS7bnfY5t5mSinwvd8ZGuwTBNPL142jGG5FwxBD6S0Mj0AhGVekurjgwDehbwx
         wTAti/zk4YsU/j2wJHyfzaT8sKWSpFa4nF0dUBGhV5rwRSVH34qF7ROPfO/SZrYiB+Wj
         SpjhV6zueQA3Spsi+OJoE82nK0zOOYF9+7m+1eEFFf6hIXTT0bQHCmzUzl3wcxdSVZEm
         rQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoXHfuXYzc7+p6uA7OR0OLG4JPoyNaGh9u2qRQoG7QA=;
        b=hg7B1KeftRV1ugCWONkD+SrCbwuwod+IkrQYyjY3QfaqMwK5zSds59zduCTvkyL0LH
         Iq1LnxiQpf7/jCDtfiPiQ1xlqsUwa0z2s50yqeFfp7s5CC6io/OzevMYWvXYxoEcQ/Jf
         i2aIcqps6/eQKlrHw0kLxAqaKZ27XNEt6kj2ECisyZxWxpmIgd3smVS/P3GKpcHEhHTV
         EnH0zlKzJvVPsNPeDmpn2SS17fwbrW4ucAlOIAZlI/lWUmjeyhFv906gBlU5xe8u5vBB
         BKw1ROnSWU+WGhL2Oyes/sR5q55ZWnFDfoTKeNPYx+8FOq2xg4txN87WUMB6MNzInpHv
         A86w==
X-Gm-Message-State: ANhLgQ3Lg3P+kH8zOJcu7Se+o3IfHqXyA9h02TgP7HHkodTqiG9bPDyY
        58IFfCt/ZIBUT6trr9WtctsLEg==
X-Google-Smtp-Source: ADFU+vvN8eNsV/lG7CyAMfmUF+xPvxc5unukjUQek0cvYyrrZYY7nWzlFjHzEeIz6hgWFSoiPKW9XA==
X-Received: by 2002:a5d:630e:: with SMTP id i14mr2218077wru.260.1585126229049;
        Wed, 25 Mar 2020 01:50:29 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o16sm33892229wrs.44.2020.03.25.01.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:50:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] drm/meson: add support for Amlogic Video FBC
Date:   Wed, 25 Mar 2020 09:50:17 +0100
Message-Id: <20200325085025.30631-1-narmstrong@baylibre.com>
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

 drivers/gpu/drm/meson/meson_crtc.c      | 118 ++++++++---
 drivers/gpu/drm/meson/meson_drv.h       |  16 ++
 drivers/gpu/drm/meson/meson_overlay.c   | 257 +++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_registers.h |  22 ++
 include/uapi/drm/drm_fourcc.h           |  66 ++++++
 5 files changed, 441 insertions(+), 38 deletions(-)

-- 
2.22.0

