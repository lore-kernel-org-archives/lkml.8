Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F93C38A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12260214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c92JHFHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbgDQTmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52841 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730709AbgDQTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZcv3qDQzlPILR5fV5Bw6/0wcQ4spw3syCzjc3k3oHE=;
        b=c92JHFHsJ1lnbbhZf4HMVsTN3loR43vB/X8zXRMn8XvtTOc9b4TgyNKXZUTzd9go8vH4dZ
        Gn9yOP0QvZobWNjJG5SHfKhGs/F0kVUPueZKoNUJgF2zRNv82piRdpRMtO+d14964VEOkS
        q2CnKipZ10gXPQJsBrIx2QlG1HWQXks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-AUMdPxmLMxGasXEyDn67TQ-1; Fri, 17 Apr 2020 15:42:35 -0400
X-MC-Unique: AUMdPxmLMxGasXEyDn67TQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10316149C6;
        Fri, 17 Apr 2020 19:42:34 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE34A5D9CA;
        Fri, 17 Apr 2020 19:42:30 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peteris Rudzusiks <peteris.rudzusiks@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 04/11] drm/nouveau/kms/nv50-: Unroll error cleanup in nv50_head_create()
Date:   Fri, 17 Apr 2020 15:40:51 -0400
Message-Id: <20200417194145.36350-5-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
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

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/no=
uveau/dispnv50/head.c
index 8f6455697ba7..e29ea40e7c33 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -507,20 +507,28 @@ nv50_head_create(struct drm_device *dev, int index)
=20
 	if (disp->disp->object.oclass < GV100_DISP) {
 		ret =3D nv50_base_new(drm, head->base.index, &base);
+		if (ret)
+			goto fail_free;
+
 		ret =3D nv50_ovly_new(drm, head->base.index, &ovly);
+		if (ret)
+			goto fail_free;
 	} else {
 		ret =3D nv50_wndw_new(drm, DRM_PLANE_TYPE_PRIMARY,
 				    head->base.index * 2 + 0, &base);
+		if (ret)
+			goto fail_free;
+
 		ret =3D nv50_wndw_new(drm, DRM_PLANE_TYPE_OVERLAY,
 				    head->base.index * 2 + 1, &ovly);
-	}
-	if (ret =3D=3D 0)
-		ret =3D nv50_curs_new(drm, head->base.index, &curs);
-	if (ret) {
-		kfree(head);
-		return ERR_PTR(ret);
+		if (ret)
+			goto fail_free;
 	}
=20
+	ret =3D nv50_curs_new(drm, head->base.index, &curs);
+	if (ret)
+		goto fail_free;
+
 	crtc =3D &head->base.base;
 	drm_crtc_init_with_planes(dev, crtc, &base->plane, &curs->plane,
 				  &nv50_head_func, "head-%d", head->base.index);
@@ -533,11 +541,16 @@ nv50_head_create(struct drm_device *dev, int index)
=20
 	if (head->func->olut_set) {
 		ret =3D nv50_lut_init(disp, &drm->client.mmu, &head->olut);
-		if (ret) {
-			nv50_head_destroy(crtc);
-			return ERR_PTR(ret);
-		}
+		if (ret)
+			goto fail_crtc_cleanup;
 	}
=20
 	return head;
+
+fail_crtc_cleanup:
+	drm_crtc_cleanup(crtc);
+fail_free:
+	kfree(head);
+
+	return ERR_PTR(ret);
 }
--=20
2.25.1

