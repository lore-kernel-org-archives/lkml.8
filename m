Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49EDC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8406A208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM4HFs6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEHFYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgEHFYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:24:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C3C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 22:24:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d16so291104edv.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 22:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ef0QmtaHsENzA1h2bYZFII6gKVElXIt2dZPDJ6SKNPQ=;
        b=GM4HFs6n8zTBxukvtGDxAeGK9haAZC3nRwZVVCRH1EILyVZs93+khT0YomI6HwkaJS
         eB/Lsu5oyWJb5wmuilBG0cjbcNLgAxtOWcVBIHkarGTVhKbNVlegbYIk2fM3CDKGuwOT
         1fj5H/B4U/GSCgURXQGpEZEcnHCg0Z8HGzuwUvfRKJrE0dus4L2Y3WSuA3Rh/hfmTefS
         GBiqQ6hF4TYsP9uoDvVe3JTVsCgJbT+w9sam4qBtDVbn17nEAmi+vAXLe+mwzuQDbmsF
         HKA+MGBDEgCaqUs2tEI380CsS3YmOtDDEHWgBf13FPKbfVGOzg8TDpmZndKwQIuNXV57
         ZKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ef0QmtaHsENzA1h2bYZFII6gKVElXIt2dZPDJ6SKNPQ=;
        b=NSInZwEoIngvCD2MASzjLNn9knh986YJVsPJscwKs1QK0OL4neG5Eat5rO40mBA4dw
         wXhKOj/cHxcrP2I2z8NeO6tsqa6TEReLbJZIWLSQwyP+XiVsMbIMLuHIT3H6PNM9CeXY
         EMy68cOoFwLsGVoA67EcKQ/ZdyGBaXqzuegEJ8MWBcEICPQFFC1YkyQvZtlFIzLYr85V
         RUtcNJqBE/dIZVQ+aTaQlGU5Xn840VuJHpmKZpAaWBNY3Lpdv4+pWdpSmWJicNYXmpoC
         SgjVUb6AHmh+Q5RBdUdRsqw5Fs2pYw46irqV7rhbnDhBcWRx8dC4KKm+8QMUCq5PgWc7
         hUVg==
X-Gm-Message-State: AGi0PuZIy9Oqx1Mf6NjncApdhskyQMcs2KrHzXvj4mzcrpox1ZDEFl57
        dtutxzUbJWMrqMJqeCSjmW8MRnT/Xcind3BACYVSpCac
X-Google-Smtp-Source: APiQypJse4q2t7KtC/3tgQc2PyAzjVhr9cBIg95wAOXOFBg/TX5JxfKeKxOj9bAn/JSspnT5cRSSs4tvmC9+Oo4IQ10=
X-Received: by 2002:a05:6402:1482:: with SMTP id e2mr705398edv.113.1588915441243;
 Thu, 07 May 2020 22:24:01 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 8 May 2020 15:23:50 +1000
Message-ID: <CAPM=9tx_hR6GYxb6zSm4Z0XMExZ0BA1NJqR8bDy5k4Nzd4xwtg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc5
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

Another pretty normal week, didn't get any i915 fixes yet, so next
week I'd expect double the usual i915, but otherwise a bunch of amdgpu
and some scattered other fixes.

Dave.

drm-fixes-2020-05-08:
drm fixes for 5.7-rc5

hdcp:
- fix HDCP regression

amdgpu:
- Runtime PM fixes
- DC fix for PPC
- Misc DC fixes

virtio:
- fix context ordering issue

sun4i:
- old gcc warning fix

ingenic-drm:
- missing module support
The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd=
:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-08

for you to fetch changes up to a9fe6f18cde03c20facbf75dc910a372c1c1025b:

  Merge tag 'drm-misc-fixes-2020-05-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-05-08
15:04:25 +1000)

----------------------------------------------------------------
drm fixes for 5.7-rc5

hdcp:
- fix HDCP regression

amdgpu:
- Runtime PM fixes
- DC fix for PPC
- Misc DC fixes

virtio:
- fix context ordering issue

sun4i:
- old gcc warning fix

ingenic-drm:
- missing module support

----------------------------------------------------------------
Arnd Bergmann (1):
      sun6i: dsi: fix gcc-4.8

Aurabindo Pillai (1):
      drm/amd/display: Prevent dpcd reads with passive dongles

Daniel Kolesa (1):
      drm/amd/display: work around fp code being emitted outside of
DC_FP_START/END

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-5.7-2020-05-06' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-05-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Evan Quan (2):
      drm/amdgpu: move kfd suspend after ip_suspend_phase1
      drm/amdgpu: drop redundant cg/pg ungate on runpm enter

Gurchetan Singh (1):
      drm/virtio: create context before RESOURCE_CREATE_2D in 3D mode

H. Nikolaus Schaller (1):
      drm: ingenic-drm: add MODULE_DEVICE_TABLE

Michel D=C3=A4nzer (1):
      drm/amdgpu/dc: Use WARN_ON_ONCE for ASSERT

Roman Li (1):
      drm/amd/display: fix counter in wait_for_no_pipes_pending

Sean Paul (1):
      drm: Fix HDCP failures when SRM fw is missing

Sung Lee (1):
      drm/amd/display: Update DCN2.1 DV Code Revision

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  7 ++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 17 +++++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  5 ++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  | 31 ++++++++++++++++--=
----
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |  8 +++---
 drivers/gpu/drm/amd/display/dc/os_types.h          |  2 +-
 drivers/gpu/drm/drm_hdcp.c                         |  8 +++++-
 drivers/gpu/drm/ingenic/ingenic-drm.c              |  1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |  1 +
 drivers/gpu/drm/virtio/virtgpu_gem.c               |  3 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |  3 +--
 12 files changed, 57 insertions(+), 31 deletions(-)
