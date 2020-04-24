Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500E9C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FA321473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHexWr1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDXDWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbgDXDWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:22:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABCCC09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:22:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j20so6131599edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=abRl9WO9L5aHTZUxjonADdYG8d/NHJpa1DNCFn9mMXI=;
        b=RHexWr1+8BoIornTZPveiuic/gwUY2Q6Katd6kYEhKmK4LPKKQc+r/Ksm76LV64q1u
         td+utQdc67ykz+BLnRr0XjYRLGwKj0Mmz//VBnu20X01dUrSpjkIRI0hvjGb2JX8Gdh1
         canPOm4TtZtXm6LcAmB+wGHaTsel2F9JCt7ex4OZQo8vX0QqkaoMVsMkGOzu98N+hanp
         Yk57sWcRRFPyyjyBWP+R8GsFTwRXS5eAILQC3VSBvLWFneV5fhJTqGfLM4XiFGzIdhyo
         5xQ6L364DN3P+gMYEIZCbh7LNJ0oZris+TIAuNUNTAaDsGrl5WPt6a07UWeUGJtx9abw
         Ua5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=abRl9WO9L5aHTZUxjonADdYG8d/NHJpa1DNCFn9mMXI=;
        b=qtIhIwO1Bp4BjHNWwiB4TLXVq4XFfwsxoDmnouC6qkaWWVUwvSes/VPXIeBoDl1o/X
         Jnp5CfsLeznbsRZoR0OUBUpALYALk63lu8YCvNRUfYKj0JRAUAjyEUmNfk3qDO9gAqnv
         pl/6PVJZTG2owej6VRDo35CaOqCYxWgQVnIQnEvGTsbmoXCN3FrE8FAwlrh3ch1I1biN
         6/kI2aSGOo+buPBfvI/GhwYKruN3uXDal9owKG49Zk5BUoM7tAB7O7zKZGLQ1RVd+Uw7
         hBqwuhBQDwUixfGeZLqymxr+M/pfW4yZN8/09M/HSwYzKBhENqSh0tAREBB5NDu3I0dd
         AUnw==
X-Gm-Message-State: AGi0PuYjh1viCtrtI2ni8hqH2bSt7yAfeZjwMQ9v8TgBQODdnn0uuCcS
        LfPjuerrsLl2vQkykhdLvx9pgargRVTfG0CFxK+UQiYi
X-Google-Smtp-Source: APiQypLAbeDXjZ4JEoaiya6oH/MkNPql2y+xAsvFy2d4ul5inFB9ndHCuJHEZRfF2L915WXb5wq+6voZ4MKpwPdewco=
X-Received: by 2002:aa7:dac4:: with SMTP id x4mr4274447eds.127.1587698562488;
 Thu, 23 Apr 2020 20:22:42 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 24 Apr 2020 13:22:30 +1000
Message-ID: <CAPM=9txZkNiAoVMyoBwDaew+WDBQu3rcTYOTs9+Vn1unoq9m1A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc3
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

Hey Linus,

Weekly regular fixes for drm, The usual rc3 uptick here, but nothing
too crazy or notable.

Dave.

drm-fixes-2020-04-24:
drm fixes for 5.7-rc3

core:
- mst: zero pbn when releasing vcpi slots

amdgpu:
- Fix resume issue on renoir
- Thermal fix for older CI dGPUs
- Fix some fallout from dropping drm load/unload callbacks

i915:
- Tigerlake Workaround - disabling media recompression (Matt)
- Fix RPS interrupts for right GPU frequency (Chris)
- HDCP fix prime check (Oliver)
- Tigerlake Thunderbolt power well fix (Matt)
- Tigerlake DP link training fixes (Jose)
- Documentation sphinx build fix (Jani)
- Fix enable_dpcd_backlight modparam (Lyude)

analogix-dp:
- binding fix

meson:
- remove unneeded error message

bindings:
- fix warnings
- fix lvds binding

scheduler:
- thread racing fix

tidss:
- use after free fix
The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936=
:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-04-24

for you to fetch changes up to e32b2484b3e00170b6cf57d99a18972e174e10ea:

  Merge tag 'drm-misc-fixes-2020-04-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-04-24
10:14:04 +1000)

----------------------------------------------------------------
drm fixes for 5.7-rc3

