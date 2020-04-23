Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1C1C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0869820776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="ea0jbfin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDWVKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDWVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:10:23 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34390C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:10:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e17so2772556qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGEfF7JznP06It+jkOfAQDQc1pJd8JmwvNQgGMabKeI=;
        b=ea0jbfinBVFNiW+VjkmQJcHsJy7+egIybfZNyTsemPXQ7TiuqAkvL6sMrIqM+HBEXz
         17psvgvhDDKqJV8MpbzxEBunSze8Up13OSimKrC0ARAVcsu3qWZLWIHAIZc0+5qrjaQn
         HWOHZ7K5LuiOoQBbc0Bl89x8C9QtWMAiArLKyU1aSiDWNARfspKasO9uaQ2RsocUk9jE
         jbtJTPkfrrXbiKwZcs+3nJiCLd/a9UrycrS/IsPCdre28p4TEG7rTHIPBff1QLiL2Qrd
         dtSsw77LbnE4YZ6WR54jZ29vnWHcMEWoP2MrjeUiTJZLcyN/Ec78MBvB1NDJt6EXARhD
         UFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hGEfF7JznP06It+jkOfAQDQc1pJd8JmwvNQgGMabKeI=;
        b=LhV7v+IDB/TuowOKdqvBVA4qoKMV08qImxFhWkhkI1WR/m3kzUlWgaN5vq7G2dhfoQ
         oxrFzrW3nruPu5VXGy0HYSOVaSvNBs7O2ATNMHBgO5fVHxLtB5J4WvsTsIs2m+lmSrkH
         ZhzCZveRzPpKsYa0cTBQuSfamdPOZf3moLe1iU+ofiRCtmXtRK6+8nBzlBFcbXl0/bD+
         t2sV86H41BT+k6l3mZhmTIYIGdAXwcSmig3VI7Lv+s3X3jI2/lXF9mxGHAauci1c46z5
         LExD/eq2tUvJsfAG5S8O7jaeoAcS6opxacZTi2PUOkidvfZwYn8Bk2myD3zc3eDn7fkr
         Cydg==
X-Gm-Message-State: AGi0PuZGR/drfD+BFciGpBv5CpxocfsYxY3Ad8wDX4k430/2VUdCNiaN
        iqe92h2XPtpxb5VJ3IkwwANn+w==
X-Google-Smtp-Source: APiQypIbsUjeczD5kx3I0NgkeV/HdDQwfnk0rn2ZtWZm19J5oyVSkXK/8Ss3zEV9Gpc4MxOe0BduJw==
X-Received: by 2002:aed:249c:: with SMTP id t28mr6130659qtc.169.1587676221224;
        Thu, 23 Apr 2020 14:10:21 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id n4sm2341495qkh.38.2020.04.23.14.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:10:20 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Enrico Weigelt <info@metux.net>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v3 0/9] Add support for A640 and A650
Date:   Thu, 23 Apr 2020 17:09:12 -0400
Message-Id: <20200423210946.28867-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for A640 and A650 GPUs.

Missing bus scaling, hwcg, and UBWC config, but GPU works without those.

Changes in V2:
Use msm_gem for allocations (first 3 patches are new)
Squashed pdc/rscc patches together
Removed unnecessary "WARN_ON"s in "HFI v2 for A640 and A650"

Changes in V3:
Updated patches 6 and 7 (see commit logs for details)

Jonathan Marek (9):
  drm/msm: add msm_gem_get_and_pin_iova_range
  drm/msm: add internal MSM_BO_MAP_PRIV flag
  drm/msm/a6xx: use msm_gem for GMU memory objects
  drm/msm/a6xx: add A640/A650 to gpulist
  drm/msm/a6xx: HFI v2 for A640 and A650
  drm/msm/a6xx: A640/A650 GMU firmware path
  drm/msm/a6xx: update pdc/rscc GMU registers for A640/A650
  drm/msm/a6xx: enable GMU log
  drm/msm/a6xx: update a6xx_hw_init for A640 and A650

 drivers/gpu/drm/msm/adreno/a6xx.xml.h      |  14 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 412 ++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h      |  37 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h  |  48 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  62 +++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c      | 123 +++++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h      |  50 ++-
 drivers/gpu/drm/msm/adreno/adreno_device.c |  24 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  10 +
 drivers/gpu/drm/msm/msm_drv.h              |   6 +-
 drivers/gpu/drm/msm/msm_gem.c              |  31 +-
 drivers/gpu/drm/msm/msm_gem.h              |   1 +
 drivers/gpu/drm/msm/msm_gem_vma.c          |   6 +-
 14 files changed, 677 insertions(+), 149 deletions(-)

-- 
2.26.1

