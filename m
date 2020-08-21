Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E5620738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030425;
	bh=91ULYNXhDIzau/5gbAZtb8ShhfOIbWiO1f1qXd90GxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bPv91SUCt2pq0GUtkuN1rz56vHrKyruV2IXYxAfJB+N5aWr9g7ezpv0qO7h/2mEqP
	 6+iMLDntFd0j3PSGBIqdsQFhQvApbKWHbHWDgYTFEySOGzWn0v+L9c2S2neH2aqCS2
	 ocWf3SHc2rvmaKnzjLGvw13Ctux8uhwCWv/Rogno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgHURUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgHUQQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:16:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B21B20578;
        Fri, 21 Aug 2020 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026573;
        bh=91ULYNXhDIzau/5gbAZtb8ShhfOIbWiO1f1qXd90GxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uz+kmfF4gClF8R557Ob5paufTXyVQJNjZFGRI9IjcQKZrPOqMpecq53OehNxN7G86
         eBNk1Tx0nHOZdQ/k2HH3vUH1Wvw60wS9T0of3Ha+Uw5kpyDK/HEfIHhEL356eYBg6I
         PrqSh9/kwhO+v9/Rtux6+VgFL7VoW5wbUKjr3zk8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 23/61] drm/amdgpu: fix ref count leak in amdgpu_driver_open_kms
Date:   Fri, 21 Aug 2020 12:15:07 -0400
Message-Id: <20200821161545.347622-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161545.347622-1-sashal@kernel.org>
References: <20200821161545.347622-1-sashal@kernel.org>
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
index 81f83ee4b12b8..121ff705ff60e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -992,7 +992,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0)
-		return r;
+		goto pm_put;
 
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
@@ -1043,6 +1043,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
+pm_put:
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return r;
-- 
2.25.1

