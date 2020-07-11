Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A089C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D7E2075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="sV02vE9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGKAuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgGKAuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:50:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F358C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so7050463qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=20pV1CIodg74lrZACp1xknXljGhFXMhtlkIxrWqAh18=;
        b=sV02vE9byfWPbEVCcYwB3QUisTSlxWw7Wi25mI64f6uBLTgJ7C1UIFPI7plN8Ppa55
         RWkKcGXCGGzzeWcIZ2l4BWa68ebOnIhN8nFMRxCLZ4XD/edYZOD33+jcNEZHpAP8qiNm
         8DULOUGv9/JVrSLGD8/BR5jWVlTfxOIn8+njnKmX7sJ140zwLZumfWH/NYQcxH+n8A+q
         whRojYp1oHJd04TAtKeFIw3xRpBQrfTtSejwrYPASsxt2zONNy0Obb9DCZhTlVPEA2D3
         Icrj4b/v5bO/Cf98AOWQLuMiAwuCFSPhFFhtISOOWNDT40E7OiNKjET7Cqmg+E4eKQni
         WtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=20pV1CIodg74lrZACp1xknXljGhFXMhtlkIxrWqAh18=;
        b=FtMkKNVuVcEtWZTLnW3ASCnFDLYQJsXmLIwaPdTyTS/f3VgFJ3ZwEICmv1Ui78PTmw
         mLEUs1cIQ4vmkcGE1dhShxDO/lSFZODhKDGzjWWGwlGz2NO4dVnJwn3Pr7vqqlLYXTaU
         tNGohqnMt9hClaY3JyslBu1+aDR6iz/Mhx/UCO4tV8JuI8wfv5MmNWUnBRlgrWaz8x64
         /qDbVHxUR3/2TEjCljVhUON55ASaXWoqo1ccT9Qt5QimvAVx6+0pdOPKDjIYvelWCNFc
         Jz/ci5px9bcdXALMs9WxEtiMyhJse4JRswLiHfkb24NqqpnycGFEprZ2M/JkaJUzzUsN
         Bw9A==
X-Gm-Message-State: AOAM532omk0qGUOpLQjDb9dBNk7TSN+wHN7DaoPQk/I5M37/5X+Lhmei
        YFWLlZ0lQHvyLdYVPwpMwAVeHg==
X-Google-Smtp-Source: ABdhPJyVyrsZVLhaxkXm9h29nJJCU9M+eXdlkKV3LKb55qN6JAcw8Ss1bKD7yrrXGUmy/Q5IkV8e7A==
X-Received: by 2002:a37:6642:: with SMTP id a63mr72203468qkc.5.1594428599315;
        Fri, 10 Jul 2020 17:49:59 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g20sm10427510qtc.46.2020.07.10.17.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 17:49:58 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Drew Davenport <ddavenport@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), John Stultz <john.stultz@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Raviteja Tamatam <travitej@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        zhengbin <zhengbin13@huawei.com>
Subject: [PATCH v2 0/8] Initial SM8150 and SM8250 DPU bringup
Date:   Fri, 10 Jul 2020 20:47:23 -0400
Message-Id: <20200711004752.30760-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches bring up SM8150 and SM8250 with basic functionality.

Tested with displayport output (single mixer, video mode case).

v2: rebased

Jonathan Marek (8):
  drm/msm/dpu: use right setup_blend_config for sm8150 and sm8250
  drm/msm/dpu: update UBWC config for sm8150 and sm8250
  drm/msm/dpu: move some sspp caps to dpu_caps
  drm/msm/dpu: don't use INTF_INPUT_CTRL feature on sdm845
  drm/msm/dpu: set missing flush bits for INTF_2 and INTF_3
  drm/msm/dpu: intf timing path for displayport
  drm/msm/dpu: add SM8150 to hw catalog
  drm/msm/dpu: add SM8250 to hw catalog

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |   8 -
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 288 +++++++++++++++++-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  48 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c    |  20 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   |  29 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c     |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   |  16 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c    |  18 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h    |   7 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c      |  75 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     |   6 +-
 12 files changed, 364 insertions(+), 158 deletions(-)

-- 
2.26.1

