Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F397DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C250D2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598026568;
	bh=W2rAa3hVKvGfCtUIdsWN4znjxtVhRCXRyUpQdLekit0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FAPxHjS4GEcwfzv4EeJMUe62fjZzTP+/Z5jxDLEBYcX6k9qOPJ050q9efiLLitoCn
	 OpGUzETDr1ZOSt3DafR6c8K7ZN2fTuUPYQy8pUCagsCNRgM3IN+HAxr3wOhzzxLQ9E
	 19pzlQNKn+NaQkeYGwrkOZe33xRELh4H6mVLqYlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgHUQQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgHUQOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:14:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8EF9214F1;
        Fri, 21 Aug 2020 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026494;
        bh=W2rAa3hVKvGfCtUIdsWN4znjxtVhRCXRyUpQdLekit0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ORrcPmUG8+/aAkJlpqSICxk/MpNksRoWnBHagVzzMbc1gKmihQuydlKo934/qBUv0
         dmO8ctu3os++dQ+hyVs9N20KAYr4eB09zXaWxpBzuysrjaTBrVhLTPRjVAskKzZPI3
         5f8b3BRoVYnk67I5YnIU1k8cV8BL31On0390dZxw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 25/62] drm/amdgpu: fix ref count leak in amdgpu_display_crtc_set_config
Date:   Fri, 21 Aug 2020 12:13:46 -0400
Message-Id: <20200821161423.347071-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161423.347071-1-sashal@kernel.org>
References: <20200821161423.347071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit e008fa6fb41544b63973a529b704ef342f47cc65 ]

in amdgpu_display_crtc_set_config, the call to pm_runtime_get_sync
increments the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index f7143d927b6d8..5e51f0acf744f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -282,7 +282,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = drm_crtc_helper_set_config(set, ctx);
 
@@ -297,7 +297,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 	   take the current one */
 	if (active && !adev->have_disp_power_ref) {
 		adev->have_disp_power_ref = true;
-		return ret;
+		goto out;
 	}
 	/* if we have no active crtcs, then drop the power ref
 	   we got before */
@@ -306,6 +306,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 		adev->have_disp_power_ref = false;
 	}
 
+out:
 	/* drop the power reference we got coming in here */
 	pm_runtime_put_autosuspend(dev->dev);
 	return ret;
-- 
2.25.1

