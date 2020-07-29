Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B31C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83636207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzOzn234"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgG2Vh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:37:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28169 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbgG2VhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596058642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrUnfRcbB8TeX4xq00PXZWnFqDspEOmAntW7u0EIgTs=;
        b=HzOzn234xBuczfnEfRJoJjh7TOdrNEpLV74BxFzQZpL8OJ6OsgB6TtOJRoXQ+p+AXOzyYQ
        GlkGlk+l5TyZN+mMq0S55MLpztDD0B6iaOMU8HchI9O3HlGcMXWZ2Ubjn0jzxRvJq5iVTc
        jsZKD7pO9Lnd/ZfZnBoQoNOAAOQDYw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-czHsmebpMZmpc-6H9BMHLA-1; Wed, 29 Jul 2020 17:37:18 -0400
X-MC-Unique: czHsmebpMZmpc-6H9BMHLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AE0B801E6A;
        Wed, 29 Jul 2020 21:37:17 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-146.rdu2.redhat.com [10.10.119.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 046D161176;
        Wed, 29 Jul 2020 21:37:15 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/9] drm/nouveau/kms: Use pm_runtime_put_autosuspend() in hpd_work
Date:   Wed, 29 Jul 2020 17:37:00 -0400
Message-Id: <20200729213703.119137-7-lyude@redhat.com>
In-Reply-To: <20200729213703.119137-1-lyude@redhat.com>
References: <20200729213703.119137-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again, we don't have any need to suspend the device synchronously here,
and doing so could in theory lead to a deadlock (although it's unlikely
since we've called pm_runtime_mark_last_busy() before-hand).

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 63c58f12458c9..cdc5a2200f95e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -444,7 +444,7 @@ nouveau_display_hpd_work(struct work_struct *work)
 	drm_helper_hpd_irq_event(drm->dev);
 
 	pm_runtime_mark_last_busy(drm->dev->dev);
-	pm_runtime_put_sync(drm->dev->dev);
+	pm_runtime_put_autosuspend(drm->dev->dev);
 }
 
 #ifdef CONFIG_ACPI
-- 
2.26.2

