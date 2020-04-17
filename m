Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B625C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081D9206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVLcwRMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgDQTmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730795AbgDQTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVzUeLsK/ex7wmz5dO3apvfkzXrz9r7J/0m09OwoDBE=;
        b=WVLcwRMCcdx0RbVKSDx9vQLr6g5omNXtCnx6TtstlvyemZnF/fcMgDutSNLqOkElMO9/RA
        BLPZcjleB0JXbj9bA7DjTFbO+Qc66+irjtIilMMf6f5/5pOS9GoYmoV8YD6I8q4EmFTR0U
        1xtBLeCdcWBH5O5nIoE+xn6Z4kIxP9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-9DutaUuwO9KyeSBlHewy0g-1; Fri, 17 Apr 2020 15:42:46 -0400
X-MC-Unique: 9DutaUuwO9KyeSBlHewy0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F8368017F5;
        Fri, 17 Apr 2020 19:42:45 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 554CF5DA7B;
        Fri, 17 Apr 2020 19:42:40 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 07/11] drm/nouveau/kms/nv50-: s/harm/armh/g
Date:   Fri, 17 Apr 2020 15:40:54 -0400
Message-Id: <20200417194145.36350-8-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We refer to the armed hardware assembly as armh elsewhere in nouveau, so
fix the naming here to make it consistent.

This patch contains no functional changes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/wndw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.c
index bb737f9281e6..39cca8eaa066 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -397,7 +397,7 @@ nv50_wndw_atomic_check(struct drm_plane *plane, struc=
t drm_plane_state *state)
 	struct nv50_wndw *wndw =3D nv50_wndw(plane);
 	struct nv50_wndw_atom *armw =3D nv50_wndw_atom(wndw->plane.state);
 	struct nv50_wndw_atom *asyw =3D nv50_wndw_atom(state);
-	struct nv50_head_atom *harm =3D NULL, *asyh =3D NULL;
+	struct nv50_head_atom *armh =3D NULL, *asyh =3D NULL;
 	bool modeset =3D false;
 	int ret;
=20
@@ -418,9 +418,9 @@ nv50_wndw_atomic_check(struct drm_plane *plane, struc=
t drm_plane_state *state)
=20
 	/* Fetch assembly state for the head the window used to belong to. */
 	if (armw->state.crtc) {
-		harm =3D nv50_head_atom_get(asyw->state.state, armw->state.crtc);
-		if (IS_ERR(harm))
-			return PTR_ERR(harm);
+		armh =3D nv50_head_atom_get(asyw->state.state, armw->state.crtc);
+		if (IS_ERR(armh))
+			return PTR_ERR(armh);
 	}
=20
 	/* LUT configuration can potentially cause the window to be disabled. *=
/
@@ -444,8 +444,8 @@ nv50_wndw_atomic_check(struct drm_plane *plane, struc=
t drm_plane_state *state)
 		asyh->wndw.mask |=3D BIT(wndw->id);
 	} else
 	if (armw->visible) {
-		nv50_wndw_atomic_check_release(wndw, asyw, harm);
-		harm->wndw.mask &=3D ~BIT(wndw->id);
+		nv50_wndw_atomic_check_release(wndw, asyw, armh);
+		armh->wndw.mask &=3D ~BIT(wndw->id);
 	} else {
 		return 0;
 	}
--=20
2.25.1

