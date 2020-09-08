Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D52C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E74207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOJ9YbOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgIHGWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgIHGWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:22:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225F3C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 23:22:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y1so1308117ejq.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 23:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8xZk5h8orsIZMMLdKGKwgCSU5Ncg3lkxXCBEPDaDCpA=;
        b=AOJ9YbOknHhYRe8Qlv1bDfj1mKnIEK3rjnrnnokpWXh3KVgYDd+Eddod0BzcNJsYgP
         uASMP1/hfpnaJaFtycqgMR6s3rFkAKrnxthyVtz22nRC9aPQV3nQCVDkdTHqXhI7WbQS
         yyfhS7Q12z0lS3hmlbojvTVU+kYcCTH24k3U5FeqdIcg4YEvuvjhLaR+zSweBl00OieL
         B9b/sS5dk+2ac3CP0JslmRg4ZeYFu3KC3thBWi0MInZWSk+UbVr5cVujq10i+/cMkNQI
         PwBdO4NM4VHGBazZsSNersHcb1v4XMTPtub82DWnSETQwSSmQN5bUhb16e3/VPUJ6GCr
         nzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8xZk5h8orsIZMMLdKGKwgCSU5Ncg3lkxXCBEPDaDCpA=;
        b=DbOe77UFeyWOgGk9rY+YpO/+MZsWuusES3EpnUq85IHA1Iy0oYaTgzEEQvnae8NpKM
         SSVPcCdqPvYR7v1lNZyEMNwCxlRJMzKatSwqjzgVtuySvB0ifU60IipHPLxuvglguvXf
         xeCg/13vp6ZuXeK4GqvaKV9Ih//bI5cNoLH42JPhAjag1oDT0WaiIBNHmQXLAO0ICvxZ
         bE+8KL88OBZXiDnSAnIZByirzxZhw7iKm1Fkp7L9/gW+tRmkz8KCJ52RSvTapVxiN7eb
         WtYEDu76oI4Ss1QKirolxT28rwB5dOAXr0/rR2c0EQs70Z/rpowzx+P7/ruQ51+h0Jty
         EW9w==
X-Gm-Message-State: AOAM5339i2X4afAl1vb0fSekQqLWq86Pc1CJOY7vWAZrXEV6UviR/n/w
        tLCt96NYYnViLe4k/UDsxBEt8KReMXXHLa+i6sPVMnyyhEqapA==
X-Google-Smtp-Source: ABdhPJwSL+vwLLfI3ZQQLK3zjTUolN5DDIkPKvkkXftjIBRkq5bCkLoAP+3zJkb8G1WgKjf88kBfXa1kB8JTYrNl8cg=
X-Received: by 2002:a17:906:fb8c:: with SMTP id lr12mr25668509ejb.9.1599546156100;
 Mon, 07 Sep 2020 23:22:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 8 Sep 2020 16:22:25 +1000
Message-ID: <CAPM=9tw2tebfrjMEiB5fUy8USZrjq4b_siciDecFfMu8H794gA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.9-rc5 (special edition)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The i915 reverts are going to be a bit of a conflict mess for next, so
I decided to dequeue them now, along with some msm fixes for a ring
corruption issue, that Rob sent over the weekend.

Dave.

drm-fixes-2020-09-08:
drm fixes for 5.9-rc5 (special edition)

i915:
- revert gpu relocation changes due to regression

msm:
- fixes for RPTR corruption issue
The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-08

for you to fetch changes up to 20561da3a2e1e0e827ef5510cb0f74bcfd377e41:

  Revert "drm/i915/gem: Delete unused code" (2020-09-08 15:45:27 +1000)

----------------------------------------------------------------
drm fixes for 5.9-rc5 (special edition)

i915:
- revert gpu relocation changes due to regression

msm:
- fixes for RPTR corruption issue

----------------------------------------------------------------
Dave Airlie (4):
      Merge tag 'drm-msm-fixes-2020-09-04' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Revert "drm/i915: Remove i915_gem_object_get_dirty_page()"
      Revert "drm/i915/gem: Async GPU relocations only"
      Revert "drm/i915/gem: Delete unused code"

Jordan Crouse (4):
      drm/msm: Split the a5xx preemption record
      drm/msm: Enable expanded apriv support for a650
      drm/msm: Disable preemption on all 5xx targets
      drm/msm: Disable the RPTR shadow

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     | 314 +++++++++++++++++++--
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |   4 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |  14 +
 .../drm/i915/gem/selftests/i915_gem_execbuffer.c   |  21 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   5 +
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |  10 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |  10 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  14 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |   1 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c          |  25 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  13 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  27 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   2 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |  11 +
 drivers/gpu/drm/msm/msm_ringbuffer.c               |   4 +-
 15 files changed, 411 insertions(+), 64 deletions(-)
