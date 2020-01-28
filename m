Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB33C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D7F24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220510;
	bh=1AE2Z7je6fHaZKtxxnoogY/Y797SKVl8mnTWazMwgy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9gXSlYJm5sMJKC7QUwXX1gLCOhGAPOgOiD8WW0ygVTiKx/mjH5aYQdUwipJb2700
	 CeJGktd0AgQ67vC6Yw9mH/lrGqw5brEU+VYqXY345EYp5UMgwAD9eQTZw6tsp2vvpF
	 49/rfeq5Mq7p+UtlHauZXDWTgbE3qw3swxHXBg/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgA1OIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:08:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbgA1OIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:08:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F72E2468F;
        Tue, 28 Jan 2020 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220501;
        bh=1AE2Z7je6fHaZKtxxnoogY/Y797SKVl8mnTWazMwgy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f28UGLQbo+7lFqZ//rJbtMLEfMa1H09t9ksB4WJKB+JhGQO/5jxISC5pWV8gvIqKj
         UeMcsvMZQatVb+94JhMDD/WYhZ8xQJhVInmFqlr7yG7aVILHvvsD7oAh3CybKhL9Ds
         PCpep6pAXiil9wALsOXncZ5ydlm8jeK0uxrZeeKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 004/183] drm/virtio: fix bounds check in virtio_gpu_cmd_get_capset()
Date:   Tue, 28 Jan 2020 15:03:43 +0100
Message-Id: <20200128135829.996022414@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 09c4b49457434fa74749ad6194ef28464d9f5df9 ]

This doesn't affect runtime because in the current code "idx" is always
valid.

First, we read from "vgdev->capsets[idx].max_size" before checking
whether "idx" is within bounds.  And secondly the bounds check is off by
one so we could end up reading one element beyond the end of the
vgdev->capsets[] array.

Fixes: 62fb7a5e1096 ("virtio-gpu: add 3d/virgl support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20180704094250.m7sgvvzg3dhcvv3h@kili.mountain
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index a1b3ea1ccb65b..772a5a3b0ce1a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -681,11 +681,11 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_get_capset *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
-	int max_size = vgdev->capsets[idx].max_size;
+	int max_size;
 	struct virtio_gpu_drv_cap_cache *cache_ent;
 	void *resp_buf;
 
-	if (idx > vgdev->num_capsets)
+	if (idx >= vgdev->num_capsets)
 		return -EINVAL;
 
 	if (version > vgdev->capsets[idx].max_version)
@@ -695,6 +695,7 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	if (!cache_ent)
 		return -ENOMEM;
 
+	max_size = vgdev->capsets[idx].max_size;
 	cache_ent->caps_cache = kmalloc(max_size, GFP_KERNEL);
 	if (!cache_ent->caps_cache) {
 		kfree(cache_ent);
-- 
2.20.1



