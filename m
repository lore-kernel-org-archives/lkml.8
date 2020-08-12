Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0892C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCBE20768
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/0TTVDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHLExb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgHLExa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:53:30 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B932C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:53:30 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so790019ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6wIp8t0nzxAu+Gvw3Raiqpihz3BHZz5alLcgMe2N8zc=;
        b=k/0TTVDI9D6+2i2wAtubSL25Ph03TOV8KhvBuQN55BXp+IL56sizMdy+miy+X2WIHK
         ZbbWFDyvgiqKcKlxlYUszQzJvZ3tbID4yU/8XDlNoC2nfnwrKotIeUvT/xQeaX7vOoGT
         QiuMZMujg6mJBIuUOFfE6eRNvHOO85JnocfzmvO0/V77DdZ7H+gaFOdDKDaFneYJ40BK
         OO+GKOKOvZdVZOpISyVhceNp45TXoATHdMhESt11wizt3rJeMDw4FVKy3slJ/kpfFbXj
         XSE3d83qa867nRMVYqTk1ibHdp2FxDet/bwo3aWQ9J9nz4S6PTdXqTjnzMPBE0LPk9ix
         Hq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6wIp8t0nzxAu+Gvw3Raiqpihz3BHZz5alLcgMe2N8zc=;
        b=m058FfjeAXHKMiqDfJcNlo63sWDUYRn2lE0PvfXK4GWQXdS7tXIeKFh1zGMits+Pzz
         qx8rAMoNK89B98T21LgYqq4FQL1mM2SXTZLZ+GQQcxnTwoFq3mKVD5QvOX6REa0/YIwS
         6RLoelbBNZ/zbaCM59MwpmcQpt8ieJnNtM7RHGqwJIbRNdwM9ez9fzrgdvWkkcf3YfZg
         TsAZQc357R7Jj86izySLFBb/MJPi4eH4oStQngsaH/KvIfUnhGMqhXqhyP8lH1DTvI2p
         9AzitHck7flzvqm5aMv9dwYGjJBWHDmk/CB8VvZ+W8Za4wn75aMziV1WEGyI5r1CAwLC
         wUag==
X-Gm-Message-State: AOAM530SL1fzj5qgKky+j54o2/X322TVqvv1Dw1+bMRzS+xIsqXJQQxC
        tUbl+WB4xCS5fnnk/jYWNeUy1YId2qcr5XyzKTY5Nqr4
X-Google-Smtp-Source: ABdhPJzlQinBh5Vqwps6I4zj1g5bAhRMwe5y4/argNuva7bEeTbfrvgv0W/rBXoRS7if8SJkPRz8XeyYhD4aOW7o+bw=
X-Received: by 2002:a17:906:d054:: with SMTP id bo20mr17999687ejb.9.1597208008719;
 Tue, 11 Aug 2020 21:53:28 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 12 Aug 2020 14:53:17 +1000
Message-ID: <CAPM=9tyXhxOGiH9yRsQf5bQ22bib1m_wmJBaVDFxFkEh4Y+dtQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.9-rc1
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

This is the fixes pull for 5.9-rc1. I had some fixes from the misc
fixes tree come on a later base than drm-next was on, so I had to
backmerge 5.8 into this to make things work for me and CI. However it
totally messed up the diffstat so I didn't bother including it. The
changelog looks fine.

This has a few vmwgfx regression fixes we hit from the merge window
(one in TTM), it also has a bunch of amdgpu fixes along with a
scattering everywhere else.

I'm not working for next few days, but I'll be around and have some
time if anything comes up, but hopefully this is good enough for rc1,
and any pulls after this can wait for rc2.

Dave.

drm-next-2020-08-12:
drm fixes for 5.9-rc1

core:
- Fix drm_dp_mst_port refcount leaks in drm_dp_mst_allocate_vcpi
- Remove null check for kfree in drm_dev_release.
- Fix DRM_FORMAT_MOD_AMLOGIC_FBC definition.
- re-added docs for drm_gem_flink_ioctl()
- add orientation quirk for ASUS T103HAF

ttm:
- ttm: fix page-offset calculation within TTM
- revert patch causing vmwgfx regressions

fbcon:
- Fix a fbcon OOB read in fbdev, found by syzbot.

