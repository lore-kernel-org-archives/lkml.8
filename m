Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67653C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F920767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSMd8vBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgFVUID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:08:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728307AbgFVUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592856482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lSAb/eseSEs/+a9Bniw5lJiSCdPpLF6HO9i3q2ob+7o=;
        b=VSMd8vBlhchYnlBQMSRcY32KLu5ADBJqf3fS66anXUP8QF0l72K+Z1GqUmssPbpp1JQnA3
        e/4aZvzy98dY84A5fGJL154hO6GDM+qpTbCNFdaPxelb8BYOpkRCMbzH4tr4BjE25uiWPq
        NDWWk6KC96oG3MMTT58OxLfD/94sh7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-n7C1-OBbOuaTO5iqvTMmYg-1; Mon, 22 Jun 2020 16:07:58 -0400
X-MC-Unique: n7C1-OBbOuaTO5iqvTMmYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED5A18A8221;
        Mon, 22 Jun 2020 20:07:56 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-117-166.rdu2.redhat.com [10.10.117.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 046A95C1BD;
        Mon, 22 Jun 2020 20:07:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v5 01/10] drm/vblank: Register drmm cleanup action once per drm_vblank_crtc
Date:   Mon, 22 Jun 2020 16:07:21 -0400
Message-Id: <20200622200730.120716-2-lyude@redhat.com>
In-Reply-To: <20200622200730.120716-1-lyude@redhat.com>
References: <20200622200730.120716-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index 85e5f2db16085..ce5c1e1d29963 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -492,16 +492,12 @@ static void vblank_disable_fn(struct timer_list *t)
 
 static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 {
-	unsigned int pipe;
-
-	for (pipe = 0; pipe < dev->num_crtcs; pipe++) {
-		struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
+	struct drm_vblank_crtc *vblank = ptr;
 
-		drm_WARN_ON(dev, READ_ONCE(vblank->enabled) &&
-			    drm_core_check_feature(dev, DRIVER_MODESET));
+	drm_WARN_ON(dev, READ_ONCE(vblank->enabled) &&
+		    drm_core_check_feature(dev, DRIVER_MODESET));
 
-		del_timer_sync(&vblank->disable_timer);
-	}
+	del_timer_sync(&vblank->disable_timer);
 }
 
 /**
@@ -511,7 +507,7 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
  *
  * This function initializes vblank support for @num_crtcs display pipelines.
  * Cleanup is handled automatically through a cleanup function added with
- * drmm_add_action().
+ * drmm_add_action_or_reset().
  *
  * Returns:
  * Zero on success or a negative error code on failure.
@@ -530,10 +526,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 
 	dev->num_crtcs = num_crtcs;
 
-	ret = drmm_add_action(dev, drm_vblank_init_release, NULL);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < num_crtcs; i++) {
 		struct drm_vblank_crtc *vblank = &dev->vblank[i];
 
@@ -542,6 +534,11 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 		init_waitqueue_head(&vblank->queue);
 		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
 		seqlock_init(&vblank->seqlock);
+
+		ret = drmm_add_action_or_reset(dev, drm_vblank_init_release,
+					       vblank);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.26.2

