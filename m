Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F6C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A5D22BEF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQcxVpFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgGTTHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:07:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54984 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728766AbgGTTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595272072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zurpX8t5Oe22ZRXjmmq6bc4/JlbLHckZjRUTW5w4qAk=;
        b=DQcxVpFDr/WLjSYWMoxmVxyYVeDFcGfy6/Dt8cagfQUBDeXKhae8N16hFT6mw0Fa7aj4Nu
        zQEWsCHf4NvZOLrOJRoUt1/1CgR2rX2Dguc20Xu9xJxb5/pTQEk80c4K86PA5aGnwiFKx6
        ImRurjPimzeIqJy5pARyAo7H/BFcvGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-x33gDq3ePcmvY2Y9hhPL9Q-1; Mon, 20 Jul 2020 15:07:48 -0400
X-MC-Unique: x33gDq3ePcmvY2Y9hhPL9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39B038005B0;
        Mon, 20 Jul 2020 19:07:47 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-120-196.rdu2.redhat.com [10.10.120.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0A6B5C22A;
        Mon, 20 Jul 2020 19:07:45 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] drm/vblank: Use spin_(un)lock_irq() in drm_crtc_vblank_on()
Date:   Mon, 20 Jul 2020 15:07:33 -0400
Message-Id: <20200720190736.180297-3-lyude@redhat.com>
In-Reply-To: <20200720190736.180297-1-lyude@redhat.com>
References: <20200720190736.180297-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only called from:
* Atomic modesetting hooks
* Module probing routines
* Legacy modesetting hooks

All of which have IRQs enabled, so we can also get rid of
irqsave/restore here to make the IRQ context of this function more
obvious.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_vblank.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 6af78aecea9d4..9891e82939e35 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1428,12 +1428,11 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc)
 	struct drm_device *dev = crtc->dev;
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
-	unsigned long irqflags;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return;
 
-	spin_lock_irqsave(&dev->vbl_lock, irqflags);
+	spin_lock_irq(&dev->vbl_lock);
 	drm_dbg_vbl(dev, "crtc %d, vblank enabled %d, inmodeset %d\n",
 		    pipe, vblank->enabled, vblank->inmodeset);
 
@@ -1451,7 +1450,7 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc)
 	 */
 	if (atomic_read(&vblank->refcount) != 0 || drm_vblank_offdelay == 0)
 		drm_WARN_ON(dev, drm_vblank_enable(dev, pipe));
-	spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
+	spin_unlock_irq(&dev->vbl_lock);
 }
 EXPORT_SYMBOL(drm_crtc_vblank_on);
 
-- 
2.26.2