vga:
- Mark vga_tryget static as it's not used elsewhere.

amdgpu:
- Re-add spelling typo fix
- Sienna Cichlid fixes
- Navy Flounder fixes
- DC fixes
- SMU i2c fix
- Power fixes

vmwgfx:
- regression fixes for modesetting crashes
- misc fixes

xlnx:
- Small fixes to xlnx.

omap:
- Fix mode initialization in omap_connector_mode_valid().
- force runtime PM suspend on system suspend

tidss:
- fix modeset init for DPI panels
The following changes since commit dc100bc8fae59aafd2ea2e1a1a43ef1f65f8a8bc=
:

  Merge tag 'drm-msm-next-2020-07-30' of
https://gitlab.freedesktop.org/drm/msm into drm-next (2020-08-05
08:05:31 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-08-12

for you to fetch changes up to 62975d27d647a40c58d3b96c29b911fc4f33c310:

  drm/ttm: revert "drm/ttm: make TT creation purely optional v3"
(2020-08-12 13:26:28 +1000)

----------------------------------------------------------------
drm fixes for 5.9-rc1

core:
- Fix drm_dp_mst_port refcount leaks in drm_dp_mst_allocate_vcpi
- Remove null check for kfree in drm_dev_release.
- Fix DRM_FORMAT_MOD_AMLOGIC_FBC definition.
- re-added docs for drm_gem_flink_ioctl()
- add orientation quirk for ASUS T103HAF

ttm:
- ttm: fix page-offset calculation within TTM
- revert patch causing vmwgfx regressions

fbcon:
- Fix a fbcon OOB read in fbdev, found by syzbot.

vga:
- Mark vga_tryget static as it's not used elsewhere.

amdgpu:
- Re-add spelling typo fix
- Sienna Cichlid fixes
- Navy Flounder fixes
- DC fixes
- SMU i2c fix
- Power fixes

vmwgfx:
- regression fixes for modesetting crashes
- misc fixes

xlnx:
- Small fixes to xlnx.

omap:
- Fix mode initialization in omap_connector_mode_valid().
- force runtime PM suspend on system suspend

tidss:
- fix modeset init for DPI panels

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/smu: rework i2c adpater registration

Alvin Lee (1):
      drm/amd/display: Don't compare dppclk before updating DTO

Aric Cyr (2):
      drm/amd/display: Fix DP Compliance tests 4.3.2.1 and 4.3.2.2
      drm/amd/display: AMD OUI (DPCD 0x00300) skipped on some sink

Bhawanpreet Lakha (2):
      drm/amd/display: Use seperate dmcub firmware for navy_flounder
      drm/amd/display: Use proper abm/backlight functions for DCN3

Boyuan Zhang (1):
      drm/amdgpu: update dec ring test for VCN 3.0

Changfeng (2):
      Revert "drm/amd/powerplay: drop unnecessary message support check"
      drm/amd/powerplay: drop unnecessary message support check(v2)

Christian K=C3=B6nig (1):
      drm/ttm: revert "drm/ttm: make TT creation purely optional v3"

Christoph Hellwig (1):
      vgaarb: mark vga_tryget static

Colin Ian King (4):
      drm: xlnx: fix spelling mistake "failes" -> "failed"
      drm/amdgpu: fix spelling mistake "Falied" -> "Failed"
      drm/vmwgfx: fix spelling mistake "Cound" -> "Could"
      drm/vmwgfx: fix spelling mistake "Cant" -> "Can't"

Dan Carpenter (3):
      drm/amd/powerplay: off by one bugs in smu_cmn_to_asic_specific_index(=
)
      drm/vmwgfx: Use correct vmw_legacy_display_unit pointer
      drm/vmwgfx: Fix two list_for_each loop exit tests

Daniel Vetter (1):
      drm/vmwgfx/stdu: Use drm_mode_config_reset

Dave Airlie (5):
      Merge tag 'drm-misc-next-fixes-2020-08-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'v5.8' into drm-next
      Merge tag 'drm-misc-fixes-2020-08-04' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-fixes-5.9-2020-08-07' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'vmwgfx-next-5.9' of
git://people.freedesktop.org/~sroland/linux into drm-next

Dmytro Laktyushkin (2):
      drm/amd/display: Clean up global sync param retrieval
      drm/amd/display: populate new dml variable