core:
- mst: zero pbn when releasing vcpi slots

amdgpu:
- Fix resume issue on renoir
- Thermal fix for older CI dGPUs
- Fix some fallout from dropping drm load/unload callbacks

i915:
- Tigerlake Workaround - disabling media recompression (Matt)
- Fix RPS interrupts for right GPU frequency (Chris)
- HDCP fix prime check (Oliver)
- Tigerlake Thunderbolt power well fix (Matt)
- Tigerlake DP link training fixes (Jose)
- Documentation sphinx build fix (Jani)
- Fix enable_dpcd_backlight modparam (Lyude)

analogix-dp:
- binding fix

meson:
- remove unneeded error message

bindings:
- fix warnings
- fix lvds binding

scheduler:
- thread racing fix

tidss:
- use after free fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/display: fix aux registration (v2)
      drm/amdgpu/display: give aux i2c buses more meaningful names

Chris Wilson (1):
      drm/i915/gt: Update PMINTRMSK holding fw

Christian K=C3=B6nig (1):
      drm/scheduler: fix drm_sched_get_cleanup_job

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.7-2020-04-22' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-04-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2020-04-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Fabio Estevam (2):
      dt-bindings: display: ltk500hd1829: Remove the reg property
      dt-bindings: display: xpp055c272: Remove the reg property

Jani Nikula (1):
      drm/i915: fix Sphinx build duplicate label warning

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/display: Load DP_TP_CTL/STATUS offset before use it

Lyude Paul (1):
      drm/i915/dpcd_bl: Unbreak enable_dpcd_backlight modparam

Marek Szyprowski (1):
      drm/bridge: analogix_dp: Split bind() into probe() and real bind()

Markus Elfring (1):
      drm/meson: Delete an error message in meson_dw_hdmi_bind()

Matt Roper (2):
      drm/i915/tgl: Add Wa_14010477008:tgl
      drm/i915/tgl: TBT AUX should use TC power well ops

Maxime Ripard (1):
      Merge v5.7-rc1 into drm-misc-fixes

Mikita Lipski (1):
      drm/dp_mst: Zero assigned PBN when releasing VCPI slots

Oliver Barta (1):
      drm/i915: HDCP: fix Ri prime check done during link check

Prike Liang (1):
      drm/amd/powerplay: fix resume failed as smu table initialize early ex=
it

Sam Ravnborg (1):
      dt-bindings: display: allow port and ports in panel-lvds

Sandeep Raghuraman (1):
      drm/amdgpu: Correctly initialize thermal controller for GPUs
with Powerplay table v0 (e.g Hawaii)

Tomi Valkeinen (1):
      drm/tidss: fix crash related to accessing freed memory

Vasily Khoruzhick (1):
      drm/bridge: anx6345: set correct BPC for display_info of connector

 .../display/panel/leadtek,ltk500hd1829.yaml        |  1 -
 .../devicetree/bindings/display/panel/lvds.yaml    | 10 ++++++++-
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |  1 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 ++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 15 ++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  3 ++-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  | 26 ++++++++++++++++++=
++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |  7 +++++-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  3 +++
 drivers/gpu/drm/drm_dp_mst_topology.c              |  1 +
 drivers/gpu/drm/i915/display/intel_ddi.c           | 14 +++++++++---
 drivers/gpu/drm/i915/display/intel_display_power.c | 12 +++++-----
 drivers/gpu/drm/i915/display/intel_dp.c            |  5 ++---
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |  1 +
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  3 ++-
 drivers/gpu/drm/i915/display/intel_sprite.c        | 17 +++++++++-----
 drivers/gpu/drm/i915/gt/intel_rps.c                |  9 +++++---
 drivers/gpu/drm/i915/i915_drv.h                    |  2 ++
 drivers/gpu/drm/i915/i915_reg.h                    |  4 ++--
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  4 +---
 drivers/gpu/drm/scheduler/sched_main.c             |  2 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 | 16 ++++++++++---
 drivers/gpu/drm/tidss/tidss_encoder.c              | 14 +++++++++---
 drivers/gpu/drm/tidss/tidss_plane.c                | 24 +++++++++++++++---=
--
 24 files changed, 156 insertions(+), 52 deletions(-)
