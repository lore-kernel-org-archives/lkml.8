Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A1C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E69C206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7vrYzR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgDQTmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28200 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730764AbgDQTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWTsiKNhj6P9xR5Gj1CVXp5Rd5Inw4ERGco9o1NjySs=;
        b=O7vrYzR0zQDqwSHIOvUPU5ZPa+zBovLPWomKq1GL36oECDXqos7unueElROUUS704jCL6u
        H9cAjkOcBRbCr/wfbgqwFtQOyW9npizeCuFP4ttQfpZCSTkak7/RGb2mHEn5H4yxc3saeV
        8D40MBSgjqs3RKWQDMFzJxJx9UKG6Ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-kCvBgDPtNlu6dedeWPJLOQ-1; Fri, 17 Apr 2020 15:42:40 -0400
X-MC-Unique: kCvBgDPtNlu6dedeWPJLOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2C28017FC;
        Fri, 17 Apr 2020 19:42:39 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 277325DA7B;
        Fri, 17 Apr 2020 19:42:38 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 06/11] drm/nouveau/kms/nv50-: Fix disabling dithering
Date:   Fri, 17 Apr 2020 15:40:53 -0400
Message-Id: <20200417194145.36350-7-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we expose the ability to turn off hardware dithering for nouveau,
we actually make the mistake of turning it on anyway, due to
dithering_depth containing a non-zero value if our dithering depth isn't
also set to 6 bpc.

So, fix it by never enabling dithering when it's disabled.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/head.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/no=
uveau/dispnv50/head.c
index e29ea40e7c33..72bc3bce396a 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -84,18 +84,20 @@ nv50_head_atomic_check_dither(struct nv50_head_atom *=
armh,
 {
 	u32 mode =3D 0x00;
=20
-	if (asyc->dither.mode =3D=3D DITHERING_MODE_AUTO) {
-		if (asyh->base.depth > asyh->or.bpc * 3)
-			mode =3D DITHERING_MODE_DYNAMIC2X2;
-	} else {
-		mode =3D asyc->dither.mode;
-	}
+	if (asyc->dither.mode) {
+		if (asyc->dither.mode =3D=3D DITHERING_MODE_AUTO) {
+			if (asyh->base.depth > asyh->or.bpc * 3)
+				mode =3D DITHERING_MODE_DYNAMIC2X2;
+		} else {
+			mode =3D asyc->dither.mode;
+		}
=20
-	if (asyc->dither.depth =3D=3D DITHERING_DEPTH_AUTO) {
-		if (asyh->or.bpc >=3D 8)
-			mode |=3D DITHERING_DEPTH_8BPC;
-	} else {
-		mode |=3D asyc->dither.depth;
+		if (asyc->dither.depth =3D=3D DITHERING_DEPTH_AUTO) {
+			if (asyh->or.bpc >=3D 8)
+				mode |=3D DITHERING_DEPTH_8BPC;
+		} else {
+			mode |=3D asyc->dither.depth;
+		}
 	}
=20
 	asyh->dither.enable =3D mode;
--=20
2.25.1

