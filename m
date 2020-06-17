Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD91B21548
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592430708;
	bh=hrwO+kM2wjdv4ncpwZvo+b5b3WHUo+MGuqTylhXVPl0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cy3hD0SgMxFWonRCaWZkDlMz622rAwBSVlx/DdtZcujVnFUhcpWcyOqf8knJlact3
	 ToQUOhMR/UgAYZpXx9MMt9984tsqs0LxFoMmbTbAE/KQMUUwbcNOE44Ij9epmgtBJV
	 xh/ZXvTFgPluxGp9fRfzyAYP1LVbBiGF6v7mLT2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFQVvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgFQVvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:51:47 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF01206E2;
        Wed, 17 Jun 2020 21:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592430706;
        bh=hrwO+kM2wjdv4ncpwZvo+b5b3WHUo+MGuqTylhXVPl0=;
        h=Date:From:To:Cc:Subject:From;
        b=wOvVB9WRLIrXD8MQwrapjXinSs4LiDjJ7u55Xp+IoiyLP2GO8SLUdrW6D5I3MgKA1
         LsJQNuCBi7vqBj//p7VGZfp22VxRulyVkV1e6ItN96ebmCyA0o8VCIbZZg4odtpM2s
         cpnan2bw7kAgVz0oxEU9boM+CRm/i7ekGT8Ygcxs=
Date:   Wed, 17 Jun 2020 16:57:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] drm/virtio: Use struct_size() helper in kmalloc()
Message-ID: <20200617215707.GA16785@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 24ffacac99e4..c30c75ee83fc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -154,9 +154,8 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)
 {
 	struct virtio_gpu_object_array *objs;
-	size_t size = sizeof(*objs) + sizeof(objs->objs[0]) * nents;
 
-	objs = kmalloc(size, GFP_KERNEL);
+	objs = kmalloc(struct_size(objs, objs, nents), GFP_KERNEL);
 	if (!objs)
 		return NULL;
 
-- 
2.27.0

