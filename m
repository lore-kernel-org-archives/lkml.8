Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D624AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC45B214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863597;
	bh=HIiLUUl1Nnt381tpHq0u/mo82KKiV6RswkCuL32IbWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=edEBr90n4rSnyPza5grx93BNNRHlnCBfxZ/TApBq4Xm6LgqyrBcKbBE47qY3fchsI
	 10un34H2W3uF+3w+wpv1YaysVpU1PgsYnW8qdoZRlElUYOzJtOt/m5PGOhbx2V2yvn
	 kGmKgjBmSCoc4PQU7vQ+MPx0PAYQpLH+u+yStnaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgAXK74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgAXK7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:59:55 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA292087E;
        Fri, 24 Jan 2020 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863594;
        bh=HIiLUUl1Nnt381tpHq0u/mo82KKiV6RswkCuL32IbWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/NSoIrz2Y1txfJNlvxDZtux0AAvX+yJUZ+8g4GxYmmGHSUT6bfWUVbQsQMN4l4FD
         /ARfDGr3ThFqYxTROZucHoBohZGUCvgLzgyz6UgtejtYIhfFOdQvGgMfp11a6CNgyB
         F/rIXMWcNQR9pU+W98aJfIzcDbcZzKSS5EkXrNVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/639] drm/virtio: fix bounds check in virtio_gpu_cmd_get_capset()
Date:   Fri, 24 Jan 2020 10:23:12 +0100
Message-Id: <20200124093049.979206055@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
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
index c8a581b1f4c40..608906f06cedd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -650,11 +650,11 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
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
@@ -664,6 +664,7 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
 	if (!cache_ent)
 		return -ENOMEM;
 
+	max_size = vgdev->capsets[idx].max_size;
 	cache_ent->caps_cache = kmalloc(max_size, GFP_KERNEL);
 	if (!cache_ent->caps_cache) {
 		kfree(cache_ent);
-- 
2.20.1



