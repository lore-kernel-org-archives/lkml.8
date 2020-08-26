Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D09BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1688A2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK9O3wn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHZPwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgHZPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:52:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB50C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:52:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j11so1088213plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5J4tHsMCAfIrp1wGadn2uKy2Cv9kYNhHiKmKplllS+A=;
        b=oK9O3wn33DfG4C5PnF1IMcCqCbxGIao1L1ZyU6sXFNzIcbMUggT+TmaH02aTGFWZHi
         Z1RqS7DarL9SSnIPu/gIOmRo7RVNEgOqyZRNGREhRlX5O9gDqcjd3ZntBSk3oEmrYvTw
         RB8HibofSgluV0DDab2UJQB/Er8eAy/AIEL3aEGbrV+NJIHlu74Y/SDFRTd93U+SUYoO
         yHfGUIUkmyJCPnJi2ZpbWN/3v2Fhebr9JdDJkI3d8Vydxr1JloBFhsIIDGTf7q5xrmGe
         l+HUsPmC9AW2wgqCiZqctDOo/HSHGhEzeZNSpSVDZVRUjU3ModRjgzOoDvKKZ01BK1uR
         GSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5J4tHsMCAfIrp1wGadn2uKy2Cv9kYNhHiKmKplllS+A=;
        b=cJQSPkSmECGsSD+y5lVaNz42wyy3/WtTnHzzGYNNGIlU/ExUCLd5yBdPiVdHlxFqdw
         egyKboJDwY4duoMNw+6ApeV4sph+ZH1vgK95VE2K0sas1JK2IBi0He92PEew4fR4dV+v
         6LW9ptvUPaF/EsnCuvw9mJ91f9ki9DPd4mRniRzVti2PvtIlXm5VPXxjCRis+jTK53yR
         +Kk1DinFFp6n+FREN1K08svBGFRPJOd+6vQLKGoil69iEo36HziOTeCvajxbu8F2IKZk
         bgcS1nofCga3ZGPPPt3EN8GhJ7zaUY53QXUOfv+iY9wa9hURvhak7uplRmuHG6MjG578
         GV5A==
X-Gm-Message-State: AOAM531Ft3BgyLUgRDLOODvepbqaRk84XNTRpVBwkoHkDtpUG2lxieTL
        1oxpEi796jdCbtKNOFWHWzk=
X-Google-Smtp-Source: ABdhPJxj5q+Vo5FQU/sigmknfPp+oHTMTbcTfGLqqq9lc/2Ly9uf1Cm93QFC9ZolVrZBUHuQ1oPg4w==
X-Received: by 2002:a17:90a:4608:: with SMTP id w8mr115257pjg.1.1598457150469;
        Wed, 26 Aug 2020 08:52:30 -0700 (PDT)
Received: from realwakka.navercorp.com ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id y7sm3414687pfm.68.2020.08.26.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:52:29 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        melissa.srw@gmail.com, Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vkms: replace deprecated functions in vkms_driver
Date:   Wed, 26 Aug 2020 15:52:15 +0000
Message-Id: <20200826155215.7736-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gem_vm_ops and gem_free_object_unlocked function pointer is deprecated.
This patch replace these functions with drm_gem_object_funcs. And
functions used in drm_gem_object_funcs, vkms_gem_vm_ops and
vkms_gem_free_object, are not used other file but vkms_gem.c. So these
goes static functions. When creating vkms_gem_object, vkms_gem_funcs
is used for drm_gem_object.funcs.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Melissa Wen <melissa.srw@gmail.com>

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c |  8 --------
 drivers/gpu/drm/vkms/vkms_drv.h |  4 ----
 drivers/gpu/drm/vkms/vkms_gem.c | 21 +++++++++++++++++++--
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 83dd5567de8b..a3a1ee1f77fb 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -51,12 +51,6 @@ static const struct file_operations vkms_driver_fops = {
 	.release	= drm_release,
 };
 
-static const struct vm_operations_struct vkms_gem_vm_ops = {
-	.fault = vkms_gem_fault,
-	.open = drm_gem_vm_open,
-	.close = drm_gem_vm_close,
-};
-
 static void vkms_release(struct drm_device *dev)
 {
 	struct vkms_device *vkms = container_of(dev, struct vkms_device, drm);
@@ -101,8 +95,6 @@ static struct drm_driver vkms_driver = {
 	.release		= vkms_release,
 	.fops			= &vkms_driver_fops,
 	.dumb_create		= vkms_dumb_create,
-	.gem_vm_ops		= &vkms_gem_vm_ops,
-	.gem_free_object_unlocked = vkms_gem_free_object,
 	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
 	.gem_prime_import_sg_table = vkms_prime_import_sg_table,
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index f4036bb0b9a8..d7870755513c 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -117,13 +117,9 @@ struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 				  enum drm_plane_type type, int index);
 
 /* Gem stuff */
-vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
-
 int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
 		     struct drm_mode_create_dumb *args);
 
-void vkms_gem_free_object(struct drm_gem_object *obj);
-
 int vkms_gem_vmap(struct drm_gem_object *obj);
 
 void vkms_gem_vunmap(struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index a017fc59905e..9d58e29c1b8f 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -7,6 +7,20 @@
 
 #include "vkms_drv.h"
 
+static vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
+static void vkms_gem_free_object(struct drm_gem_object *obj);
+
+static const struct vm_operations_struct vkms_gem_vm_ops = {
+	.fault = vkms_gem_fault,
+	.open = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
+
+static struct drm_gem_object_funcs vkms_gem_funcs = {
+	.free = vkms_gem_free_object,
+	.vm_ops = &vkms_gem_vm_ops
+};
+
 static struct vkms_gem_object *__vkms_gem_create(struct drm_device *dev,
 						 u64 size)
 {
@@ -19,6 +33,8 @@ static struct vkms_gem_object *__vkms_gem_create(struct drm_device *dev,
 
 	size = roundup(size, PAGE_SIZE);
 	ret = drm_gem_object_init(dev, &obj->gem, size);
+	obj->gem.funcs = &vkms_gem_funcs;
+
 	if (ret) {
 		kfree(obj);
 		return ERR_PTR(ret);
@@ -29,7 +45,7 @@ static struct vkms_gem_object *__vkms_gem_create(struct drm_device *dev,
 	return obj;
 }
 
-void vkms_gem_free_object(struct drm_gem_object *obj)
+static void vkms_gem_free_object(struct drm_gem_object *obj)
 {
 	struct vkms_gem_object *gem = container_of(obj, struct vkms_gem_object,
 						   gem);
@@ -42,7 +58,7 @@ void vkms_gem_free_object(struct drm_gem_object *obj)
 	kfree(gem);
 }
 
-vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
+static vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vkms_gem_object *obj = vma->vm_private_data;
@@ -97,6 +113,7 @@ vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
 	return ret;
 }
 
+
 static struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 					      struct drm_file *file,
 					      u32 *handle,
-- 
2.17.1

