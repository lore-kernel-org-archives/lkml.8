Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F9C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D406024687
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brkho-com.20150623.gappssmtp.com header.i=@brkho-com.20150623.gappssmtp.com header.b="gemQ994Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgAOU5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:57:21 -0500
Received: from mail-vs1-f97.google.com ([209.85.217.97]:46434 "EHLO
        mail-vs1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgAOU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:57:20 -0500
Received: by mail-vs1-f97.google.com with SMTP id t12so11300802vso.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brkho-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHyeBb8P8MuXBOujO8Ub/x9es/mztS5rWLEPJQm2/Ko=;
        b=gemQ994QSr6JkWm5dYBVsYR1LIUE6WIVOW8OxEKlh9bU4AqNaICD0FbZpeOl6z/LAl
         vuC+aCpJJETBjSq2TECPu90Go2szUdkpo1gjupaHPIGJ9ZZooVYxI71Rirzmg6A4bu1L
         C/inqb7wdAsLxPei6JNCqpy1b5SAaEnWS23sMH6VFSBAKedca6LycF29bEiadY3uRsC2
         5pyd9Vh82G2+fmvOBf/aPdjBWU9KkWz+IfbKfdlYWoElECqklH7jr3veHq3W7vdY5cHF
         /ZlDSYv6Igq7WkuojeDl6YSvE69k3n6aCqYrLg13TbuutyCBl5JkOU/tEG1KzumGXC9M
         Tfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHyeBb8P8MuXBOujO8Ub/x9es/mztS5rWLEPJQm2/Ko=;
        b=lT3AqWPm5bBE9YajIL08wnCo1tgN8NfpyW8mi6aLMmanBGgoI+UlP6/b0iOLKNZVZV
         3iI/QiZvtqF+NdDFZ5R4Qy68ikON+NOZ6UjQ+w6fV742AaUI6A8/n36i9iOSsjSeZKVB
         LY/LPx7U8b+0Ad59DrR2N4zrPU9FjxxXM957PbG2kGKBsk0102WqxGgG3fi40GW1pe8K
         vCLJNbc7Uy7b/uViDYRwraoOx/qm5DffqGcxWhhAF1lwQBHGuiQT3mRI+nynmJArXFki
         j7DBJcOWVmDq5r8h+NhfLhJOQMpmBLFTxq4h7Gfzlk4+vy9R1RWm+9lwBcI46yz7Igsn
         HauA==
X-Gm-Message-State: APjAAAUbPoH3Y5+F1INMN4VJMJjTuHXGnlVG5xtpEUeKTkHKascEaDA1
        QUe8HYEKt7mldEUXI/fKU3nQwShDhiB4ZFdc1XzQKqLRv9UhrQ==
X-Google-Smtp-Source: APXvYqwa4eobrkUlejkxbm2vmrBfah47TV7vVGHvbgpZIUMZp/IuDRvCLBzND9WHntaSOfLkMYAbMYa3NIun
X-Received: by 2002:a05:6102:3126:: with SMTP id f6mr5458988vsh.204.1579121838618;
        Wed, 15 Jan 2020 12:57:18 -0800 (PST)
Received: from hob1.nyc.corp.google.com ([100.118.32.120])
        by smtp-relay.gmail.com with ESMTPS id j26sm1472756uak.1.2020.01.15.12.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:57:18 -0800 (PST)
X-Relaying-Domain: brkho.com
From:   Brian Ho <brian@brkho.com>
To:     freedreno@lists.freedesktop.org
Cc:     hoegsberg@chromium.org, robdclark@chromium.org,
        jcrouse@codeaurora.org, Brian Ho <brian@brkho.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/2] drm/msm: Add the MSM_WAIT_IOVA ioctl
Date:   Wed, 15 Jan 2020 15:56:47 -0500
Message-Id: <20200115205649.12971-1-brian@brkho.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set implements the MSM_WAIT_IOVA ioctl which lets
userspace sleep until the value at a given iova reaches a certain
condition. This is needed in turnip to implement the
VK_QUERY_RESULT_WAIT_BIT flag for vkGetQueryPoolResults.

First, we add a GPU-wide wait queue that is signaled on all IRQs.
We can then wait on this wait queue inside MSM_WAIT_IOVA until the
condition is met.

The corresponding merge request in mesa can be found at:
https://gitlab.freedesktop.org/mesa/mesa/merge_requests/3279

Changes in v2:
    * Updated cleanup logic on error
    * Added a mask
    * 32 bit values by default

Brian Ho (2):
  drm/msm: Add a GPU-wide wait queue
  drm/msm: Add MSM_WAIT_IOVA ioctl

 drivers/gpu/drm/msm/msm_drv.c | 61 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.c |  4 +++
 drivers/gpu/drm/msm/msm_gpu.h |  3 ++
 include/uapi/drm/msm_drm.h    | 14 ++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

