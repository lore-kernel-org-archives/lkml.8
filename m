Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9EBC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57AA204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976763;
	bh=M+Bk+/4lU9mMcnvrN2jpBXG1aWpPW0uTtcT+LKxuSn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=voVHWzhit8kBUJE7Btdpi5qTEGBmNE9ddY5xLysvVkLRF9KwdBU2ybiHryjqYQZs4
	 TrRee7ZZK/0UkHq0o4R7tsSFvgL1Sc2plFpBYmsKqBL5RKBGsG9xbHZerOzn63Hcy/
	 HvnGDMxMR0EXnRi+bHluU/otbfgmoWmdRa+jAfIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbgIAQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbgIAPgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:36:54 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5AA220E65;
        Tue,  1 Sep 2020 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974614;
        bh=M+Bk+/4lU9mMcnvrN2jpBXG1aWpPW0uTtcT+LKxuSn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXR/qp2+RJitLnmQfwrP/2N12Q4/DahSddvAt/mt0ntAMg4cIfFDTdeEXw9rq0nLp
         PMCmSBy2QFwEdZdC7TSFYVbEDJk2X1OjHeB7xce+vpvVgL+vlrY9kg1t68xbEheJci
         mCtqUp0FL7DmqJDXhXkgA+z6/bp1UIHBlKXLxmQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 029/255] drm/amdgpu/fence: fix ref count leak when pm_runtime_get_sync fails
Date:   Tue,  1 Sep 2020 17:08:05 +0200
Message-Id: <20200901151002.170202815@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit e520d3e0d2818aafcdf9d8b60916754d8fedc366 ]

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3414e119f0cbf..f5a6ee7c2eaa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -754,8 +754,10 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return 0;
+	}
 
 	seq_printf(m, "gpu recover\n");
 	amdgpu_device_gpu_recover(adev, NULL);
-- 
2.25.1



