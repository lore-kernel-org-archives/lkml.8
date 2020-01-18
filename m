Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE0C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365D024683
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0CEMd7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgARVVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:21:49 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44057 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgARVVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:21:48 -0500
Received: by mail-lf1-f43.google.com with SMTP id v201so20997096lfa.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 13:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Yj4XEU5EtFjO2WH0v0wMntHUc/4ZhJ63I+DRrWgRx2k=;
        b=L0CEMd7rNoyM0obhUqEZjLfQ2GjoJAxSCDLdmjvj9PgFZVii77XcfGbLOLH4zo+32N
         ag/9cfUqabNsBW+VqC0Z9fEXtj+WKsHfTgyW7qcZYL8sOWNvmyU01L+wrN8RM61x47fT
         K+8qzVkZCkhArx+8GICw6av5/4AazfYYmeTiOm8KqYUO8/eOStIKMDjbpklga/Nk7UdM
         cQ0/RmufWaYoHgSwYd5M+JlkgQBwO5+bwiAGhgtrKiZkCOCniz3gDQrwAa9wm69fcPwN
         NpYzrJCmODb/BMTON7EbNdmTXp/b4yq2T4zWcCjnJScyYdBAdvjboxJ94myC82Zig6Cq
         AVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Yj4XEU5EtFjO2WH0v0wMntHUc/4ZhJ63I+DRrWgRx2k=;
        b=SsVYMxdcfe6T6URcb2RA4jW/XwFeKpkRseRMa8FS1ShifbDvH5eQmI9LV8pvtdEKuG
         0E+Dx2TSBfETGgZbhgSrCZrs65p31kBmCl6YFcBJafsAxoPxqKTJn5UfcY6uMMat4Pdt
         XVB6IUYFY9bGqrE/Q/aay1uZ/4Wd8m0Vcs25k/Ju166jk0BSiHIiNTPytAgmWudqia8M
         yUsVhhLkFu8CYzFLg8z3Jg92rXXk7xFOPkohQuX2vp7vIIAQlKc57evwu+g86xRCIZFw
         CBpM91sVV7Mq18eHGj0HIN+rse2YBlSDIRM6tL4fdu1B3ONjJ6DoL1UL8zdeA2sR2j4C
         X+3g==
X-Gm-Message-State: APjAAAWHoAANj03hWIYgFSm0ivYQcI8qL87BP9nU89ZShjptERfh/OYo
        WGRnZVZdHAx6h0MXdTyVWtT0/Y4Th6B9M/xcinA=
X-Google-Smtp-Source: APXvYqyEuDOQooArqH3BmeO+9lfGOyrHBpQ1fXlFn2FSuGxgv7BSw3F0XEtYtUXUN/DefRd5nTZPXKOb5rH0swqRkj0=
X-Received: by 2002:a19:e30b:: with SMTP id a11mr9148830lfh.48.1579382506307;
 Sat, 18 Jan 2020 13:21:46 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 19 Jan 2020 07:21:35 +1000
Message-ID: <CAPM=9tyCmZM2Nzy397APbb9-EcNyC-Bgz4Q_7hTcjaQpX6E1Pw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.5-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Back from LCA2020, fixes wasn't too busy last week, seems to have
quieten down appropriately, some amdgpu, i915, then a core mst fix and
one fix for virtio-gpu and one for rockchip.

Dave.


drm-fixes-2020-01-19:
drm fixes for 5.5-rc7

core mst:
- serialize down messages and clear timeslots are on unplug

amdgpu:
- Update golden settings for renoir
- eDP fix

i915:
- uAPI fix: Remove dash and colon from PMU names to comply with tools/perf
- Fix for include file that was indirectly included
- Two fixes to make sure VMA are marked active for error capture

virtio:
- maintain obj reservation lock when submitting cmds

rockchip:
- increase link rate var size to accommodate rates
The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-19

for you to fetch changes up to f66d84c8b4db9a4f77f29e2d8fd521196c879582:

  Merge tag 'drm-misc-fixes-2020-01-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-01-18
12:54:37 +1000)

----------------------------------------------------------------
drm fixes for 5.5-rc7

core mst:
- serialize down messages and clear timeslots are on unplug

amdgpu:
- Update golden settings for renoir
- eDP fix

i915:
- uAPI fix: Remove dash and colon from PMU names to comply with tools/perf
- Fix for include file that was indirectly included
- Two fixes to make sure VMA are marked active for error capture

virtio:
- maintain obj reservation lock when submitting cmds

rockchip:
- increase link rate var size to accommodate rates

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu: update goldensetting for renoir

Chris Wilson (3):
      drm/i915/gt: Skip trying to unbind in restore_ggtt_mappings
      drm/i915/gt: Mark context->state vma as active while pinned
      drm/i915/gt: Mark ring->vma as active while pinned

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.5-2020-01-15' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-01-16' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2020-01-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Gerd Hoffmann (1):
      drm/virtio: add missing virtio_gpu_array_lock_resv call

Mario Kleiner (1):
      drm/amd/display: Reorder detect_edp_sink_caps before link settings read.

Tobias Schramm (1):
      drm/rockchip: fix integer type used for storing dp data rate

Tvrtko Ursulin (1):
      drm/i915/pmu: Do not use colons or dashes in PMU names

Wayne Lin (2):
      drm/dp_mst: clear time slots for ports invalid
      drm/dp_mst: Have DP_Tx send one msg at a time

YueHaibing (1):
      drm/i915: Add missing include file <linux/math64.h>

 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 drivers/gpu/drm/drm_dp_mst_topology.c         | 39 ++++++++++++++++++++++++--
 drivers/gpu/drm/i915/gt/intel_context.c       | 40 +++++++++++++++++++++++++--
 drivers/gpu/drm/i915/i915_gem_gtt.c           |  7 ++---
 drivers/gpu/drm/i915/i915_pmu.c               | 11 ++++++--
 drivers/gpu/drm/i915/selftests/i915_random.h  |  1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c        |  1 +
 include/drm/drm_dp_mst_helper.h               |  6 ++++
 10 files changed, 94 insertions(+), 17 deletions(-)
