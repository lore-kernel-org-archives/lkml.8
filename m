Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A9DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE4F20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030416;
	bh=fkalerq2g4g50vH0Wr4FqY+VaGO2dALKJfw6UNkTFpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=piXv3x/ZKf3MkYrP2GBNsvgSwQgm3DjNrMUyOLJgRnsdNwpM/3X/hfG9gCB7x/y5g
	 0Kn/PtjPBJnEk7mtP1hKff5ZGVtclw0vGjylxvsrxflpikvbQuiEpNu98a6Ir7Br6T
	 snHYFHRxAzx2POk5CNk2RbZtwc8lMes/yUcRBBfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHURUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgHUQQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:16:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2903A22BEF;
        Fri, 21 Aug 2020 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026579;
        bh=fkalerq2g4g50vH0Wr4FqY+VaGO2dALKJfw6UNkTFpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFZKSPf+gjgxJHeG2oadBMbGmjRowoyTSJEtzxjUtA+xB89lSBR6yWN+ny7tTT/x9
         KBx1NJtJTUaQv9V7LdUofpSqbRqGG3f4vWJsa9DddO1jSvU4NyDl26MSxn22QPe3Xa
         DhXOZdZLEhX/J0Dkqw9LM1BAuGRYA5XeEzOs3GhY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 28/61] drm/amdkfd: fix ref count leak when pm_runtime_get_sync fails
Date:   Fri, 21 Aug 2020 12:15:12 -0400
Message-Id: <20200821161545.347622-28-sashal@kernel.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 1c1ada37af6ee6fb9cfc8da6a56cc83208cd8d6f ]

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d8c74aa4e5650..281bd84b0ff44 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -959,8 +959,10 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 	 */
 	if (!pdd->runtime_inuse) {
 		err = pm_runtime_get_sync(dev->ddev->dev);
-		if (err < 0)
+		if (err < 0) {
+			pm_runtime_put_autosuspend(dev->ddev->dev);
 			return ERR_PTR(err);
+		}
 	}
 
 	err = kfd_iommu_bind_process_to_device(pdd);
-- 
2.25.1

