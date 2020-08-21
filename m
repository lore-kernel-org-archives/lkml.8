Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5622C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B4020738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030400;
	bh=aeNLfbOxc1fi4O4pUGXUtGAphJ/8yx6rS/qKYDWhY34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tqh6pzXd3syxDoQ3jn8fL83aP78gAqCoRNsswcUL3yJon3hCz238HxL9sPg63ftAc
	 tyEHqUX+35Py2q342HIvWXwQreFvucyuU+7AMmZ+WxJ8G5VzKDGrBJ6seQ5Or7uz6A
	 zaJhzSCMm5NV+9xvDTRCceqwpw12ebsXhUdfdmEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgHURT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgHUQQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:16:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2B12224D;
        Fri, 21 Aug 2020 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026578;
        bh=aeNLfbOxc1fi4O4pUGXUtGAphJ/8yx6rS/qKYDWhY34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMHUqRKJvojsv7bdiGwB1NXBKoc6OWu8CDYXvGpe0D3hcp3ypC7sKar5lCuORgQVZ
         khOXQgUEfN6yvnavTK4JKugsEjzLm9XuX2/ihiPjMuDSaC67XdY01UDmJvVFO7Bd0P
         NxjF05cj9O8nsOZ5B3WVb2tXTo/f5jB63maiGvQQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 27/61] drm/amdgpu/fence: fix ref count leak when pm_runtime_get_sync fails
Date:   Fri, 21 Aug 2020 12:15:11 -0400
Message-Id: <20200821161545.347622-27-sashal@kernel.org>
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
index 892c1e9a1eb04..bf82b25e1aa32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -746,8 +746,10 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
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

