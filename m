Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3C2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A702137B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tl4b+2Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgIDDxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgIDDxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:53:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E89C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:53:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j11so6804265ejk.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 20:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8x3NTRCTKgtCNUxj9R1GgJk1hed7ywjOyhVq4HVWWIA=;
        b=tl4b+2Rt+YMPUu4mo7RZJIIZILFp6poZAYZsnmGMtJYF9ADqleaUmMgu9wFRp8HX4v
         4BhZfYACBaGyMeHRRbA+RRxGSEUDTd4ADVysrzdX49b5RIBb+lEaYiSKcm2q4+yDpJC8
         1AJQoCJXWJ+ta43TU0+HZ4k+XaH4YVUme/9m2j50hKSSchZBcSVwoAnvxPBZ5eLkVqTO
         LsQHeFVF+X6X25PBhwt7IwbEWsjuuqRp1vD2osXB7Uhhb9azMetn6ydKPgmIK4dZZ9Vn
         H3vRTkQBBqNjpcPSKfxBoZ9HZ1uysn8WB9nEm4k1IA8U0pYTlp29SRJo3gpV8YL13aBm
         y3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8x3NTRCTKgtCNUxj9R1GgJk1hed7ywjOyhVq4HVWWIA=;
        b=MPd2AvECpUJ8eyTE+/PBJSSfdP0oTVdXNx0/OTcEJP69IAk0iCU+WpE7XWxtPSbVYK
         n/+U86ifm5y6t13IysF7ao6FOCxAML44X+KWLPBumdi/qbWQ21CCEYoFhI8rt4+EwzGL
         PgJKMm/MfSuueafGnl5kIPuNNHMjsyAdObsJAHmkQxWmL7jUZ4pLML+5Xa2ZlCtvxoYx
         TRTvmgKyy4YM5XTCTYiAIum6btHjUfjAjpfAE2a/ZKRKqhy4jSJEdmCxDlwEgubUKVED
         6he3aGcjOgYYqoaFDqrISLXuynKvgmuKQDfSGT77T8lmUvJQ/bXAOIgaXTjtmBVZmpvC
         9oJA==
X-Gm-Message-State: AOAM530xzQsFQuhqox8K28PyzGOT79IIVIQgJGaTuPdAt9A++15TKL2w
        /NyF0YBhUeQWgmjcmfoCBYoQ4Ail2Pi6oP460jAL2NYyhtxZ5w==
X-Google-Smtp-Source: ABdhPJw5WqGeSuLUM7iMduAWAG1PRIDEdlc6m2nlWiUW3tBxr0BW7oSQOFX30FfcGZrrUOOB18ivC8m6kL7iSZ5gHoE=
X-Received: by 2002:a17:906:d787:: with SMTP id pj7mr5238195ejb.340.1599191587006;
 Thu, 03 Sep 2020 20:53:07 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 4 Sep 2020 13:52:56 +1000
Message-ID: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.9-rc4
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

Not much going on this week, nouveau has a display hw bug workaround,
amdgpu has some PM fixes and CIK regression fixes, one single radeon
PLL fix, and a couple of i915 display fixes.

Dave.

drm-fixes-2020-09-04:
drm fixes for 5.9-rc4

amdgpu:
- Fix for 32bit systems
- SW CTF fix
- Update for Sienna Cichlid
- CIK bug fixes

radeon:
- PLL fix

i915:
- Clang build warning fix
- HDCP fixes

nouveau:
- display fixes
The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-04

for you to fetch changes up to d37d56920004cae612fa32d1f92aaacca5e145f7:

  Merge branch 'linux-5.9' of git://github.com/skeggsb/linux into
drm-fixes (2020-09-04 11:14:49 +1000)

----------------------------------------------------------------
drm fixes for 5.9-rc4

amdgpu:
- Fix for 32bit systems
- SW CTF fix
- Update for Sienna Cichlid
- CIK bug fixes

radeon:
- PLL fix

i915:
- Clang build warning fix
- HDCP fixes

nouveau:
- display fixes

----------------------------------------------------------------
Ben Skeggs (3):
      drm/nouveau/kms/nv50-: add some whitespace before debug message
      drm/nouveau/kms/nv50-gp1xx: disable notifies again after core update
      drm/nouveau/kms/nv50-gp1xx: add WAR for EVO push buffer HW bug

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.9-2020-09-03' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-09-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'linux-5.9' of git://github.com/skeggsb/linux into drm-fixes

Evan Quan (1):
      drm/amd/pm: avoid false alarm due to confusing
softwareshutdowntemp setting

Jiansong Chen (1):
      drm/amd/pm: enable MP0 DPM for sienna_cichlid

Kai-Heng Feng (1):
      drm/radeon: Prefer lower feedback dividers

Kevin Wang (1):
      drm/amd/pm: fix is_dpm_running() run error on 32bit system

Lyude Paul (1):
      drm/nouveau/kms/gv100-: Include correct push header in crcc37d.c

Nathan Chancellor (1):
      drm/i915/display: Ensure that ret is always initialized in
icl_combo_phy_verify_state

Sandeep Raghuraman (2):
      drm/amdgpu: Specify get_argument function for ci_smu_funcs
      drm/amdgpu: Fix bug in reporting voltage for CIK

Sean Paul (2):
      drm/i915: Fix sha_text population code
      drm/i915: Clear the repeater bit on HDCP disable

 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 10 +++++--
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  3 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   | 14 ++++++++--
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 10 +++++--
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 14 +++++++---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |  2 ++
 drivers/gpu/drm/i915/display/intel_combo_phy.c     |  4 +--
 drivers/gpu/drm/i915/display/intel_hdcp.c          | 32 ++++++++++++++++++----
 drivers/gpu/drm/nouveau/dispnv50/core507d.c        |  5 +++-
 drivers/gpu/drm/nouveau/dispnv50/crcc37d.c         |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  6 ++++
 drivers/gpu/drm/nouveau/include/nvif/push507c.h    |  2 +-
 drivers/gpu/drm/radeon/radeon_display.c            |  2 +-
 include/drm/drm_hdcp.h                             |  3 ++
 14 files changed, 84 insertions(+), 25 deletions(-)
