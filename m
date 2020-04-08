Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80999C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B36206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw/Ylw7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDHAtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:49:22 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:39593 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgDHAtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:49:22 -0400
Received: by mail-ed1-f50.google.com with SMTP id a43so6409226edf.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 17:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=i7u2yferxIfNJVp0OaQiWzqcyOEkipj30BlmZM5UaYA=;
        b=Zw/Ylw7VXZ78jviOSjqxjUu3Wa96/H1iYL7i+esu5a5K1dn557ed0DZG8IqMurJEus
         bUosy+5ZGh9pDsN9Cebpz5P1ci5a09EyZxfLuNTmzJobrAR9Ah0GOfyt5VNLs+TFk9gE
         QGvS5r+e/jfPxvdpQPyvEcaTh9QpECmS4lZUbjKhuJA+duzBPgHRyFOI6KixHycWfsdz
         DIxVFYxWGenRoUq5UrG+RkF6mFb/ZHfFNa+6eEh+sEl7teQoF6RntKnTAUDNnXPWNcMI
         jqbE1tf0H5WAXeB/e1TRveywJ7u/KZg/LnQvoHXwdU+9q6roHr3YY1Z5tB6aCo/inFDp
         c8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=i7u2yferxIfNJVp0OaQiWzqcyOEkipj30BlmZM5UaYA=;
        b=sndpNBtCbOkZyWqtKePmG6nwazSYZV/HLBLA/dJJpRhfo5gqHvGfL61BPs8jc1fLNQ
         545o4+Uix6y3x3UxoBa/rYBBP//W6gYV7RRYIZ9zyuDFzxJub1tydA68bamq55/GJD4N
         zbzHrSmThdGaDLUXbr+0l+KucLeg6xGUr842QEFIUy1lP59db5OFvNmdPGB4n7oK7s7H
         QEK3FFipYMCpZk8EvBJpwpD1I/aT6f2t1OsqqexqcsvmPwLjb3BnZM/C9sfNBKwsE+Nf
         hdSbsGAL9lvyzLCwwT/E8CpamWDrW6EZluSBWbCNxls3TmfH8WwimTq/wLvQXW9rxVOh
         zuCA==
X-Gm-Message-State: AGi0PuaBg6juLaiwJXXqu+j2SrnzwDakcxDNr+ueJQeNORHLhimNVMgH
        2ClFPP365WhOfj+wyGewXWWa6jLfoLvjjkLs4KCvaM6QOv/CSQ==
X-Google-Smtp-Source: APiQypIOBlvRgPbcoE1LlAfUfOY4ENWhb+LIBxHw5F3BAG/k2WR0CXo/Y90dLcMt15CLf/G1L20krBO7zCrRTgMleSk=
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr4343092edl.127.1586306958726;
 Tue, 07 Apr 2020 17:49:18 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 8 Apr 2020 10:49:06 +1000
Message-ID: <CAPM=9tzqR6HkM_XyijcKozqfh-WXKRWhe+Ay7mwA0o3kSooOEw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc1
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

This is a set of fixes that have queued up, I think I might have
another pull with some more before rc1 but I'd like to dequeue what I
have now just in case Easter is more eggciting that expected.

The main thing in here is a fix for a longstanding nouveau power
management issues on certain laptops, it should help runtime
suspend/resume for a lot of people.

There is also a reverted patch for some drm_mm behaviour in atomic contexts=
.

Dave.

drm-next-2020-04-08:
drm fixes for 5.7-rc1

core:
- revert drm_mm atomic patch
- dt binding fixes

fbcon:
- null ptr error fix

i915:
- GVT fixes

nouveau:
- runpm fix
- svm fixes

amdgpu:
- HDCP fixes
- gfx10 fix
- Misc display fixes
- BACO fixes

amdkfd:
- Fix memory leak

vboxvideo:
- remove conflicting fbs

vc4:
- mode validation fix

xen:
- fix PTR_ERR usage
The following changes since commit 0e7e6198af28c1573267aba1be33dd0b7fb35691=
:

  Merge branch 'ttm-transhuge' of
