Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D0E20C09
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657885;
	bh=kntZHaADtqmXEkROzUlLhxaIDHYMV/qGZ2kMk2G8Nlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqPfkyqVVUkeho0chFWNnyyXYt86iG7NapCzYo83zmRPywqvgQAPv9ihuoZ12GY3v
	 CpUGaYUSSLKnwbg6H10sFKCGrgE3DWHtqADNzkM9nnYXfg4OiSY04V2WRXNnGpncIW
	 XLGAhXOHqPdXXKKqJoYSQ4NqCUAnp1rDvyl6hxEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFHXLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgFHXJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:09:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89B020B80;
        Mon,  8 Jun 2020 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657788;
        bh=kntZHaADtqmXEkROzUlLhxaIDHYMV/qGZ2kMk2G8Nlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eli+0q8+23VI6xuqdkBZEVpE/REEAaazVpMc7EqhQ5oI98Y8jlA4l71ACC46kRyW2
         uTSlTiRkgJTrC/h9OeQMg2q3WxbfTeJoAaKb3ulQ8LZDJSot0NO8Hyqa6DublVQDig
         cwyyLWQE+ueArq82nz2Ept/0QKDo+ZgweM6XjpLU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        syzbot+e3372a2afe1e7ef04bc7@syzkaller.appspotmail.com,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 169/274] drm/vkms: Hold gem object while still in-use
Date:   Mon,  8 Jun 2020 19:04:22 -0400
Message-Id: <20200608230607.3361041-169-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

[ Upstream commit 0ea2ea42b31abc1141f2fd3911f952a97d401fcb ]

We need to keep the reference to the drm_gem_object
until the last access by vkms_dumb_create.

Therefore, the put the object after it is used.

This fixes a use-after-free issue reported by syzbot.

While here, change vkms_gem_create() symbol to static.

Reported-and-tested-by: syzbot+e3372a2afe1e7ef04bc7@syzkaller.appspotmail.com
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200427214405.13069-1-ezequiel@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_drv.h |  5 -----
 drivers/gpu/drm/vkms/vkms_gem.c | 11 ++++++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index eda04ffba7b1..f4036bb0b9a8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -117,11 +117,6 @@ struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 				  enum drm_plane_type type, int index);
 
 /* Gem stuff */
-struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
-				       struct drm_file *file,
-				       u32 *handle,
-				       u64 size);
-
 vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
 
 int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index 2e01186fb943..c541fec57566 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -97,10 +97,10 @@ vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
-				       struct drm_file *file,
-				       u32 *handle,
-				       u64 size)
+static struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
+					      struct drm_file *file,
+					      u32 *handle,
+					      u64 size)
 {
 	struct vkms_gem_object *obj;
 	int ret;
@@ -113,7 +113,6 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 		return ERR_CAST(obj);
 
 	ret = drm_gem_handle_create(file, &obj->gem, handle);
-	drm_gem_object_put_unlocked(&obj->gem);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -142,6 +141,8 @@ int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
 	args->size = gem_obj->size;
 	args->pitch = pitch;
 
+	drm_gem_object_put_unlocked(gem_obj);
+
 	DRM_DEBUG_DRIVER("Created object of size %lld\n", size);
 
 	return 0;
-- 
2.25.1

