Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE76C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A091220679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MHq30fHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgBUJIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:08:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35536 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBUJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:08:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so855626wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 01:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kb32uRYkhezIHBTmj+5SdLW5ETiBbDtA9WwDv9jFqg=;
        b=MHq30fHLCK1yAJBfIiqeZy2r0lRKlMQNNi0H+yiAO1uObLJy/V8lgFd0bW7GRlbdZA
         pVm+zKouDVsFeYirga2GLz6wxiIIIXU73yRTJnQWpy3+2jzqpfvbRD0GzW1r6Kfwahhq
         9em/BTeVTo9+SWaF0nC8xs4UoEhcx2w7NhKWVJpP77auP3klD1qQPWIwj1tSXmIRUmPp
         rRm7bqD8lP+V5f8+tZn6Iy7XDqtZJXzu3n1VCNq0Nyq+cSXoXbaCPtApVhwnN2UFx/8a
         8Pk7xV8Me2jOJ+nIvyIBR0AVtt5DEm/ZQQhklA60Qwjfv4CEyIeXbYS/rSRF5eBX9XZP
         0wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kb32uRYkhezIHBTmj+5SdLW5ETiBbDtA9WwDv9jFqg=;
        b=grFQGNY8Xm9cIwkkVRGoGxnfSiWHbC6axlv/quRWzdl7H4fNxVSpI9Mys8H8UAjZUW
         fnqEh3CETfHSu0fXdy1k+Q5VAeCZdjdinELKdppU9tLNMncXwEJ2uZj2VIK2cBKLzSVn
         H6e2q8NaCJTJIPE/gt2Qoh0vJHYEXdNa28V6ytW3wQaN0jC5SUJr9ZN5Dvyx3M9CRA08
         TiPFTGm/x3kyeMGcDJO6/Z2ItHG33AZQ71SbBBgdL1cbt+paQ2us/TpG5JNtxdUFcb8W
         zave8CXL3IaNL1/nBLD9freKina6EHlAoAB4IzwKo9DbR7245/ZgWwXo+ic6XjG+kyVW
         JEBQ==
X-Gm-Message-State: APjAAAX8mUZtLgdedJf5OIvsypOOLnvbI83sAU8eeDpZY60z0s1ANXyE
        pWYrhZlfL1DDXusoqY1odmm0Dg==
X-Google-Smtp-Source: APXvYqyASv2VhtyTE+GbLI9Iyxv1oYm6p8uGHIxc63RjQjtV3HCvpFF/TwD2nkmX9SvFBq2eEeVOoQ==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr2419247wmm.179.1582276128899;
        Fri, 21 Feb 2020 01:08:48 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:4ca8:b25b:98e4:858])
        by smtp.gmail.com with ESMTPSA id h5sm3173288wmf.8.2020.02.21.01.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 01:08:48 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/meson: add support for Amlogic Video FBC
Date:   Fri, 21 Feb 2020 10:08:41 +0100
Message-Id: <20200221090845.7397-1-narmstrong@baylibre.com>
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

At least two options are supported :
- Scatter mode: the buffer is filled with a IOMMU scatter table referring
  to the encoder current memory layout. This mode if more efficient in terms
  of memory allocation but frames are not dumpable and only valid during until
  the buffer is freed and back in control of the encoder
- Memory saving: when the pixel bpp is 8b, the size of the superblock can
  be reduced, thus saving memory.

This serie adds the missing register, updated the FBC decoder registers
content to be committed by the crtc code.

The Amlogic FBC has been tested with compressed content from the Amlogic
HW VP9 decoder on S905X (GXL), S905D2 (G12A) and S905X3 (SM1) in 8bit
(Scatter+Mem Saving on G12A/SM1, Mem Saving on GXL) and 10bit
(Scatter on G12A/SM1, default on GXL).

It's expected to work as-is on GXM and G12B SoCs.

Changes since v1 at [1]:
- s/VD1_AXI_SEL_AFB/VD1_AXI_SEL_AFBC/ into meson_registers.h

[1] https://patchwork.freedesktop.org/series/73722/#rev1

Neil Armstrong (4):
  drm/fourcc: Add modifier definitions for describing Amlogic Video
    Framebuffer Compression
  drm/meson: add Amlogic Video FBC registers
  drm/meson: overlay: setup overlay for Amlogic FBC
  drm/meson: crtc: handle commit of Amlogic FBC frames

 drivers/gpu/drm/meson/meson_crtc.c      | 118 ++++++++---
 drivers/gpu/drm/meson/meson_drv.h       |  16 ++
 drivers/gpu/drm/meson/meson_overlay.c   | 257 +++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_registers.h |  22 ++
 include/uapi/drm/drm_fourcc.h           |  56 ++++++
 5 files changed, 431 insertions(+), 38 deletions(-)

-- 
2.22.0