git://people.freedesktop.org/~thomash/linux into drm-next (2020-04-03
09:07:49 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-04-08

for you to fetch changes up to 12ab316ced2c5f32ced0e6300a054db644b5444a:

  Merge tag 'amd-drm-next-5.7-2020-04-01' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2020-04-08
09:34:27 +1000)

----------------------------------------------------------------
drm fixes for 5.7-rc1

core:
- revert drm_mm atomic patch
- dt binding fixes

fbcon:
- null ptr error fix

i915:
- GVT fixes

nouveau:
- runpm fix
- svm fixes

amdgpu:
- HDCP fixes
- gfx10 fix
- Misc display fixes
- BACO fixes

amdkfd:
- Fix memory leak

vboxvideo:
- remove conflicting fbs

vc4:
- mode validation fix

xen:
- fix PTR_ERR usage

----------------------------------------------------------------
Aric Cyr (1):
      drm/amd/display: LFC not working on 2.0x range monitors (v2)

Ben Skeggs (5):
      drm/nouveau/ttm: evict other IO mappings when running out of BAR1 spa=
ce
      drm/nouveau/gr/gp107,gp108: implement workaround for HW hanging
during init
      drm/nouveau/nvif: access PTIMER through usermode class, if available
      drm/nouveau/nvif: protect waits against GPU falling off the bus
      drm/nouveau/kms/nv50-: wait for FIFO space on PIO channels

Bhawanpreet Lakha (3):
      drm/amd/display: Don't try hdcp1.4 when content_type is set to type1
      drm/amd/display: Correctly cancel future watchdog and callback events
      drm/amd/display: increase HDCP authentication delay

Christian K=C3=B6nig (1):
      drm/mm: revert "Break long searches in fragmented address spaces"

Dave Airlie (4):
      Merge tag 'drm-intel-next-fixes-2020-04-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-fixes-2020-04-04' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'linux-5.7' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge tag 'amd-drm-next-5.7-2020-04-01' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Ding Xiang (1):
      drm/xen: fix passing zero to 'PTR_ERR' warning

Dmytro Laktyushkin (1):
      drm/amd/display: Fix dcn21 num_states

Eric Bernstein (1):
      drm/amd/display: Update function to get optimal number of taps

Evan Quan (2):
      drm/amd/powerplay: drop redundant BIF doorbell interrupt operations
      drm/amd/powerplay: move the ASIC specific nbio operation out of
smu_v11_0.c

Geert Uytterhoeven (1):
      dma-buf: Improve CONFIG_DMABUF_MOVE_NOTIFY help text

Hans de Goede (1):
      drm/vboxvideo: Add missing remove_conflicting_pci_framebuffers call, =
v2

Isabel Zhang (1):
      drm/amd/display: Revert change to HDCP display states

Jack Zhang (1):
      drm/amdkfd: kfree the wrong pointer

Karol Herbst (1):
      drm/nouveau: workaround runpm fail by disabling PCI power
management on certain intel bridges

Kevin Wang (1):
      drm/amdgpu: fix hpd bo size calculation error

Mauro Carvalho Chehab (1):
      docs: dt: display/ti: fix typos at the devicetree/ directory name

Nicholas Kazlauskas (1):
      drm/amd/display: Use double buffered DRR timing update by default

Nicolas Saenz Julienne (1):
      drm/vc4: Fix HDMI mode validation

Qiujun Huang (1):
      fbcon: fix null-ptr-deref in fbcon_switch

Ralph Campbell (3):
      drm/nouveau/svm: fix vma range check for migration
      drm/nouveau/svm: check for SVM initialized before migrating
      drm/nouveau/svm: remove useless SVM range check

Rob Herring (1):
      dt-bindings: display: ti: Fix dtc unit-address warnings in examples

Rodrigo Vivi (1):
      Merge tag 'gvt-next-fixes-2020-03-31' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Sam Ravnborg (2):
      dt-bindings: display: drop data-mapping from panel-dpi
      drm/panel-simple: drop use of data-mapping property

Stylon Wang (3):
      drm/amd/display: Support P010 pixel format
      drm/amd/display: Support plane level CTM
      drm/amd/display: Enable BT2020 in COLOR_ENCODING property

