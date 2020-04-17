Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A37C38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F4206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biMvwV/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgDQTmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58137 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgDQTmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sx8d7lrVpEcUzH6AwRgjUrQjeecIZrofUzOu/gD0BLs=;
        b=biMvwV/ew+AS3Cwvcx2wl+MU/wNJd1cO+tQ+KYjRjYwFAi0Id5veaNNNzU43vhmwNvznuX
        EY98g37if9EnxiVx2nTSZeCbXrDnYYS+KRAnv+2YBC3ql28iES5uTbt0Ap3bijSbI8N5Au
        WRw+eKRFnuOGXs1IPNMUJAnMA4xGcak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-r966xwrGNKmN8EPj32UWHA-1; Fri, 17 Apr 2020 15:42:26 -0400
X-MC-Unique: r966xwrGNKmN8EPj32UWHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFCD8149C3;
        Fri, 17 Apr 2020 19:42:24 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 025E85DA7C;
        Fri, 17 Apr 2020 19:42:23 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [RFC v3 01/11] drm/vblank: Register drmm cleanup action once per drm_vblank_crtc
Date:   Fri, 17 Apr 2020 15:40:48 -0400
Message-Id: <20200417194145.36350-2-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we'll be allocating resources for kthread_create_worker() in the
next commit (which could fail and require us to clean up the mess),
let's simplify the cleanup process a bit by registering a
drm_vblank_init_release() action for each drm_vblank_crtc so they're
still cleaned up if we fail to initialize one of them.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 758bf74e1cab..bf8de10c131f 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -491,16 +491,12 @@ static void vblank_disable_fn(struct timer_list *t)
=20
 static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 {
-	unsigned int pipe;
-
-	for (pipe =3D 0; pipe < dev->num_crtcs; pipe++) {
-		struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
+	struct drm_vblank_crtc *vblank =3D ptr;
=20
-		WARN_ON(READ_ONCE(vblank->enabled) &&
-			drm_core_check_feature(dev, DRIVER_MODESET));
+	WARN_ON(READ_ONCE(vblank->enabled) &&
+		drm_core_check_feature(dev, DRIVER_MODESET));
=20
-		del_timer_sync(&vblank->disable_timer);
-	}
+	del_timer_sync(&vblank->disable_timer);
 }
=20
 /**
@@ -529,10 +525,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned=
 int num_crtcs)
=20
 	dev->num_crtcs =3D num_crtcs;
=20
-	ret =3D drmm_add_action(dev, drm_vblank_init_release, NULL);
-	if (ret)
-		return ret;
-
 	for (i =3D 0; i < num_crtcs; i++) {
 		struct drm_vblank_crtc *vblank =3D &dev->vblank[i];
=20
@@ -541,6 +533,12 @@ int drm_vblank_init(struct drm_device *dev, unsigned=
 int num_crtcs)
 		init_waitqueue_head(&vblank->queue);
 		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
 		seqlock_init(&vblank->seqlock);
+
+		ret =3D drmm_add_action(dev, drm_vblank_init_release, vblank);
+		if (ret) {
+			del_timer_sync(&vblank->disable_timer);
+			return ret;
+		}
 	}
=20
 	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
--=20
2.25.1

