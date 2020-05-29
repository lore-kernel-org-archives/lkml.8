Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268EF2075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWbxRWqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbgE2CiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389013AbgE2CiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:38:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2DC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:38:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n24so564082ejd.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LRWL3md3cdfmyEEJJW9b1YfTGvsPpjYM45xVODC6cfc=;
        b=PWbxRWqfCKXeJr+EPrN+hJitAczR2rWP+QP2s/cIcVNKpQy7BtLNt0pCGIjwGby667
         4RdLLFRuWU3RU7CNx40+MaNrKjI8fZWt3LJQK/IhGvKimWhThZe2EGUqwenVIB2sxdV1
         FU3nUXh5J/+sJ+OjyR7yiIeJ0S2ahL7kI/YSPK0NXPx4787GGrIlKsWY3quqZtTlrMps
         1nZrFpq/ER6cFFgJzWZ3L6HzFajogsYMCeDeeEfIzMrBTgD/0WamHS786L/zqHhim8lq
         H8kwxnRzBjGeJy7VCsT3BoLtlq3S5b/v151SW8CLSn+NS1P9a90ENkKOHLtZxXplDgDE
         Ffpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LRWL3md3cdfmyEEJJW9b1YfTGvsPpjYM45xVODC6cfc=;
        b=tY5txD2Eth/w1QPqZr0jdlGtwK7lsm4uH7bprmzHrAvmoC4qaQfld2QBOCP2S5VLRz
         CvV4f6KRoU/E3+lxhEuazJrVuD1WwGngqTIzyT2tWCdTbJNCoeBgEnstuWc3JNe9KCqC
         zFAT7BM6aZltTRhA8dxr27KqYf2HRtiPUJWcYecy5XQEU6981y/r6EYUlL0EtuavjgH0
         wPJ20gi9pNn4FxPMGZ4iP4ELxAL798K+payNbbVnq/cbPQhj6bvmwuPTo5QfbtqZRqnO
         9M6mlwXK97uLKSBjOOn7l7HuyqozxY4I+SGAw3ASb2VZdy2CiJPB9je21h9hh6sIRlA9
         8kqg==
X-Gm-Message-State: AOAM530UKAS4Ws0KOYc51lO70harGiLxCq8kGGpp/HWuPs/h8e98GaZx
        p+G4KsGq7rUwkJA7f5f7KdqCX4oP7FRO9yT7XXA=
X-Google-Smtp-Source: ABdhPJwuQwT+mh59AfvI9h748+ECizDXZ6gIe+r811X0N6LfgmL4jbXZrAOk/o8tGqll+chuI/++ePZj/hfmwWJqnTQ=
X-Received: by 2002:a17:906:f115:: with SMTP id gv21mr104958ejb.340.1590719882776;
 Thu, 28 May 2020 19:38:02 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 May 2020 12:37:51 +1000
Message-ID: <CAPM=9tznwDT9GEhbAHD1dkUVY_OF5bQNzxX7sBjXPkSH6VFjcw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7 final (apologies release)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Apologies for previous PR, I did build it locally, I just don't build
EXPERT kernels, I expect if I ever get a new builder I should add a
few more configs to my list.

I've just dropped the i915 PR from this completely, I'm sure when they
wake up they'll be able to tell us what we are missing due to mistakes
made.

Dave.

drm-fixes-2020-05-29-1:
drm fixes for 5.7 final

amdgpu:
- display atomic test fix
- Fix soft hang in display vupdate code

ingenic:
- fix pointer cast
- fix crtc atomic check callback
The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-29-1

for you to fetch changes up to ed9244bd0b265c4c0866a9246c6e7cca1cca3acf:

  Merge tag 'drm-misc-fixes-2020-05-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-05-29
12:11:11 +1000)

----------------------------------------------------------------
drm fixes for 5.7 final

amdgpu:
- display atomic test fix
- Fix soft hang in display vupdate code

ingenic:
- fix pointer cast
- fix crtc atomic check callback

----------------------------------------------------------------
Aric Cyr (1):
      drm/amd/display: Fix potential integer wraparound resulting in a hang

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-5.7-2020-05-27' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-05-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Paul Cercueil (2):
      gpu/drm: ingenic: Fix bogus crtc_atomic_check callback
      gpu/drm: Ingenic: Fix opaque pointer casted to wrong type

Simon Ser (1):
      drm/amd/display: drop cursor position check in atomic test

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 7 -------
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 ++
 drivers/gpu/drm/ingenic/ingenic-drm.c                     | 6 +++---
 3 files changed, 5 insertions(+), 10 deletions(-)
