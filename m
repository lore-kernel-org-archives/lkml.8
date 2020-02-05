Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5CEC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97012085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PucvsHxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgBEGxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:53:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22733 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726614AbgBEGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580885602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=d/H8Uw2fGE2aBzDIfMTx++ovLGWmzUssb90jy8x2c6E=;
        b=PucvsHxdRgeHf1zvoUePt+k+C4jaMQ/M8VoSkRzYE36et9C9RyNRDYlWJyuXv43LlrpsDb
        Gg36uYaSY2l2Mnd/fC4ODKtx7wKwD4cbAurZrR2PpCyjnAFmpKglBo/xVvpNH/ZW8t1Ovn
        U9eZ3b8gSp4spo5ZyHacq3yxc71w+vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-Rxn7RGLHPnCfgZTy0C8iXw-1; Wed, 05 Feb 2020 01:53:17 -0500
X-MC-Unique: Rxn7RGLHPnCfgZTy0C8iXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B93CD8010FE;
        Wed,  5 Feb 2020 06:53:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD4C460BF7;
        Wed,  5 Feb 2020 06:53:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 105AD9D1E; Wed,  5 Feb 2020 07:53:12 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: fix vblank handling
Date:   Wed,  5 Feb 2020 07:53:11 +0100
Message-Id: <20200205065312.15790-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio has its own commit fail function.  Add the
drm_atomic_helper_fake_vblank() call there.

Fixes: 2a735ad3d211 ("drm/virtio: Remove sending of vblank event")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index ecf4ba7cc32b..7b0f0643bb2d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -324,6 +324,7 @@ static void vgdev_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_commit_modeset_enables(dev, state);
 	drm_atomic_helper_commit_planes(dev, state, 0);
 
+	drm_atomic_helper_fake_vblank(state);
 	drm_atomic_helper_commit_hw_done(state);
 
 	drm_atomic_helper_wait_for_vblanks(dev, state);
-- 
2.18.1

