Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D77C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65AF20737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk71s0ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgGXE4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 00:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgGXE4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 00:56:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E8C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 21:56:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id rk21so8666053ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 21:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=39B552rOVuQr2Xg7u2Ye/tXd5T1f52cUplKQU/FRNlw=;
        b=lk71s0ceyeNzvR5egC7cotmpELo+FlzHVdaL78nod0JX7N/1c4RaQ1+kDV6zxEYSLc
         Ny3MumicKcO4LwyzG0VVnkmWc9+LM6KjDuWy9SgaXSsy84pFWr+gs65v6zr24qW5N7uy
         mDpaodRrBDKer0NEIQXA/Oc5CTGiyzAx4ofzACG10B0DzECKpy+Z1KQs5bxGYbj8Tgzm
         h32Ztl0tlstvty1/GHamN/I6SHgGDP7QVhtII4Kz3NX0kfR5ZrbEojRL2q1ZoN5PPx24
         ThDEKtEgddVtO1RUii/uHFuXT1+F5X22Y3ZImlFctji6NuMTxxyr+t4qgGHTXgaKL223
         Ok8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=39B552rOVuQr2Xg7u2Ye/tXd5T1f52cUplKQU/FRNlw=;
        b=X0XGxUn5jkXdNFPpEN7JPp6SsKZy2kDNP/Exe7KEY3EfBGUL/c2CnOrCegXTC037i+
         YfBV2IXTGOfNNHUUFaZ75cOPHahSrN4ATVv4feYGid3hui7ZB/KRVR3CIMAX1IWJmqBz
         alC/gO9pkKp1xVQrSfrGQpb/eXQeZ01ELhAVPcp4Gt5LbhfsP4e0AucGBeVn/kf1SuDp
         en8pjZ5/xhywngEB3dJUkpwdAu5Pxzn8JezRq5bFzP1Bk9O2A2+HgyqH4rxJwpvz+fPq
         PEDbNomo/kO28oQGQc2DbSWQfpgd0BKqosP9S33RoiaKIQ7WfiL/YTM/fB3W/kB3ZnVb
         mAVQ==
X-Gm-Message-State: AOAM531nOJeSWMLc1qJevwC3mHtuQl0OyafSAyEH4pF0Nhme7IDtJA11
        AFyFuntkmitF2qkl+kG74EmtevWFvq1SFxsiaI76lmLB
X-Google-Smtp-Source: ABdhPJyQZgKurdxHDzMjEVHATc+iSgxDpC/lesn76a1ODXYSuHXO6rl/8gY1v481ZRWJeQp8CdFlX9i6BtV84rQnfyY=
X-Received: by 2002:a17:906:8782:: with SMTP id za2mr5218765ejb.419.1595566611256;
 Thu, 23 Jul 2020 21:56:51 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 24 Jul 2020 14:56:40 +1000
Message-ID: <CAPM=9twWoMc=xxXnZ7kKYp_fmYEquLE=PgVtjPhcH86Ocv3W7g@mail.gmail.com>
Subject: [git pull] drm fixes for 5.8-rc7
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

Quiet fixes, I may have a single regression fix follow up to this for
nouveau, but it might be next week, Ben was testing it a bit more .

Otherwise two amdgpu fixes, one lima and one sun4i.

Dave.

drm-fixes-2020-07-24:
drm fixes for 5.6-rc7

amdgpu:
- Fix crash when overclocking VegaM
- Fix possible crash when editing dpm levels

sun4i:
- Fix inverted HPD result; fixes an earlier fix

lima:
- fix timeout during reset
The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7=
:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-24

for you to fetch changes up to d8904ca9d338cdaa67e3bd06d7a7d418e426648c:

  Merge tag 'amd-drm-fixes-5.8-2020-07-22' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-07-23
14:06:16 +1000)

----------------------------------------------------------------
drm fixes for 5.6-rc7

amdgpu:
- Fix crash when overclocking VegaM
- Fix possible crash when editing dpm levels

sun4i:
- Fix inverted HPD result; fixes an earlier fix

lima:
- fix timeout during reset

----------------------------------------------------------------
Chen-Yu Tsai (1):
      drm: sun4i: hdmi: Fix inverted HPD result

Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2020-07-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.8-2020-07-22' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Pawe=C5=82 Gronowski (1):
      drm/amdgpu: Fix NULL dereference in dpm sysfs handlers

Qiang Yu (1):
      drm/lima: fix wait pp reset timeout

Qiu Wenbo (1):
      drm/amd/powerplay: fix a crash when overclocking Vega M

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c              |  9 +++------
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 10 ++++++----
 drivers/gpu/drm/lima/lima_pp.c                      |  2 ++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c              |  2 +-
 4 files changed, 12 insertions(+), 11 deletions(-)
