Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2916C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E29B2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJFltKzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgEVUiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbgEVUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:38:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87908C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:38:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f13so9632657edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/64TcRGVeyAfbkdtn6zZLXZfWddQEQcQu56Nspe0klc=;
        b=lJFltKzS1rPILobpAg7+of0yxLiV9bYXZjxsKyMz4S+b5EOt6NM+beBYDfA36PbkZn
         4C5EIy0Hi2rc0Drj9WgDNeuL+i12f3VXckzSThbIsNBBHk/4/Kmr19YoQS0pDm6IdhdO
         RvHkUCmZYvGY4cbEgMJoEV5WxPzL5861nSf/uqralg92cWCyxG8E/Et9oe9rf8R8X5no
         Ioy4+706v3e0zP1nYnpdntKdAfjSjNaCkiY7ow7ezHhMLploGV+aoMxUdYPKa2iJP127
         0bn/0Kj5oi/jkUJkBL6kH4GrKyKe2TsmtP5UY5/h0OoFYqFDopWeok1UDiOGuUttHEtd
         +qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/64TcRGVeyAfbkdtn6zZLXZfWddQEQcQu56Nspe0klc=;
        b=lpYcxwSVgTvkcm0f29p+2AGtzredILBaLOyI8l/xlbk1GxhiM9TwozgTa/cFEy63fH
         dM8xKgUa0Uz8sid5n/UO5WJFLa1VS+DuaisWIeCnQT4jvLGftFMrwjbUSevv27ksFM06
         l1k+3zJgEiI1L4XmImD0UZWKT8+CBESMSYsq70fUSal1FPEkz21jp31fJcJv1HuTujLk
         C8Khnvze6bRcw832VSIYj6hLXIs7BaOC5p1YwGaWd67eeZfI4wZiU+sP9yCfxM6iqRjB
         3M6Dq+a7BAqQfUf3NtlYaHYym8Yi/VQTLJxUY7m1iUtybxvjDhJB4BR9aBub4RiTDHzk
         /u3g==
X-Gm-Message-State: AOAM531Syil7zXhMx8a+ty1H61I0mqPDEVNHCsQMqusNsfVcodSP8pE4
        hJEldQQEbQqzk/uJsmx58j6LnGtG49I+RhYmXko=
X-Google-Smtp-Source: ABdhPJyPglfPxGsohOq+itEj+JAQjo4eXYFiIGjO1YGVF3lXw0v+AN5z0MWO/viL2XJAMNRCJ7U5xRYBi/DKmn3VoPU=
X-Received: by 2002:aa7:d54c:: with SMTP id u12mr4429839edr.298.1590179902933;
 Fri, 22 May 2020 13:38:22 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 23 May 2020 06:38:11 +1000
Message-ID: <CAPM=9tzdB+BSVLCDwpCBLvKOmamqcwUoSUk4izUzBLK-nY2RRg@mail.gmail.com>
Subject: [git pull] drm fixes for v5.7-rc7
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

Things seemed to have quieten down, though no i915 pull (I even gave
them an extra 12 hours in case they were late). The amdgpu floating
point fix is probably the largest, but it just moves some code around
to it doesn't do fpu stuff outside the fpu boundaries. Otherwise it's
just a couple of vmwgfx fixes (maintainer change) and two etnaviv
fixes.

Dave.

drm-fixes-2020-05-23:
drm fixes for v5.7-rc7

vmwgfx:
- change maintainers
- fix redundant assignment
- fix parameter name
- fix return value

etnaviv:
- memory leak fix when userspace passes a invalid softpin address
- off-by-one crashing the kernel in the perfmon domain iteration when
  the GPU core has both 2D and 3D capabilities

amdgpu:
- DP fix
- Floating point fix
- Fix cursor stutter issue
The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-23

for you to fetch changes up to 7d9ff5eed4146bf026c69e766ff630bc0bd555bb:

  Merge tag 'amd-drm-fixes-5.7-2020-05-21' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-05-22
10:30:51 +1000)

----------------------------------------------------------------
drm fixes for v5.7-rc7

vmwgfx:
- change maintainers
- fix redundant assignment
- fix parameter name
- fix return value

etnaviv:
- memory leak fix when userspace passes a invalid softpin address
- off-by-one crashing the kernel in the perfmon domain iteration when
  the GPU core has both 2D and 3D capabilities

amdgpu:
- DP fix
- Floating point fix
- Fix cursor stutter issue

----------------------------------------------------------------
Christian Gmeiner (1):
      drm/etnaviv: fix perfmon domain interation

Colin Ian King (1):
      drm/vmwgfx: remove redundant assignment to variable ret

Dan Carpenter (1):
      drm/etnaviv: Fix a leak in submit_pin_objects()

Dave Airlie (3):
      Merge branch 'vmwgfx-fixes-5.7' of
git://people.freedesktop.org/~sroland/linux into drm-fixes
      Merge branch 'etnaviv/fixes' of
https://git.pengutronix.de/git/lst/linux into drm-fixes
      Merge tag 'amd-drm-fixes-5.7-2020-05-21' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Guixiong Wei (1):
      drm/vmwgfx: Fix parameter name in vmw_bo_init

Jan Schmidt (1):
      drm/edid: Add Oculus Rift S to non-desktop list

Jason Yan (1):
      drm/vmwgfx: Return true in function vmw_fence_obj_signaled()

Nicholas Kazlauskas (1):
      drm/amd/display: Defer cursor lock until after VUPDATE

Rodrigo Siqueira (1):
      drm/amd/display: Remove dml_common_def file

Roland Scheidegger (1):
      drm/vmwgfx: update MAINTAINERS entry

Vladimir Stempen (1):
      drm/amd/display: DP training to set properly SCRAMBLING_DISABLE

 MAINTAINERS                                        |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 27 +++++++++
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 69 +++++++++++++++++++++-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |  5 ++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |  2 -
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.h  |  1 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h        |  1 -
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.h  |  2 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |  6 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |  2 -
 .../amd/display/dc/dml/display_rq_dlg_helpers.h    |  1 -
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.h  |  2 -
 .../gpu/drm/amd/display/dc/dml/dml_common_defs.c   | 43 --------------
 .../gpu/drm/amd/display/dc/dml/dml_common_defs.h   | 37 ------------
 .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   | 15 ++++-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |  5 ++
 drivers/gpu/drm/drm_edid.c                         |  3 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c          |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  2 +-
 25 files changed, 137 insertions(+), 103 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.h
