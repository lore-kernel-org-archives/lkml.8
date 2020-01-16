Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15ACC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3372077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202284;
	bh=TBonzQ10dSFUgOdB4B2DcmnCu975X+gpMksn/PHNrEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBoHcnX+OAj9CkeWRoZZ1jEXapTc++V9xjkRzKFfl5605vszgqxPS9nAE7fU4LaS9
	 RDBYPRFkwIqNiGUOxGYT2cLR9CwVRBcQFav7Y3yXiE0vAI6gc+DG21C20onb7BAYCh
	 XR8nUQvMmjo1zDExHzhInm+ojv6hOR7K8axYBlBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437588AbgAPTSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:18:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732571AbgAPQzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC50E22464;
        Thu, 16 Jan 2020 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193709;
        bh=TBonzQ10dSFUgOdB4B2DcmnCu975X+gpMksn/PHNrEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0BCxwY83NGCwKU4IPM+NY+ZbJVDDYzAXtF0U5zHtaIqnSwjuyB0C1NqrxCkPhA1z
         5Qz2UOswb4EnBtkufwD7aTgPyV2Rc8+CXZWs185kghXmgd3NAf4ohlkh44IqekTryS
         l9o1aG5Z9WjB83wbw9nPw8yrA1E6seQRwzFwWpBI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 005/671] drm/virtio: fix bounds check in virtio_gpu_cmd_get_capset()
Date:   Thu, 16 Jan 2020 11:43:56 -0500
Message-Id: <20200116165502.8838-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 09c4b49457434fa74749ad6194ef28464d9f5df9 ]

This doesn't affect runtime because in the current code "idx" is always
valid.

First, we read from "vgdev->capsets[idx].max_size" before checking
whether "idx" is within bounds.  And secondly the bounds check is off by
one so we could end up reading one element beyond the end of the
vgdev->capsets[] array.

Fixes: 62fb7a5e1096 ("virtio-gpu: add 3d/virgl support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20180704094250.m7sgvvzg3dhcvv3h@kili.mountain
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c8a581b1f4c4..608906f06ced 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -650,11 +650,11 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_get_capset *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
-	int max_size = vgdev->capsets[idx].max_size;
+	int max_size;
 	struct virtio_gpu_drv_cap_cache *cache_ent;
 	void *resp_buf;
 
-	if (idx > vgdev->num_capsets)
+	if (idx >= vgdev->num_capsets)
 		return -EINVAL;
 
 	if (version > vgdev->capsets[idx].max_version)
@@ -664,6 +664,7 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	if (!cache_ent)
 		return -ENOMEM;
 
+	max_size = vgdev->capsets[idx].max_size;
 	cache_ent->caps_cache = kmalloc(max_size, GFP_KERNEL);
 	if (!cache_ent->caps_cache) {
 		kfree(cache_ent);
-- 
2.20.1

