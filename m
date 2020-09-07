Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EDFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287FC21582
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL3o6MyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIGGdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:33:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35485 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbgIGGdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599460432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17hx+uQnRYN37kt9J2TS1rwaCj5ZQT0lilbznWEFqTQ=;
        b=fL3o6MyIcQsBrTwrd+aE403ajYSyNlvZYCDwbE+xFspZeP39onyqwmrzM+FlcnauDV4n3H
        I3xoFhfgsxD+Lc2Ko+bFSNPu0pVB7pv1x+JDEgn0ngVzXRUnw69ZKCPtOQH6xB/pXu6QoE
        CG27XknfRnjQz0UMxYNVEP1mkbV397M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-AZ6I_DA3P3amXemm0ORAjA-1; Mon, 07 Sep 2020 02:33:50 -0400
X-MC-Unique: AZ6I_DA3P3amXemm0ORAjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74DC480046B;
        Mon,  7 Sep 2020 06:33:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7101E805E0;
        Mon,  7 Sep 2020 06:33:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8C06F204A1; Mon,  7 Sep 2020 08:33:44 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     christian.koenig@amd.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] drm/virtio: set max_segment
Date:   Mon,  7 Sep 2020 08:33:43 +0200
Message-Id: <20200907063343.18097-3-kraxel@redhat.com>
In-Reply-To: <20200907063343.18097-1-kraxel@redhat.com>
References: <20200907063343.18097-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 75d0dc2f6d28..151471acdfcf 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -167,6 +167,7 @@ int virtio_gpu_init(struct drm_device *dev)
 		DRM_ERROR("failed to alloc vbufs\n");
 		goto err_vbufs;
 	}
+	dev->max_segment = virtio_max_dma_size(vgdev->vdev);
 
 	/* get display info */
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
-- 
2.27.0

