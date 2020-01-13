Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D0C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C121734
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brkho-com.20150623.gappssmtp.com header.i=@brkho-com.20150623.gappssmtp.com header.b="Ra1HwBng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMPgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:36:50 -0500
Received: from mail-yw1-f99.google.com ([209.85.161.99]:40397 "EHLO
        mail-yw1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgAMPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:36:49 -0500
Received: by mail-yw1-f99.google.com with SMTP id i126so6325661ywe.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brkho-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJFdDikfbN+KalEJTdnTdl6gsZ3fW2Tc7ZjkvYTvyD0=;
        b=Ra1HwBngnQsFsdibS3erX1ro72SPNFOPBuna6fAXIQWG17KVuwQqD9gMrdmCX7ki+B
         EfZnaFMA5gKVT3d2qJucInxK1XRuJFIQjhpLG292NZcU6B2kEOsnvEAtLvx58jiTXMJk
         R3JhbyxnKu264DFtvTI48xgHQS4fvpOzUpteR3OrVr78AnbU2zIkVDSvrN5ZD8cvjeee
         JFM3IRmFzWideOV8V9KEow0sfm4l9HLJVDVYnrOiZTg2y3gnmUrcDev8aU5KY5uD5KlR
         ZI8urhn7LhvdDYHsVAv38s1cdzYy0VpHd73CuBsHJdDdJIh3/5QdZn3CfaseC0z8UOlv
         K8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJFdDikfbN+KalEJTdnTdl6gsZ3fW2Tc7ZjkvYTvyD0=;
        b=EgvnxI5ZfMtG2P+jzdEfJWULz2fBui3Gb5JJP2ZAFCr/EpEOam40Aj70/sOUu0TdIE
         EDjJu/Kgen0O/M/CyfKWnhhutNvZ84c5esRn3Yjf8GfpqCEA/O7FOoPo1/sygACrQH7K
         7Nobtx+p/PLiuO42D3x6O938kmk4R8H7Dhety+exhsSmADsVFKnHE8Fd9I6pL4gaQIE7
         HwbCbs7v4nPv2I2EyyvT0P4jKFxHbZ8HUelIG+Pu8F5DYhejISEdOzbyhqh9kS6hnFqI
         5iKEtrMRb6aoO63DQeQEo8fo3rGslNW7qulq225E2g2x1xwvD/Jc+bvc2TR8Zd67jaJW
         679Q==
X-Gm-Message-State: APjAAAXtkfial8m6FzD2M5Dd/NH+FDSNILFvWDqZai7G/nRDrg/sIExU
        2NJ+cMjdV4B7+Xw1Aa7LBYvagIoDctObeB1hxKVQ4kV/wBN/HQ==
X-Google-Smtp-Source: APXvYqze74w6U50gaTJnAzutIy9P9BFgvcZsIGa2e6zF7CwAW4jN8VuBPit1CodjbUXUBdLxFIXm1nt6Mg+C
X-Received: by 2002:a25:2c9:: with SMTP id 192mr12441529ybc.48.1578929808492;
        Mon, 13 Jan 2020 07:36:48 -0800 (PST)
Received: from hob1.nyc.corp.google.com ([100.118.32.120])
        by smtp-relay.gmail.com with ESMTPS id m193sm1672393ywd.0.2020.01.13.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:36:48 -0800 (PST)
X-Relaying-Domain: brkho.com
From:   Brian Ho <brian@brkho.com>
To:     freedreno@lists.freedesktop.org
Cc:     hoegsberg@chromium.org, robdclark@chromium.org,
        Brian Ho <brian@brkho.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] drm/msm: Add the MSM_WAIT_IOVA ioctl
Date:   Mon, 13 Jan 2020 10:36:03 -0500
Message-Id: <20200113153605.52350-1-brian@brkho.com>
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

Brian Ho (2):
  drm/msm: Add a GPU-wide wait queue
  drm/msm: Add MSM_WAIT_IOVA ioctl

 drivers/gpu/drm/msm/msm_drv.c | 63 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.c |  4 +++
 drivers/gpu/drm/msm/msm_gpu.h |  3 ++
 include/uapi/drm/msm_drm.h    | 13 ++++++++
 4 files changed, 81 insertions(+), 2 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

