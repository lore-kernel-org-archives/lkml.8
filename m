Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE114C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BFD22B51
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fp/JJuhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgGTTHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:07:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbgGTTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595272072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PchI2xNWPaPeMD+/aLFeAV9uqsA6o3tGDxXbbP2ElkQ=;
        b=Fp/JJuhphgL11Vg2/k4UQFPlVoF7wYFOWDDdcZUZ4e5SPFv1Ebfu6r4qhAT3qlgBGlgqri
        RRIOotRa8qnxd2GVmJsPHlDUR/gblMmJ2TjKoLTVf7rq9v1J6SkwgRmxpvbUoL3NPWgVXP
        mokmHJK79jU00hUIU6/fPSxUgbRqfUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-e8gq-JDJP2u3PZqlLzi5Uw-1; Mon, 20 Jul 2020 15:07:48 -0400
X-MC-Unique: e8gq-JDJP2u3PZqlLzi5Uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A0B18C63C0;
        Mon, 20 Jul 2020 19:07:45 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-120-196.rdu2.redhat.com [10.10.120.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 850CE5C1D4;
        Mon, 20 Jul 2020 19:07:43 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] drm/vblank: Use spin_(un)lock_irq() in drm_crtc_vblank_reset()
Date:   Mon, 20 Jul 2020 15:07:32 -0400
Message-Id: <20200720190736.180297-2-lyude@redhat.com>
In-Reply-To: <20200720190736.180297-1-lyude@redhat.com>
References: <20200720190736.180297-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the drivers in the kernel tree only call this from one of the
following contexts:

* drm_crtc_funcs->reset
* During initial module load

Since both of these contexts are guaranteed to have interrupts enabled
beforehand, there's no need to use the irqsave/irqrestore variants of
spin_(un)lock(). So, fix this to make the irq context of this function
more obvious.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_vblank.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f402c75b9d343..6af78aecea9d4 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1363,11 +1363,10 @@ EXPORT_SYMBOL(drm_crtc_vblank_off);
 void drm_crtc_vblank_reset(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
-	unsigned long irqflags;
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 
-	spin_lock_irqsave(&dev->vbl_lock, irqflags);
+	spin_lock_irq(&dev->vbl_lock);
 	/*
 	 * Prevent subsequent drm_vblank_get() from enabling the vblank
 	 * interrupt by bumping the refcount.
@@ -1376,7 +1375,7 @@ void drm_crtc_vblank_reset(struct drm_crtc *crtc)
 		atomic_inc(&vblank->refcount);
 		vblank->inmodeset = 1;
 	}
-	spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
+	spin_unlock_irq(&dev->vbl_lock);
 
 	drm_WARN_ON(dev, !list_empty(&dev->vblank_event_list));
 	drm_WARN_ON(dev, !list_empty(&vblank->pending_work));
-- 
2.26.2

