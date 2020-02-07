Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577BAC352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B12E20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLIhQ+mY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgBGMNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:13:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31674 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgBGMNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581077602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aOOYqVPrj4S2St31AUk2Ye43S8BIUm6kjTFmGx5Z+/A=;
        b=WLIhQ+mY3zLrfH5TZB0DndJ27dbNoHT8mqzT+nRKEcAY7gew8Mfd6sjzi9DqMCsTSnI9hH
        zFkpT+59ukBr5SDel66+GRihZudfaPudOA2G229sRhTaZWsdw8wb2aiz6fs4fOHaOICsRO
        gaZPYuwtKxlp3w2di6KvlFVxJyOP6z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-drYNRWgjMKmihOmabsGQuw-1; Fri, 07 Feb 2020 07:13:17 -0500
X-MC-Unique: drYNRWgjMKmihOmabsGQuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A051088397;
        Fri,  7 Feb 2020 12:13:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 978D9790F2;
        Fri,  7 Feb 2020 12:13:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C03591747D; Fri,  7 Feb 2020 13:13:12 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/bochs: add drm_driver.release callback.
Date:   Fri,  7 Feb 2020 13:13:12 +0100
Message-Id: <20200207121312.25296-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gurchetan Singh <gurchetansingh@chromium.org>

Move bochs_unload call from bochs_remove() to the new bochs_release()
callback.  Also call drm_dev_unregister() first in bochs_remove().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 10460878414e..87ee1eb21a4d 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -60,6 +60,11 @@ static int bochs_load(struct drm_device *dev)
 
 DEFINE_DRM_GEM_FOPS(bochs_fops);
 
+static void bochs_release(struct drm_device *dev)
+{
+	bochs_unload(dev);
+}
+
 static struct drm_driver bochs_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &bochs_fops,
@@ -69,6 +74,7 @@ static struct drm_driver bochs_driver = {
 	.major			= 1,
 	.minor			= 0,
 	DRM_GEM_VRAM_DRIVER,
+	.release                = bochs_release,
 };
 
 /* ---------------------------------------------------------------------- */
@@ -148,9 +154,8 @@ static void bochs_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
-	drm_atomic_helper_shutdown(dev);
 	drm_dev_unregister(dev);
-	bochs_unload(dev);
+	drm_atomic_helper_shutdown(dev);
 	drm_dev_put(dev);
 }
 
-- 
2.18.1

