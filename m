Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DBDC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D252082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICfvoMYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBEK0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:26:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39601 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727234AbgBEK0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580898362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ty2qopoz5uFvayM3OqAA/q+IIy2XgdQGOmBn5/Sdrz8=;
        b=ICfvoMYKQ6uXyXkZqzgEKBgkC4OhaBkclCI0oP3BOKrIEjZqgWt/JtyLCEPdw9ujubcSQw
        jZsVjvaBFqqa+5nNMwKLMzg0JAZrsOSGhFmpuO7SLSFimg+7bwqVq+UCiH+kgHG6pRM4BS
        pQrqdqwlEuxdIPKghVigO4rQ+J/B3mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-vJRFFA-wOqCyJns9a-gY-g-1; Wed, 05 Feb 2020 05:25:58 -0500
X-MC-Unique: vJRFFA-wOqCyJns9a-gY-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EB471075920;
        Wed,  5 Feb 2020 10:25:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8441E2135;
        Wed,  5 Feb 2020 10:25:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BCD69A1E0; Wed,  5 Feb 2020 11:25:52 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, olvaffe@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: ratelimit error logging
Date:   Wed,  5 Feb 2020 11:25:52 +0100
Message-Id: <20200205102552.21409-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid flooding the log in case we screw up badly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 5914e79d3429..83f22933c3bb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -212,9 +212,9 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 			if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
 				struct virtio_gpu_ctrl_hdr *cmd;
 				cmd = (struct virtio_gpu_ctrl_hdr *)entry->buf;
-				DRM_ERROR("response 0x%x (command 0x%x)\n",
-					  le32_to_cpu(resp->type),
-					  le32_to_cpu(cmd->type));
+				DRM_ERROR_RATELIMITED("response 0x%x (command 0x%x)\n",
+						      le32_to_cpu(resp->type),
+						      le32_to_cpu(cmd->type));
 			} else
 				DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
 		}
-- 
2.18.1

