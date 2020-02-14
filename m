Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0ABC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED392467E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695557;
	bh=WKtH/RZTRwM7WT0NeLzaocPcyIhA+2QbGqT+MfxqYcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Xl48qQPhCIM1IWzyWXdSMurNJ5z7yZJ9/YZ/P7Rfms63iEvjSNRZMox05iHaUC/+
	 0IFWLKL/UAsUIbXUvVMZbVdfnfoRr+QlZg6gcfGtAkaJedafKHS2RsGzXhFshJAxYi
	 bsvLnXyGDfJ1q997qnT0DgYcDVPbPMVQ5r+AiVIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbgBNPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbgBNPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F31222C4;
        Fri, 14 Feb 2020 15:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695527;
        bh=WKtH/RZTRwM7WT0NeLzaocPcyIhA+2QbGqT+MfxqYcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwD2w8Q+1nZ0BK8KMggi8Iu9Z0mqZaTj6jnhlvCtla8lwZyjeqWC8zK4qPnZzV4Fm
         CeYVc4SZP5qDJu+EQ0ORltFNiI0HIqkSzUxOfchLBUFUSaNOEQKgToW5xxeRTzVPkA
         GfWy8lUlF0gzFjnpLZRwVf1RvOYpWj53dzYHiSjk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 148/542] drm/amdgpu: remove set but not used variable 'count'
Date:   Fri, 14 Feb 2020 10:42:20 -0500
Message-Id: <20200214154854.6746-148-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit a1bd079fca6219e18bb0892f0a7228a76dd6292c ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdkfd/kfd_device.c: In function
‘kgd2kfd_post_reset’:
drivers/gpu/drm/amd/amdkfd/kfd_device.c:745:11: warning:
variable ‘count’ set but not used [-Wunused-but-set-variable]

'count' is never used, so can be removed. Thus 'atomic_dec_return'
can be replaced as 'atomic_dec'

Fixes: e42051d2133b ("drm/amdkfd: Implement GPU reset handlers in KFD")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4fa8834ce7cb0..209bfc849352b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -742,7 +742,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 int kgd2kfd_post_reset(struct kfd_dev *kfd)
 {
-	int ret, count;
+	int ret;
 
 	if (!kfd->init_complete)
 		return 0;
@@ -750,7 +750,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	ret = kfd_resume(kfd);
 	if (ret)
 		return ret;
-	count = atomic_dec_return(&kfd_locked);
+	atomic_dec(&kfd_locked);
 
 	atomic_set(&kfd->sram_ecc_flag, 0);
 
-- 
2.20.1

