Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FF4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45173206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFPGcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:32:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6329 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgFPGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:32:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A36DC17FFFEF82B1B2BE;
        Tue, 16 Jun 2020 14:31:55 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 14:31:49 +0800
From:   Chen Tao <chentao107@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <tom.stdenis@amd.com>, <Jack.Xiao@amd.com>,
        <yttao@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH 1/2] drm/amdgpu/debugfs: fix memory leak when pm_runtime_get_sync failed
Date:   Tue, 16 Jun 2020 14:30:38 +0800
Message-ID: <20200616063039.260990-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leak in amdgpu_debugfs_gpr_read not freeing data when
pm_runtime_get_sync failed.

Fixes: a9ffe2a983383 ("drm/amdgpu/debugfs: properly handle runtime pm")
Signed-off-by: Chen Tao <chentao107@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..bea8c36a53a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -862,8 +862,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		kfree(data);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
 	if (r < 0)
-- 
2.22.0

