Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC676C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6022067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSmuDJeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgF0TrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 15:47:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36379 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbgF0TrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 15:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593287232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06AlwKVkuVI6ElbE+J2x+1IfIbX5X762VJ0OLmfYmJ4=;
        b=VSmuDJeIuzVB2kawvDBAoIDSbMVy1LZRqs+7ZNXrAtKlUc4GTXusTBrilIXxq5oigX4pl+
        2XVLQEWG3OPrQ1B+rhY2Zur5AKiqgZcfQ3i58/f4l2tdWICJPp9Fv5lgSXnagJzazmz2aO
        gpAYLStPfkVCLkkmHsrZU/t7TUZKO1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-arU-Ip_dOiihnId6YAtiWA-1; Sat, 27 Jun 2020 15:47:08 -0400
X-MC-Unique: arU-Ip_dOiihnId6YAtiWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90E90464;
        Sat, 27 Jun 2020 19:47:06 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-112-223.rdu2.redhat.com [10.10.112.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C65A7930D;
        Sat, 27 Jun 2020 19:47:05 +0000 (UTC)
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
Subject: [RFC v8 2/9] drm/vblank: Use spin_(un)lock_irq() in drm_crtc_vblank_off()
Date:   Sat, 27 Jun 2020 15:46:50 -0400
Message-Id: <20200627194657.156514-3-lyude@redhat.com>
In-Reply-To: <20200627194657.156514-1-lyude@redhat.com>
References: <20200627194657.156514-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This got me confused for a bit while looking over this code: I had been
planning on adding some blocking function calls into this function, but
seeing the irqsave/irqrestore variants of spin_(un)lock() didn't make it
very clear whether or not that would actually be safe.

So I went ahead and reviewed every single driver in the kernel that uses
this function, and they all fall into three categories:

* Driver probe code
* ->atomic_disable() callbacks
* Legacy modesetting callbacks

All of these will be guaranteed to have IRQs enabled, which means it's
perfectly safe to block here. Just to make things a little less
confusing to others in the future, let's switch over to
spin_lock_irq()/spin_unlock_irq() to make that fact a little more
obvious.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_vblank.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index ce5c1e1d29963..e895f5331fdb4 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1283,13 +1283,12 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 	struct drm_pending_vblank_event *e, *t;
 
 	ktime_t now;
-	unsigned long irqflags;
 	u64 seq;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return;
 
-	spin_lock_irqsave(&dev->event_lock, irqflags);
+	spin_lock_irq(&dev->event_lock);
 
 	spin_lock(&dev->vbl_lock);
 	drm_dbg_vbl(dev, "crtc %d, vblank enabled %d, inmodeset %d\n",
@@ -1325,7 +1324,7 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 		drm_vblank_put(dev, pipe);
 		send_vblank_event(dev, e, seq, now);
 	}
-	spin_unlock_irqrestore(&dev->event_lock, irqflags);
+	spin_unlock_irq(&dev->event_lock);
 
 	/* Will be reset by the modeset helpers when re-enabling the crtc by
 	 * calling drm_calc_timestamping_constants(). */
-- 
2.26.2

