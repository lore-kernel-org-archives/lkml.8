Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2102C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C275724683
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXY7+A3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbgAJDzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:55:24 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:44380 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbgAJDzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:55:24 -0500
Received: by mail-lj1-f173.google.com with SMTP id u71so610138lje.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 19:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iFWg/nZPSD1b9y01T9keuRr9NKGxYuhWrPAOsBj9JwA=;
        b=RXY7+A3HbdU86uNeZYxqwJWkTo/YQ696MPpJCFRR9mWtCzeZyzajvA98Oe0QiJ/MOj
         n36wv8cZA0svu8oLhzE4+aNETwFjasAi80P+2DLd81bZZQ1iXyj87u9clG+++eR9Siqg
         /ruJ4QUz2/ivw0nFMvg2XwyVyDfI4sDnbNijtAhpgysys5tJe8mo6yXg6BrAe19JqE6x
         Pug2KO9OJ6MW/aRj1tXzmTuje8Rag0BZppPSVKWApaT0TM4WuktDCDTohXe5wGqBqu7s
         YFvMsbbU7m1XzioTKBr0vB9HzYvQrNbGYhYJX3i2OqeN3D2ZqoiJXTemaCcSEEBfqwaw
         YlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iFWg/nZPSD1b9y01T9keuRr9NKGxYuhWrPAOsBj9JwA=;
        b=sarLYkatPdZxJyJg++/lO08PQm0bPYJKxSeOZLo8zh7+3vViRDjcj2hcDfvEOmhBZR
         mi+L6eHG6bNjrD4PdmVfOP2URZ/Hao/JwYMoje60KmXazcxqKd80n89FoIeUEF8jm+Eo
         /1i4yDaPyIPV6bhtdLTapwZ3h+BSHXOfMblQEDw48BLVicYp2fkh6zeQV04lvkbeMLmM
         FoF07wuT5f/LVCiLrGVsOJWjXtMYl3Ots2orkoqEsbvqLfRwgvymNhM/KsGD4ZvBVE5e
         PLgvolJAYuTBXmn39L4ze4Qs4T3Hc2tR9cao2bf54RH/egm0HzNhKid8jqyIzSeQGu48
         fd9g==
X-Gm-Message-State: APjAAAUywwVThTVbUChna/E+T1ZrC2KBspBac6vw9NkAkxyytiP9wgPJ
        0e97xkWUemAQfM2jsdr2HjcIZGhjFybY5WLlhNblW0uX
X-Google-Smtp-Source: APXvYqx13+7hhQZyA1YyKm1pGyf2A1DRjD/suy8fRPTWtmDJSRLSfATOOSm6kw7ymPHbkBu99sYm33mi89pTtzfA1ws=
X-Received: by 2002:a2e:b4ef:: with SMTP id s15mr1046003ljm.20.1578628521181;
 Thu, 09 Jan 2020 19:55:21 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 10 Jan 2020 13:55:10 +1000
Message-ID: <CAPM=9txLfwePjpy4euR+VX+g44=YN=uq4OX6zEix6FWaO05PLA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.5-rc6
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

Pre-LCA pull request I'm not sure how things will look next week,
myself and Daniel are at LCA and I'm speaking quite late, so if I get
my talk finished I'll probably process fixes.

This week has a bunch of i915 fixes, some amdgpu fixes, one sun4i, one
core MST, and one core fb_helper fix. More details are below.

Regards,
Dave.


drm-fixes-2020-01-10:
drm fixes for 5.5-rc6

core:
- mst Fix NO_STOP_BIT bit offset (Wayne)

fb_helper:
- fb_helper: Fix bits_per_pixel param set behavior to round up (Geert)

sun4i:
- Fix RGB_DIV clock min divider on old hardware (Chen-Yu)

amdgpu:
- Stability fix for raven
- Reduce pixel encoding to if max clock is exceeded on HDMI
  to allow additional high res modes
