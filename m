Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E513DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 04:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCC52070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 04:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oA4k5FLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2Eoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 00:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Eo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 00:44:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 21:44:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id o18so22872138eje.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 21:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rs1lenLZotPQ2iHXu2o75GAkpYxrTmCghOL/rHRCFjc=;
        b=oA4k5FLGgYFEA2LAM1hQQRKLywC0bIuFyNApPnG12/xMmUuVUHq74dPP00hjeSxegz
         KSKfGK4RPsLFi3FHRC5kueCZ4+gg6OuIK1a+UoSJhLxiocA/RV3h+UDbByoZly0wPl6W
         Rr7KlwVsbt9n7gOG3mdYy7M7lkh9VC5j4yqKwnCCJevN+lusd/pUpefyPc5g9sTrM6P6
         Xg21cxEO7NnNrsdzdEhEt1C62v4FRiJQNCIN1bZxdM0Iw8dG+vi32WhtupPNqOvQNjmS
         sVq2N4NTrwEZH3VikSUN6LSwfznx/cljAdPLM2hSvkingzjseRni8N7GjtdjnNDgZcB2
         z62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rs1lenLZotPQ2iHXu2o75GAkpYxrTmCghOL/rHRCFjc=;
        b=hhdOAk5m+eoG6iYDh4t25lh9bq59l0rz2hYoIZBxgIaB4FlWszbgpI5/oluRN3qGv8
         8YWNhPQ9PYH9RmB00uAPGZvblNUtU3a/s142F9YuNPrOEUjzSbIufPzhPyhVfaHkDcAM
         YolitJiz9xmASuYZNZQE2kBAu43Bv5BmWz2IXAtHj64ehGqidK5ESERn2zTDrv9+xl88
         OrdKrf5UM8TlByPtSBgKB5GHqfCEGJ0bmJ08YCKF40h0r5BeET7ilpKrGbZdPL6Iy9Up
         AcaDlowWKc27V9ue9biOFhOlnWdCRB7CFJzsQWHzrQwfkr8TGYWzVZnO5miyZkDQmULH
         rGeg==
X-Gm-Message-State: AOAM531ak9Fwdkc8VYGZ7AfbP/Or4APqTUaUtvD/PTXiqQjpB4NwLZDa
        1ZWPy+0fz/VHJKnxbOHkFwX4Um4Tw0Bd6235o2M=
X-Google-Smtp-Source: ABdhPJwdFf5bgF/ENdzXvkOOyLdAydhPv9WfkBWFDArVoNsjxhpOcER0I6RYdYs3zQ7YOlmD8AvokH0M2BxdItEMK1U=
X-Received: by 2002:a17:906:4158:: with SMTP id l24mr27898808ejk.101.1595997867983;
 Tue, 28 Jul 2020 21:44:27 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 29 Jul 2020 14:44:16 +1000
Message-ID: <CAPM=9tzCWbg3CUSeywiHxQ-fCE1FAGGdOt5Qm+sjsLQLBSExyw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.8-rc8
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

I'm sending this out a bit early, just to give you a chance to reject
it or help decide on an rc8.

The nouveau fixes missed the last pull by a few hours, and we had a
few arm driver/panel/bridge fixes come in. This is possibly a bit more
than I'm comfortable sending at this stage, but I've looked at each
patch, the core + nouveau patches fix regressions, and the arm related
ones are all around screens turning on and working, and are mostly
trivial patches, the line count is mostly in comments.

If you feel this is too much I'm happy to respin with the
core/drm_fb_helper and nouveau fixes. we have one outstanding nouveau
regression fix, that I'll follow this up with in the next day or so
once Ben and James get it reviewed.

Dave.

This is possibly a bit

drm-fixes-2020-07-29:
drm fixes for 5.8-rc8

core:
- fix possible use-after-free

drm_fb_helper:
- regression fix to use memcpy_io on bochs' sparc64

