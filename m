Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0603C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98542054F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRMoRvwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHRJU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgHRJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597742425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pw595Aj/46zo0ERIuwv1IEbY3YqPvqwxwOPHQJVu1hs=;
        b=DRMoRvwBOcGztbVwu+eEgBW+nXmWahSH4wAchDFCQZ5RyARCuu3PKoYsO9baowsfZWQqB7
        kU+CXU8txbE4zAWtir1RfkCNVzTH7Iz0Z167lOD80W/993tO32WSG+hptGNkL1FOM9ViLJ
        jDFPWll2P140x4WC4zBppHlXfU3DV+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-6GGjtExdPOycVoy0rIiN8w-1; Tue, 18 Aug 2020 05:20:24 -0400
X-MC-Unique: 6GGjtExdPOycVoy0rIiN8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE0451007465;
        Tue, 18 Aug 2020 09:20:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 203131001901;
        Tue, 18 Aug 2020 09:20:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4BEEB9AE3; Tue, 18 Aug 2020 11:20:18 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     christian.koenig@amd.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/virtio: set max_segment
Date:   Tue, 18 Aug 2020 11:20:17 +0200
Message-Id: <20200818092017.26290-3-kraxel@redhat.com>
In-Reply-To: <20200818092017.26290-1-kraxel@redhat.com>
References: <20200818092017.26290-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initializing call virtio_max_dma_size() to figure the scatter list
limit.  Needed to make virtio-gpu work properly with SEV.

v2: place max_segment in drm driver not gem object.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index bf060c69850f..5a4364c00fae 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -114,6 +114,7 @@ int virtio_gpu_init(struct drm_device *dev)
 
 	vgdev->ddev = dev;
 	dev->dev_private = vgdev;
+	dev->max_segment = virtio_max_dma_size(vgdev->vdev);
 	vgdev->vdev = dev_to_virtio(dev->dev);
 	vgdev->dev = dev->dev;
 
-- 
2.18.4

