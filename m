Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEF920675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKbpLqiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgBNIBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:01:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728691AbgBNIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581667267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=40VP33gu2neJNp1TOhQHNjH0xuCUDhYDqToHmrgnVbw=;
        b=gKbpLqiOLPXtuTac+KNpaHJlib9edfPGLSecMVL+fbUhmHG6l3AilDykeeFLqjULi1Izmx
        QpOMYJ76ioxmFFwyk4KYQYOyiawIOaNPcRTOlTf8019y07uw78oYt4/tes7UArv8owrplG
        UzTeOWJ6Lps+VWif+ixwQFKrO4Rf7dE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-CvIYS2qUOgyUWJS3UebuyA-1; Fri, 14 Feb 2020 03:01:06 -0500
X-MC-Unique: CvIYS2qUOgyUWJS3UebuyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD1113E2;
        Fri, 14 Feb 2020 08:01:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com [10.36.117.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3391988854;
        Fri, 14 Feb 2020 08:01:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6DEC3939B; Fri, 14 Feb 2020 09:01:00 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, cohuck@redhat.com, smitterl@redhat.com,
        gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: fix error check
Date:   Fri, 14 Feb 2020 09:01:00 +0100
Message-Id: <20200214080100.1273-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The >= compare op must happen in cpu byte order, doing it in
little endian fails on big endian machines like s390.

Reported-by: Sebastian Mitterle <smitterl@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index cfe9c54f87a3..67caecde623e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -222,7 +222,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 		trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp);
 
 		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
-			if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
+			if (le32_to_cpu(resp->type) >= VIRTIO_GPU_RESP_ERR_UNSPEC) {
 				struct virtio_gpu_ctrl_hdr *cmd;
 				cmd = virtio_gpu_vbuf_ctrl_hdr(entry);
 				DRM_ERROR_RATELIMITED("response 0x%x (command 0x%x)\n",
-- 
2.18.2

