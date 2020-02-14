Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F52C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A20524673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxGzfTXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBNMzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:55:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729122AbgBNMzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581684945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=0EViE0wdsGxj6jnigZu403igKjitlwATYN0MZ2nBE3E=;
        b=OxGzfTXMblHSEU+r7f4Xq5ME1bvHq65KnuFOm+sao6E1olLNUdwXGgUvoAOrsHmvuGQhWp
        RrwpL02D7Z+s76qQYH9BIIuCqQvtKEDqRmzACjPSXVHGfn3dlfpqHAhEVeEum7x15tRv0E
        rgmvagw/BdQ5sLQmxVAw5fx+KQvcTZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-ZJYz2DlcNketE3rccRhlcQ-1; Fri, 14 Feb 2020 07:55:41 -0500
X-MC-Unique: ZJYz2DlcNketE3rccRhlcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB938107B26F;
        Fri, 14 Feb 2020 12:55:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com [10.36.117.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE3960BE2;
        Fri, 14 Feb 2020 12:55:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 85187939B; Fri, 14 Feb 2020 13:55:35 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, olvaffe@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/6] drm/virtio: notify before waiting
Date:   Fri, 14 Feb 2020 13:55:31 +0100
Message-Id: <20200214125535.26349-3-kraxel@redhat.com>
In-Reply-To: <20200214125535.26349-1-kraxel@redhat.com>
References: <20200214125535.26349-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we are going to wait for virtqueue entries becoming available
call virtio_gpu_notify() to make sure the host has seen everything
we've submitted.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6cc259cfa517..653efb26bcd9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -346,6 +346,7 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 
 	if (vq->num_free < elemcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
+		virtio_gpu_notify(vgdev);
 		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
 		goto again;
 	}
-- 
2.18.2

