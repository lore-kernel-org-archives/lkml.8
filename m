Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD236C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93012070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq2DIMGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgEHUso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:48:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21890 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727869AbgEHUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588970920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXpdhM+rtPQWCM2nbEhmD9wSJauxBVAjYhlNi9rDAcw=;
        b=gq2DIMGN2mjiLe9FHrC1oWKuK7Qwhk6J+dtyvTZwFgjE96JKq//hGDQXeaj4HEP5W3Ovdk
        fZCIeD5w0WRPi6RzHG2SmM13N2ajXC5sU/mTRsTDzXJ09R+GQOmYwjPcKngRZubSbKpFx8
        EmeSthwLgLAXJCW603VB/9DmLndx94I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-50VqKQlfOxKcNNoYNFLF7A-1; Fri, 08 May 2020 16:48:37 -0400
X-MC-Unique: 50VqKQlfOxKcNNoYNFLF7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3612100CCC5;
        Fri,  8 May 2020 20:48:35 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-118-29.rdu2.redhat.com [10.10.118.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 649CA5D9CA;
        Fri,  8 May 2020 20:48:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
Subject: [RFC v4 03/12] drm/vblank: Register drmm cleanup action once per drm_vblank_crtc
Date:   Fri,  8 May 2020 16:46:53 -0400
Message-Id: <20200508204751.155488-4-lyude@redhat.com>
In-Reply-To: <20200508204751.155488-1-lyude@redhat.com>
References: <20200508204751.155488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we'll be allocating resources for kthread_create_worker() in the
next commit (which could fail and require us to clean up the mess),
let's simplify the cleanup process a bit by registering a
drm_vblank_init_release() action for each drm_vblank_crtc so they're
still cleaned up if we fail to initialize one of them.

Changes since v3:
* Use drmm_add_action_or_reset() - Daniel Vetter

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 758bf74e1cab..a4a9013584e2 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -491,16 +491,12 @@ static void vblank_disable_fn(struct timer_list *t)
 
 static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 {
-	unsigned int pipe;
-
-	for (pipe = 0; pipe < dev->num_crtcs; pipe++) {
-		struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
+	struct drm_vblank_crtc *vblank = ptr;
 
-		WARN_ON(READ_ONCE(vblank->enabled) &&
-			drm_core_check_feature(dev, DRIVER_MODESET));
+	WARN_ON(READ_ONCE(vblank->enabled) &&
+		drm_core_check_feature(dev, DRIVER_MODESET));
 
-		del_timer_sync(&vblank->disable_timer);
-	}
+	del_timer_sync(&vblank->disable_timer);
 }
 
 /**
@@ -510,7 +506,7 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
  *
  * This function initializes vblank support for @num_crtcs display pipelines.
  * Cleanup is handled automatically through a cleanup function added with
- * drmm_add_action().
+ * drmm_add_action_or_reset().
  *
  * Returns:
  * Zero on success or a negative error code on failure.
@@ -529,10 +525,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 
 	dev->num_crtcs = num_crtcs;
 
-	ret = drmm_add_action(dev, drm_vblank_init_release, NULL);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < num_crtcs; i++) {
 		struct drm_vblank_crtc *vblank = &dev->vblank[i];
 
@@ -541,6 +533,11 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 		init_waitqueue_head(&vblank->queue);
 		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
 		seqlock_init(&vblank->seqlock);
+
+		ret = drmm_add_action_or_reset(dev, drm_vblank_init_release,
+					       vblank);
+		if (ret)
+			return ret;
 	}
 
 	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
-- 
2.25.4

