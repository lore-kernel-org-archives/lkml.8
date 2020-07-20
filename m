Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC05C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D80822B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="sOlzDOWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgGTOpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:45:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36205C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:45:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 1so9152759pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3fAHcvVg4jnZtoaiivjfSSE8o0hNzpTD9CyVyYtzCQ=;
        b=sOlzDOWuF+3RlEwNt2F5CrcNZqj5ddpZi3faZ9Bj9LGVNS+/HCg4ITjur/s9KGE8Um
         EErcgyT0YlA/Vt27osM+RlWCRgnYCvOrQ4GBds6LxWSoJswfyVQlYLuQQF68Dnlzhh/N
         R5CGaKX23fe1yNWLrh5YvObKYO5WeaPhCwMYmozzfak8l+EpGDYvzvQuF63JZrikisuH
         t2WnZ2wHL5+DY+e3BM/WH3zvaVAgJ9zjG/bN4CyIVFyvC8agiGULf1HyIpIdADzX9Ynj
         DqpxiUkonBkuuVA5KnJj8zC2eJ2/k5gQw5WXImWBYghWgRi1nRfPXZ1n3fOvYnehUEz7
         56BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3fAHcvVg4jnZtoaiivjfSSE8o0hNzpTD9CyVyYtzCQ=;
        b=eTtXCNl0lKWYoSxnK+SWF0UyYzBS58ttbrXnC4EFkZ1rOKu6NQ2AlteRyAvm4wKozU
         irmYFo34fB5SD7x6PyR45nyhGzCjMeTPKA/evbmX9/vcHfRZzzZIpcVSQq3+tdNWTDfm
         /cXo6Zv8m3MM5AIEpAVOwDmtYkiJyGe7h8n1LoRTG1nv520YrSRw0c/SFkakFF+vWw1r
         sXmuWa0v9zsWYaVOoCugZ94lUavd63a9Kx3oIJt6Pc27mIrzoJlqyhIXW0eqLta8HzDV
         cFLBxNeUhDRXLJp9LDqWArDwhhvrBvPnt6gSxspZU77iG1EtdV+cS1iTb3trKFvpZYYO
         pTlw==
X-Gm-Message-State: AOAM530hT1j6YAF4LqPVeIIXFwVI38/58QFwKxZmrNXa2uvUOuBqDD5w
        WJfeChz0YMcqb7ugTT6YSl4s9Q==
X-Google-Smtp-Source: ABdhPJwRAonkAHS7pUDdFtQUFZnVnmqFela2Z+QxFm1cKeXlzbDX3rdGvU5oZ7BhRlEbOXhoueAOmA==
X-Received: by 2002:a63:7e55:: with SMTP id o21mr19414072pgn.263.1595256305771;
        Mon, 20 Jul 2020 07:45:05 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.73])
        by smtp.gmail.com with ESMTPSA id t13sm11951338pjs.17.2020.07.20.07.45.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 07:45:04 -0700 (PDT)
From:   hexin <hexin.op@bytedance.com>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        christian.koenig@amd.com, daniel@ffwll.ch, airlied@linux.ie,
        kraxel@redhat.com, Markus.Elfring@web.de, sumit.semwal@linaro.org
Cc:     linux-kernel@vger.kernel.org, hexin <hexin.op@bytedance.com>,
        Liu Qi <liuqi.16@bytedance.com>
Subject: [PATCH v2] drm/virtio: fixed memory leak in virtio_gpu_execbuffer_ioctl()
Date:   Mon, 20 Jul 2020 22:44:07 +0800
Message-Id: <20200720144407.13706-1-hexin.op@bytedance.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2cd7b6f08bc4 ("drm/virtio: add in/out fence support
for explicit synchronization") deleted dma_fence_put(),
which will cause the memory leak. To balance the reference
count initialized when allocating fence, dma_fence_put()
should not be deleted.

Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
Signed-off-by: Liu Qi <liuqi.16@bytedance.com>
Signed-off-by: hexin <hexin.op@bytedance.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 5df722072ba0..19c5bc01eb79 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -179,6 +179,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
 			      vfpriv->ctx_id, buflist, out_fence);
+	dma_fence_put(&out_fence->f);
 	virtio_gpu_notify(vgdev);
 	return 0;
 
-- 
2.21.1 (Apple Git-122.3)

