Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F064C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4F620754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfbFfGjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCTDB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 23:01:57 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39160 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCTDB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:01:56 -0400
Received: by mail-ot1-f52.google.com with SMTP id r2so4685162otn.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 20:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zToM2vZiFh64aleo6394lnbX3TeWMRdOKkO6etfhVds=;
        b=cfbFfGjBXFilHfvDx5MaOK8ILLQvH6ri8ltNka6974ET78ztmk4G50vewjbBTReVSw
         bjSr/cCbhKRg66LwqMQnhNJzhlqa4knWfXRkAvkUywLmdsr8MWNXLX755Zs90Q2LCnLB
         BnIPC70hu7iBvMzk0+LUOYWNh5IJnJEUy9y9cqPV1G2rSsVB8ARLSHn5e7J//Sm2Kggt
         zqbzi/6HDeqy571TyCZPpysS8uTJnQCtK/vP3lhMlCSt7C5fIlGgMyuU+cyM8AE0NKoS
         03NUxUkqC3iAM4+PmYEYxK0aS5E2SVXzFd3X7o4KFCMhnlCQWF7eQc+jnsltX69dF0Zj
         xk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zToM2vZiFh64aleo6394lnbX3TeWMRdOKkO6etfhVds=;
        b=TEqQsBtZfNy1IwHET+Vja/h9PkBfO6SO/3tPk3TUKSmWSe8VkrGjT5w3T3KbyXR19T
         gygmKYe0ePDmbOGX1AJ1MEvxbifUjioLMjUWq7e3ipIffP0swpWlr/3a8+FY4mE86tz3
         19DZrZORP3BKcVzw1CHa49rTUmaGGk92XCfOupxKPH40B+mBE/llKdM9T5yrJRrNOxY4
         Dm3O/whtBnhuDBdEVwayIlVFUrVy0xa+rIvfFFYUkljkkszGcRUA7ZBmbM9Y0LRvlshK
         xv7M4OwBOdLra5I+3zvT0MUuekXBBQievYVxPyLLC6phjMhyYyPHGztVs+V3gbwjzDOl
         o+Rg==
X-Gm-Message-State: ANhLgQ0hm/teJKYzHU4cT9vN354IdDqFAunWhi0nHyePx2WkdgaFG5yc
        bhIoG+NXV4wTZfKU6ucQE8wzrsBWFjfkQhrMVXmF9Js74LI=
X-Google-Smtp-Source: ADFU+vtJOhKJRoTSjcdyhpwBn4Bwdn+X9RGuEWNi/V6/4R09ipu1RBg5d2wWp/on7zCFup4kQw3qd+NqXZM4sDZmerI=
X-Received: by 2002:a9d:6c58:: with SMTP id g24mr4889943otq.106.1584673315609;
 Thu, 19 Mar 2020 20:01:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 20 Mar 2020 13:01:44 +1000
Message-ID: <CAPM=9tziNvC7VozK1C3yd+wqspVGF7d0eToOANwV4Euwy4LMkQ@mail.gmail.com>
Subject: [git pull drm fixes for 5.6-rc7
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

Hope you are well hiding out above the garage, a few amdgpu changes
but nothing too major. I've had a wisdom tooth out this week so
haven't been to on top of things, but all seems good.

Dave.

drm-fixes-2020-03-20:
drm fixes for 5.6-rc7

core:
- fix lease warning

i915:
- Track active elements during dequeue
- Fix failure to handle all MCR ranges
- Revert unnecessary workaround

amdgpu:
- Pageflip fix
- VCN clockgating fixes
- GPR debugfs fix for umr
- GPU reset fix
- eDP fix for MBP
- DCN2.x fix

dw-hdmi:
- fix AVI frame colorimetry

komeda:
- fix compiler warning

bochs:
- downgrade a binding failure to a warning
The following changes since commit fb33c6510d5595144d585aa194d377cf74d31911:

  Linux 5.6-rc6 (2020-03-15 15:01:23 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-20

for you to fetch changes up to 5366b96b1997745d903c697a32e0ed27b66fd158:

  Merge tag 'drm-intel-fixes-2020-03-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2020-03-20
12:52:35 +1000)

----------------------------------------------------------------
drm fixes for 5.6-rc7

core:
- fix lease warning

i915:
- Track active elements during dequeue
- Fix failure to handle all MCR ranges
- Revert unnecessary workaround

amdgpu:
- Pageflip fix
- VCN clockgating fixes
- GPR debugfs fix for umr
- GPU reset fix
- eDP fix for MBP
- DCN2.x fix

dw-hdmi:
- fix AVI frame colorimetry

komeda:
- fix compiler warning

bochs:
- downgrade a binding failure to a warning

----------------------------------------------------------------
Arnd Bergmann (1):
      drm/komeda: mark PM functions as __maybe_unused

Caz Yokoyama (1):
      Revert "drm/i915/tgl: Add extra hdc flush workaround"

Chris Wilson (1):
      drm/i915/execlists: Track active elements during dequeue

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2020-03-18-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.6-2020-03-19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-03-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (1):
      drm/amdgpu: add fbdev suspend/resume on gpu reset

Gerd Hoffmann (1):
      drm/bochs: downgrade pci_request_region failure from error to warning

James Zhu (3):
      drm/amdgpu: fix typo for vcn1 idle check
      drm/amdgpu: fix typo for vcn2/jpeg2 idle check
      drm/amdgpu: fix typo for vcn2.5/jpeg2.5 idle check

Jernej Skrabec (1):
      drm/bridge: dw-hdmi: fix AVI frame colorimetry

Mario Kleiner (2):
      drm/amd/display: Add link_rate quirk for Apple 15" MBP 2017
      drm/amd/display: Fix pageflip event race condition for DCN.

Matt Roper (1):
      drm/i915: Handle all MCR ranges

Qiujun Huang (1):
      drm/lease: fix WARNING in idr_destroy

Stanley.Yang (1):
      drm/amd/display: fix typos for dcn20_funcs and dcn21_funcs struct

Tom St Denis (1):
      drm/amd/amdgpu: Fix GPR read from debugfs (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c       |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  4 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 18 ++++++--
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c  | 11 +++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 -
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 -
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c   |  4 +-
 drivers/gpu/drm/bochs/bochs_hw.c                  |  6 +--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c         | 46 +++++++++++---------
 drivers/gpu/drm/drm_lease.c                       |  3 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c               | 52 ++++++-----------------
 drivers/gpu/drm/i915/gt/intel_workarounds.c       | 25 +++++++++--
 17 files changed, 104 insertions(+), 83 deletions(-)
