Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB87FC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A2520709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860580;
	bh=NsL/XEYWYT0nbrdwtmMgxsp0HrfqXxOWX3og0QqbDko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jUGp8hbu1ONm9y23RO4nRiVfpGGml3lSgrWJu9XUJy52TBnY4gKf4ztwCoTAf/3+M
	 rKD+b5X0rnhJlIuslt1DKG6fUu6xKeqyWZkHtR0+1xQWT5KWcq4ryJDvW8VM5QOiU2
	 2pP0vtrMfY10esZQQd9QtHii3mdL2ifZsaYnUzec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389649AbgAXKJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389250AbgAXKJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:09:36 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5775320709;
        Fri, 24 Jan 2020 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860576;
        bh=NsL/XEYWYT0nbrdwtmMgxsp0HrfqXxOWX3og0QqbDko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKFe8CpqQhISvTwmuj5+p8JKGncliEeuEap+9mqrp8Q21FAR5eNkBQw3mdjvCG/v+
         sSRuMClgksFqmzL6z9LS/dqOmyzGbjOPeOVhFlLxe0twv9JK9KfgjLq/SFN65JooHD
         KqcYi1tnRpvPc7inefKLHrG+s7ZEyOJ6nB6r8bGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/639] drm/hisilicon: hibmc: Dont overwrite fb helper surface depth
Date:   Fri, 24 Jan 2020 10:23:21 +0100
Message-Id: <20200124093051.298777324@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit 0ff9f49646353ce31312411e7e7bd2281492a40e ]

Currently the driver overwrites the surface depth provided by the fb
helper to give an invalid bpp/surface depth combination.

This has been exposed by commit 70109354fed2 ("drm: Reject unknown legacy
bpp and depth for drm_mode_addfb ioctl"), which now causes the driver to
fail to probe.

Fix by not overwriting the surface depth.

Fixes: d1667b86795a ("drm/hisilicon/hibmc: Add support for frame buffer")
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Signed-off-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
index 8bd29075ae4eb..edcca17615001 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
@@ -71,7 +71,6 @@ static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
 	DRM_DEBUG_DRIVER("surface width(%d), height(%d) and bpp(%d)\n",
 			 sizes->surface_width, sizes->surface_height,
 			 sizes->surface_bpp);
-	sizes->surface_depth = 32;
 
 	bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
 
-- 
2.20.1



