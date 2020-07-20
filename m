Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345ABC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104C822B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys6/60If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgGTTIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:08:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729027AbgGTTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595272073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8JGw1vp/HeS7n74dHX0UW8Z7hcMVJHzFu7NPlVByPJI=;
        b=Ys6/60IfpPWzisoqjUKpjqTbOwh8IpuLX3hYUVzuKm9lMDTo1Ul/PGBvOsDzEAvZRo03Cw
        yjoIWUFyYnWLJShx1jJehtth1mJ1AXhVB0WxZ98VqOl9uehdXUIotspBB4rFdle6cOO0OJ
        2Kg3jnnyjPeNxBnWqZ7wwcxZ0Oe1JBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45--93WF80dNeGefZDqPZf9ZA-1; Mon, 20 Jul 2020 15:07:51 -0400
X-MC-Unique: -93WF80dNeGefZDqPZf9ZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B011E107ACCA;
        Mon, 20 Jul 2020 19:07:49 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-120-196.rdu2.redhat.com [10.10.120.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA4745C22A;
        Mon, 20 Jul 2020 19:07:48 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] drm/vblank: Use spin_(un)lock_irq() in drm_queue_vblank_event()
Date:   Mon, 20 Jul 2020 15:07:35 -0400
Message-Id: <20200720190736.180297-5-lyude@redhat.com>
In-Reply-To: <20200720190736.180297-1-lyude@redhat.com>
References: <20200720190736.180297-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one's easy - we're already calling kzalloc() in this function, so
we must already be guaranteed to have IRQs enabled when calling this.
So, use the plain _irq() variants of spin_(un)lock() to make this more
obvious.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_vblank.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 51f2e988205e7..64610070ba473 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1611,7 +1611,6 @@ static int drm_queue_vblank_event(struct drm_device *dev, unsigned int pipe,
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	struct drm_pending_vblank_event *e;
 	ktime_t now;
-	unsigned long flags;
 	u64 seq;
 	int ret;
 
@@ -1633,7 +1632,7 @@ static int drm_queue_vblank_event(struct drm_device *dev, unsigned int pipe,
 			e->event.vbl.crtc_id = crtc->base.id;
 	}
 
-	spin_lock_irqsave(&dev->event_lock, flags);
+	spin_lock_irq(&dev->event_lock);
 
 	/*
 	 * drm_crtc_vblank_off() might have been called after we called
@@ -1670,12 +1669,12 @@ static int drm_queue_vblank_event(struct drm_device *dev, unsigned int pipe,
 		vblwait->reply.sequence = req_seq;
 	}
 
-	spin_unlock_irqrestore(&dev->event_lock, flags);
+	spin_unlock_irq(&dev->event_lock);
 
 	return 0;
 
 err_unlock:
-	spin_unlock_irqrestore(&dev->event_lock, flags);
+	spin_unlock_irq(&dev->event_lock);
 	kfree(e);
 err_put:
 	drm_vblank_put(dev, pipe);
-- 
2.26.2

