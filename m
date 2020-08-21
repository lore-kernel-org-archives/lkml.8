Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F70C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0C022B4E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598027753;
	bh=mR6oGR+NyHCaBD7rYApwSslo3Nk/GcTOScozNAXPbPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKcQAypIRbBE6+KjMQ9bqcgsTFspaWE6Nv9DH4bqpx/PtfaPT/FQWVDN74veHBi8S
	 e77KlxIiAkHcGlLPuZMpjp25ckGUqvJgxKuy68hLSC0gWXbG2VHimgWNBnc1s122R4
	 4RijsSiGctZEi0D1FbG58ovcmUdcNXbGBbMiK0Uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgHUQfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbgHUQVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:21:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8369F22BEB;
        Fri, 21 Aug 2020 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026825;
        bh=mR6oGR+NyHCaBD7rYApwSslo3Nk/GcTOScozNAXPbPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SMjDhs7sA2MmiQm6D3VIgxjHKzi9mkIJVSPh+l7rhXb/2vMixHDyzlCx+y1xKVmGR
         fzmOVYcdp/QBlDlXli5PKN5MuiLazFWeqS7P7kh8DGk6JmvuQcR0TpA5zNV/ZHmaSj
         FXyQ3UEm51WjQaO/GxTRuA5pseGS+N009MUpO+HQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 08/22] drm/amd/display: fix ref count leak in amdgpu_drm_ioctl
Date:   Fri, 21 Aug 2020 12:20:00 -0400
Message-Id: <20200821162014.349506-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821162014.349506-1-sashal@kernel.org>
References: <20200821162014.349506-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 5509ac65f2fe5aa3c0003237ec629ca55024307c ]

in amdgpu_drm_ioctl the call to pm_runtime_get_sync increments the
counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8d6668cedf6db..eb3c54e1f1ca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -443,11 +443,12 @@ long amdgpu_drm_ioctl(struct file *filp,
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = drm_ioctl(filp, cmd, arg);
 
 	pm_runtime_mark_last_busy(dev->dev);
+out:
 	pm_runtime_put_autosuspend(dev->dev);
 	return ret;
 }
-- 
2.25.1

