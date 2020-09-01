Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F01C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7496A204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk78CRGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgIAQGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbgIAPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:41:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93796C061244;
        Tue,  1 Sep 2020 08:41:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c15so722625plq.4;
        Tue, 01 Sep 2020 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XcOkZQQTpeiKz0Mw1rh6CWyKzUqBxGHdddTMQluuF34=;
        b=Rk78CRGY6dy+ZFEdUZrfDrnbPXFN0j/Mbf4gfXAkMjV1FkA2jKOMgzMPmrqys1xN/H
         0oCBCSDeXw/3JmqJZZBZI2e7KU4I11AowUw16Fa5saUX2Td1HzQEjH27G0+GzfYgv8x1
         WX2VFPksk/1wwi4AtjUfXd+bsoX3k0XsL5Lq+kr6hwqV3iUoxwn+wvzj4GXMcDrGhY0A
         ysSl74XDSHwkVGrez9PxQELCFAg10MTAMEyRB6gwJ5NAGR1sUCH5qbZq+ZOcotuZrAzw
         VHuZvLHYBOgzIm4GmCQ4I4fktm63T6bnrtxlkHJkCgBlae9cGWqQATf2Lh+cNLVr/Kf+
         AHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XcOkZQQTpeiKz0Mw1rh6CWyKzUqBxGHdddTMQluuF34=;
        b=tDQ5/0JMh59DYdntZOvFiPpDMHk80VPSSOPrdDvKuiHfwmz1GhYkaUX2mCw3rgELf/
         HCVbwUXos7LjLQv5bJ8puwm/s8xfGABfj0qIt+B5Uj/kvbO1adZD0P2RSZA3ubHjBefP
         sn0iLKr029yDjmSmfkUzhhHO5oVXULtidR7PpKu9AviU8PvdpJetjI8eFOxWyh6S5hP2
         86QF0Qw9Fs5GQIVxSNWfP3nY78BzTqYGi6uLAqGhZnJlcoktUSZBthn2yFtWMNgpQ2/P
         dwAYDf/6UEhu+mJtlNjvvodGEgkn/nemgNHPOQyrNmRCkTU//o5bSTzKnuAXlFgCyRf0
         kX7g==
X-Gm-Message-State: AOAM532LYjVBVweIX4T3qRcLwSJhVDReRqw0gzQQLBuaX08sMgKAKz7u
        mE/aW+b+Y9WQKHtHTcWM+Dg=
X-Google-Smtp-Source: ABdhPJyqWurWH/ORf0ZgMqXz4uWDelIfZv4TSIVGUQMClW7m1/yiFKFieKf6KGpAAbYBd4+w7PET0g==
X-Received: by 2002:a17:90a:2846:: with SMTP id p6mr2106145pjf.75.1598974868605;
        Tue, 01 Sep 2020 08:41:08 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id l21sm2499407pgb.35.2020.09.01.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:41:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH 0/3] drm/msm: More GPU tracepoints
Date:   Tue,  1 Sep 2020 08:41:53 -0700
Message-Id: <20200901154200.2451899-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Various extra tracepoints that I've been collecting.

Rob Clark (3):
  drm/msm/gpu: Add GPU freq_change traces
  drm/msm: Convert shrinker msgs to tracepoints
  drm/msm/gpu: Add suspend/resume tracepoints

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c  |  3 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c  |  4 ++
 drivers/gpu/drm/msm/msm_gem_shrinker.c |  5 +-
 drivers/gpu/drm/msm/msm_gpu.c          |  4 ++
 drivers/gpu/drm/msm/msm_gpu_trace.h    | 83 ++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.26.2

