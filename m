Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C03FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5150720672
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm9kw0Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGQDmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgGQDmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:42:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8945BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 20:42:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d16so6570561edz.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 20:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MUvIjGbj40SAj1dmmgt2j+ZkfMCiRCcBfs1T47BWS2Y=;
        b=fm9kw0Pwv9iBokBTe7xaMyYRNUETdgLiMt5Cr17Cf9pU7yOsefrFtSlG1nu196apbq
         g1oBv7PXRDleXh6twUkDijvoluzzB4kfx2zSzP7PJjUuOppCyWiycOSrvy2vjM1nbLlU
         QPfHqy28LJkZE2m9jZMimJI+no9hg8s2tL54IV9k5SxrpFF4UeTy//rvb8BbjdgxH/pk
         BQdRkNRDfRQDTUNat8BAFnA9uVz5qhYt0ZgqE5sDb2K5Dh4Jk48/jORXSb5/KuPbrXNI
         6VV846pTjxINMibgut/2WLRO8BpXnujB4hO4AttJs0NCwUTN744OuMd4n/g7qkiCqetM
         XrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MUvIjGbj40SAj1dmmgt2j+ZkfMCiRCcBfs1T47BWS2Y=;
        b=VWl7+DJH9rih3luwyToMokAd+1XIddp/lq/d5OwWCk4lfxbvEpJpQ5jxhIxJP//W+h
         tOf++/Nl+KY0R0mT/zd6oxkRM3ggYqFmwfQgLHubHH5kAhMZBxFWzirz+2sFPw5f6ZHI
         YxE1TZl/b9sWAjrsQ96lz9rk8YC7WMg0WaT6K9psGbWSuBYSSORk9s6g+Yh2FM6EfLHM
         D2o1pDFuhkqDq90r+HA8mymVoufmng9uEmpKjkyrDrZ1OngPB9pHC55CDmnHLudIuFeR
         ZY18rTy19jSooxcRnaGqKTOCp2imoWXRRgSZLFg00qudQOhhihr1vqgHEqmF99Ja6yTy
         bS6Q==
X-Gm-Message-State: AOAM530TfxOBtszi5vZNpxUhtOBLqu4qmwiuwnXMofwS9uBZIrXv02Z0
        Td/92IJbtwyZndb7nFNjO/s6fFNz0ubDSVAUZgsama9T
X-Google-Smtp-Source: ABdhPJxtv8fNG4Ou+5NYjx0vsOyNAXX1yfRs4yM09a1RMl3qJwv2I097O6UJMwBa0wfvkfbhMWQQNgdomwqbh16+p2M=
X-Received: by 2002:a50:f08c:: with SMTP id v12mr7203912edl.119.1594957334013;
 Thu, 16 Jul 2020 20:42:14 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 17 Jul 2020 13:42:02 +1000
Message-ID: <CAPM=9txCq=97pFiCoOGLz7-Ght-spbVFKURx_b0kVw9sO1+=zw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.8-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Weekly fixes pull, big bigger than I'd normally like, but they are
fairly scattered and small individually. The vmwgfx one is a black
screen regression, otherwise the largest is an MST encoder fix for
amdgpu which results in a WARN in some cases, and a scattering of i915
fixes.

I'm tracking two regressions at the moment that hopefully we get
nailed down this week for rc7.

Dave.

drm-fixes-2020-07-17-1:
drm fixes for 5.8-rc6

dma-buf:
- sleeping atomic fix

amdgpu:
- Fix a race condition with KIQ
- Preemption fix
- Fix handling of fake MST encoders
- OLED panel fix
- Handle allocation failure in stream construction
- Renoir SMC fix
- SDMA 5.x fix

i915:
- FBC w/a stride fix
- Fix use-after-free fix on module reload
- Ignore irq enabling on the virtual engines to fix device sleep
- Use GTT when saving/restoring engine GPR
- Fix selftest sort function

vmwgfx:
- black screen fix

aspeed:
- fbcon init warn fix
The following changes since commit 11ba468877bb23f28956a35e896356252d63c983=
:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-17-1

for you to fetch changes up to adbe8a3cae94a63e9f416795c750237a9b789124:

  Merge tag 'amd-drm-fixes-5.8-2020-07-15' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-07-17
13:29:00 +1000)

----------------------------------------------------------------
drm fixes for 5.8-rc6

dma-buf:
- sleeping atomic fix

amdgpu:
- Fix a race condition with KIQ
- Preemption fix
- Fix handling of fake MST encoders
- OLED panel fix
- Handle allocation failure in stream construction
- Renoir SMC fix
- SDMA 5.x fix

i915:
- FBC w/a stride fix
- Fix use-after-free fix on module reload
- Ignore irq enabling on the virtual engines to fix device sleep
- Use GTT when saving/restoring engine GPR
- Fix selftest sort function

vmwgfx:
- black screen fix

aspeed:
- fbcon init warn fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/display: create fake mst encoders ahead of time (v4)

Charan Teja Kalla (1):
      dmabuf: use spinlock to access dmabuf->name

Chris Wilson (2):
      drm/i915/gt: Ignore irq enabling on the virtual engines
      drm/i915/gt: Only swap to a random sibling once upon creation

Dave Airlie (4):
      Merge branch 'vmwgfx-fixes-5.8' of
git://people.freedesktop.org/~sroland/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-07-15' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2020-07-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.8-2020-07-15' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Guenter Roeck (1):
      drm/aspeed: Call drm_fbdev_generic_setup after drm_dev_register

Jack Xiao (2):
      drm/amdgpu/gfx10: fix race condition for kiq
      drm/amdgpu: fix preemption unit test

Josip Pavic (1):
      drm/amd/display: handle failed allocation during stream construction

Maarten Lankhorst (1):
      drm/i915: Move cec_notifier to intel_hdmi_connector_unregister, v2.

Roland Scheidegger (1):
      drm/vmwgfx: fix update of display surface when resolution changes

Sudeep Holla (1):
      drm/i915/selftests: Fix compare functions provided for sorting

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Use GTT when saving/restoring engine GPR

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Recalculate FBC w/a stride when needed

Xiaojie Yuan (1):
      drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()

chen gong (1):
      drm/amdgpu/powerplay: Modify SMC message name for setting power
profile mode

hersen wu (1):
      drm/amd/display: OLED panel backlight adjust not work with
external display connected

 drivers/dma-buf/dma-buf.c                          | 11 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 20 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  9 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             | 26 ++++-------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 ++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  | 11 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 53 +++++++++++-------=
----
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  3 ++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    | 19 ++++++--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |  2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |  3 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           | 33 +++++++++++---
 drivers/gpu/drm/i915/display/intel_hdmi.c          | 10 +---
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 19 ++------
 drivers/gpu/drm/i915/gt/selftest_rps.c             |  8 ++--
 drivers/gpu/drm/i915/i915_drv.h                    |  1 +
 drivers/gpu/drm/i915/i915_perf.c                   |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  8 ++--
 include/linux/dma-buf.h                            |  1 +
 19 files changed, 153 insertions(+), 99 deletions(-)
