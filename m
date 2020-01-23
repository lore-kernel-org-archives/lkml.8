Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AC7C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5502120706
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brkho-com.20150623.gappssmtp.com header.i=@brkho-com.20150623.gappssmtp.com header.b="D7OYHpFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgAWX7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:59:36 -0500
Received: from mail-yw1-f99.google.com ([209.85.161.99]:42262 "EHLO
        mail-yw1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgAWX7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:59:36 -0500
Received: by mail-yw1-f99.google.com with SMTP id l14so56444ywj.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brkho-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrSo2+pGduAw292a0r+TdBhJS9mLgXGxwVlVbyCbpLg=;
        b=D7OYHpFLgk97teU0zZSRPPccfqMZUapF8TpobPPhIx/gWfpISr+LuVI6MDdnJDhbs4
         apMzxOnEd3+jzgIMs070Vk+xjc6o+5gb0ZBitQOL2ahu20wsHITfv4+aW8aRmiJmh1wc
         X8RIjb4s+cPG5CghTJHdXKgkuR5GSh1hrb9/twhckyMLrxupMtCJ0/9IkEIn6l0I3xXc
         LSx1unKEneXQbbOETIQOHpnbCvX+y5yyKBvVoAvwQbe/AxUJ/cnuLNMKDF1FklNC3hsf
         zYj6M9WePrwvnY+mhcncUZYDXnAXRSxHgb7XVYlLn3kGv7uWwXRruiT8Y0GO4JFyzjUv
         1QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrSo2+pGduAw292a0r+TdBhJS9mLgXGxwVlVbyCbpLg=;
        b=GZLEMHW39ezaahF/tGjP8rBhZEuun2NOxfIBvRg69g8x7mS0my9jplTzZ/UrEmBnuS
         FcxcLgcLUrqpGWBJt2t08T5xzKRYiBoC7AxRFD1oUKdqALzgzR1nKcuJaxrCXXB7/W7p
         LfucdAh3BH2DwCiuhIausuerdBzQbZyJjSl7KHNaTHCax8WJe9y1+wRnV3RLHEF+myEK
         USu0YmiXkcC1fy9QyiGpnegVU8x2MBSEJnaMv0iS53omTO2exFKet3YHIKNCtS9U8PP7
         SLg7hCXL15HKT8lOYH8ynqNtgOaCaP6w7dyjoYT9gpBrpsSoVhCPmRwFFQLMYSLVXazh
         LgZQ==
X-Gm-Message-State: APjAAAWFVx7cK5qHo4Wcg5EPYIoDcd+GRIVj+fuijyMK3+sKO7VlQspS
        5yrgwBBdy6vo5YQoT15TuyoUud4WSDLmdRrLjwOl4WabW6k0tw==
X-Google-Smtp-Source: APXvYqyitskCyEXAQcqS53IPFPyVLU9xyT5Uc39138IvOAogcA8kZveFb67zLpleAblvQ8kXm3+zAJJzhtKV
X-Received: by 2002:a81:9c14:: with SMTP id m20mr163298ywa.143.1579823974817;
        Thu, 23 Jan 2020 15:59:34 -0800 (PST)
Received: from hob1.nyc.corp.google.com ([100.118.32.120])
        by smtp-relay.gmail.com with ESMTPS id i82sm591239ywg.11.2020.01.23.15.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:59:34 -0800 (PST)
X-Relaying-Domain: brkho.com
From:   Brian Ho <brian@brkho.com>
To:     freedreno@lists.freedesktop.org
Cc:     hoegsberg@chromium.org, robdclark@chromium.org,
        Brian Ho <brian@brkho.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/2] drm/msm: Add the MSM_WAIT_IOVA ioctl
Date:   Thu, 23 Jan 2020 18:57:36 -0500
Message-Id: <20200123235738.48182-1-brian@brkho.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
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

Changes in v3:
    * Fixed a bug where the mask was being applied incorrectly

Brian Ho (2):
  drm/msm: Add a GPU-wide wait queue
  drm/msm: Add MSM_WAIT_IOVA ioctl

 drivers/gpu/drm/msm/msm_drv.c | 61 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.c |  4 +++
 drivers/gpu/drm/msm/msm_gpu.h |  3 ++
 include/uapi/drm/msm_drm.h    | 14 ++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