Eric Bernstein (1):
      drm/amd/display: Use parameter for call to set output mux

Eryk Brol (2):
      drm/amd/display: Rename bytes_pp to the correct bits_pp
      drm/amd/display: Fix naming of DSC Debugfs entry

Evan Quan (2):
      drm/amd/powerplay: update swSMU VCN/JPEG PG logics
      drm/amd/powerplay: put VCN/JPEG into PG ungate state before dpm
table setup(V3)

Felix Kuehling (1):
      drm/ttm: fix offset in VMAs with a pg_offs in ttm_bo_vm_access

George Shen (1):
      drm/amd/display: Change null plane state swizzle mode to 4kb_s

Guchun Chen (1):
      drm/amdgpu: add printing after executing page reservation to eeprom

Gustavo A. R. Silva (1):
      drm/vmwgfx: Use struct_size() helper

Harry Wentland (1):
      drm/amd/display: Fix logger context

Huang Rui (1):
      drm/amdgpu: skip crit temperature values on APU (v2)

Hyun Kwon (1):
      drm: xlnx: zynqmp: Use switch - case for link rate downshift

Igor Kravchenko (2):
      drm/amd/display: Read VBIOS Golden Settings Tbl
      drm/amd/display: Display goes blank after inst

James Zhu (1):
      drm/amdgpu/jpeg3.0: remove extra asic type check

Jiansong Chen (3):
      drm/amd/powerplay: update driver if version for navy_flounder
      drm/amdgpu: update GC golden setting for navy_flounder
      drm/amdgpu: enable GFXOFF for navy_flounder

JinZe.Xu (1):
      drm/amd/display: Use helper function to check for HDMI signal

John Clements (1):
      drm/amdgpu: expand sienna chichlid reg access  support

Jun Lei (1):
      drm/amd/display: Disable idle optimizations before programming DCN

Kenneth Feng (1):
      drm/amd/powerplay: remove the dpm checking in the boot sequence

Kevin Wang (1):
      drm/amd/swsmu: allow asic to handle sensor type by itself

Li Heng (1):
      drm: Remove redundant NULL check

Likun Gao (6):
      drm/amd/powerplay: skip invalid msg when smu set mp1 state
      drm/amd/powerplay: add msg map for mode1 reset
      drm/amd/powerplay: correct smu message for vf mode
      drm/amdgpu: update golden setting for sienna_cichlid
      drm/amd/powerplay: update driver if file for sienna_cichlid
      drm/amdgpu: use mode1 reset by default for sienna_cichlid

Liu ChengZhe (2):
      drm/amdgpu: fix PSP autoload twice in FLR
      drm amdgpu: Skip tmr load for SRIOV

Marius Iacob (1):
      drm: Added orientation quirk for ASUS tablet model T103HAF

Martin Tsai (1):
      drm/amd/display: Check lane status again after link training done

Neil Armstrong (1):
      drm/fourcc: fix Amlogic Video Framebuffer Compression macro

Reza Amini (1):
      drm/amd/display: Allow asic specific FSFT timing optimization

Roland Scheidegger (2):
      drm/vmwgfx/sou: Use drm_mode_config_reset
      drm/vmwgfx/ldu: Use drm_mode_config_reset

Sandeep Raghuraman (1):
      drm/amdgpu: Fix bug where DPM is not enabled after hibernate and resu=
me

Steve Cohen (1):
      drm: re-add deleted doc for drm_gem_open_ioctl

Stylon Wang (1):
      drm/amd/display: Fix dmesg warning from setting abm level

Tetsuo Handa (1):
      fbmem: pull fbcon_update_vcs() out of fb_set_var()

Thomas Zimmermann (1):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes

Tomi Valkeinen (2):
      drm/tidss: fix modeset init for DPI panels
      drm/omap: force runtime PM suspend on system suspend

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/omap: Use {} to zero initialize the mode

Wei Yongjun (1):
      drm: xlnx: Fix typo in parameter description

Wyatt Wood (1):
      drm/amd/display: Use hw lock mgr

Xin Xiong (1):
      drm: fix drm_dp_mst_port refcount leaks in drm_dp_mst_allocate_vcpi

hersen wu (1):
      drm/amd/display: dchubbub p-state warning during surface planes switc=
h