Tina Zhang (3):
      drm/i915/gvt: Add some regs to force-to-nonpriv whitelist
      drm/i915/gvt: Fix display port type issue
      drm/i915/gvt: Fix klocwork issues about data size

Wambui Karuga (1):
      drm/nouveau: remove checks for return value of debugfs functions

Yan Zhao (2):
      drm/i915/gvt: add support to command SWTESS_BASE_ADDRESS
      drm/i915/gvt: do not check len & max_len for lri

Yongqiang Sun (1):
      drm/amd/display: Not doing optimize bandwidth if flip pending.

 .../bindings/display/panel/panel-dpi.yaml          | 10 ----
 .../bindings/display/ti/ti,am65x-dss.yaml          |  4 +-
 .../bindings/display/ti/ti,j721e-dss.yaml          |  4 +-
 .../devicetree/bindings/display/ti/ti,k2g-dss.yaml |  4 +-
 drivers/dma-buf/Kconfig                            | 11 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 12 ++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 14 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 33 +++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dc.h                |  3 ++
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  6 +++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  | 18 +++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |  3 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  5 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  | 40 +++++---------
 drivers/gpu/drm/amd/display/dc/dml/dc_features.h   |  2 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |  7 +--
 .../drm/amd/display/modules/freesync/freesync.c    | 34 ++++++------
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |  5 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    | 28 +++++++---
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |  2 +-
 .../drm/amd/display/modules/hdcp/hdcp2_execution.c |  2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    | 39 ++++++++------
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |  1 +
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 15 +++++-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 18 ++++++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 24 +--------
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         | 14 ++++-
 drivers/gpu/drm/drm_mm.c                           |  8 +--
 drivers/gpu/drm/i915/gvt/cmd_parser.c              | 16 ++----
 drivers/gpu/drm/i915/gvt/display.c                 |  6 +--
 drivers/gpu/drm/i915/gvt/handlers.c                |  8 ++-
 drivers/gpu/drm/i915/gvt/scheduler.c               |  4 +-
 drivers/gpu/drm/nouveau/dispnv04/dac.c             |  3 +-
 drivers/gpu/drm/nouveau/dispnv04/hw.c              |  1 +
 drivers/gpu/drm/nouveau/dispnv50/base507c.c        |  1 +
 drivers/gpu/drm/nouveau/dispnv50/core507d.c        |  1 +
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c        |  2 +
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c        | 21 ++++++--
 drivers/gpu/drm/nouveau/dispnv50/cursc37a.c        |  9 ++--
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  1 +
 drivers/gpu/drm/nouveau/dispnv50/ovly827e.c        |  2 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |  1 +
 drivers/gpu/drm/nouveau/include/nvif/device.h      | 21 --------
 drivers/gpu/drm/nouveau/include/nvif/timer.h       | 35 ++++++++++++
 drivers/gpu/drm/nouveau/include/nvif/user.h        |  1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c               |  9 +++-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          | 20 +++----
 drivers/gpu/drm/nouveau/nouveau_drm.c              | 63 ++++++++++++++++++=
++++
 drivers/gpu/drm/nouveau/nouveau_drv.h              |  2 +
 drivers/gpu/drm/nouveau/nouveau_svm.c              |  9 ++--
 drivers/gpu/drm/nouveau/nvif/Kbuild                |  1 +
 drivers/gpu/drm/nouveau/nvif/device.c              | 14 +++--
 drivers/gpu/drm/nouveau/nvif/timer.c               | 56 ++++++++++++++++++=
+
 drivers/gpu/drm/nouveau/nvif/userc361.c            | 14 +++++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c     | 26 +++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 11 ----
 drivers/gpu/drm/vboxvideo/vbox_drv.c               |  4 ++
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 20 +++++--
 drivers/gpu/drm/xen/xen_drm_front.c                |  2 +-
 drivers/video/fbdev/core/fbcon.c                   |  3 ++
 65 files changed, 538 insertions(+), 227 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/include/nvif/timer.h
 create mode 100644 drivers/gpu/drm/nouveau/nvif/timer.c