nouveau:
- format modifiers fixes
- HDA regression fix
- turing modesetting race fix

of:
- fix a double free

dbi:
- fix SPI Type 1 transfer

mcde:
- fix screen stability crash

panel:
- panel: fix display noise on auo,kd101n80-45na
- panel: delay HPD checks for boe_nv133fhm_n61

bridge:
- bridge: drop connector check in nwl-dsi bridge
- bridge: set proper bridge type for adv7511
The following changes since commit 92ed301919932f777713b9172e525674157e983d=
:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-29

for you to fetch changes up to a4a2739beb8933a19281bca077fdb852598803ed:

  Merge tag 'drm-misc-fixes-2020-07-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-07-29
12:46:58 +1000)

----------------------------------------------------------------
drm fixes for 5.8-rc8

core:
- fix possible use-after-free

drm_fb_helper:
- regression fix to use memcpy_io on bochs' sparc64

nouveau:
- format modifiers fixes
- HDA regression fix
- turing modesetting race fix

of:
- fix a double free
dbi:
- fix SPI Type 1 transfer

mcde:
- fix screen stability crash

panel:
- panel: fix display noise on auo,kd101n80-45na
- panel: delay HPD checks for boe_nv133fhm_n61

bridge:
- bridge: drop connector check in nwl-dsi bridge
- bridge: set proper bridge type for adv7511

----------------------------------------------------------------
Ben Skeggs (5):
      drm/nouveau/disp/gm200-: fix regression from HDA SOR selection change=
s
      drm/nouveau/kms/gf100: use correct format modifiers
      drm/nouveau/kms/tu102: wait for core update to complete when
assigning windows
      drm/nouveau/fbcon: fix module unload when fbcon init has failed
for some reason
      drm/nouveau/fbcon: zero-initialise the mode_cmd2 structure

Biju Das (1):
      drm: of: Fix double-free bug

Dave Airlie (2):
      Merge branch 'linux-5.8' of git://github.com/skeggsb/linux into drm-f=
ixes
      Merge tag 'drm-misc-fixes-2020-07-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Douglas Anderson (1):
      drm: panel: simple: Delay HPD checking on boe_nv133fhm_n61 for 15 ms

Guido G=C3=BCnther (1):
      drm/bridge: nwl-dsi: Drop DRM_BRIDGE_ATTACH_NO_CONNECTOR check.

Jitao Shi (1):
      drm/panel: Fix auo, kd101n80-45na horizontal noise on edges of panel

Laurentiu Palcu (1):
      drm/bridge/adv7511: set the bridge type properly

Linus Walleij (1):
      drm/mcde: Fix stability issue

Paul Cercueil (1):
      drm/dbi: Fix SPI Type 1 (9-bit) transfer

Sam Ravnborg (1):
      drm/drm_fb_helper: fix fbdev with sparc64

Steve Cohen (1):
      drm: hold gem reference until object is no longer accessed

 drivers/gpu/drm/bochs/bochs_kms.c               |  1 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c    |  1 +
 drivers/gpu/drm/bridge/nwl-dsi.c                |  5 -----
 drivers/gpu/drm/drm_fb_helper.c                 |  6 ++++-
 drivers/gpu/drm/drm_gem.c                       | 10 ++++-----
 drivers/gpu/drm/drm_mipi_dbi.c                  |  2 +-
 drivers/gpu/drm/drm_of.c                        |  4 +---
 drivers/gpu/drm/mcde/mcde_display.c             | 11 ++++++---
 drivers/gpu/drm/nouveau/dispnv50/disp.c         |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_fbcon.c         |  3 ++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c | 30 +++++++++++++++++----=
----
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c  |  6 ++---
 drivers/gpu/drm/panel/panel-simple.c            | 16 ++++++++++++-
 include/drm/drm_mode_config.h                   | 12 ++++++++++
 14 files changed, 76 insertions(+), 35 deletions(-)
