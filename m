Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7552EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452B3246B6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196579;
	bh=SjvVj+je/HMlB1NOEWTRrKGFRifaS0pbyWGdTMOoztQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Vp8yFopmcMgKolGAQOl3swu+/1DuY/shvaMhCkR4rHaZyV4Sgu1BBx9kZjE0W1AwU
	 8reI73SNOXDrK+7LfTQ6/OP5in6MQ1/5b4sMXxChAe9kFDB6/9h5ZaFzNxj+YmcMyv
	 LUXlfNtsNpvISAT8JoXk6PdlZAFSR2DeyV8nfObc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbgAPRm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405855AbgAPRmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:42:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C14020728;
        Thu, 16 Jan 2020 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196573;
        bh=SjvVj+je/HMlB1NOEWTRrKGFRifaS0pbyWGdTMOoztQ=;
        h=From:To:Cc:Subject:Date:From;
        b=B2B8Az3+sDeZ9fW1Jnz/IhYHzHvoqrauzA27Wrma3JznGfVnBFEPuGMLJAltD0166
         qPAcU2XtFF8vI++qoZZcy9bRKgzW1/tLob+4cPCpHz5sNGLFR/Z8RYcozgt+MCFD4N
         Jt+wpTTKe/11r7Woqa/T2YgOtSrE8zs/9JhS76I8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.4 001/174] drm/virtio: fix bounds check in virtio_gpu_cmd_get_capset()
Date:   Thu, 16 Jan 2020 12:39:58 -0500
Message-Id: <20200116174251.24326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
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
index a1b3ea1ccb65..772a5a3b0ce1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -681,11 +681,11 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
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
@@ -695,6 +695,7 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	if (!cache_ent)
 		return -ENOMEM;
 
+	max_size = vgdev->capsets[idx].max_size;
 	cache_ent->caps_cache = kmalloc(max_size, GFP_KERNEL);
 	if (!cache_ent->caps_cache) {
 		kfree(cache_ent);
-- 
2.20.1

