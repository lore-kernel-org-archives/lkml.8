Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E80C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66C92075A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olkRWEm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgIKHUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:20:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D357C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:20:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so12423329eja.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YFeXjg7bqtTOYH49LIXUF1fo0jTBbkbgWiE0BAtXQYM=;
        b=olkRWEm+WkS5GkVvHd2wfMIUqeYzYCZEhMDvsVxvkL+iSN6OtLdTXjcP1+Zeu+VopI
         nyiKZEt75J3tgl2EDVHz4ypb72b4LB/r0PiEqr06K7QuWFHx6hwbIodp2uU4B6wHAhyn
         VcdXlw3SDgWyJ+ukCqgQblphQ2UXgoa5yDt7E1mLOzqapI8Ha+VWmjqOqW800PkXdY1s
         FT0UKWiorqK1mlKQQL2utMCAQozPPfU5ud0gdNC8OcmvwuND7/IEkGuRbDLGEOMWH5yq
         1xl8hhCnmBrTTKZ9guGPoZ67hmZcXpXjFJFYptCgiCTkoEdB2kj48bv6S4apuMp6d+U8
         FxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YFeXjg7bqtTOYH49LIXUF1fo0jTBbkbgWiE0BAtXQYM=;
        b=V/u/Lq8yLwFz26rv+/50kYEUTbd4tG5dJcqyGeCeuhUWdDCOo8Pw7SWNaJgz1ci8s4
         z6ElvHh580jcew4ryviXHfB5nQtDVhdDw8rGezXkbu9lJHwDEnpiBSXq2x9An2lzrLM3
         vhRLaD4hhhT4oAp1YJfvEqmXnZAj2+zu8Q5BRJXx/TZuY/E/+A9K5E5lzlvUrj91HLff
         x6r28rEgI8uG4TKgFpm9VfWNOMLKAWu/6sASpgdlFTed71MsHapP2aLePl0mHaEhRV/2
         491ti5GCuC5XEatCjWG/mEB7n3Ke1nL5R5/N6WUqz/GWJOd3/BMrreelOpXCAolq/CNp
         T3hQ==
X-Gm-Message-State: AOAM532ZvmeyLntp5Iwyou5lLzXtJHAsZY+TF7sjI8ishGQuyKuABqyf
        Dc27DPDz6NmCWhbHEt3np/wXKe4VK4Gu5v2kTsA=
X-Google-Smtp-Source: ABdhPJw5ZsirWV0c7OfUpQwJtF/NnjigCb9xkes2Un4J5HwOVhwQLdiF2NkaO5xLFDOkwqy7/91kNkfVF/LyQOXoKYI=
X-Received: by 2002:a17:906:fb8c:: with SMTP id lr12mr799162ejb.9.1599808827116;
 Fri, 11 Sep 2020 00:20:27 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 11 Sep 2020 17:20:15 +1000
Message-ID: <CAPM=9txiwAocSprg6zCMF7ajJm-aY7wX=NY47+ZhVdKLfVZi+A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.9-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular fixes, not much a major amount. One thing though is Laurent
fixed some Kconfig issues, and I'm carrying the rapidio kconfig change
so the drm one for xlnx driver works. He hadn't got a response from
rapidio maintainers.

Otherwise, virtio, sun4i, tve200, ingenic have some fixes, one audio
fix for i915 and a core docs fix.

DAve.


drm-fixes-2020-09-11:
drm fixes for 5.9-rc5

rapidio/xlnx kconfig fix.

core:
- Documentation fix.

i915:
- audio regression fix

virtio:
- Fix double free in virtio.
- Fix virtio unblank.
- Remove output->enabled from virtio, as it should use crtc_state.

sun4i:
- Add missing put_device in sun4i, and other fixes.
- Handle sun4i alpha on lowest plane correctly.

tv200:
- Fix tve200 enable/disable.