- enable DRIVER_SYNCOBJ_TIMELINE for amdgpu

i915:
- Fix GitLab issue #446 causing GPU hangs: Do not restore invalid RS state
- Fix GitLab issue #846: Restore coarse power gating that was disabled
  by initial RC66 context corruption security fixes.
- Revert f6ec9483091f ("drm/i915: extend audio CDCLK>=2*BCLK
constraint to more platforms")
  to avoid screen flicker
- Fix to fill in unitialized uabi_instance in virtual engine uAPI
- Add two missing W/As for ICL and EHL
The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-10

for you to fetch changes up to 023b3b0e139f54a680202790ba801f61aa43a5c8:

  Merge tag 'drm-intel-fixes-2020-01-09-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2020-01-10
11:43:02 +1000)

----------------------------------------------------------------
drm fixes for 5.5-rc6

core:
- mst Fix NO_STOP_BIT bit offset (Wayne)

fb_helper:
- fb_helper: Fix bits_per_pixel param set behavior to round up (Geert)

sun4i:
- Fix RGB_DIV clock min divider on old hardware (Chen-Yu)

amdgpu:
- Stability fix for raven
- Reduce pixel encoding to if max clock is exceeded on HDMI
  to allow additional high res modes
- enable DRIVER_SYNCOBJ_TIMELINE for amdgpu

i915:
- Fix GitLab issue #446 causing GPU hangs: Do not restore invalid RS state
- Fix GitLab issue #846: Restore coarse power gating that was disabled
  by initial RC66 context corruption security fixes.
- Revert f6ec9483091f ("drm/i915: extend audio CDCLK>=2*BCLK
constraint to more platforms")
  to avoid screen flicker
- Fix to fill in unitialized uabi_instance in virtual engine uAPI
- Add two missing W/As for ICL and EHL

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amdgpu: Set no-retry as default."

Chen-Yu Tsai (1):
      drm/sun4i: tcon: Set RGB DCLK min. divider based on hardware model

Chris Wilson (3):
      drm/i915/gt: Mark up virtual engine uabi_instance
      drm/i915/gt: Do not restore invalid RS state
      drm/i915/gt: Restore coarse power gating

Chunming Zhou (1):
      drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2020-01-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.5-2020-01-08' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-01-09-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Geert Uytterhoeven (1):
      drm/fb-helper: Round up bits_per_pixel if possible

Kai Vehmanen (1):
      drm/i915: Limit audio CDCLK>=2*BCLK constraint back to GLK only

Manasi Navare (1):
      drm/i915/dp: Disable Port sync mode correctly on teardown

Matt Roper (2):
      drm/i915: Add Wa_1408615072 and Wa_1407596294 to icl,ehl
      drm/i915: Add Wa_1407352427:icl,ehl

Thomas Anderson (1):
      drm/amd/display: Reduce HDMI pixel encoding if max clock is exceeded

Wayne Lin (1):
      drm/dp_mst: correct the shifting in DP_REMOTE_I2C_READ

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |  7 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++++-----------
 drivers/gpu/drm/drm_dp_mst_topology.c             |  2 +-
 drivers/gpu/drm/drm_fb_helper.c                   |  7 +++-
 drivers/gpu/drm/i915/display/intel_audio.c        |  4 +-
 drivers/gpu/drm/i915/display/intel_display.c      |  7 +---
 drivers/gpu/drm/i915/gt/intel_lrc.c               |  2 +
 drivers/gpu/drm/i915/gt/intel_ring_submission.c   | 31 ++++++----------
 drivers/gpu/drm/i915/i915_drv.h                   |  6 ++-
 drivers/gpu/drm/i915/i915_reg.h                   |  8 +++-
 drivers/gpu/drm/i915/intel_pm.c                   | 11 ++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                | 15 ++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h                |  1 +
 13 files changed, 85 insertions(+), 61 deletions(-)
