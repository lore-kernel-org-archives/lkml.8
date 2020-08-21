Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482FFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238B220748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029824;
	bh=eVcPTzL9hbKoVXDtsQ64VvN+g9cHH5uG0hbLgDgR5vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qj/V3dlg1KVww1c1IBm0vaG74iHnj/d5hSqJhF029+seO+dC059rMeUITOEPpJn6U
	 1UGZhUs2EIDmXw1wwBoXKfJ9u8ywN8cWD2BwEKEyxbc7tt4zdkFq3YY+kuzxB1WXPw
	 SJv3d8FrGtDNW9y5GZcdUREmlVTqEEfWSsJOShro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgHURKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgHUQRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:17:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434C122CAF;
        Fri, 21 Aug 2020 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026647;
        bh=eVcPTzL9hbKoVXDtsQ64VvN+g9cHH5uG0hbLgDgR5vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdUKsA4Rofp17CjpZD2xC4rs3Ue0UQmHhcrX/zK16ScVTOv9hEh2pPsoR/UiY9/YI
         kyBpKX9XX2tx00wqQO90CnjgQOXtsbSp/XfwDgef9vpnc+PLrcqExY4DP2ssIHF56h
         94nbEWYVXmW86eLelb02YSmkuNpZfccGdMMKmhqc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 18/48] drm/amdgpu: fix ref count leak in amdgpu_driver_open_kms
Date:   Fri, 21 Aug 2020 12:16:34 -0400
Message-Id: <20200821161704.348164-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161704.348164-1-sashal@kernel.org>
References: <20200821161704.348164-1-sashal@kernel.org>
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
index 2a7da26008a27..fcc5905a7535d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -976,7 +976,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0)
-		return r;
+		goto pm_put;
 
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
@@ -1027,6 +1027,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
+pm_put:
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return r;
-- 
2.25.1

