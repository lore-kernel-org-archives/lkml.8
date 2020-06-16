Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F40E20E65
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322483;
	bh=5JcNY3+ofa7957DqRCh2OsXj0EcV00v6wRJI0km4tQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W5u0Q36KF1w/zegOTzHpmTTNkFbgxgI3jZEADm51cuJp0+LRywUXT6xF6kNH6/Pj7
	 /6WYNpi5lNJvuYz1bCLuL4Q5pcLu1IzHJV51yosg9jGDalA737wSxG5asdqo8fIeJh
	 oydp0ueKjSGpbyHZi4zIs+oB3TBi3N+LhmRm3MvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbgFPPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732367AbgFPPry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:47:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D0D2071A;
        Tue, 16 Jun 2020 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322474;
        bh=5JcNY3+ofa7957DqRCh2OsXj0EcV00v6wRJI0km4tQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXOxH4gkVDch+SpgmPUvqV7qnHygyGIxFWbOqx9/7e9AJqLGFu8+jiOlN9U/cl8/l
         RbCx2g5OehqLuyVN+I9qY9PQLv8fAzLvdeGUtYm1wi2/wNv1GYX8fxfoUQ/tijNDch
         eP2dDLvpB9U5xgq0Z0p3k5PNoxk/fYVCwmcmMzmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        syzbot+e3372a2afe1e7ef04bc7@syzkaller.appspotmail.com
Subject: [PATCH 5.7 145/163] drm/vkms: Hold gem object while still in-use
Date:   Tue, 16 Jun 2020 17:35:19 +0200
Message-Id: <20200616153113.747491695@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

commit 0ea2ea42b31abc1141f2fd3911f952a97d401fcb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vkms/vkms_drv.h |    5 -----
 drivers/gpu/drm/vkms/vkms_gem.c |   11 ++++++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -117,11 +117,6 @@ struct drm_plane *vkms_plane_init(struct
 				  enum drm_plane_type type, int index);
 
 /* Gem stuff */
-struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
-				       struct drm_file *file,
-				       u32 *handle,
-				       u64 size);
-
 vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
 
 int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -97,10 +97,10 @@ vm_fault_t vkms_gem_fault(struct vm_faul
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
@@ -113,7 +113,6 @@ struct drm_gem_object *vkms_gem_create(s
 		return ERR_CAST(obj);
 
 	ret = drm_gem_handle_create(file, &obj->gem, handle);
-	drm_gem_object_put_unlocked(&obj->gem);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -142,6 +141,8 @@ int vkms_dumb_create(struct drm_file *fi
 	args->size = gem_obj->size;
 	args->pitch = pitch;
 
+	drm_gem_object_put_unlocked(gem_obj);
+
 	DRM_DEBUG_DRIVER("Created object of size %lld\n", size);
 
 	return 0;


