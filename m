Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75BEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8C02073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I83lYF7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbgFXXDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:03:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388947AbgFXXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593039825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CIqn4trdXaLo6esz2Y3GWcQ2dIBeOVeLn2zbN8dxlA=;
        b=I83lYF7LtDVKRbfg2uf60R8VVv6du437eJhIDYbawSPzM513CrXED8w/c4MUBh4Bvr8sbS
        +X7SrsjfXkj0FTEmvUt3vx6a2xGq7GVQObmjhODAaDEPSVf1rhLIBfASbyj3inlP9dCYn9
        tH+dpWunZDQEM56t1SQARb6vZSyPM1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-kXhtDDO3MJ6LiRE9qHf8HQ-1; Wed, 24 Jun 2020 19:03:41 -0400
X-MC-Unique: kXhtDDO3MJ6LiRE9qHf8HQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D4F0107ACCD;
        Wed, 24 Jun 2020 23:03:40 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-115-214.rdu2.redhat.com [10.10.115.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC76C1001B07;
        Wed, 24 Jun 2020 23:03:38 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v7 04/11] drm/nouveau/kms/nv50-: Unroll error cleanup in nv50_head_create()
Date:   Wed, 24 Jun 2020 19:03:11 -0400
Message-Id: <20200624230318.126256-5-lyude@redhat.com>
In-Reply-To: <20200624230318.126256-1-lyude@redhat.com>
References: <20200624230318.126256-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll be rolling back more things in this function, and the way it's
structured is a bit confusing. So, let's clean this up a bit and just
unroll in the event of failure.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/head.c | 33 +++++++++++++++++--------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index 8f6455697ba72..e29ea40e7c334 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -507,20 +507,28 @@ nv50_head_create(struct drm_device *dev, int index)
 
 	if (disp->disp->object.oclass < GV100_DISP) {
 		ret = nv50_base_new(drm, head->base.index, &base);
+		if (ret)
+			goto fail_free;
+
 		ret = nv50_ovly_new(drm, head->base.index, &ovly);
+		if (ret)
+			goto fail_free;
 	} else {
 		ret = nv50_wndw_new(drm, DRM_PLANE_TYPE_PRIMARY,
 				    head->base.index * 2 + 0, &base);
+		if (ret)
+			goto fail_free;
+
 		ret = nv50_wndw_new(drm, DRM_PLANE_TYPE_OVERLAY,
 				    head->base.index * 2 + 1, &ovly);
-	}
-	if (ret == 0)
-		ret = nv50_curs_new(drm, head->base.index, &curs);
-	if (ret) {
-		kfree(head);
-		return ERR_PTR(ret);
+		if (ret)
+			goto fail_free;
 	}
 
+	ret = nv50_curs_new(drm, head->base.index, &curs);
+	if (ret)
+		goto fail_free;
+
 	crtc = &head->base.base;
 	drm_crtc_init_with_planes(dev, crtc, &base->plane, &curs->plane,
 				  &nv50_head_func, "head-%d", head->base.index);
@@ -533,11 +541,16 @@ nv50_head_create(struct drm_device *dev, int index)
 
 	if (head->func->olut_set) {
 		ret = nv50_lut_init(disp, &drm->client.mmu, &head->olut);
-		if (ret) {
-			nv50_head_destroy(crtc);
-			return ERR_PTR(ret);
-		}
+		if (ret)
+			goto fail_crtc_cleanup;
 	}
 
 	return head;
+
+fail_crtc_cleanup:
+	drm_crtc_cleanup(crtc);
+fail_free:
+	kfree(head);
+
+	return ERR_PTR(ret);
 }
-- 
2.26.2

