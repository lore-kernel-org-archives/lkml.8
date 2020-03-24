Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF41420789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rsqJnKuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCXOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:20:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38461 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgCXOUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:20:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so21664335wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pb0nOXTsvfnsHlBe6h+96Sc/Y2vhw/oF3Rb7LgSL9sA=;
        b=rsqJnKuHuJQAYKkoP4MLaf+A11zN64qwqgkLFd3IWiVck21lSHX1ysKm/r30C/khku
         OVyPTf6lqP9Qpei8+lcLVc5pah1ULccIygs7LUSwT1020WvjwlGCYQYBU+BtX0whmHed
         ujnq4xAzQk4jzQCvis3sCQtC7fadrvw4lUtVS2YjRcPjDwnrLOOAYAxGXVJatcl2n98V
         CML/eF/8FdwfbJSZFfG6OPXKHNqgAhdGz3gRS3+wLmbXFKl7tnD4+C22jcgOk7YHFnSD
         DqpB+nqm/M+YwkBzyeq8Slsg2EsuiwS96qjd7ey4QJDLDPmstzzjkrnNLx8NkstHD2S/
         YdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pb0nOXTsvfnsHlBe6h+96Sc/Y2vhw/oF3Rb7LgSL9sA=;
        b=h3zoO+My5sX8lvqMlQm+j2A2ax9JenCsD1XgXOl2XY52nNVJIAYXecXnBdL54soUCN
         EV/TsI3pIRWUfBB3zVCF9SJcXTjowH/PNz3OMKneMnE9cBgEK+ZobUCYlODQ2i53j5rV
         aht2onq+LDQSkO6p2kZNxVU5dRz5iQmLGWuLMLCKtjQs1Fog0a9ae1LTVOyLDP0ejgao
         E5iYuWoocWpRtI7qckFsA2G7AmUxAM5UL7NEqs5akqUmiJqf9se1PGeyPpnsvzzmZ9OS
         6x31lEZWyBabIGQutmqF4B2r623kgREKQfVe59Bn8S5s87RpenVdUPIPoW/EzI0ipVRS
         xxFA==
X-Gm-Message-State: ANhLgQ1BWsvutYC0/r0zxTKGDJUxOHRAoTmXJL1IcdqLo2E9mdDZ48BJ
        bHNBKo2+FqPrNdnjV1SUCjdFLg==
X-Google-Smtp-Source: ADFU+vtcO35jlay/gxVcEpkyIV7bq9dlC30QrfhSlVYiFA9hMEECf/zlJKLj8mUQKhkft+409j05Jw==
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr37764304wrs.96.1585059623310;
        Tue, 24 Mar 2020 07:20:23 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o4sm28688472wrp.84.2020.03.24.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:20:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] drm/meson: add support for Amlogic Video FBC
Date:   Tue, 24 Mar 2020 15:20:09 +0100
Message-Id: <20200324142016.31824-1-narmstrong@baylibre.com>
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

Neil Armstrong (7):
  drm/fourcc: Add modifier definitions for describing Amlogic Video
    Framebuffer Compression
  drm/meson: add Amlogic Video FBC registers
  drm/meson: overlay: setup overlay for Amlogic FBC
  drm/meson: crtc: handle commit of Amlogic FBC frames
  drm/fourcc: amlogic: Add modifier definitions for Memory Saving option
  drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
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

