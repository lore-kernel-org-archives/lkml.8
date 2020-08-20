Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8666C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6685620674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931055;
	bh=L9dSTyxFIUL5QEh5h/RoTGvt3xEb1evM5ulwEW4iRhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLQJN5GinYT0fUoekhelA7jt7NyhaYmMXo7rZESzq0mIMMgR6tKAvzyFZ5aXLZSJj
	 uhoKxB2JR4rMrs2AXnBbiNsAM3I5MKBOMDnUodIGSetjAxiGbTzbYZCaT6xgGp5NbK
	 Wb7iIZFtRPU2ZyZEeBZedFaV8YjtEfzy1/YZibN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgHTNoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgHTJ3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:29:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763DF2173E;
        Thu, 20 Aug 2020 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915748;
        bh=L9dSTyxFIUL5QEh5h/RoTGvt3xEb1evM5ulwEW4iRhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fH1t+MJ635KfuSJpuSpx6XjgwDFg2PG+qZN5WL9q/E5RKVoWuNiWp/lv/1FK6QlLu
         aLW7cTUJDy8QCpWgVakrQIjWwluRW7CFweOkxZwgUIJfj15g2CIk2igAhjCO5DEnvB
         tLTPkwEn+HnrGixEl+xrjre0H5i+O2Byem2+jWrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Tao <chentao107@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 120/232] drm/amdgpu/debugfs: fix memory leak when pm_runtime_get_sync failed
Date:   Thu, 20 Aug 2020 11:19:31 +0200
Message-Id: <20200820091618.628022066@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Tao <chentao107@huawei.com>

[ Upstream commit 3e4aeff36e9212a939290c0ca70d4931c4ad1950 ]

Fix memory leak in amdgpu_debugfs_gpr_read not freeing data when
pm_runtime_get_sync failed.

Fixes: a9ffe2a983383 ("drm/amdgpu/debugfs: properly handle runtime pm")
Signed-off-by: Chen Tao <chentao107@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f87b225437fc3..bd5061fbe031e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -973,7 +973,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
-		return r;
+		goto err;
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
 	if (r < 0)
@@ -1003,7 +1003,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 		value = data[result >> 2];
 		r = put_user(value, (uint32_t *)buf);
 		if (r) {
-			result = r;
+			amdgpu_virt_disable_access_debugfs(adev);
 			goto err;
 		}
 
@@ -1012,11 +1012,14 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 		size -= 4;
 	}
 
-err:
-	pm_runtime_put_autosuspend(adev->ddev->dev);
 	kfree(data);
 	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
+
+err:
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+	kfree(data);
+	return r;
 }
 
 /**
-- 
2.25.1



