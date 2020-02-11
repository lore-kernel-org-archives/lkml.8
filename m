Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756BBC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC712173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2WJVxmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgBKNzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:55:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgBKNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581429329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=LiI8OXeqApXKVycGwDYh1aLBwvgIFPPVhBrhusiyeE4=;
        b=H2WJVxmPqDGbqr/ts4Av1Bf5MhBoIqPL4ROSUQ7vyc4FAfBAEvnQaHTjGmmNtO6O+7uZK+
        /XR1ISbpBhCT+ADvXYSmTWTYWLQ3LtmgStrJ0pC1RXGneVzr0ouGOtKrvnebef9YbVJp/e
        aFFzMNXyLmP2hkTy0ExZMUMh52zK6dU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-XXjEI8eUMeeF-aIDrc7KMg-1; Tue, 11 Feb 2020 08:55:27 -0500
X-MC-Unique: XXjEI8eUMeeF-aIDrc7KMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70085801E6C;
        Tue, 11 Feb 2020 13:55:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3252F60BF1;
        Tue, 11 Feb 2020 13:55:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 219DB17447; Tue, 11 Feb 2020 14:55:22 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] drm/cirrus: add drm_driver.release callback.
Date:   Tue, 11 Feb 2020 14:55:22 +0100
Message-Id: <20200211135522.23654-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move final cleanups from cirrus_pci_remove() to the new callback.
Add drm_atomic_helper_shutdown() call to cirrus_pci_remove().

Use drm_dev_{enter,exit,unplug} to avoid touching hardware after
device removal.

v4: add changelog.
v3: use drm_dev*.
v2: stop touching hardware after pci_remove().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus.c | 43 ++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index a91fb0d7282c..d2ff63ce8eaf 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -151,9 +151,13 @@ static int cirrus_pitch(struct drm_framebuffer *fb)
 
 static void cirrus_set_start_address(struct cirrus_device *cirrus, u32 offset)
 {
+	int idx;
 	u32 addr;
 	u8 tmp;
 
+	if (!drm_dev_enter(&cirrus->dev, &idx))
+		return;
+
 	addr = offset >> 2;
 	wreg_crt(cirrus, 0x0c, (u8)((addr >> 8) & 0xff));
 	wreg_crt(cirrus, 0x0d, (u8)(addr & 0xff));
@@ -168,6 +172,8 @@ static void cirrus_set_start_address(struct cirrus_device *cirrus, u32 offset)
 	tmp &= 0x7f;
 	tmp |= (addr >> 12) & 0x80;
 	wreg_crt(cirrus, 0x1d, tmp);
+
+	drm_dev_exit(idx);
 }
 
 static int cirrus_mode_set(struct cirrus_device *cirrus,
@@ -176,9 +182,12 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 {
 	int hsyncstart, hsyncend, htotal, hdispend;
 	int vtotal, vdispend;
-	int tmp;
+	int tmp, idx;
 	int sr07 = 0, hdr = 0;
 
+	if (!drm_dev_enter(&cirrus->dev, &idx))
+		return -1;
+
 	htotal = mode->htotal / 8;
 	hsyncend = mode->hsync_end / 8;
 	hsyncstart = mode->hsync_start / 8;
@@ -264,6 +273,7 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 		hdr = 0xc5;
 		break;
 	default:
+		drm_dev_exit(idx);
 		return -1;
 	}
 
@@ -292,6 +302,8 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 
 	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
 	outb(0x20, 0x3c0);
+
+	drm_dev_exit(idx);
 	return 0;
 }
 
@@ -300,10 +312,16 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 {
 	struct cirrus_device *cirrus = fb->dev->dev_private;
 	void *vmap;
+	int idx, ret;
 
+	ret = -ENODEV;
+	if (!drm_dev_enter(&cirrus->dev, &idx))
+		goto out;
+
+	ret = -ENOMEM;
 	vmap = drm_gem_shmem_vmap(fb->obj[0]);
 	if (!vmap)
-		return -ENOMEM;
+		goto out_dev_exit;
 
 	if (cirrus->cpp == fb->format->cpp[0])
 		drm_fb_memcpy_dstclip(cirrus->vram,
@@ -323,7 +341,12 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 		WARN_ON_ONCE("cpp mismatch");
 
 	drm_gem_shmem_vunmap(fb->obj[0], vmap);
-	return 0;
+	ret = 0;
+
+out_dev_exit:
+	drm_dev_exit(idx);
+out:
+	return ret;
 }
 
 static int cirrus_fb_blit_fullscreen(struct drm_framebuffer *fb)
@@ -502,6 +525,14 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
 /* ------------------------------------------------------------------ */
 
+static void cirrus_release(struct drm_device *dev)
+{
+	struct cirrus_device *cirrus = dev->dev_private;
+
+	drm_mode_config_cleanup(dev);
+	kfree(cirrus);
+}
+
 DEFINE_DRM_GEM_FOPS(cirrus_fops);
 
 static struct drm_driver cirrus_driver = {
@@ -515,6 +546,7 @@ static struct drm_driver cirrus_driver = {
 
 	.fops		 = &cirrus_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
+	.release         = cirrus_release,
 };
 
 static int cirrus_pci_probe(struct pci_dev *pdev,
@@ -598,12 +630,11 @@ static void cirrus_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct cirrus_device *cirrus = dev->dev_private;
 
-	drm_dev_unregister(dev);
-	drm_mode_config_cleanup(dev);
+	drm_dev_unplug(dev);
+	drm_atomic_helper_shutdown(dev);
 	iounmap(cirrus->mmio);
 	iounmap(cirrus->vram);
 	drm_dev_put(dev);
-	kfree(cirrus);
 	pci_release_regions(pdev);
 }
 
-- 
2.18.2

