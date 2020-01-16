Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3ADC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389E6207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202246;
	bh=mrqyG+s5KkU79YeSwsbvGa5llda5DIJSBZQHAAEAfXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XBoqdWRVIL4Ni+ejtph9mbSuBzJX0tW+fZs7nKP5u+QRo0wdin2JG62hwHtC1zHjd
	 36Rfm14T+td3J/y9zxMdnOGQoEZMM166kKkGy+a/Yuz3yOgcIJRBCzZEAAoHy9GKMC
	 X6ngzaHr5jZr3ZU5OqY0N51wbwnJNhCZXqWcw/Ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbgAPTRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732677AbgAPQzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203882192A;
        Thu, 16 Jan 2020 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193719;
        bh=mrqyG+s5KkU79YeSwsbvGa5llda5DIJSBZQHAAEAfXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guhFjWabM+V+h7WfYKpDiAInDCYY4vWr0VP1h6djzh0ellC5q6V2cjZ5Oaur23IRI
         plkElDqBj+BK61Hq0y/Pp7WB4K56kC4YAJNt1vODjk/sNoSlEhha8em113l/S0ZCmX
         y2skKv97CErUtRhjVhFMUl9b4msN2BdFhhLLnvqM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 014/671] drm/hisilicon: hibmc: Don't overwrite fb helper surface depth
Date:   Thu, 16 Jan 2020 11:44:05 -0500
Message-Id: <20200116165502.8838-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8bd29075ae4e..edcca1761500 100644
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

