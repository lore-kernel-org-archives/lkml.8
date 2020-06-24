Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD63C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B482076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHFn0H7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbgFXXDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:03:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388733AbgFXXDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593039817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3U3JCwO4VzQgWa/F4AMchtTgG5L8l0WvWQNM/P/cZc=;
        b=dHFn0H7Rh0hfYdSf3LWCrvoad1DwuLeD4BGXwNtbC9ihT4qWS6b5dT9HnTJV7uSP7e4A+5
        FE+W28wqY4qIffT+1NgS6rLbNQ4nnzpFfEdjXTxxIkmbpHOHjeMBJnzWncVlv9di7/Mcxs
        9G7+kvaZv0qSRqgX3SJo004Q6TSv218=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-gjx9PDlrPjGM0EWb1v3kuw-1; Wed, 24 Jun 2020 19:03:35 -0400
X-MC-Unique: gjx9PDlrPjGM0EWb1v3kuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302A28015F0;
        Wed, 24 Jun 2020 23:03:34 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-115-214.rdu2.redhat.com [10.10.115.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A4B71011396;
        Wed, 24 Jun 2020 23:03:31 +0000 (UTC)
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
Subject: [RFC v7 02/11] drm/vblank: Use spin_(un)lock_irq() in drm_crtc_vblank_off()
Date:   Wed, 24 Jun 2020 19:03:09 -0400
Message-Id: <20200624230318.126256-3-lyude@redhat.com>
In-Reply-To: <20200624230318.126256-1-lyude@redhat.com>
References: <20200624230318.126256-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Daniel Vetter <daniel@ffwll.ch>
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

