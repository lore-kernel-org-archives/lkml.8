Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC4C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F2A206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOZCCIZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCRAmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:42:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49623 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727408AbgCRAmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584492161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q13VZYlzLtolpKOuigDLfvkLF77EfuwXW+oKeY0ztNU=;
        b=IOZCCIZ7J3WghgDVPDYTm/8QkTH+/6r5snm1H4q7HKoqEylnQvLUkvSkvP9JU8Ou8aHd2O
        xlzSoT9vvaYemeJgQ/YWIt+RzR38Wsfyu7VVORxjObtGYJL2GMjP+qEkmup7sD8Idi6asn
        TessLZSJI+boA2YZAjwGW+Ba+C+Kdpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-Caiap6T9PPK0j0SbTUbZKQ-1; Tue, 17 Mar 2020 20:42:39 -0400
X-MC-Unique: Caiap6T9PPK0j0SbTUbZKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 406E01005509;
        Wed, 18 Mar 2020 00:42:38 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 181E060BE0;
        Wed, 18 Mar 2020 00:42:37 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] drm/nouveau/kms/nv50-: Fix disabling dithering
Date:   Tue, 17 Mar 2020 20:41:01 -0400
Message-Id: <20200318004159.235623-5-lyude@redhat.com>
In-Reply-To: <20200318004159.235623-1-lyude@redhat.com>
References: <20200318004159.235623-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
2.24.1

