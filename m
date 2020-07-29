Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB439C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8877C207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmBlaAa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgG2Vhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:37:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727801AbgG2VhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596058638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ny64fSMMc7Rq10ZRUtyqKunya/reGTsGGORluTaaBMg=;
        b=MmBlaAa/JetmwAfTOAt4Va+9gP3PaLpV1m7Iy0vQGjxxgB+aMW+6v8E7KttSpKRYTrzlyw
        31Ba/P7DK395FKxmbCZcaKv4q8WcPEcPbvJ+0LmFziT1ZZezMAHwSin+RbtbVdg2hrEoee
        e17+x9hD8HfC81T9saY+ZyIjDrLkTK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-g7qGyxW0PC2vBuHIW8CSZQ-1; Wed, 29 Jul 2020 17:37:14 -0400
X-MC-Unique: g7qGyxW0PC2vBuHIW8CSZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7766F91275;
        Wed, 29 Jul 2020 21:37:13 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-119-146.rdu2.redhat.com [10.10.119.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EC9A60C84;
        Wed, 29 Jul 2020 21:37:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, stable@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/9] drm/nouveau/kms/fbcon: Correct pm_runtime calls in nouveau_fbcon_release()
Date:   Wed, 29 Jul 2020 17:36:57 -0400
Message-Id: <20200729213703.119137-4-lyude@redhat.com>
In-Reply-To: <20200729213703.119137-1-lyude@redhat.com>
References: <20200729213703.119137-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to update the last busy timer for our device and use
pm_runtime_put_autosuspend() here instead so that our GPU can
autosuspend when we're done.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: f231976c2e89 ("drm/nouveau/fbcon: take runpm reference when userspace has an open fd")
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: stable@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.3+
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index fad8030ec1f81..4d9f3b5ae72d2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -200,8 +200,11 @@ static int
 nouveau_fbcon_release(struct fb_info *info, int user)
 {
 	struct nouveau_fbdev *fbcon = info->par;
-	struct nouveau_drm *drm = nouveau_drm(fbcon->helper.dev);
-	pm_runtime_put(drm->dev->dev);
+	struct drm_device *dev = fbcon->helper.dev;
+
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
 	return 0;
 }
 
-- 
2.26.2