ingenic
- Small ingenic fixes.
The following changes since commit 20561da3a2e1e0e827ef5510cb0f74bcfd377e41:

  Revert "drm/i915/gem: Delete unused code" (2020-09-08 15:45:27 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-11

for you to fetch changes up to 7f7a47952c0f981f9c9a6409c8cf8d025d55af64:

  Merge tag 'drm-misc-fixes-2020-09-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-09-11
09:49:23 +1000)

----------------------------------------------------------------
drm fixes for 5.9-rc5

rapidio/xlnx kconfig fix.

core:
- Documentation fix.

i915:
- audio regression fix

virtio:
- Fix double free in virtio.
- Fix virtio unblank.
- Remove output->enabled from virtio, as it should use crtc_state.

sun4i:
- Add missing put_device in sun4i, and other fixes.
- Handle sun4i alpha on lowest plane correctly.

tv200:
- Fix tve200 enable/disable.

ingenic
- Small ingenic fixes.

----------------------------------------------------------------
Dave Airlie (3):
      Merge tag 'drm-xlnx-dpsub-fixes-20200905' of
git://linuxtv.org/pinchartl/media into drm-fixes
      Merge tag 'drm-intel-fixes-2020-09-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2020-09-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Gerd Hoffmann (2):
      drm/virtio: fix unblank
      drm/virtio: drop virtio_gpu_output->enabled

Gurchetan Singh (1):
      drm/virtio: Revert "drm/virtio: Call the right shmem helpers"

Jernej Skrabec (1):
      drm/sun4i: Fix DE2 YVU handling

Kai Vehmanen (1):
      drm/i915: fix regression leading to display audio probe failure on GLK

Krzysztof Kozlowski (2):
      dma-buf: Fix kerneldoc of dma_buf_set_name()
      dma-buf: fence-chain: Document missing dma_fence_chain_init()
parameter in kerneldoc

Laurent Pinchart (2):
      rapidio: Replace 'select' DMAENGINES 'with depends on'
      drm: xlnx: dpsub: Fix DMADEVICES Kconfig dependency

Linus Walleij (1):
      drm/tve200: Stabilize enable/disable

Maxime Ripard (2):
      drm/sun4i: backend: Support alpha property on lowest plane
      drm/sun4i: backend: Disable alpha on the lowest plane on the A20

Ondrej Jirman (1):
      drm/sun4i: Fix dsi dcs long write function

Paul Cercueil (2):
      drm/ingenic: Fix leak of device_node pointer
      drm/ingenic: Fix driver not probing when IPU port is missing

Randy Dunlap (1):
      Documentation: fix dma-buf.rst underline length warning

Yu Kuai (1):
      drm/sun4i: add missing put_device() call in sun8i_r40_tcon_tv_set_mux()

 Documentation/driver-api/dma-buf.rst         |  2 +-
 drivers/dma-buf/dma-buf.c                    |  6 +++---
 drivers/dma-buf/dma-fence-chain.c            |  1 +
 drivers/gpu/drm/i915/display/intel_display.c | 10 ++++------
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c    | 20 ++++++++++++--------
 drivers/gpu/drm/sun4i/sun4i_backend.c        |  4 +---
 drivers/gpu/drm/sun4i/sun4i_tcon.c           |  8 ++++++--
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c       |  4 ++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c       |  2 +-
 drivers/gpu/drm/tve200/tve200_display.c      | 22 +++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_display.c     | 15 +++++++++++----
 drivers/gpu/drm/virtio/virtgpu_drv.h         |  2 +-
 drivers/gpu/drm/virtio/virtgpu_object.c      |  8 +++++++-
 drivers/gpu/drm/virtio/virtgpu_plane.c       |  6 ++++--
 drivers/gpu/drm/xlnx/Kconfig                 |  1 +
 drivers/rapidio/Kconfig                      |  2 +-
 16 files changed, 77 insertions(+), 36 deletions(-)
