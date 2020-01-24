Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 06:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892F72071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 06:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRFfwyu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgAXGDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 01:03:18 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38630 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXGDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 01:03:18 -0500
Received: by mail-lf1-f49.google.com with SMTP id r14so395343lfm.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 22:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zEdYPtIr5Rj3i3xej5EyjAn95dEVZ50fUuhaeqXUW1I=;
        b=IRFfwyu1B895wr30zPmlPm8PYsbUOvEBdoHQUyQ/AeyYyVDH1aLRD6jEnxElOfNgFS
         ckgnBnCu1jNWtjAZVH3rXv4qT9ryueQ8vtEbDBa+Q8KzFXsHeb7Ozj1LORiSrVhIED9t
         YHzL7v3w3WY+95Pwg3+CTiTb93HzYt3ZQJMPgCLpCp3Iq+oyPSkOu7Nc16UFG10aAz3a
         gAMyU6uj8hORY7spN1Ck9RkzBeV+PNjY+tVL4btqZDvwILGXkGaJoKQOUFEA1a5woJ7p
         YaDlbpIK8wZ8n5lyAhSLqVvZCqcv1zoBOUt4OjAqlnt76l94xwGTFkqMM3rsf3ev8RV2
         hgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zEdYPtIr5Rj3i3xej5EyjAn95dEVZ50fUuhaeqXUW1I=;
        b=WqGpzYVQECzeDcNbHE2rRCVaAeonOfP3qfdQPHW1lMQLwTs9KzkQS6n4tI0JlPAFmx
         f0+KNJ6HSwYnqS/pxGkrz52MYzbVYkG5PqE6lqogaUP7ukS0Na04QYsPap5IYNxCfySG
         ZcHqXJlQxFbqLX3/Ls/zbEEgNN7rAw1GKr+9KGJzz0PzlvkB6AUsQigQxaKhgKRcPjdX
         3g4CPcQRZ9EBEJ1CY2eqI0ENib/94hpXnsI6CUFRi0NhcRRyJYrlHU5gZwIBu9sFOtVt
         FoZ+BU/Vt/Qxxk9FzcCdib/1fkKh75QZe846ZY+EOKxF2ajCgFL7/gAH31yGitNxxNP2
         af9Q==
X-Gm-Message-State: APjAAAVOZ+Tg8C1Twc1OpOkcK1zfrP73bRiBudEs+PM+NLQJc92NIT4l
        32ZejpgjjCpULQTlYjqWzR5ZaMwLvjbYwXgJ8MNcXSCv
X-Google-Smtp-Source: APXvYqzo7XanGadzPh7lXKC+qfgcHEFVXzkKcERZu7mKj6XG4Vns2PGd9FGlG/WtO32iOgfdTpkQCPVkkoEvgk7yrrU=
X-Received: by 2002:a19:9d0:: with SMTP id 199mr649062lfj.110.1579845796081;
 Thu, 23 Jan 2020 22:03:16 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 24 Jan 2020 16:03:04 +1000
Message-ID: <CAPM=9ty8zJzPMuvaO4=AuvviKjqMO-VXbZgs+f93wiPFFhg0kw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.5-rc8/final
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

This one has a core mst fix and two i915 fixes. amdgpu just enables
some hw outside experimental.

The panfrost fix is a little bigger than I'd like at this stage but it
fixes a fairly fundamental problem with global shared buffers in that
driver, and since it's confined to that driver and I've taken a look
at it, I think it's fine to get into the tree now, so it can get
stable propagated as well.

Dave.

drm-fixes-2020-01-24:
drm fixes for 5.5-rc8

core/mst:
- Fix SST branch device handling

amdgpu:
- enable renoir outside experimental

i915:
- Avoid overflow with huge userptr objects
- uAPI fix to correctly handle negative values in
  engine->uabi_class/instance (cc: stable)

panfrost:
- Fix mapping of globally visible BO's (Boris)
The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-24

for you to fetch changes up to 49412f6636bab17dbdc25e36d6482013e4188c88:

  Merge tag 'amd-drm-fixes-5.5-2020-01-23' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-01-24
08:58:12 +1000)

----------------------------------------------------------------
drm fixes for 5.5-rc8

core/mst:
- Fix SST branch device handling

amdgpu:
- enable renoir outside experimental

i915:
- Avoid overflow with huge userptr objects
- uAPI fix to correctly handle negative values in
  engine->uabi_class/instance (cc: stable)

panfrost:
- Fix mapping of globally visible BO's (Boris)

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: remove the experimental flag for renoir

Boris Brezillon (1):
      drm/panfrost: Add the panfrost_gem_mapping concept

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2020-01-22-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2020-01-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.5-2020-01-23' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Matthew Auld (1):
      drm/i915/userptr: fix size calculation

Tvrtko Ursulin (1):
      drm/i915: Align engine->uabi_class/instance with i915_drm.h

Wayne Lin (1):
      drm/dp_mst: Handle SST-only branch device case

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |   2 +-
 drivers/gpu/drm/drm_dp_mst_topology.c            | 140 +++++++++++++----------
 drivers/gpu/drm/i915/gem/i915_gem_busy.c         |  12 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c      |   9 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h     |   4 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c              |   2 +
 drivers/gpu/drm/panfrost/panfrost_drv.c          |  91 +++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_gem.c          | 124 +++++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_gem.h          |  41 ++++++-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |   3 +-
 drivers/gpu/drm/panfrost/panfrost_job.c          |  13 ++-
 drivers/gpu/drm/panfrost/panfrost_job.h          |   1 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c          |  61 +++++-----
 drivers/gpu/drm/panfrost/panfrost_mmu.h          |   6 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c      |  34 ++++--
 15 files changed, 396 insertions(+), 147 deletions(-)
