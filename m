Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83481C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCEC20702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029388;
	bh=LX02lHq/65D91ykDc6OlibqFlwnpLmix249DejHjv68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6MnbIQ+pOLHakW6WqLxau6flezI7NW4xUWmONaWOrXyU8781UT55eSPEYyDAT2M7
	 EmPfCSZ0wk9SH4hjX3fbDw0r4gf3IJVLfFlWJ44aeNQtz0PudVVL+16K12tIhOXfyG
	 4kwzyQObvHpZfWj+IcyGqKuODzy3mCiwBIW6fWWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHURDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbgHUQTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:19:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E9622CF8;
        Fri, 21 Aug 2020 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026705;
        bh=LX02lHq/65D91ykDc6OlibqFlwnpLmix249DejHjv68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biFZdgLKLNzACFisEc2RSB7bSJJNu0P4xi27G8Yzg/93Q1l6Anrml319/1Ujdd0sl
         dk7ojylMeDL1EiTRiBcpL0Ocw+butUkDY5g/J7ABZK3S2m1tu4ZtoKMiZMUU17ayRo
         DR+dX3TVxqbLFHEg2ahOhTavsy8KZMzTcmWTXIZo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 14/38] drm/amdgpu: fix ref count leak in amdgpu_driver_open_kms
Date:   Fri, 21 Aug 2020 12:17:43 -0400
Message-Id: <20200821161807.348600-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161807.348600-1-sashal@kernel.org>
References: <20200821161807.348600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 9ba8923cbbe11564dd1bf9f3602add9a9cfbb5c6 ]

in amdgpu_driver_open_kms the call to pm_runtime_get_sync increments the
counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bb41936df0d97..2beaaf4bee687 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -835,7 +835,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0)
-		return r;
+		goto pm_put;
 
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
@@ -883,6 +883,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
+pm_put:
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return r;
-- 
2.25.1

