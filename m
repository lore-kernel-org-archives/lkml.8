Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C30EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EB720674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgCLTTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:19:10 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:42804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbgCLTTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:19:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2162F1800EC2E;
        Thu, 12 Mar 2020 19:19:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tank01_6c88f0addf926
X-Filterd-Recvd-Size: 2400
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 19:19:05 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm: drm_vm: Use fallthrough;
Date:   Thu, 12 Mar 2020 12:17:12 -0700
Message-Id: <398db73cdc8a584fd7f34f5013c04df13ba90f64.1584040050.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1584040050.git.joe@perches.com>
References: <cover.1584040050.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert /* fallthrough */ style comments to fallthrough;

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

And by hand:

This file has a fallthrough comment outside of an #ifdef block
that causes gcc to emit a warning if converted in-place.

So move the new fallthrough; inside the containing #ifdef/#endif too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/drm_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index 64619f..fd65c59 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -595,8 +595,8 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
 			vma->vm_ops = &drm_vm_ops;
 			break;
 		}
+		fallthrough;	/* to _DRM_FRAME_BUFFER... */
 #endif
-		/* fall through - to _DRM_FRAME_BUFFER... */
 	case _DRM_FRAME_BUFFER:
 	case _DRM_REGISTERS:
 		offset = drm_core_get_reg_ofs(dev);
@@ -621,7 +621,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
 		    vma->vm_end - vma->vm_start, vma->vm_page_prot))
 			return -EAGAIN;
 		vma->vm_page_prot = drm_dma_prot(map->type, vma);
-		/* fall through - to _DRM_SHM */
+		fallthrough;	/* to _DRM_SHM */
 	case _DRM_SHM:
 		vma->vm_ops = &drm_vm_shm_ops;
 		vma->vm_private_data = (void *)map;
-- 
2.24.0

