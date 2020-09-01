Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5A62078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598981106;
	bh=mR6oGR+NyHCaBD7rYApwSslo3Nk/GcTOScozNAXPbPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvdSEBP7cGEszXUF/E63UdBM3qYjoL0kLSYAyUxgKv10I0mGErmcJNB7YqecyLKHt
	 8x1fzvklA776Vbo9Ou+bAnaeft5Al9UfqlN9YzSmNtjbYDWCzTBQngWBiWCPZxLQkg
	 38Jeb7Dk14MWviPr2XqWddk9SCR5clj1FH2DcIiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbgIARYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgIAPL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:11:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2B12078B;
        Tue,  1 Sep 2020 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973117;
        bh=mR6oGR+NyHCaBD7rYApwSslo3Nk/GcTOScozNAXPbPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YF1+/XKVysIXcGYHbn0FPyKKVI7cZQIKH4kPIVituN/cebfdEUQh4uLNnnhSU7so3
         kmIxVDD8a+l775QVJFbE+xEExuznwuQwrHSY1Ee4CD+4gjjEIyVs0b70y+WddsgWQH
         sNMO3WYnJ7ns+ZUFP9ysNino+vWAeyLHCbHHugD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 14/62] drm/amd/display: fix ref count leak in amdgpu_drm_ioctl
Date:   Tue,  1 Sep 2020 17:09:57 +0200
Message-Id: <20200901150921.414625994@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



