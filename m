Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192FCC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54CD206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258105;
	bh=g+3Uo/aO5dluReE790lVRLnSb6yjhQw/wFQxZjqFlLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WnzJYfftyohq0Qo4AfPpJZ5SbV7YDyLLuVhaWhe9tyoIzbrH/wmIfij1jnY8unBb/
	 wKgL8hxbAUgAwutin19oeaIbk7Vh6fjtQ/ea7kEmQnzd9a5+v7XU0qgGvdWWlJ/zav
	 Bh3yjKQBR4cf13Yj1yEDndfrLoAO3tRk7tpCaEhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHXIfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgHXIe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:34:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2919206F0;
        Mon, 24 Aug 2020 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258096;
        bh=g+3Uo/aO5dluReE790lVRLnSb6yjhQw/wFQxZjqFlLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYgVfrrdOCcUT2cmUOQBn4uhNJxMT+Gts105/bRqLRTCoKfIdpR5QhGR6no5BYggy
         KY34CT7+5es7paz3fy2YQY3vscGMCG6qw8xU35/ccyYKw2hRPOriupew97NnDsOKi8
         Xbyv4YDhewlmtKj8D84S69wtnAK45lNwsLmvteiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin He <hexin.op@bytedance.com>,
        Qi Liu <liuqi.16@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 073/148] drm/virtio: fix missing dma_fence_put() in virtio_gpu_execbuffer_ioctl()
Date:   Mon, 24 Aug 2020 10:29:31 +0200
Message-Id: <20200824082417.566014766@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi.16@bytedance.com>

[ Upstream commit 8b6ec999b198b59ae61e86e70f5e9df73fe4754f ]

We should put the reference count of the fence after calling
virtio_gpu_cmd_submit(). So add the missing dma_fence_put().

Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
Co-developed-by: Xin He <hexin.op@bytedance.com>
Signed-off-by: Xin He <hexin.op@bytedance.com>
Signed-off-by: Qi Liu <liuqi.16@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20200721101647.42653-1-hexin.op@bytedance.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 5df722072ba0b..19c5bc01eb790 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -179,6 +179,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
 			      vfpriv->ctx_id, buflist, out_fence);
+	dma_fence_put(&out_fence->f);
 	virtio_gpu_notify(vgdev);
 	return 0;
 
-- 
2.25.1



